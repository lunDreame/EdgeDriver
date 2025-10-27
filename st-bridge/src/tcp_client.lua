local cosock = require "cosock"
local socket = require "cosock.socket"
local json   = require "dkjson"

local M = {}

-- Simple TCP client with line-delimited JSON framing (`\n`)
function M.connect(ip, port, on_msg, on_err)
  local sock, err = socket.tcp()
  if not sock then return nil, err end

  sock:settimeout(5)
  local ok, cerr = sock:connect(ip, port)
  if not ok then
    return nil, "connect_failed"
  end

  -- non-blocking; we'll drive reads via socket.select
  sock:settimeout(0)

  local closed = false
  local function close()
    if not closed then
      closed = true
      pcall(sock.close, sock)
    end
  end

  local function send(obj)
    local payload
    local ok1, enc_err = pcall(function() payload = json.encode(obj) .. "\n" end)
    if not ok1 then
      if on_err then on_err(enc_err or "encode_failed") end
      return
    end
    local ok2, se = pcall(function() sock:send(payload) end)
    if not ok2 and on_err then on_err(se or "send_failed") end
  end

  -- reader: wait for readability with socket.select (no cosock.sleep)
  cosock.spawn(function()
    local buffer = ""
    while not closed do
      -- block up to 500ms for readability
      local rlist, _, _ = socket.select({ sock }, nil, 0.5)
      if rlist and #rlist > 0 then
        local chunk, recverr, partial = sock:receive(1024)
        local data = chunk or partial
        if data and #data > 0 then
          buffer = buffer .. data
          -- process complete lines
          while true do
            local nl = buffer:find("\n", 1, true)
            if not nl then break end
            local line = buffer:sub(1, nl - 1)
            buffer = buffer:sub(nl + 1)
            if #line > 0 then
              local obj = json.decode(line)
              if obj then
                local okcb, cb_err = pcall(on_msg, obj)
                if not okcb and on_err then on_err(cb_err) end
              end
            end
          end
        end
        if recverr == "closed" then
          break
        end
      end
      -- if not readable, loop again (select already waited)
    end
    close()
  end, "st-bridge-reader")

  return {
    send = send,
    close = close,
  }
end

return M
