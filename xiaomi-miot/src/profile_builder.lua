-- MIT License
-- Copyright (c) 2025 lunDreame

local log = require "log"

local M = {}

function M.get_profile_for_model(model)
  if not model then
    return "xiaomi-generic"
  end

  local device_models = require "device_models"

  -- Get spec to determine exact capabilities
  local spec = device_models.get_device_spec(model)

  local device_type = "generic"

  if spec then
    device_type = spec.device_type

    -- For lights, check if color is supported
    if device_type == "light" and spec.properties and spec.properties.color then
      return "xiaomi-light-color"
    end
    -- For humidifiers, check if temperature is supported
    if device_type == "humidifier" and spec.properties and spec.properties.temperature then
      return "xiaomi-humidifier-temp"
    end
    -- For vacuums, check if power is supported
    if device_type == "vacuum" and spec.properties and spec.properties.power then
      return "xiaomi-vacuum-switch"
    end
  else
    -- Fallback: infer from model name
    if model:find("light") or model:find("lamp") or model:find("ceiling") then
      device_type = "light"
      -- Check if it's a color model
      if model:find("color") or model:find("bslamp") then
        return "xiaomi-light-color"
      end
    elseif model:find("plug") or model:find("switch") then
      device_type = "switch"
    elseif model:find("aircondition") or model:find("acpartner") or model:find("airrtc") then
      device_type = "climate"
    elseif model:find("airpurifier") or model:find("airp%.") then
      device_type = "air-purifier"
    elseif model:find("fan") then
      device_type = "fan"
    elseif model:find("vacuum") then
      device_type = "vacuum"
    elseif model:find("curtain") or model:find("airer") or model:find("wopener") then
      device_type = "cover"
    elseif model:find("derh") then
      device_type = "dehumidifier"
    elseif model:find("humidifier") then
      device_type = "humidifier"
    elseif model:find("heater") then
      device_type = "heater"
    elseif model:find("bhf_light") then
      device_type = "light"
    elseif model:find("camera") or model:find("cateye") then
      device_type = "camera"
    end
  end

  return "xiaomi-" .. device_type
end

function M.get_capabilities_for_type(device_type)
  local capability_map = {
    light = {
      "switch",
      "switchLevel",
      "colorTemperature",
      "refresh",
    },
    ["light-color"] = {
      "switch",
      "switchLevel",
      "colorTemperature",
      "colorControl",
      "refresh",
    },
    switch = {
      "switch",
      "powerMeter",
      "energyMeter",
      "voltageMeasurement",
      "currentMeasurement",
      "temperatureMeasurement",
      "refresh",
    },
    climate = {
      "switch",
      "thermostatMode",
      "thermostatCoolingSetpoint",
      "thermostatHeatingSetpoint",
      "temperatureMeasurement",
      "relativeHumidityMeasurement",
      "fanSpeed",
      "fanOscillationMode",
      "dictionaryangel05655.targetHumidity",
      "carbonDioxideMeasurement",
      "powerMeter",
      "energyMeter",
      "refresh",
    },
    fan = {
      "switch",
      "fanSpeed",
      "fanSpeedPercent",
      "fanOscillationMode",
      "dictionaryangel05655.fanMode",
      "refresh",
    },
    ["air-purifier"] = {
      "switch",
      "dictionaryangel05655.airPurifierMode",
      "filterState",
      "filterStatus",
      "relativeHumidityMeasurement",
      "temperatureMeasurement",
      "fineDustSensor",
      "airQualityHealthConcern",
      "refresh",
    },
    vacuum = {
      "switch",
      "battery",
      "chargingState",
      "filterState",
      "filterStatus",
      "dictionaryangel05655.vacuumMode",
      "dictionaryangel05655.vacuumStatus",
      "dictionaryangel05655.vacuumControl",
      "refresh",
    },
    cover = {
      "windowShade",
      "windowShadeLevel",
      "battery",
      "refresh",
    },
    humidifier = {
      "switch",
      "dictionaryangel05655.humidifierMode",
      "dictionaryangel05655.targetHumidity",
      "relativeHumidityMeasurement",
      "temperatureMeasurement",
      "refresh",
    },
    dehumidifier = {
      "switch",
      "dictionaryangel05655.dehumidifierMode",
      "dictionaryangel05655.targetHumidity",
      "relativeHumidityMeasurement",
      "temperatureMeasurement",
      "refresh",
    },
    heater = {
      "switch",
      "thermostatHeatingSetpoint",
      "temperatureMeasurement",
      "relativeHumidityMeasurement",
      "refresh",
    },
    generic = {
      "refresh",
    }
  }

  return capability_map[device_type] or capability_map.generic
end

return M
