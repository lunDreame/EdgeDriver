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

function M.handle_vacuum_mode(driver, device, command)
  log.info(string.format("Set vacuum mode to %s for %s", command.args.mode, device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.properties or not spec.properties.mode then
    log.warn("Device does not support mode property")
    return
  end

  if not spec.mode_map then
    log.warn("Device does not have mode_map defined")
    return
  end

  local vacuum_mode_capability = capabilities["dictionaryangel05655.vacuumMode"]

  -- Find the mode value from mode_map (reverse lookup)
  local mode_value = nil
  for value, mode_name in pairs(spec.mode_map) do
    if mode_name == command.args.mode then
      mode_value = value
      break
    end
  end

  if not mode_value then
    log.error(string.format("Invalid vacuum mode: %s", command.args.mode))
    return
  end

  local protocol = get_miot_protocol(device)
  local prop = spec.properties.mode

  local success = protocol:set_property(
    device_data.ip,
    device_data.token,
    prop.siid,
    prop.piid,
    mode_value
  )

  if success then
    device:emit_event(vacuum_mode_capability.vacuumMode({ value = command.args.mode }))
  else
    log.error("Failed to set vacuum mode")
  end
end

-- Vacuum Control Actions
function M.handle_start_sweep(driver, device, command)
  log.info(string.format("Start sweep command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.actions or not spec.actions.start_sweep then
    log.warn("Device does not support start_sweep action")
    return
  end

  local protocol = get_miot_protocol(device)
  local action = spec.actions.start_sweep

  local result = protocol:call_action(
    device_data.ip,
    device_data.token,
    action.siid,
    action.aiid,
    {}
  )

  if result and result.code == 0 then
    log.info("Start sweep action executed successfully")
  else
    log.error("Failed to execute start sweep action")
  end
end

function M.handle_stop_sweeping(driver, device, command)
  log.info(string.format("Stop sweeping command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.actions or not spec.actions.stop_sweeping then
    log.warn("Device does not support stop_sweeping action")
    return
  end

  local protocol = get_miot_protocol(device)
  local action = spec.actions.stop_sweeping

  local result = protocol:call_action(
    device_data.ip,
    device_data.token,
    action.siid,
    action.aiid,
    {}
  )

  if result and result.code == 0 then
    log.info("Stop sweeping action executed successfully")
  else
    log.error("Failed to execute stop sweeping action")
  end
end

function M.handle_start_room_sweep(driver, device, command)
  log.info(string.format("Start room sweep command for %s with room IDs: %s", device.label, command.args.roomIds or ""))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.actions or not spec.actions.start_room_sweep then
    log.warn("Device does not support start_room_sweep action")
    return
  end

  local protocol = get_miot_protocol(device)
  local action = spec.actions.start_room_sweep

  -- Parse room IDs (comma-separated string to array)
  local room_ids = {}
  if command.args.roomIds and command.args.roomIds ~= "" then
    for id in string.gmatch(command.args.roomIds, "([^,]+)") do
      table.insert(room_ids, tonumber(id:match("^%s*(.-)%s*$")))
    end
  end

  local result = protocol:call_action(
    device_data.ip,
    device_data.token,
    action.siid,
    action.aiid,
    room_ids
  )

  if result and result.code == 0 then
    log.info("Start room sweep action executed successfully")
  else
    log.error("Failed to execute start room sweep action")
  end
end

function M.handle_start_dust_arrest(driver, device, command)
  log.info(string.format("Start dust arrest command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.actions or not spec.actions.start_dust_arrest then
    log.warn("Device does not support start_dust_arrest action")
    return
  end

  local protocol = get_miot_protocol(device)
  local action = spec.actions.start_dust_arrest

  local result = protocol:call_action(
    device_data.ip,
    device_data.token,
    action.siid,
    action.aiid,
    {}
  )

  if result and result.code == 0 then
    log.info("Start dust arrest action executed successfully")
  else
    log.error("Failed to execute start dust arrest action")
  end
end

function M.handle_start_mop_wash(driver, device, command)
  log.info(string.format("Start mop wash command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.actions or not spec.actions.start_mop_wash then
    log.warn("Device does not support start_mop_wash action")
    return
  end

  local protocol = get_miot_protocol(device)
  local action = spec.actions.start_mop_wash

  local result = protocol:call_action(
    device_data.ip,
    device_data.token,
    action.siid,
    action.aiid,
    {}
  )

  if result and result.code == 0 then
    log.info("Start mop wash action executed successfully")
  else
    log.error("Failed to execute start mop wash action")
  end
end

function M.handle_start_dry(driver, device, command)
  log.info(string.format("Start dry command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.actions or not spec.actions.start_dry then
    log.warn("Device does not support start_dry action")
    return
  end

  local protocol = get_miot_protocol(device)
  local action = spec.actions.start_dry

  local result = protocol:call_action(
    device_data.ip,
    device_data.token,
    action.siid,
    action.aiid,
    {}
  )

  if result and result.code == 0 then
    log.info("Start dry action executed successfully")
  else
    log.error("Failed to execute start dry action")
  end
end

function M.handle_stop_dry(driver, device, command)
  log.info(string.format("Stop dry command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.actions or not spec.actions.stop_dry then
    log.warn("Device does not support stop_dry action")
    return
  end

  local protocol = get_miot_protocol(device)
  local action = spec.actions.stop_dry

  local result = protocol:call_action(
    device_data.ip,
    device_data.token,
    action.siid,
    action.aiid,
    {}
  )

  if result and result.code == 0 then
    log.info("Stop dry action executed successfully")
  else
    log.error("Failed to execute stop dry action")
  end
end

function M.handle_start_eject(driver, device, command)
  log.info(string.format("Start eject command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.actions or not spec.actions.start_eject then
    log.warn("Device does not support start_eject action")
    return
  end

  local protocol = get_miot_protocol(device)
  local action = spec.actions.start_eject

  local result = protocol:call_action(
    device_data.ip,
    device_data.token,
    action.siid,
    action.aiid,
    {}
  )

  if result and result.code == 0 then
    log.info("Start eject action executed successfully")
  else
    log.error("Failed to execute start eject action")
  end
end

return M
