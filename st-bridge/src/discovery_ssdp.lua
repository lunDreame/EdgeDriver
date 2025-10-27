local socket = require "cosock.socket"
local log = require "log"

local M = {}

local SSDP_ADDR = "239.255.255.250"
local SSDP_PORT = 1900
local SSDP_ST   = "urn:st-bridge:service:bridge:1"

local function parse_headers(blob)
  local headers = {}
  for line in blob:gmatch("[^\r\n]+") do
    local k, v = line:match("^%s*([^:]+):%s*(.+)$")
    if k and v then headers[k:upper()] = v end
  end
  return headers
end

-- send M-SEARCH and collect responses for ~timeout_s seconds
function M.scan(timeout_s)
  timeout_s = timeout_s or 2
  local udp = assert(socket.udp())
  udp:settimeout(0)
  assert(udp:setsockname("0.0.0.0", 0))

  local req =
    "M-SEARCH * HTTP/1.1\r\n" ..
    "HOST: " .. SSDP_ADDR .. ":" .. SSDP_PORT .. "\r\n" ..
    "MAN: \"ssdp:discover\"\r\n" ..
    "MX: 1\r\n" ..
    "ST: " .. SSDP_ST .. "\r\n" ..
    "\r\n"

  assert(udp:sendto(req, SSDP_ADDR, SSDP_PORT))

  local found = {}
  local step = 0.05 -- 50ms poll
  local loops = math.max(1, math.floor(timeout_s / step))

  for _ = 1, loops do
    local rcv, _, _ = socket.select({ udp }, nil, step)  -- block up to step
    if rcv and #rcv > 0 then
      -- drain all pending packets for this tick
      while true do
        local data, rip, rport = udp:receivefrom()
        if not data then break end
        local headers = parse_headers(data)
        local st = (headers["ST"] or headers["NT"] or ""):lower()
        if st == SSDP_ST:lower() or st == "ssdp:all" then
          local port = tonumber(headers["BRIDGE-PORT"]) or 8323
          local usn  = headers["USN"]
          local key  = (usn and ("USN:" .. usn)) or (rip .. ":" .. port)
          found[key] = { ip = rip, port = port, usn = usn }
        end
      end
    end
  end

  udp:close()

  local list = {}
  for _, v in pairs(found) do table.insert(list, v) end
  return list
end

return M
