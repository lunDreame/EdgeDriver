-- MIT License
-- Copyright (c) 2025 lunDreame

local M = {}

function M.get_miot_protocol(device)
  local MiotProtocol = require "miot_protocol"
  local protocol = device:get_field("miot_protocol")
  if not protocol then
    protocol = MiotProtocol.new()
    device:set_field("miot_protocol", protocol, {persist = false})
  end
  return protocol
end

function M.get_device_data(device)
  return device:get_field("xiaomi_miot_data") or {}
end

function M.get_device_spec(device)
  return device:get_field("device_spec")
end

function M.hex_to_bytes(hex)
  local bytes = ""
  for i = 1, #hex, 2 do
    bytes = bytes .. string.char(tonumber(hex:sub(i, i + 1), 16))
  end
  return bytes
end

function M.bytes_to_hex(bytes)
  return (bytes:gsub('.', function(c)
    return string.format("%02x", string.byte(c))
  end))
end

function M.deep_copy(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == 'table' then
    copy = {}
    for orig_key, orig_value in next, orig, nil do
      copy[M.deep_copy(orig_key)] = M.deep_copy(orig_value)
    end
    setmetatable(copy, M.deep_copy(getmetatable(orig)))
  else
    copy = orig
  end
  return copy
end

function M.merge_tables(t1, t2)
  local result = M.deep_copy(t1)
  for k, v in pairs(t2) do
    if type(v) == "table" and type(result[k]) == "table" then
      result[k] = M.merge_tables(result[k], v)
    else
      result[k] = v
    end
  end
  return result
end

function M.table_contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function M.round(num, decimals)
  local mult = 10^(decimals or 0)
  return math.floor(num * mult + 0.5) / mult
end

function M.clamp(value, min, max)
  if value < min then
    return min
  elseif value > max then
    return max
  else
    return value
  end
end

function M.map_range(value, in_min, in_max, out_min, out_max)
  return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

function M.rgb_to_int(r, g, b)
  return (r * 65536) + (g * 256) + b
end

function M.int_to_rgb(value)
  local r = math.floor(value / 65536) % 256
  local g = math.floor(value / 256) % 256
  local b = value % 256
  return r, g, b
end

function M.kelvin_to_mireds(kelvin)
  return math.floor(1000000 / kelvin)
end

function M.mireds_to_kelvin(mireds)
  return math.floor(1000000 / mireds)
end

function M.split(str, delimiter)
  local result = {}
  for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

function M.trim(s)
  return s:match("^%s*(.-)%s*$")
end

return M
