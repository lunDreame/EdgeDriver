-- MIT License
-- Copyright (c) 2025 lunDreame

local log = require "log"
local capabilities = require "st.capabilities"
local cosock = require "cosock"
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

function M.update_device_state(device)
  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not device_data.ip or not device_data.token then
    log.warn(string.format("Device %s not configured", device.label))
    return
  end

  if not spec or not spec.properties then
    log.warn(string.format("Device spec not found for %s", device.label))
    return
  end

  local protocol = get_miot_protocol(device)

  -- Get all properties at once
  local params = {}
  for name, prop in pairs(spec.properties) do
    table.insert(params, { siid = prop.siid, piid = prop.piid })
  end

  local result = protocol:send_command(
    device_data.ip,
    device_data.token,
    "get_properties",
    params
  )

  if not result or not result.result then
    log.error(string.format("Failed to get properties for %s", device.label))
    device:offline()
    return
  end

  device:online()

  -- Set supported modes and ranges if not already set
  if spec.device_type == "fan" or spec.device_type == "air-purifier" or spec.device_type == "climate" then
    -- Set supported oscillation modes
    local current_supported = device:get_latest_state("main", capabilities.fanOscillationMode.ID,
      capabilities.fanOscillationMode.supportedFanOscillationModes.NAME)

    if not current_supported then
      local supported_modes = { "fixed" }
      if spec.properties and (spec.properties.horizontal_swing or spec.properties.vertical_swing) then
        if spec.properties.horizontal_swing then
          table.insert(supported_modes, "horizontal")
        end
        if spec.properties.vertical_swing then
          table.insert(supported_modes, "vertical")
        end

        device:emit_event(capabilities.fanOscillationMode.supportedFanOscillationModes(supported_modes,
          { visibility = { displayed = false } }))
        log.debug(string.format("Set supported oscillation modes: %s", table.concat(supported_modes, ", ")))
      end
    end
  end

  -- Set supported fan modes for fan devices
  if spec.device_type == "fan" and spec.mode_map then
    local current_supported = device:get_latest_state("main", capabilities["dictionaryangel05655.fanMode"].ID,
      capabilities["dictionaryangel05655.fanMode"].supportedFanModes.NAME)

    if not current_supported then
      local fan_mode_capability = capabilities["dictionaryangel05655.fanMode"]
      local supported_modes = {}
      for mode_value, mode_name in pairs(spec.mode_map) do
        table.insert(supported_modes, mode_name)
      end

      if #supported_modes > 0 then
        device:emit_event(fan_mode_capability.supportedFanModes(supported_modes,
          { visibility = { displayed = false } }))
        log.debug(string.format("Set supported fan modes: %s", table.concat(supported_modes, ", ")))
      end
    end
  end

  -- Set supported fan modes for air-purifier
  if spec.device_type == "air-purifier" and spec.mode_map then
    local current_supported = device:get_latest_state("main", capabilities["dictionaryangel05655.fanMode"].ID,
      capabilities["dictionaryangel05655.fanMode"].supportedFanModes.NAME)

    if not current_supported then
      local fan_mode_capability = capabilities["dictionaryangel05655.fanMode"]
      local supported_modes = {}
      for mode_value, mode_name in pairs(spec.mode_map) do
        table.insert(supported_modes, mode_name)
      end

      if #supported_modes > 0 then
        device:emit_event(fan_mode_capability.supportedFanModes(supported_modes,
          { visibility = { displayed = false } }))
        log.debug(string.format("Set supported air purifier modes: %s", table.concat(supported_modes, ", ")))
      end
    end
  end

  -- Set supported thermostat modes for climate
  if spec.device_type == "climate" then
    local current_supported = device:get_latest_state("main", capabilities.thermostatMode.ID,
      capabilities.thermostatMode.supportedThermostatModes.NAME)

    if not current_supported then
      local supported_modes = {}
      if spec.mode_map then
        for mode_value, mode_name in pairs(spec.mode_map) do
          table.insert(supported_modes, mode_name)
        end
      else
        -- fallback to default modes
        supported_modes = { "auto", "cool", "heat", "dry", "fan" }
      end
      table.insert(supported_modes, "off")

      if #supported_modes > 1 then
        device:emit_event(capabilities.thermostatMode.supportedThermostatModes(supported_modes,
          { visibility = { displayed = false } }))
        log.debug(string.format("Set supported thermostat modes: %s", table.concat(supported_modes, ", ")))
      end
    end
  end

  -- Set supported humidifier modes
  if spec.device_type == "humidifier" and spec.mode_map then
    local current_supported = device:get_latest_state("main", capabilities["dictionaryangel05655.humidifierMode"].ID,
      capabilities["dictionaryangel05655.humidifierMode"].supportedHumidifierModes.NAME)

    if not current_supported then
      local humidifier_mode_capability = capabilities["dictionaryangel05655.humidifierMode"]
      local supported_modes = {}
      for mode_value, mode_name in pairs(spec.mode_map) do
        table.insert(supported_modes, mode_name)
      end

      if #supported_modes > 0 then
        device:emit_event(humidifier_mode_capability.supportedHumidifierModes(supported_modes,
          { visibility = { displayed = false } }))
        log.debug(string.format("Set supported humidifier modes: %s", table.concat(supported_modes, ", ")))
      end
    end
  end

  -- Set target humidity range for dehumidifier, humidifier, and climate
  if (spec.device_type == "dehumidifier" or spec.device_type == "humidifier" or spec.device_type == "climate") and spec.properties and spec.properties.target_humidity then
    local current_range = device:get_latest_state("main", capabilities["dictionaryangel05655.targetHumidity"].ID,
      capabilities["dictionaryangel05655.targetHumidity"].targetHumidityRange.NAME)

    if not current_range then
      local target_humidity_capability = capabilities["dictionaryangel05655.targetHumidity"]
      local humidity_prop = spec.properties.target_humidity
      if humidity_prop.min and humidity_prop.max then
        device:emit_event(target_humidity_capability.targetHumidityRange({
          value = {
            minimum = humidity_prop.min,
            maximum = humidity_prop.max,
            step = humidity_prop.step or 1
          },
          unit = "%"
        }, { visibility = { displayed = false } }))
        log.debug(string.format("Target humidity range: %d%% - %d%% (step: %d%%)",
          humidity_prop.min, humidity_prop.max, humidity_prop.step or 1))
      end
    end
  end

  -- Set temperature range for heater and climate
  if (spec.device_type == "heater" or spec.device_type == "climate") and spec.properties and spec.properties.target_temperature then
    local current_range = device:get_latest_state("main", capabilities.thermostatHeatingSetpoint.ID,
      capabilities.thermostatHeatingSetpoint.heatingSetpointRange.NAME)

    if not current_range then
      local temp_prop = spec.properties.target_temperature
      if temp_prop.min and temp_prop.max then
        device:emit_event(capabilities.thermostatHeatingSetpoint.heatingSetpointRange({
          value = {
            minimum = temp_prop.min,
            maximum = temp_prop.max,
            step = temp_prop.step or 1
          },
          unit = "C"
        }, { visibility = { displayed = false } }))
        log.debug(string.format("Target temperature range: %d°C - %d°C (step: %.1f°C)",
          temp_prop.min, temp_prop.max, temp_prop.step or 1))
      end
    end
  end

  -- Process results and emit events
  for _, prop_result in ipairs(result.result) do
    if prop_result.code == 0 then
      M.process_property_value(device, spec, prop_result.siid, prop_result.piid, prop_result.value)
    else
      log.warn(string.format("Property error: siid=%d, piid=%d, code=%d",
        prop_result.siid, prop_result.piid, prop_result.code))
    end
  end
