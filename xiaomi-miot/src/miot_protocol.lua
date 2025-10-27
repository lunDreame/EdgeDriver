-- MIT License
-- Copyright (c) 2025 lunDreame

local socket = require "cosock.socket"
local log = require "log"
local json = require "st.json"
local security = require "st.security"
local md5_lib = require "md5"

local MiotProtocol = {}
MiotProtocol.__index = MiotProtocol

local MIOT_PORT = 54321
local HANDSHAKE_TIMEOUT = 5
local DEFAULT_TIMEOUT = 4
local MAGIC_NUMBER = 0x2131

local function md5(data)
  return md5_lib.sum(data)
end

local function aes_encrypt(data, key, iv)
  local padding_length = 16 - (#data % 16)
  local padded_data = data .. string.rep(string.char(padding_length), padding_length)

  local encrypted, err = security.encrypt_bytes(padded_data, key, {
    cipher = "aes128-cbc",
    iv = iv,
    padding = false
  })

  if not encrypted then
    log.error(string.format("AES encryption failed: %s", err or "unknown error"))
    return nil
  end

  return encrypted
end

local function aes_decrypt(data, key, iv)
  local decrypted, err = security.decrypt_bytes(data, key, {
    cipher = "aes128-cbc",
    iv = iv,
    padding = false
  })

  if not decrypted then
    log.error(string.format("AES decryption failed: %s", err or "unknown error"))
    return nil
  end

  if #decrypted > 0 then
    local padding_length = string.byte(decrypted, #decrypted)
    return decrypted:sub(1, #decrypted - padding_length)
  end

  return decrypted
end

local function pack_uint32(value)
  return string.pack(">I4", value)
end

local function pack_uint16(value)
  return string.pack(">I2", value)
end

local function unpack_uint32(data, offset)
  offset = offset or 1
  return string.unpack(">I4", data, offset)
end

local function unpack_uint16(data, offset)
  offset = offset or 1
  return string.unpack(">I2", data, offset)
end

function MiotProtocol.new()
  local self = setmetatable({}, MiotProtocol)
  self.message_id = 0
  self.server_stamp = 0
  self.server_stamp_time = 0
  return self
end

function MiotProtocol:get_next_message_id()
  self.message_id = self.message_id + 1
  if self.message_id >= 10000 then
    self.message_id = 1
  end
  return self.message_id
end

function MiotProtocol:prepare_token(token_hex)
  local token = ""
  for i = 1, #token_hex, 2 do
    token = token .. string.char(tonumber(token_hex:sub(i, i + 1), 16))
  end

  local token_key = md5(token)
  local token_iv = md5(token_key .. token)

  return token, token_key, token_iv
end

function MiotProtocol:encrypt_message(data, token, token_key, token_iv, device_id, stamp)
  stamp = stamp or 0xFFFFFFFF

  local data_str
  if type(data) == "string" then
    data_str = data
  else
    data_str = json.encode(data)
  end

  local encrypted = aes_encrypt(data_str, token_key, token_iv)

  local header = ""
  header = header .. pack_uint16(MAGIC_NUMBER)  -- magic (2바이트)
  header = header .. pack_uint16(32 + #encrypted)  -- length (2바이트)
  header = header .. pack_uint32(0)  -- unknown (4바이트)
  header = header .. pack_uint32(device_id)  -- device_id (4바이트)
  header = header .. pack_uint32(stamp)  -- stamp (4바이트)

  local checksum = md5(header .. token .. encrypted)
  header = header .. checksum

  return header .. encrypted
end

function MiotProtocol:decrypt_message(data, token, token_key, token_iv)
  if #data < 32 then
    log.error("Response data is too short.")
    return nil
  end

  local header = data:sub(1, 16)
  local checksum = data:sub(17, 32)
  local encrypted = data:sub(33)

  local calculated_checksum = md5(header .. token .. encrypted)
  if checksum ~= calculated_checksum then
    log.error("Checksum does not match.")
    return nil
  end

  local decrypted = aes_decrypt(encrypted, token_key, token_iv)
  return decrypted
end

function MiotProtocol:handshake(udp, ip)
  local handshake_data = ""
  for i = 1, #"21310020ffffffffffffffffffffffffffffffffffffffffffffffffffffffff", 2 do
    local hex = "21310020ffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
    handshake_data = handshake_data .. string.char(tonumber(hex:sub(i, i + 1), 16))
  end

  local success, err = udp:sendto(handshake_data, ip, MIOT_PORT)
  if not success then
    log.error(string.format("Handshake send failed: %s", err))
    return false, nil
  end

  udp:settimeout(HANDSHAKE_TIMEOUT)
  local response, from_ip, from_port = udp:receivefrom()

  if not response or #response < 32 then
    log.error("Handshake response not received.")
    return false, nil
  end

  local device_id = unpack_uint32(response, 9)
  local stamp = unpack_uint32(response, 13)

  if stamp > 0 then
    self.server_stamp = stamp
    self.server_stamp_time = socket.gettime() * 1000
  end

  log.info(string.format("Handshake success: Device ID=%d, Stamp=%d", device_id, stamp))
  return true, device_id
end

function MiotProtocol:send_command(ip, token_hex, method, params, retry_count)
  params = params or {}
  retry_count = retry_count or 3

  local last_error = nil

  for attempt = 1, retry_count do
    local token, token_key, token_iv = self:prepare_token(token_hex)

    local udp = socket.udp()
    udp:settimeout(DEFAULT_TIMEOUT)

    local success, device_id = self:handshake(udp, ip)
    if not success or not device_id then
      udp:close()
      last_error = "Handshake failed"

      if attempt < retry_count then
        log.warn(string.format("Attempt %d/%d failed, retrying...", attempt, retry_count))
        socket.sleep(1)
      end
      goto continue
    end

    local message_id = self:get_next_message_id()
    local command = {
      id = message_id,
      method = method,
      params = params
    }

    local current_stamp = 0xFFFFFFFF
    if self.server_stamp_time > 0 then
      local current_time = socket.gettime() * 1000
      local seconds_passed = math.floor((current_time - self.server_stamp_time) / 1000)
      current_stamp = self.server_stamp + seconds_passed
    end

    local encrypted_data = self:encrypt_message(command, token, token_key, token_iv, device_id, current_stamp)

    success, err = udp:sendto(encrypted_data, ip, MIOT_PORT)
    if not success then
      log.error(string.format("Command send failed: %s", err))
      udp:close()
      last_error = "Send failed: " .. tostring(err)
      goto continue
    end

    local response, from_ip, from_port = udp:receivefrom()
    udp:close()

    if not response then
      log.error("Command response not received.")
      last_error = "No response"

      if attempt < retry_count then
        log.warn(string.format("Attempt %d/%d: no response, retrying...", attempt, retry_count))
        socket.sleep(1)
      end
      goto continue
    end

    local decrypted_response = self:decrypt_message(response, token, token_key, token_iv)
    if not decrypted_response then
      log.error("Response decryption failed.")
      last_error = "Decryption failed"
      goto continue
    end

    local result = json.decode(decrypted_response)

    -- Check for errors in response
    if result and result.error then
      log.warn(string.format("Device returned error: %s", json.encode(result.error)))
      last_error = "Device error: " .. tostring(result.error.message)
    else
      -- Success!
      if attempt > 1 then
        log.info(string.format("Command succeeded on attempt %d/%d", attempt, retry_count))
      end
      return result
    end

    ::continue::
  end

  log.error(string.format("All %d attempts failed. Last error: %s", retry_count, last_error or "unknown"))
  return nil
end

function MiotProtocol:get_device_info(ip, token)
  local result = self:send_command(ip, token, "miIO.info")
  if result and result.result then
    return result.result
  end
  return nil
end

function MiotProtocol:get_property(ip, token, siid, piid)
  local params = {{siid = siid, piid = piid}}
  local result = self:send_command(ip, token, "get_properties", params)
  if result and result.result and #result.result > 0 then
    return result.result[1].value
  end
  return nil
end

function MiotProtocol:set_property(ip, token, siid, piid, value)
  local params = {{siid = siid, piid = piid, value = value}}
  local result = self:send_command(ip, token, "set_properties", params)
  if result and result.result and #result.result > 0 then
    return result.result[1].code == 0
  end
  return false
end

function MiotProtocol:call_action(ip, token, siid, aiid, action_params)
  action_params = action_params or {}
  local params = {{siid = siid, aiid = aiid, ["in"] = action_params}}
  local result = self:send_command(ip, token, "action", params)
  if result and result.result and #result.result > 0 then
    return result.result[1]
  end
  return nil
end

return MiotProtocol
