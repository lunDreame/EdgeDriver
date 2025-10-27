-- MIT License
-- Copyright (c) 2025 lunDreame

local log = require "log"
local capabilities = require "st.capabilities"
local MiotProtocol = require "miot_protocol"

local dehumidifier_mode_capability = capabilities["dictionaryangel05655.dehumidifierMode"]
local humidifier_mode_capability = capabilities["dictionaryangel05655.humidifierMode"]
local target_humidity_capability = capabilities["dictionaryangel05655.targetHumidity"]

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

function M.handle_fan_speed(driver, device, command)
  log.info(string.format("Set fan speed to %d for %s", command.args.speed, device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.properties then
    return
  end

  local protocol = get_miot_protocol(device)

  -- Try fan_level property
  if spec.properties.fan_level then
    local prop = spec.properties.fan_level
    local speed = command.args.speed

    local success = protocol:set_property(
      device_data.ip,
      device_data.token,
      prop.siid,
      prop.piid,
      speed
    )

    if success then
      device:emit_event(capabilities.fanSpeed.fanSpeed(speed))
    else
      log.error("Failed to set fan speed")
    end
  else
    log.warn("Device does not support fan_level property")
  end
end

function M.handle_fan_speed_percent(driver, device, command)
  log.info(string.format("Set fan speed percent to %d for %s", command.args.percent, device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.properties then
    return
  end

  local protocol = get_miot_protocol(device)

  -- Try speed_level property
  if spec.properties.speed_level then
    local prop = spec.properties.speed_level
    local percent = command.args.percent

    local success = protocol:set_property(
      device_data.ip,
      device_data.token,
      prop.siid,
      prop.piid,
      percent
    )

    if success then
      device:emit_event(capabilities.fanSpeedPercent.percent(percent))
    else
      log.error("Failed to set fan speed percent")
    end
  else
    log.warn("Device does not support speed_level property")
  end
end

function M.handle_target_humidity(driver, device, command)
  local humidity = command.args.humidity
  log.info(string.format("Set target humidity to %d for %s", humidity, device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.properties or not spec.properties.target_humidity then
    log.warn("Device does not support target_humidity property")
    return
  end

  local protocol = get_miot_protocol(device)
  local prop = spec.properties.target_humidity

  local success = protocol:set_property(
    device_data.ip,
    device_data.token,
    prop.siid,
    prop.piid,
    humidity
  )

  if success then
    device:emit_event(target_humidity_capability.targetHumidity({ value = humidity, unit = "%" }))
  else
    log.error("Failed to set target humidity")
  end
end

function M.handle_dehumidifier_mode(driver, device, command)
  log.info(string.format("Set dehumidifier mode to %s for %s", command.args.mode, device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.properties or not spec.properties.mode then
    log.warn("Device does not support mode property")
    return
  end

  local mode_map = {
    ["smart"] = 0,
    ["sleep"] = 1,
    ["clothesDrying"] = 2
  }

  local mode_value = mode_map[command.args.mode]
  if not mode_value then
    log.error(string.format("Invalid mode: %s", command.args.mode))
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
    device:emit_event(dehumidifier_mode_capability.dehumidifierMode(command.args.mode))
  else
    log.error("Failed to set dehumidifier mode")
  end
end

function M.handle_humidifier_mode(driver, device, command)
  log.info(string.format("Set humidifier mode to %s for %s", command.args.mode, device.label))

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

  -- Find the mode value from mode_map (reverse lookup)
  local mode_value = nil
  for value, mode_name in pairs(spec.mode_map) do
    if mode_name == command.args.mode then
      mode_value = value
      break
    end
  end

  if not mode_value then
    log.error(string.format("Invalid mode: %s", command.args.mode))
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
    device:emit_event(humidifier_mode_capability.humidifierMode(command.args.mode))
  else
    log.error("Failed to set humidifier mode")
  end
end

return M
