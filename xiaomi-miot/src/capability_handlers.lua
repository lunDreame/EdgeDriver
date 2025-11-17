-- MIT License
-- Copyright (c) 2025 lunDreame

local log = require "log"
local capabilities = require "st.capabilities"
local MiotProtocol = require "miot_protocol"
local MiioProtocol = require "miio_protocol"

local M = {}

local function get_miot_protocol(device)
  local protocol = device:get_field("miot_protocol")
  if not protocol then
    protocol = MiotProtocol.new()
    device:set_field("miot_protocol", protocol)
  end
  return protocol
end

local function get_miio_protocol(device)
  local protocol = device:get_field("miio_protocol")
  if not protocol then
    protocol = MiioProtocol.new()
    device:set_field("miio_protocol", protocol)
  end
  return protocol
end

local function get_device_data(device)
  return device:get_field("xiaomi_miot_data") or {}
end

local function get_device_spec(device)
  return device:get_field("device_spec")
end

function M.handle_switch_on(driver, device, command)
  log.info(string.format("Switch ON command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec then
    log.warn("Device spec not found")
    return
  end

  if spec.protocol == "miio" then
    if not spec.commands or not spec.commands.power_on then
      log.warn("MiIO device does not define commands.power_on")
      return
    end

    local protocol = get_miio_protocol(device)
    local cmd = spec.commands.power_on
    local params = cmd.params or {}

    local result = protocol:send_raw(device_data.ip, device_data.token, cmd.method, params)
    local success = result ~= nil

    if success then
      device:emit_event(capabilities.switch.switch.on())
    else
      log.error("Failed to turn on MiIO switch device")
    end
    return
  end

  if not spec.properties or not spec.properties.power then
    log.warn("Device spec or power property not found")
    return
  end

  local protocol = get_miot_protocol(device)
  local prop = spec.properties.power

  local success = protocol:set_property(
    device_data.ip,
    device_data.token,
    prop.siid,
    prop.piid,
    true
  )

  if success then
    device:emit_event(capabilities.switch.switch.on())
  else
    log.error("Failed to turn on device")
  end
end

function M.handle_switch_off(driver, device, command)
  log.info(string.format("Switch OFF command for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec then
    log.warn("Device spec not found")
    return
  end

  if spec.protocol == "miio" then
    if not spec.commands or not spec.commands.power_off then
      log.warn("MiIO device does not define commands.power_off")
      return
    end

    local protocol = get_miio_protocol(device)
    local cmd = spec.commands.power_off
    local params = cmd.params or {}

    local result = protocol:send_raw(device_data.ip, device_data.token, cmd.method, params)
    local success = result ~= nil

    if success then
      device:emit_event(capabilities.switch.switch.off())
    else
      log.error("Failed to turn off MiIO switch device")
    end
    return
  end

  if not spec.properties or not spec.properties.power then
    log.warn("Device spec or power property not found")
    return
  end

  local protocol = get_miot_protocol(device)
  local prop = spec.properties.power

  local success = protocol:set_property(
    device_data.ip,
    device_data.token,
    prop.siid,
    prop.piid,
    false
  )

  if success then
    device:emit_event(capabilities.switch.switch.off())
  else
    log.error("Failed to turn off device")
  end
end

function M.handle_switch_level(driver, device, command)
  log.info(string.format("Set level to %d for %s", command.args.level, device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec then
    log.warn("Device spec not found")
    return
  end

  local level = command.args.level

  if spec.protocol == "miio" then
    if not spec.commands or not spec.commands.set_brightness then
      log.warn("MiIO device does not define commands.set_brightness")
      return
    end

    local protocol = get_miio_protocol(device)
    local cmd = spec.commands.set_brightness
    local params = {}

    if cmd.param_key then
      params = { level }
    else
      params = cmd.params or {}
    end

    local result = protocol:send_raw(device_data.ip, device_data.token, cmd.method, params)
    local success = result ~= nil

    if success then
      device:emit_event(capabilities.switchLevel.level(level))
    else
      log.error("Failed to set brightness for MiIO device")
    end
    return
  end

  if not spec.properties or not spec.properties.brightness then
    log.warn("Device spec or brightness property not found")
    return
  end

  local protocol = get_miot_protocol(device)
  local prop = spec.properties.brightness

  local success = protocol:set_property(
    device_data.ip,
    device_data.token,
    prop.siid,
    prop.piid,
    level
  )

  if success then
    device:emit_event(capabilities.switchLevel.level(level))
  else
    log.error("Failed to set level")
  end
end

function M.handle_color_temperature(driver, device, command)
  log.info(string.format("Set color temperature to %d for %s", command.args.temperature, device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec then
    log.warn("Device spec not found")
    return
  end

  local kelvin = command.args.temperature

  if spec.protocol == "miio" then
    if not spec.commands or not spec.commands.set_color_temperature then
      log.warn("MiIO device does not define commands.set_color_temperature")
      return
    end

    local protocol = get_miio_protocol(device)
    local cmd = spec.commands.set_color_temperature
    local params = {}

    if cmd.param_key then
      params = { kelvin, "smooth", 500 }
    else
      params = cmd.params or {}
    end

    local result = protocol:send_raw(device_data.ip, device_data.token, cmd.method, params)
    local success = result ~= nil

    if success then
      device:emit_event(capabilities.colorTemperature.colorTemperature(kelvin))
    else
      log.error("Failed to set color temperature for MiIO device")
    end
    return
  end

  if not spec.properties or not spec.properties.color_temperature then
    log.warn("Device spec or color_temperature property not found")
    return
  end

  local protocol = get_miot_protocol(device)
  local prop = spec.properties.color_temperature

  local success = protocol:set_property(
    device_data.ip,
    device_data.token,
    prop.siid,
    prop.piid,
    kelvin
  )

  if success then
    device:emit_event(capabilities.colorTemperature.colorTemperature(kelvin))
  else
    log.error("Failed to set color temperature")
  end
end

function M.handle_fan_speed(driver, device, command)
  log.info(string.format("Set fan speed to %d for %s", command.args.speed, device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.properties then
    log.warn("Device spec not found")
    return
  end

  local protocol = get_miot_protocol(device)
  local speed = command.args.speed
  local device_type = spec.device_type

  -- If speed is 0, turn off the device (fan_level doesn't support 0/off)
  if speed == 0 then
    if not spec.properties.power then
      log.warn("Device spec or power property not found")
      return
    end

    local power_prop = spec.properties.power
    local success = protocol:set_property(
      device_data.ip,
      device_data.token,
      power_prop.siid,
      power_prop.piid,
      false
    )

    if success then
      device:emit_event(capabilities.switch.switch.off())
      device:emit_event(capabilities.fanSpeed.fanSpeed(0))
    else
      log.error("Failed to turn off device")
    end
    return
  end

  -- Check if power is off, turn it on first (fan_level control requires power on)
  local current_power_state = device:get_latest_state("main", capabilities.switch.ID, capabilities.switch.switch.NAME)
  if current_power_state == "off" then
    log.info("Power is off, turning on before setting fan speed")

    if not spec.properties.power then
      log.warn("Device spec or power property not found")
      return
    end

    local power_prop = spec.properties.power
    local power_success = protocol:set_property(
      device_data.ip,
      device_data.token,
      power_prop.siid,
      power_prop.piid,
      true
    )

    if power_success then
      device:emit_event(capabilities.switch.switch.on())
    else
      log.error("Failed to turn on device before setting fan speed")
      return
    end
  end

  local prop = spec.properties.fan_level

  if not prop then
    log.warn("Device does not support fan_level property")
    return
  end

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
end

function M.handle_fan_speed_percent(driver, device, command)
  log.info(string.format("Set fan speed percent to %d for %s", command.args.percent, device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.properties then
    log.warn("Device spec not found")
    return
  end

  local protocol = get_miot_protocol(device)
  local percent = command.args.percent
  local device_type = spec.device_type

  -- If percent is 0, turn off the device
  if percent == 0 then
    if not spec.properties.power then
      log.warn("Device spec or power property not found")
      return
    end

    local power_prop = spec.properties.power
    local success = protocol:set_property(
      device_data.ip,
      device_data.token,
      power_prop.siid,
      power_prop.piid,
      false
    )

    if success then
      device:emit_event(capabilities.switch.switch.off())
      device:emit_event(capabilities.fanSpeedPercent.percent(0))
    else
      log.error("Failed to turn off device")
    end
    return
  end

  -- Check if power is off, turn it on first
  local current_power_state = device:get_latest_state("main", capabilities.switch.ID, capabilities.switch.switch.NAME)
  if current_power_state == "off" then
    log.info("Power is off, turning on before setting fan speed percent")

    if not spec.properties.power then
      log.warn("Device spec or power property not found")
      return
    end

    local power_prop = spec.properties.power
    local power_success = protocol:set_property(
      device_data.ip,
      device_data.token,
      power_prop.siid,
      power_prop.piid,
      true
    )

    if power_success then
      device:emit_event(capabilities.switch.switch.on())
    else
      log.error("Failed to turn on device before setting fan speed percent")
      return
    end
  end

  local prop = spec.properties.speed_level

  if not prop then
    log.warn("Device does not support speed_level property")
    return
  end

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
end

function M.handle_cooling_setpoint(driver, device, command)
  log.info(string.format("Set cooling setpoint to %d for %s", command.args.setpoint, device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.properties or not spec.properties.target_temperature then
    log.warn("Device spec or target_temperature property not found")
    return
  end

  local protocol = get_miot_protocol(device)
  local prop = spec.properties.target_temperature

  local temp = command.args.setpoint

  local success = protocol:set_property(
    device_data.ip,
    device_data.token,
    prop.siid,
    prop.piid,
    temp
  )

  if success then
    device:emit_event(capabilities.thermostatCoolingSetpoint.coolingSetpoint({ value = temp, unit = "C" }))
  else
    log.error("Failed to set cooling setpoint")
  end
end

function M.handle_heating_setpoint(driver, device, command)
  log.info(string.format("Set heating setpoint to %d for %s", command.args.setpoint, device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.properties or not spec.properties.target_temperature then
    log.warn("Device spec or target_temperature property not found")
    return
  end

  local protocol = get_miot_protocol(device)
  local prop = spec.properties.target_temperature

  local temp = command.args.setpoint

  local success = protocol:set_property(
    device_data.ip,
    device_data.token,
    prop.siid,
    prop.piid,
    temp
  )

  if success then
    device:emit_event(capabilities.thermostatHeatingSetpoint.heatingSetpoint({ value = temp, unit = "C" }))
  else
    log.error("Failed to set heating setpoint")
  end
end

function M.handle_thermostat_mode(driver, device, command)
  log.info(string.format("Set thermostat mode to %s for %s", command.args.mode, device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  local protocol = get_miot_protocol(device)

  -- Handle "off" mode by turning off power
  if command.args.mode == "off" then
    if spec and spec.properties and spec.properties.power then
      local power_prop = spec.properties.power
      local success = protocol:set_property(
        device_data.ip,
        device_data.token,
        power_prop.siid,
        power_prop.piid,
        false
      )

      if success then
        device:emit_event(capabilities.switch.switch.off())
        device:emit_event(capabilities.thermostatMode.thermostatMode("off"))
      else
        log.error("Failed to turn off device")
      end
      return
    end
  end

  if not spec or not spec.properties or not spec.properties.mode then
    log.warn("Device spec or mode property not found")
    return
  end

  local prop = spec.properties.mode

  -- Find mode value from device spec's mode_map (reverse lookup)
  local mode_value = nil
  if spec.mode_map then
    for value, mode_name in pairs(spec.mode_map) do
      if mode_name == command.args.mode then
        mode_value = value
        break
      end
    end
  end

  -- Fallback to default mapping if not found in mode_map
  if not mode_value then
    local default_mode_map = {
      cool = 1,
      heat = 3,
      auto = 0,
      dry = 2,
      fan = 4,
    }
    mode_value = default_mode_map[command.args.mode]
  end

  if not mode_value then
    log.warn("Unknown thermostat mode: " .. command.args.mode)
    return
  end

  -- Make sure device is on before changing mode
  local current_power_state = device:get_latest_state("main", capabilities.switch.ID, capabilities.switch.switch.NAME)
  if current_power_state == "off" then
    if spec.properties.power then
      local power_prop = spec.properties.power
      local power_success = protocol:set_property(
        device_data.ip,
        device_data.token,
        power_prop.siid,
        power_prop.piid,
        true
      )

      if power_success then
        device:emit_event(capabilities.switch.switch.on())
        log.info("Turned on device before setting mode")
      else
        log.error("Failed to turn on device before setting mode")
        return
      end
    end
  end

  local success = protocol:set_property(
    device_data.ip,
    device_data.token,
    prop.siid,
    prop.piid,
    mode_value
  )

  if success then
    device:emit_event(capabilities.thermostatMode.thermostatMode(command.args.mode))
  else
    log.error("Failed to set thermostat mode")
  end
end

function M.handle_set_color(driver, device, command)
  log.info(string.format("Set color for %s", device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec then
    log.warn("Device spec not found")
    return
  end

  local utils = require "utils"
  local hue = command.args.color.hue
  local saturation = command.args.color.saturation

  -- Convert HSV to RGB (SmartThings uses hue 0-100, saturation 0-100)
  local h = hue * 3.6 -- Convert to 0-360
  local s = saturation / 100
  local v = 1.0

  local c = v * s
  local x = c * (1 - math.abs((h / 60) % 2 - 1))
  local m = v - c

  local r, g, b
  if h < 60 then
    r, g, b = c, x, 0
  elseif h < 120 then
    r, g, b = x, c, 0
  elseif h < 180 then
    r, g, b = 0, c, x
  elseif h < 240 then
    r, g, b = 0, x, c
  elseif h < 300 then
    r, g, b = x, 0, c
  else
    r, g, b = c, 0, x
  end

  r = math.floor((r + m) * 255)
  g = math.floor((g + m) * 255)
  b = math.floor((b + m) * 255)

  local rgb_value = utils.rgb_to_int(r, g, b)

  if spec.protocol == "miio" then
    if not spec.commands or not spec.commands.set_rgb_int then
      log.warn("MiIO device does not define commands.set_rgb_int")
      return
    end

    local protocol = get_miio_protocol(device)
    local cmd = spec.commands.set_rgb_int
    local params = {}

    if cmd.param_key then
      params = { rgb_value, "smooth", 500 }
    else
      params = cmd.params or {}
    end

    local result = protocol:send_raw(device_data.ip, device_data.token, cmd.method, params)
    local success = result ~= nil

    if success then
      device:emit_event(capabilities.colorControl.color(command.args.color))
    else
      log.error("Failed to set color for MiIO device")
    end
    return
  end

  if not spec.properties or not spec.properties.color then
    log.warn("Device spec or color property not found")
    return
  end

  local protocol = get_miot_protocol(device)
  local prop = spec.properties.color

  local success = protocol:set_property(
    device_data.ip,
    device_data.token,
    prop.siid,
    prop.piid,
    rgb_value
  )

  if success then
    device:emit_event(capabilities.colorControl.color(command.args.color))
  else
    log.error("Failed to set color")
  end
end

function M.handle_set_hue(driver, device, command)
  log.info(string.format("Set hue to %d for %s", command.args.hue, device.label))

  -- Get current saturation from device state
  local current_state = device:get_latest_state("main", capabilities.colorControl.ID,
    capabilities.colorControl.saturation.NAME)
  local saturation = current_state or 100

  M.handle_set_color(driver, device, {
    args = {
      color = {
        hue = command.args.hue,
        saturation = saturation
      }
    }
  })
end

function M.handle_set_saturation(driver, device, command)
  log.info(string.format("Set saturation to %d for %s", command.args.saturation, device.label))

  -- Get current hue from device state
  local current_state = device:get_latest_state("main", capabilities.colorControl.ID, capabilities.colorControl.hue.NAME)
  local hue = current_state or 0

  M.handle_set_color(driver, device, {
    args = {
      color = {
        hue = hue,
        saturation = command.args.saturation
      }
    }
  })
end

function M.handle_fan_oscillation_mode(driver, device, command)
  log.info(string.format("Set fan oscillation mode to %s for %s", command.args.fanOscillationMode, device.label))

  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not spec or not spec.properties then
    log.warn("Device spec not found")
    return
  end

  local protocol = get_miot_protocol(device)
  local mode = command.args.fanOscillationMode
  local success = false

  -- Handle horizontal oscillation
  if mode == "horizontal" and spec.properties.horizontal_swing then
    local prop = spec.properties.horizontal_swing
    success = protocol:set_property(
      device_data.ip,
      device_data.token,
      prop.siid,
      prop.piid,
      true
    )
    if success then
      device:emit_event(capabilities.fanOscillationMode.fanOscillationMode.horizontal())
    end
    -- Handle vertical oscillation
  elseif mode == "vertical" and spec.properties.vertical_swing then
    local prop = spec.properties.vertical_swing
    success = protocol:set_property(
      device_data.ip,
      device_data.token,
      prop.siid,
      prop.piid,
      true
    )
    if success then
      device:emit_event(capabilities.fanOscillationMode.fanOscillationMode.vertical())
    end
    -- Handle fixed (turn off oscillation)
  elseif mode == "fixed" then
    if spec.properties.horizontal_swing then
      local prop = spec.properties.horizontal_swing
      success = protocol:set_property(
        device_data.ip,
        device_data.token,
        prop.siid,
        prop.piid,
        false
      )
    end
    if success then
      device:emit_event(capabilities.fanOscillationMode.fanOscillationMode.fixed())
    end
  else
    log.warn(string.format("Device does not support oscillation mode: %s", mode))
    return
  end

  if not success then
    log.error("Failed to set fan oscillation mode")
  end
end

function M.handle_fan_mode(driver, device, command)
  log.info(string.format("Set fan mode to %s for %s", command.args.mode, device.label))

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

  local fan_mode_capability = capabilities["dictionaryangel05655.fanMode"]

  -- Find the mode value from mode_map (reverse lookup)
  local mode_value = nil
  for value, mode_name in pairs(spec.mode_map) do
    if mode_name == command.args.mode then
      mode_value = value
      break
    end
  end

  if not mode_value then
    log.error(string.format("Invalid fan mode: %s", command.args.mode))
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
    device:emit_event(fan_mode_capability.fanMode(command.args.mode))
  else
    log.error("Failed to set fan mode")
  end
end

function M.handle_air_purifier_mode(driver, device, command)
  log.info(string.format("Set air purifier mode to %s for %s", command.args.mode, device.label))

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

  local air_purifier_mode_capability = capabilities["dictionaryangel05655.airPurifierMode"]

  -- Find the mode value from mode_map (reverse lookup)
  local mode_value = nil
  for value, mode_name in pairs(spec.mode_map) do
    if mode_name == command.args.mode then
      mode_value = value
      break
    end
  end

  if not mode_value then
    log.error(string.format("Invalid air purifier mode: %s", command.args.mode))
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
    device:emit_event(air_purifier_mode_capability.airPurifierMode(command.args.mode))
  else
    log.error("Failed to set air purifier mode")
  end
end

return M
