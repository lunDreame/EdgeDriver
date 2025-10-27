-- MIT License
-- Copyright (c) 2025 lunDreame

local log = require "log"
local socket = require "cosock.socket"

local M = {}

local function parse_discovery_response(data, ip, port)
  if not data or #data < 32 then
    return nil
  end

  local ok, magic, length, unknown, device_id, stamp, checksum, next_idx =
    pcall(string.unpack, ">I2I2I4I4I4c16", data)

  if not ok then
    log.warn(string.format("unpack failed from %s: %s", ip, tostring(magic)))
    return nil
  end

  local has_encrypted_data = (#data > 32)
  local encrypted_data = nil
  if has_encrypted_data then
    encrypted_data = data:sub(33) -- hex는 메타데이터에만 요약 반영
  end

  return {
    ip = ip,
    port = port,
    magic = magic,
    length = length,
    unknown = unknown,
    device_id = device_id,
    stamp = stamp,
    checksum = checksum, -- raw 16 bytes
    has_encrypted_data = has_encrypted_data,
    encrypted_data = encrypted_data, -- raw payload
  }
end

local function to_hex(str)
  if not str then return "" end
  return (str:gsub('.', function(c) return string.format("%02x", string.byte(c)) end))
end

local function to_hex16(n) return string.format("0x%04X", n & 0xFFFF) end
local function to_hex32(n) return string.format("0x%08X", n & 0xFFFFFFFF) end

local DISCOVERED_DEVICES_KEY = "discovered_devices_cache"

local function cache_discovered_device(driver, device_id, ip)
  local cache = driver.datastore[DISCOVERED_DEVICES_KEY] or {}
  cache[device_id] = {
    ip = ip,
    timestamp = os.time(),
    used = false  -- Track if this cache entry has been used
  }
  driver.datastore[DISCOVERED_DEVICES_KEY] = cache
end

function M.get_cached_device_info(driver, device_network_id)
  local cache = driver.datastore[DISCOVERED_DEVICES_KEY] or {}
  local info = cache[device_network_id]

  if info then
    info.used = true
    cache[device_network_id] = info
    driver.datastore[DISCOVERED_DEVICES_KEY] = cache
  end

  return info
end

function M.remove_cached_device(driver, device_network_id)
  local cache = driver.datastore[DISCOVERED_DEVICES_KEY] or {}
  if cache[device_network_id] then
    cache[device_network_id] = nil
    driver.datastore[DISCOVERED_DEVICES_KEY] = cache
    log.info(string.format("Removed cached device: %s", device_network_id))
  end
end

local function cleanup_unused_cache_entries(driver)
  local cache = driver.datastore[DISCOVERED_DEVICES_KEY] or {}
  local cleaned = 0
  local current_time = os.time()

  for device_id, info in pairs(cache) do
    local age = current_time - (info.timestamp or 0)
    if info.used or age > 3600 then
      cache[device_id] = nil
      cleaned = cleaned + 1
    end
  end

  if cleaned > 0 then
    driver.datastore[DISCOVERED_DEVICES_KEY] = cache
    log.debug(string.format("Cleaned up %d discovery cache entries", cleaned))
  end
end

function M.discovery_handler(driver, _, should_continue)
  log.info("Start searching for Xiaomi MIoT devices")

  local udp = socket.udp()
  udp:setoption("broadcast", true)
  udp:settimeout(5)

  local hex = "21310020ffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
  local handshake_data = {}
  for i = 1, #hex, 2 do
    handshake_data[#handshake_data+1] = string.char(tonumber(hex:sub(i, i+1), 16))
  end
  handshake_data = table.concat(handshake_data)

  udp:sendto(handshake_data, "255.255.255.255", 54321)

  while should_continue() do
    local data, ip, port = udp:receivefrom()
    if not data then
      break
    end

    local info = parse_discovery_response(data, ip, port)
    if info then
      log.info(string.format(
        "Xiaomi device found: %s (device_id=%s, stamp=%u, magic=%s, enc=%s)",
        info.ip, to_hex32(info.device_id), info.stamp, to_hex16(info.magic),
        info.has_encrypted_data and "yes" or "no"
      ))

      local device_id = tostring(info.device_id)
      local device_network_id = string.format("%s@%s", device_id, info.ip)

      local metadata = {
        type = "LAN",
        device_network_id = device_network_id,
        label = device_id,
        profile = "xiaomi-generic",
        manufacturer = "Xiaomi",
      }

      cache_discovered_device(driver, device_network_id, info.ip)

      local existed = false
      for _, dev in ipairs(driver:get_devices()) do
        if dev.device_network_id == device_network_id then
          existed = true
          local device_data = dev:get_field("xiaomi_miot_data") or {}
          device_data.ip = info.ip
          dev:set_field("xiaomi_miot_data", device_data, {persist = true})
          log.info(string.format("Updated IP for existing device: %s -> %s", device_network_id, info.ip))
          break
        end
      end

      if not existed then
        driver:try_create_device(metadata)
      else
        log.info(string.format("Device already exists: %s", device_network_id))
      end
    end
  end

  udp:close()
  log.info("Device discovery complete")

  cleanup_unused_cache_entries(driver)
end

return M
