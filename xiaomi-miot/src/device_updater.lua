-- MIT License
-- Copyright (c) 2025 lunDreame

local log = require "log"
local capabilities = require "st.capabilities"
local cosock = require "cosock"
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

function M.update_device_state(device)
  local device_data = get_device_data(device)
  local spec = get_device_spec(device)

  if not device_data.ip or not device_data.token then
    log.warn(string.format("Device %s not configured", device.label))
    return
  end

  if not spec then
    log.warn(string.format("Device spec not found for %s", device.label))
    return
  end

  if spec.protocol == "miio" then
    local protocol = get_miio_protocol(device)

    if not spec.status_properties or not spec.property_map then
      log.warn(string.format("MiIO spec is incomplete for %s", device.label))
      return
    end

    local values = protocol:get_prop(device_data.ip, device_data.token, spec.status_properties)
    if not values then
      log.error(string.format("Failed to get properties for %s", device.label))
      device:offline()
      return
    end

    device:online()

    -- Handle raw properties
    local raw = {}
    for i, prop_name in ipairs(spec.status_properties) do
      if values[i] ~= nil then
        raw[prop_name] = values[i]
      end
    end

    -- Handle logical properties
    local logical = {}
    for remote_name, logical_name in pairs(spec.property_map) do
      if raw[remote_name] ~= nil then
        logical[logical_name] = raw[remote_name]
      end
    end

    -- Handle power state
    if logical.power ~= nil then
      local v = logical.power
      local power_state
      if type(v) == "boolean" then
        power_state = v
      elseif type(v) == "string" then
        power_state = (v == "on")
      end

      if power_state ~= nil then
        local current_state = device:get_latest_state("main", capabilities.switch.ID, capabilities.switch.switch.NAME)
        local new_state = power_state and "on" or "off"
        if current_state ~= new_state then
          if power_state then
            device:emit_event(capabilities.switch.switch.on())
          else
            device:emit_event(capabilities.switch.switch.off())
          end
        end
      end
    end

    -- Handle temperature
    if logical.temperature ~= nil and type(logical.temperature) == "number" then
      local t = logical.temperature
      if t >= -40 and t <= 125 then
        local current_temp = device:get_latest_state(
          "main",
          capabilities.temperatureMeasurement.ID,
          capabilities.temperatureMeasurement.temperature.NAME
        )
        if not current_temp or math.abs(current_temp - t) >= 0.1 then
          device:emit_event(capabilities.temperatureMeasurement.temperature({ value = t, unit = "C" }))
        end
      end
    end

    -- Handle temperature (0.1°C unit)
    if logical.temp_dec ~= nil and type(logical.temp_dec) == "number" then
      local t = logical.temp_dec / 10.0
      if t >= -40 and t <= 125 then
        local current_temp = device:get_latest_state(
          "main",
          capabilities.temperatureMeasurement.ID,
          capabilities.temperatureMeasurement.temperature.NAME
        )
        if not current_temp or math.abs(current_temp - t) >= 0.1 then
          device:emit_event(capabilities.temperatureMeasurement.temperature({ value = t, unit = "C" }))
        end
      end
    end

    -- Handle humidity
    if logical.humidity ~= nil and type(logical.humidity) == "number" then
      local h = logical.humidity
      if h >= 0 and h <= 100 then
        local current_h = device:get_latest_state(
          "main",
          capabilities.relativeHumidityMeasurement.ID,
          capabilities.relativeHumidityMeasurement.humidity.NAME
        )
        if not current_h or math.abs(current_h - h) >= 1 then
          device:emit_event(capabilities.relativeHumidityMeasurement.humidity(h))
        end
      end
    end

    -- Handle AQI
    if logical.aqi ~= nil and type(logical.aqi) == "number" then
      local value = logical.aqi

      local aqi_level = "good"
      if value == 0 or value == 1 then
        aqi_level = "good"
      elseif value == 2 or value == 3 then
        aqi_level = "moderate"
      elseif value == 4 then
        aqi_level = "unhealthy"
      elseif value == 5 then
        aqi_level = "hazardous"
      end

      local current_aqi = device:get_latest_state(
        "main",
        capabilities.airQualityHealthConcern.ID,
        capabilities.airQualityHealthConcern.airQualityHealthConcern.NAME
      )
      if current_aqi ~= aqi_level then
        device:emit_event(capabilities.airQualityHealthConcern.airQualityHealthConcern(aqi_level))
      end
    end

    -- Handle filter life and status
    if logical.filter_life_remaining ~= nil and type(logical.filter_life_remaining) == "number" then
      local value = logical.filter_life_remaining

      local current_filter_state = device:get_latest_state(
        "main",
        capabilities.filterState.ID,
        capabilities.filterState.filterLifeRemaining.NAME
      )
      if not current_filter_state or math.abs(current_filter_state - value) >= 1 then
        device:emit_event(capabilities.filterState.filterLifeRemaining(value))
      end

      local filter_status = "normal"
      if value < 10 then
        filter_status = "replace"
      end

      local current_filter = device:get_latest_state(
        "main",
        capabilities.filterStatus.ID,
        capabilities.filterStatus.filterStatus.NAME
      )
      if current_filter ~= filter_status then
        device:emit_event(capabilities.filterStatus.filterStatus(filter_status))
      end
    elseif logical.filter_hours_used ~= nil and type(logical.filter_hours_used) == "number" then
      local value = logical.filter_hours_used

      local filter_status = "normal"
      if value > 4000 then
        filter_status = "replace"
      end

      local current_filter = device:get_latest_state(
        "main",
        capabilities.filterStatus.ID,
        capabilities.filterStatus.filterStatus.NAME
      )
      if current_filter ~= filter_status then
        device:emit_event(capabilities.filterStatus.filterStatus(filter_status))
      end
    end

    -- Handle load power
    if device_data.model == "chuangmi.plug.v3" then
      local load_power_result = protocol:send_raw(device_data.ip, device_data.token, "get_power", {})
      if load_power_result and #load_power_result > 0 then
        local load_power = load_power_result[1] * 0.01
        local current_power = device:get_latest_state(
          "main",
          capabilities.powerMeter.ID,
          capabilities.powerMeter.power.NAME
        )
        if not current_power or math.abs(current_power - load_power) >= 0.1 then
          device:emit_event(capabilities.powerMeter.power({ value = load_power, unit = "W" }))
        end
      end
    end

    -- Handle USB power
    if logical.usb_power ~= nil then
      log.debug(string.format("USB power (logical): %s", tostring(logical.usb_power)))
    end

    -- Handle LED raw
    if logical.led_raw ~= nil then
      log.debug(string.format("LED raw state: %s", tostring(logical.led_raw)))
    end

    return
  end

  if not spec.properties then
    log.warn(string.format("Device properties not found for %s", device.label))
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

  -- Set supported air purifier modes
  if spec.device_type == "air-purifier" and spec.mode_map then
    local current_supported = device:get_latest_state("main", capabilities["dictionaryangel05655.airPurifierMode"].ID,
      capabilities["dictionaryangel05655.airPurifierMode"].supportedAirPurifierModes.NAME)

    if not current_supported then
      local air_purifier_mode_capability = capabilities["dictionaryangel05655.airPurifierMode"]
      local supported_modes = {}
      for mode_value, mode_name in pairs(spec.mode_map) do
        table.insert(supported_modes, mode_name)
      end

      if #supported_modes > 0 then
        device:emit_event(air_purifier_mode_capability.supportedAirPurifierModes(supported_modes,
          { visibility = { displayed = false } }))
        log.debug(string.format("Set supported air purifier modes: %s", table.concat(supported_modes, ", ")))
      end
    end
  end

  -- Set supported vacuum modes
  if spec.device_type == "vacuum" and spec.mode_map then
    local current_supported = device:get_latest_state("main", capabilities["dictionaryangel05655.vacuumMode"].ID,
      capabilities["dictionaryangel05655.vacuumMode"].supportedVacuumModes.NAME)

    if not current_supported then
      local vacuum_mode_capability = capabilities["dictionaryangel05655.vacuumMode"]
      local supported_modes = {}
      for mode_value, mode_name in pairs(spec.mode_map) do
        table.insert(supported_modes, mode_name)
      end

      if #supported_modes > 0 then
        device:emit_event(vacuum_mode_capability.supportedVacuumModes(supported_modes,
          { visibility = { displayed = false } }))
        log.debug(string.format("Set supported vacuum modes: %s", table.concat(supported_modes, ", ")))
      end
    end
  end

  -- Set supported charging states for vacuum
  if spec.device_type == "vacuum" and spec.charging_state_map then
    local current_supported = device:get_latest_state("main", capabilities.chargingState.ID,
      capabilities.chargingState.supportedChargingStates.NAME)

    if not current_supported then
      local supported_states = {}
      for state_value, state_name in pairs(spec.charging_state_map) do
        table.insert(supported_states, state_name)
      end

      if #supported_states > 0 then
        device:emit_event(capabilities.chargingState.supportedChargingStates(supported_states,
          { visibility = { displayed = false } }))
        log.debug(string.format("Set supported charging states: %s", table.concat(supported_states, ", ")))
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
      local air_purifier_mode_capability = capabilities["dictionaryangel05655.airPurifierMode"]

      if spec.mode_map and spec.mode_map[value] then
        local mode_value = spec.mode_map[value]
        local current_mode = device:get_latest_state("main", air_purifier_mode_capability.ID,
          air_purifier_mode_capability.airPurifierMode.NAME)
        if current_mode ~= mode_value then
          device:emit_event(air_purifier_mode_capability.airPurifierMode(mode_value))
          log.info(string.format("Air purifier mode changed to: %s (%d)", mode_value, value))
        end
      else
        log.debug(string.format("Air purifier mode value: %d (no mapping available)", value))
      end
    elseif device_type == "vacuum" then
      -- Map vacuum mode to custom capability
      local vacuum_mode_capability = capabilities["dictionaryangel05655.vacuumMode"]

      if spec.mode_map and spec.mode_map[value] then
        local mode_value = spec.mode_map[value]
        local current_mode = device:get_latest_state("main", vacuum_mode_capability.ID,
          vacuum_mode_capability.vacuumMode.NAME)
        if current_mode ~= mode_value then
          device:emit_event(vacuum_mode_capability.vacuumMode(mode_value))
          log.info(string.format("Vacuum mode changed to: %s (%d)", mode_value, value))
        end
      else
        log.debug(string.format("Vacuum mode value: %d (no mapping available)", value))
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
    -- Check if device has custom charging_state_map
    if spec.charging_state_map then
      local charging_state_name = spec.charging_state_map[value]

      if charging_state_name then
        local current_charging_state = device:get_latest_state("main", capabilities.chargingState.ID,
          capabilities.chargingState.chargingState.NAME)
        if current_charging_state ~= charging_state_name then
          device:emit_event(capabilities.chargingState.chargingState(charging_state_name))
          log.info(string.format("Charging state changed to: %s (%d)", charging_state_name, value))
        end
      else
        log.debug(string.format("Unknown charging state value: %d", value))
      end
    else
      log.debug(string.format("Charging state: %s", tostring(value)))
    end
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
  elseif prop_name == "aqi_state" then
    -- Map AQI state to air quality health concern
    local aqi_level = "good"
    if value == 0 or value == 1 then
      aqi_level = "good"
    elseif value == 2 or value == 3 then
      aqi_level = "moderate"
    elseif value == 4 then
      aqi_level = "unhealthy"
    elseif value == 5 then
      aqi_level = "hazardous"
    end

    local current_aqi = device:get_latest_state("main", capabilities.airQualityHealthConcern.ID,
      capabilities.airQualityHealthConcern.airQualityHealthConcern.NAME)
    if current_aqi ~= aqi_level then
      device:emit_event(capabilities.airQualityHealthConcern.airQualityHealthConcern(aqi_level))
      log.info(string.format("AQI state changed to: %s (value: %d)", aqi_level, value))
    end
  elseif prop_name == "pm25" or prop_name == "pm2_5_density" or prop_name == "pm10_density" then
    -- Emit fine dust sensor measurement
    local current_dust = device:get_latest_state("main", capabilities.fineDustSensor.ID,
      capabilities.fineDustSensor.fineDustLevel.NAME)
    if not current_dust or math.abs(current_dust - value) >= 1 then
      device:emit_event(capabilities.fineDustSensor.fineDustLevel(value))
      log.debug(string.format("PM2.5: %d μg/m³", value))
    end

    -- Also emit air quality health concern (only if aqi_state is not available)
    local spec = get_device_spec(device)
    if not spec or not spec.properties or not spec.properties.aqi_state then
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
    end
  elseif prop_name == "filter_life_level" or prop_name == "filter_used_time" then
    -- Emit filterState with percentage for air purifiers
    if prop_name == "filter_life_level" then
      local current_filter_state = device:get_latest_state("main", capabilities.filterState.ID,
        capabilities.filterState.filterLifeRemaining.NAME)
      if not current_filter_state or math.abs(current_filter_state - value) >= 1 then
        device:emit_event(capabilities.filterState.filterLifeRemaining(value))
        log.debug(string.format("Filter life remaining: %d%%", value))
      end
    end

    -- Also emit filterStatus
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
      -- Check if device has custom status_map
      if spec.status_map then
        local vacuum_status_capability = capabilities["dictionaryangel05655.vacuumStatus"]
        local status_name = spec.status_map[value]

        if status_name then
          local current_status = device:get_latest_state("main", vacuum_status_capability.ID,
            vacuum_status_capability.vacuumStatus.NAME)
          if current_status ~= status_name then
            device:emit_event(vacuum_status_capability.vacuumStatus(status_name))
            log.info(string.format("Vacuum status changed to: %s (%d)", status_name, value))
          end
        else
          log.debug(string.format("Unknown vacuum status value: %d", value))
        end
      end

      -- Basic switch state mapping for all vacuum devices
      local current_state = device:get_latest_state("main", capabilities.switch.ID, capabilities.switch.switch.NAME)
      local new_state
      -- Active states: sweeping (1), mopping (7), sweepingAndMopping (12), goCharging (5), etc.
      if value == 1 or value == 5 or value == 7 or value == 12 or value == 22 or value == 23 then
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