end

function M.process_property_value(device, spec, siid, piid, value)
  local device_type = spec.device_type
  local utils = require "utils"

  -- Find property name
  local prop_name = nil
  for name, prop in pairs(spec.properties) do
    if prop.siid == siid and prop.piid == piid then
      prop_name = name
      break
    end
  end

  if not prop_name then
    return
  end

  log.debug(string.format("Processing property: %s = %s", prop_name, tostring(value)))

  -- Emit appropriate events based on property
  if prop_name == "power" then
    local current_state = device:get_latest_state("main", capabilities.switch.ID, capabilities.switch.switch.NAME)
    local new_state = value and "on" or "off"
    if current_state ~= new_state then
      if value then
        device:emit_event(capabilities.switch.switch.on())
      else
        device:emit_event(capabilities.switch.switch.off())
        -- When power is off, set fan speed to 0 (fan_level doesn't support 0/off)
        if device_type == "fan" or device_type == "air-purifier" then
          local current_speed = device:get_latest_state("main", capabilities.fanSpeed.ID,
            capabilities.fanSpeed.fanSpeed.NAME)
          if current_speed and current_speed ~= 0 then
            device:emit_event(capabilities.fanSpeed.fanSpeed(0))
          end
          local current_speed_percent = device:get_latest_state("main", capabilities.fanSpeedPercent.ID,
            capabilities.fanSpeedPercent.percent.NAME)
          if current_speed_percent and current_speed_percent ~= 0 then
            device:emit_event(capabilities.fanSpeedPercent.percent(0))
          end
        elseif device_type == "climate" then
          -- Set thermostat mode to "off" when power is off
          local current_mode = device:get_latest_state("main", capabilities.thermostatMode.ID,
            capabilities.thermostatMode.thermostatMode.NAME)
          if current_mode ~= "off" then
            device:emit_event(capabilities.thermostatMode.thermostatMode("off"))
          end
        end
      end
    end
  elseif prop_name == "brightness" then
    if device_type == "light" or device_type == "climate" then
      local current_level = device:get_latest_state("main", capabilities.switchLevel.ID,
        capabilities.switchLevel.level.NAME)
      if current_level ~= value then
        device:emit_event(capabilities.switchLevel.level(value))
      end
    else
      -- For air purifier, fan, etc. - just store the value
      log.debug(string.format("Brightness: %s", tostring(value)))
    end
  elseif prop_name == "color_temperature" then
    local current_ct = device:get_latest_state("main", capabilities.colorTemperature.ID,
      capabilities.colorTemperature.colorTemperature.NAME)
    if current_ct ~= value then
      device:emit_event(capabilities.colorTemperature.colorTemperature(value))
    end
  elseif prop_name == "color" then
    -- Convert RGB integer to HSV for SmartThings
    local r, g, b = utils.int_to_rgb(value)

    -- RGB to HSV conversion
    r, g, b = r / 255, g / 255, b / 255
    local max = math.max(r, g, b)
    local min = math.min(r, g, b)
    local delta = max - min

    local hue, saturation, brightness = 0, 0, max

    if delta > 0 then
      saturation = delta / max

      if max == r then
        hue = 60 * (((g - b) / delta) % 6)
      elseif max == g then
        hue = 60 * (((b - r) / delta) + 2)
      else
        hue = 60 * (((r - g) / delta) + 4)
      end
    end

    -- SmartThings uses hue 0-100, saturation 0-100
    hue = math.floor(hue / 3.6)
    saturation = math.floor(saturation * 100)

    local current_hue = device:get_latest_state("main", capabilities.colorControl.ID, capabilities.colorControl.hue.NAME)
    local current_sat = device:get_latest_state("main", capabilities.colorControl.ID,
      capabilities.colorControl.saturation.NAME)

    if current_hue ~= hue or current_sat ~= saturation then
      device:emit_event(capabilities.colorControl.hue(hue))
      device:emit_event(capabilities.colorControl.saturation(saturation))
      device:emit_event(capabilities.colorControl.color({ hue = hue, saturation = saturation }))
    end
  elseif prop_name == "temperature" then
    -- Filter out invalid temperature values (Xiaomi devices use values like -4001 to indicate "no value")
    if value and value >= -40 and value <= 100 then
      local current_temp = device:get_latest_state("main", capabilities.temperatureMeasurement.ID,
        capabilities.temperatureMeasurement.temperature.NAME)
      if not current_temp or math.abs(current_temp - value) >= 0.1 then
        device:emit_event(capabilities.temperatureMeasurement.temperature({ value = value, unit = "C" }))
      end
    else
      log.debug(string.format("Invalid temperature value ignored: %s", tostring(value)))
    end
  elseif prop_name == "target_temperature" then
    if device_type == "climate" then
      local current_cooling = device:get_latest_state("main", capabilities.thermostatCoolingSetpoint.ID,
        capabilities.thermostatCoolingSetpoint.coolingSetpoint.NAME)
      local current_heating = device:get_latest_state("main", capabilities.thermostatHeatingSetpoint.ID,
        capabilities.thermostatHeatingSetpoint.heatingSetpoint.NAME)

      if not current_cooling or math.abs(current_cooling - value) >= 0.5 then
        device:emit_event(capabilities.thermostatCoolingSetpoint.coolingSetpoint({ value = value, unit = "C" }))
      end
      if not current_heating or math.abs(current_heating - value) >= 0.5 then
        device:emit_event(capabilities.thermostatHeatingSetpoint.heatingSetpoint({ value = value, unit = "C" }))
      end
    elseif device_type == "heater" then
      local current_heating = device:get_latest_state("main", capabilities.thermostatHeatingSetpoint.ID,
        capabilities.thermostatHeatingSetpoint.heatingSetpoint.NAME)
      if not current_heating or math.abs(current_heating - value) >= 0.5 then
        device:emit_event(capabilities.thermostatHeatingSetpoint.heatingSetpoint({ value = value, unit = "C" }))
      end
    end
  elseif prop_name == "mode" then
    if device_type == "climate" then
      -- Use mode_map from device spec if available
      local st_mode = "auto"
      if spec.mode_map and spec.mode_map[value] then
        st_mode = spec.mode_map[value]
      else
        -- Fallback to default mapping
        local mode_map = {
          [0] = "auto",
          [1] = "cool",
          [2] = "dry",
          [3] = "heat",
          [4] = "fan",
        }
        st_mode = mode_map[value] or "auto"
      end

      local current_mode = device:get_latest_state("main", capabilities.thermostatMode.ID,
        capabilities.thermostatMode.thermostatMode.NAME)
      if current_mode ~= st_mode then
        device:emit_event(capabilities.thermostatMode.thermostatMode(st_mode))
        log.info(string.format("Thermostat mode changed to: %s (%d)", st_mode, value))
      end
    elseif device_type == "fan" then
      -- Map fan mode using mode_map from device spec
      if spec.mode_map and spec.mode_map[value] then
        local fan_mode_capability = capabilities["dictionaryangel05655.fanMode"]
        local mode_name = spec.mode_map[value]

        local current_mode = device:get_latest_state("main", fan_mode_capability.ID,
          fan_mode_capability.fanMode.NAME)
        if current_mode ~= mode_name then
          device:emit_event(fan_mode_capability.fanMode(mode_name))
          log.info(string.format("Fan mode changed to: %s (%d)", mode_name, value))
        end
      end
    elseif device_type == "dehumidifier" then
      -- Map dehumidifier mode to custom capability
      local dehumidifier_mode_capability = capabilities["dictionaryangel05655.dehumidifierMode"]
      local mode_map = {
        [0] = "smart",
        [1] = "sleep",
        [2] = "clothesDrying"
      }

      local mode_value = mode_map[value]
      if mode_value then
        local current_mode = device:get_latest_state("main", dehumidifier_mode_capability.ID,
          dehumidifier_mode_capability.dehumidifierMode.NAME)
        if current_mode ~= mode_value then
          device:emit_event(dehumidifier_mode_capability.dehumidifierMode(mode_value))
          log.info(string.format("Dehumidifier mode changed to: %s (%d)", mode_value, value))
        end
      else
        log.warn(string.format("Unknown dehumidifier mode value: %d", value))
      end
    elseif device_type == "humidifier" then
      -- Map humidifier mode to custom capability
      local humidifier_mode_capability = capabilities["dictionaryangel05655.humidifierMode"]

      if spec.mode_map and spec.mode_map[value] then
        local mode_value = spec.mode_map[value]
        local current_mode = device:get_latest_state("main", humidifier_mode_capability.ID,
          humidifier_mode_capability.humidifierMode.NAME)
        if current_mode ~= mode_value then
          device:emit_event(humidifier_mode_capability.humidifierMode(mode_value))
          log.info(string.format("Humidifier mode changed to: %s (%d)", mode_value, value))
        end
      else
        log.debug(string.format("Humidifier mode value: %d (no mapping available)", value))
      end
    elseif device_type == "air-purifier" then
      -- Map air purifier mode to custom capability
      local fan_mode_capability = capabilities["dictionaryangel05655.fanMode"]

      if spec.mode_map and spec.mode_map[value] then
        local mode_value = spec.mode_map[value]
        local current_mode = device:get_latest_state("main", fan_mode_capability.ID,
          fan_mode_capability.fanMode.NAME)
        if current_mode ~= mode_value then
          device:emit_event(fan_mode_capability.fanMode(mode_value))
          log.info(string.format("Air purifier mode changed to: %s (%d)", mode_value, value))
        end
      else
        log.debug(string.format("Air purifier mode value: %d (no mapping available)", value))
      end
    elseif device_type == "heater" then
      -- Store heater mode
      if spec.mode_map and spec.mode_map[value] then
        local mode_name = spec.mode_map[value]
        log.info(string.format("Heater mode changed to: %s (%d)", mode_name, value))
      else
        log.debug(string.format("Heater mode value: %d", value))
      end
    end
  elseif prop_name == "fan_level" then
    if device_type == "fan" or device_type == "air-purifier" or device_type == "climate" or device_type == "dehumidifier" then
      local current_speed = device:get_latest_state("main", capabilities.fanSpeed.ID, capabilities.fanSpeed.fanSpeed
        .NAME)
      if current_speed ~= value then
        device:emit_event(capabilities.fanSpeed.fanSpeed(value))
      end
    end
  elseif prop_name == "speed_level" then
    if device_type == "fan" or device_type == "air-purifier" or device_type == "humidifier" then
      local current_speed_percent = device:get_latest_state("main", capabilities.fanSpeedPercent.ID,
        capabilities.fanSpeedPercent.percent.NAME)
      if current_speed_percent ~= value then
        device:emit_event(capabilities.fanSpeedPercent.percent(value))
      end
    end
  elseif prop_name == "horizontal_swing" then
    if device_type == "fan" or device_type == "air-purifier" or device_type == "climate" then
      local oscillation_mode = value and "horizontal" or "fixed"
      local current_mode = device:get_latest_state("main", capabilities.fanOscillationMode.ID,
        capabilities.fanOscillationMode.fanOscillationMode.NAME)
      if current_mode ~= oscillation_mode then
        if value then
          device:emit_event(capabilities.fanOscillationMode.fanOscillationMode.horizontal())
        else
          device:emit_event(capabilities.fanOscillationMode.fanOscillationMode.fixed())
        end
        log.info(string.format("Oscillation mode changed to: %s (%s)", oscillation_mode, tostring(value)))
      end
    end
  elseif prop_name == "vertical_swing" then
    if device_type == "fan" or device_type == "air-purifier" or device_type == "climate" then
      local oscillation_mode = value and "vertical" or "fixed"
      local current_mode = device:get_latest_state("main", capabilities.fanOscillationMode.ID,
        capabilities.fanOscillationMode.fanOscillationMode.NAME)
      if current_mode ~= oscillation_mode then
        if value then
          device:emit_event(capabilities.fanOscillationMode.fanOscillationMode.vertical())
        else
          device:emit_event(capabilities.fanOscillationMode.fanOscillationMode.fixed())
        end
        log.info(string.format("Oscillation mode changed to: %s (%s)", oscillation_mode, tostring(value)))
      end
    end
  elseif prop_name == "vertical_angle" then
    log.debug(string.format("Vertical angle: %d", value))
  elseif prop_name == "water_level" then
    log.debug(string.format("Water level: %s", tostring(value)))
  elseif prop_name == "filter_left_time" then
    log.debug(string.format("Filter time remaining: %s", tostring(value)))
  elseif prop_name == "anion" then
    log.debug(string.format("Anion (negative ion): %s", tostring(value)))
  elseif prop_name == "eco" then
    log.debug(string.format("Eco mode: %s", tostring(value)))
  elseif prop_name == "dryer" then
    log.debug(string.format("Dryer: %s", tostring(value)))
  elseif prop_name == "heater" then
    log.debug(string.format("Heater: %s", tostring(value)))
  elseif prop_name == "sleep_mode" then
    log.debug(string.format("Sleep mode: %s", tostring(value)))
  elseif prop_name == "uv" then
    log.debug(string.format("UV: %s", tostring(value)))
  elseif prop_name == "charging_state" then
    log.debug(string.format("Charging state: %s", tostring(value)))
  elseif prop_name == "hcho" then
    -- Formaldehyde measurement in mg/m³
    local current_hcho = device:get_latest_state("main", capabilities.formaldehydeMeasurement.ID,
      capabilities.formaldehydeMeasurement.formaldehydeLevel.NAME)
    if not current_hcho or math.abs(current_hcho - value) >= 0.001 then
      device:emit_event(capabilities.formaldehydeMeasurement.formaldehydeLevel({ value = value, unit = "mg/m^3" }))
      log.debug(string.format("Formaldehyde (HCHO): %.3f mg/m³", value))
    end
  elseif prop_name == "tvoc" then
    -- TVOC measurement in μg/m³
    local current_tvoc = device:get_latest_state("main", capabilities.tvocMeasurement.ID,
      capabilities.tvocMeasurement.tvocLevel.NAME)
    if not current_tvoc or math.abs(current_tvoc - value) >= 1 then
      device:emit_event(capabilities.tvocMeasurement.tvocLevel({ value = value, unit = "μg/m^3" }))
      log.debug(string.format("TVOC: %d μg/m³", value))
    end
  elseif prop_name == "co2" then
    -- CO2 measurement in ppm
    local current_co2 = device:get_latest_state("main", capabilities.carbonDioxideMeasurement.ID,
      capabilities.carbonDioxideMeasurement.carbonDioxide.NAME)
    if not current_co2 or math.abs(current_co2 - value) >= 1 then
      device:emit_event(capabilities.carbonDioxideMeasurement.carbonDioxide({ value = value, unit = "ppm" }))
      log.debug(string.format("CO2: %d ppm", value))
    end
  elseif prop_name == "humidity" or prop_name == "relative_humidity" then
    local current_humidity = device:get_latest_state("main", capabilities.relativeHumidityMeasurement.ID,
      capabilities.relativeHumidityMeasurement.humidity.NAME)
    if current_humidity ~= value then
      device:emit_event(capabilities.relativeHumidityMeasurement.humidity(value))
    end
  elseif prop_name == "target_humidity" then
    -- Check for invalid target humidity values (some modes don't support it)
    if value and value > 0 and value <= 100 then
      if device_type == "dehumidifier" or device_type == "humidifier" or device_type == "climate" then
        local target_humidity_capability = capabilities["dictionaryangel05655.targetHumidity"]
        local current_target = device:get_latest_state("main", target_humidity_capability.ID,
          target_humidity_capability.targetHumidity.NAME)
        if current_target ~= value then
          device:emit_event(target_humidity_capability.targetHumidity({ value = value, unit = "%" }))
          log.info(string.format("Target humidity updated to: %d%%", value))
        end
      else
        log.debug(string.format("Target humidity set to: %d%%", value))
      end
    else
      log.debug(string.format("Invalid or unsupported target humidity value: %s (mode may not support it)",
        tostring(value)))
    end
  elseif prop_name == "battery" then
    local current_battery = device:get_latest_state("main", capabilities.battery.ID, capabilities.battery.battery.NAME)
    if current_battery ~= value then
      device:emit_event(capabilities.battery.battery(value))
    end
  elseif prop_name == "electric_power" then
    local current_power = device:get_latest_state("main", capabilities.powerMeter.ID, capabilities.powerMeter.power.NAME)
    if not current_power or math.abs(current_power - value) >= 0.1 then
      device:emit_event(capabilities.powerMeter.power({ value = value, unit = "W" }))
    end
  elseif prop_name == "power_consumption" then
    -- Power consumption in kWh
    local current_energy = device:get_latest_state("main", capabilities.energyMeter.ID,
      capabilities.energyMeter.energy.NAME)
    if not current_energy or math.abs(current_energy - value) >= 0.01 then
      device:emit_event(capabilities.energyMeter.energy({ value = value, unit = "kWh" }))
      log.debug(string.format("Power consumption: %.2f kWh", value))
    end
  elseif prop_name == "voltage" then
    local current_voltage = device:get_latest_state("main", capabilities.voltageMeasurement.ID,
      capabilities.voltageMeasurement.voltage.NAME)
    if not current_voltage or math.abs(current_voltage - value) >= 0.1 then
      device:emit_event(capabilities.voltageMeasurement.voltage({ value = value, unit = "V" }))
    end
  elseif prop_name == "electric_current" then
    -- Electric current in amperes
    local current_amperage = device:get_latest_state("main", capabilities.currentMeasurement.ID,
      capabilities.currentMeasurement.current.NAME)
    if not current_amperage or math.abs(current_amperage - value) >= 0.01 then
      device:emit_event(capabilities.currentMeasurement.current({ value = value, unit = "A" }))
      log.debug(string.format("Electric current: %.2f A", value))
    end
  elseif prop_name == "pm25" or prop_name == "pm2_5_density" or prop_name == "pm10_density" then
    local aqi_level = "good"
    if value > 150 then
      aqi_level = "hazardous"
    elseif value > 100 then
      aqi_level = "veryUnhealthy"
    elseif value > 50 then
      aqi_level = "unhealthy"
    elseif value > 25 then
      aqi_level = "moderate"
    end

    local current_aqi = device:get_latest_state("main", capabilities.airQualityHealthConcern.ID,
      capabilities.airQualityHealthConcern.airQualityHealthConcern.NAME)
    if current_aqi ~= aqi_level then
      device:emit_event(capabilities.airQualityHealthConcern.airQualityHealthConcern(aqi_level))
    end
  elseif prop_name == "filter_life_level" or prop_name == "filter_used_time" then
    local filter_status = "normal"
    if prop_name == "filter_life_level" and value < 10 then
      filter_status = "replace"
    elseif prop_name == "filter_used_time" and value > 4000 then
      filter_status = "replace"
    end

    local current_filter = device:get_latest_state("main", capabilities.filterStatus.ID,
      capabilities.filterStatus.filterStatus.NAME)
    if current_filter ~= filter_status then
      device:emit_event(capabilities.filterStatus.filterStatus(filter_status))
    end
  elseif prop_name == "child_lock" then
    log.debug(string.format("Child lock: %s", tostring(value)))
  elseif prop_name == "fault" then
    if value and value ~= 0 then
      log.warn(string.format("Device fault detected: %s", tostring(value)))
      device:emit_event(capabilities.healthCheck.DeviceWatch.deviceHealth({ value = "offline" }))
    end
  elseif prop_name == "current_position" then
    if device_type == "cover" then
      local current_position = device:get_latest_state("main", capabilities.windowShadeLevel.ID,
        capabilities.windowShadeLevel.shadeLevel.NAME)
      if current_position ~= value then
        device:emit_event(capabilities.windowShadeLevel.shadeLevel(value))

        -- Update shade state
        local current_shade_state = device:get_latest_state("main", capabilities.windowShade.ID,
          capabilities.windowShade.windowShade.NAME)
        local new_shade_state
        if value == 0 then
          new_shade_state = "closed"
        elseif value == 100 then
          new_shade_state = "open"
        else
          new_shade_state = "partially open"
        end

        if current_shade_state ~= new_shade_state then
          if value == 0 then
            device:emit_event(capabilities.windowShade.windowShade.closed())
          elseif value == 100 then
            device:emit_event(capabilities.windowShade.windowShade.open())
          else
            device:emit_event(capabilities.windowShade.windowShade.partially_open())
          end
        end
      end
    end
  elseif prop_name == "status" then
    if device_type == "vacuum" then
      -- Vacuum status mapping
      local status_map = {
        [1] = "idle",
        [2] = "cleaning",
        [3] = "charging",
        [5] = "returning",
        [6] = "docked",
      }
      local status = status_map[value] or "idle"

      local current_state = device:get_latest_state("main", capabilities.switch.ID, capabilities.switch.switch.NAME)
      local new_state
      if value == 2 or value == 5 then
        new_state = "on"
      else
        new_state = "off"
      end

      if current_state ~= new_state then
        if new_state == "on" then
          device:emit_event(capabilities.switch.switch.on())
        else
          device:emit_event(capabilities.switch.switch.off())
        end
      end
    elseif device_type == "cover" then
      -- Cover/Curtain status
      log.debug(string.format("Cover status: %s", tostring(value)))
    else
      -- Generic status for other device types
      log.debug(string.format("Device status: %s", tostring(value)))
    end
  end
end

function M.start_polling(driver, device, interval)
  interval = interval or 30

  local polling_timer = device:get_field("polling_timer")
  if polling_timer then
    log.warn(string.format("Polling already started for device %s, skipping", device.label))
    return
  end

  log.info(string.format("Starting %d second polling for device: %s", interval, device.label))

  local function poll()
    M.update_device_state(device)
  end

  poll()

  local timer = device.thread:call_on_schedule(
    interval,
    poll,
    string.format("device_polling_%s", device.device_network_id)
  )

  device:set_field("polling_timer", timer, { persist = false })
  device:set_field("polling_started", true, { persist = false })
end

function M.stop_polling(device)
  local polling_timer = device:get_field("polling_timer")
  if polling_timer then
    log.info(string.format("Stopping polling for device: %s", device.label))
    device.thread:cancel_timer(polling_timer)
    device:set_field("polling_timer", nil, { persist = false })
    device:set_field("polling_started", false, { persist = false })
  end
end

return M
