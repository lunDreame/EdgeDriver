-- MIT License
-- Copyright (c) 2025 lunDreame

local log = require "log"
local capabilities = require "st.capabilities"
local MiotProtocol = require "miot_protocol"

local M = {}

local function get_miot_protocol(device)
  local protocol = device:get_field("miot_protocol")
  if not protocol then
    protocol = MiotProtocol.new()
    device:set_field("miot_protocol", protocol, { persist = true })
  end
  return protocol
end

local function get_device_data(device)
  return device:get_field("xiaomi_miot_data") or {}
end

local function get_device_spec(device)
  return device:get_field("device_spec")
end

function M.handle_shade_open(driver, device, command)
  log.info(string.format("Open shade command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.properties then
    return
  end

  local protocol = get_miot_protocol(device)

  if spec.properties.motor_control then
    local prop = spec.properties.motor_control
    -- Value 0 or 1 typically means open
    local success = protocol:set_property(
      device_data.ip,
      device_data.token,
      prop.siid,
      prop.piid,
      0 -- Open command
    )

    if success then
      device:emit_event(capabilities.windowShade.windowShade.opening())
    end
  elseif spec.properties.target_position then
    -- Use target_position if available
    local prop = spec.properties.target_position
    local success = protocol:set_property(
      device_data.ip,
      device_data.token,
      prop.siid,
      prop.piid,
      100 -- Fully open
    )

    if success then
      device:emit_event(capabilities.windowShade.windowShade.opening())
      device:emit_event(capabilities.windowShadeLevel.shadeLevel(100))
    end
  end
end

function M.handle_shade_close(driver, device, command)
  log.info(string.format("Close shade command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.properties then
    return
  end

  local protocol = get_miot_protocol(device)

  if spec.properties.motor_control then
    local prop = spec.properties.motor_control
    local success = protocol:set_property(
      device_data.ip,
      device_data.token,
      prop.siid,
      prop.piid,
      1 -- Close command
    )

    if success then
      device:emit_event(capabilities.windowShade.windowShade.closing())
    end
  elseif spec.properties.target_position then
    local prop = spec.properties.target_position
    local success = protocol:set_property(
      device_data.ip,
      device_data.token,
      prop.siid,
      prop.piid,
      0 -- Fully closed
    )

    if success then
      device:emit_event(capabilities.windowShade.windowShade.closing())
      device:emit_event(capabilities.windowShadeLevel.shadeLevel(0))
    end
  end
end

function M.handle_shade_pause(driver, device, command)
  log.info(string.format("Pause shade command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.properties or not spec.properties.motor_control then
    return
  end

  local protocol = get_miot_protocol(device)
  local prop = spec.properties.motor_control

  local success = protocol:set_property(
    device_data.ip,
    device_data.token,
    prop.siid,
    prop.piid,
    2 -- Pause/Stop command
  )

  if success then
    device:emit_event(capabilities.windowShade.windowShade.partially_open())
  end
end

function M.handle_shade_level(driver, device, command)
  log.info(string.format("Set shade level to %d for %s", command.args.shadeLevel, device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.properties or not spec.properties.target_position then
    log.warn("Device does not support position control")
    return
  end

  local protocol = get_miot_protocol(device)
  local prop = spec.properties.target_position
  local level = command.args.shadeLevel

  local success = protocol:set_property(
    device_data.ip,
    device_data.token,
    prop.siid,
    prop.piid,
    level
  )

  if success then
    device:emit_event(capabilities.windowShadeLevel.shadeLevel(level))

    -- Update shade state based on level
    if level == 0 then
      device:emit_event(capabilities.windowShade.windowShade.closed())
    elseif level == 100 then
      device:emit_event(capabilities.windowShade.windowShade.open())
    else
      device:emit_event(capabilities.windowShade.windowShade.partially_open())
    end
  end
end

return M
