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
    device:set_field("miot_protocol", protocol)
  end
  return protocol
end

local function get_device_data(device)
  return device:get_field("xiaomi_miot_data") or {}
end

local function get_device_spec(device)
  return device:get_field("device_spec")
end

function M.handle_vacuum_start(driver, device, command)
  log.info(string.format("Start vacuum command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.actions or not spec.actions.start then
    log.warn("Device does not support start action")
    return
  end

  local protocol = get_miot_protocol(device)
  local action = spec.actions.start

  local result = protocol:call_action(
    device_data.ip,
    device_data.token,
    action.siid,
    action.aiid,
    {}
  )

  if result and result.code == 0 then
    device:emit_event(capabilities.switch.switch.on())
  else
    log.error("Failed to start vacuum")
  end
end

function M.handle_vacuum_stop(driver, device, command)
  log.info(string.format("Stop vacuum command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.actions or not spec.actions.stop then
    log.warn("Device does not support stop action")
    return
  end

  local protocol = get_miot_protocol(device)
  local action = spec.actions.stop

  local result = protocol:call_action(
    device_data.ip,
    device_data.token,
    action.siid,
    action.aiid,
    {}
  )

  if result and result.code == 0 then
    device:emit_event(capabilities.switch.switch.off())
  else
    log.error("Failed to stop vacuum")
  end
end

function M.handle_vacuum_charge(driver, device, command)
  log.info(string.format("Return to charge command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.actions or not spec.actions.charge then
    log.warn("Device does not support charge action")
    return
  end

  local protocol = get_miot_protocol(device)
  local action = spec.actions.charge

  local result = protocol:call_action(
    device_data.ip,
    device_data.token,
    action.siid,
    action.aiid,
    {}
  )

  if result and result.code == 0 then
    log.info("Vacuum returning to charge")
  else
    log.error("Failed to send vacuum to charge")
  end
end

return M
