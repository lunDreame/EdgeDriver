-- MIT License
-- Copyright (c) 2025 lunDreame

local capabilities = require "st.capabilities"
local Driver = require "st.driver"
local log = require "log"
local cosock = require "cosock"
local json = require("dkjson")

local discovery = require "discovery"
local MiotProtocol = require "miot_protocol"
local device_models = require "device_models"
local device_updater = require "device_updater"
local capability_handlers = require "capability_handlers"
local profile_builder = require "profile_builder"
local cover_handlers = require "cover_handlers"
local vacuum_handlers = require "vacuum_handlers"
local dehumidifier_handlers = require "dehumidifier_handlers"

local DEVICE_DATA_KEY = "xiaomi_miot_data"

local function get_device_data(device)
  return device:get_field(DEVICE_DATA_KEY) or {}
end

local function set_device_data(device, data)
  device:set_field(DEVICE_DATA_KEY, data, { persist = true })
end

local function get_miot_protocol(device)
  local protocol = device:get_field("miot_protocol")
  if not protocol then
    protocol = MiotProtocol.new()
    device:set_field("miot_protocol", protocol)
  end
  return protocol
end

local function setup_device_spec(device, model)
  local spec = device_models.get_device_spec(model)
  if spec then
    device:set_field("device_spec", spec)
    log.info(string.format("Device spec loaded for model: %s (type: %s)", model, spec.device_type))

    local profile_name = profile_builder.get_profile_for_model(model)
    device:try_update_metadata({
      profile = profile_name
    })
    log.info(string.format("Updated device profile to: %s", profile_name))

    -- Supported modes and ranges will be set during device state updates
    -- to avoid timing issues with profile updates
  else
    log.warn(string.format("No spec found for model: %s, using generic", model))
  end
end

local function get_and_store_device_info(device)
  local device_data = get_device_data(device)
  local ip = device_data.ip
  local token = device_data.token

  if not ip or not token then
    log.warn("Device is not configured properly. IP or Token is missing.")
    return false
  end

  local protocol = get_miot_protocol(device)

  local info = protocol:get_device_info(ip, token)
  if info then
    log.debug(string.format("Device info: %s", json.encode(info)))

    if info.model then
      device_data.model = info.model
      device_data.fw_ver = info.fw_ver
      device_data.hw_ver = info.hw_ver
      set_device_data(device, device_data)
      log.info(string.format("Device model: %s (FW: %s, HW: %s)",
        info.model, info.fw_ver or "unknown", info.hw_ver or "unknown"))

      device:try_update_metadata({
        label = nil,
        vendor_provided_label = nil,
        model = info.model
      })

      setup_device_spec(device, info.model)
    end

    return true
  else
    log.warn(string.format("Failed to get device info for %s", device.label))
    return false
  end
end

local function handle_refresh(driver, device, command)
  log.info(string.format("Refresh command for %s", device.label))

  cosock.spawn(function()
    local spec = device:get_field("device_spec")
    if not spec then
      get_and_store_device_info(device)
    end
    device_updater.update_device_state(device)
  end, "refresh_handler")
end

local function device_init(driver, device)
  log.info(string.format("Device Initialization: %s", device.label))

  local device_data = get_device_data(device)

  if device.preferences.token and device.preferences.token ~= "" then
    device_data.token = device.preferences.token
  end

  set_device_data(device, device_data)

  if device_data.ip and device_data.token then
    if not device_data.model then
      get_and_store_device_info(device)
    else
      local spec = device:get_field("device_spec")
      if not spec then
        setup_device_spec(device, device_data.model)
      end
    end

    local polling_started = device:get_field("polling_started")
    if not polling_started then
      log.info(string.format("Starting polling for device: %s", device.label))
      device_updater.start_polling(driver, device, 30)
    end
  else
    log.warn("Device not fully configured - IP or Token is missing")
  end
end

local function device_added(driver, device)
  log.info(string.format("Device added: %s", device.label))

  local cached_info = discovery.get_cached_device_info(driver, device.device_network_id)
  if cached_info and cached_info.ip then
    local device_data = get_device_data(device)
    device_data.ip = cached_info.ip
    set_device_data(device, device_data)
    log.info(string.format("IP address set from discovery cache: %s", cached_info.ip))
  else
    log.warn("No cached IP information found for device. Please configure manually.")
  end
end

local function device_removed(driver, device)
  log.info(string.format("Device removed: %s", device.label))

  device_updater.stop_polling(device)

  discovery.remove_cached_device(driver, device.device_network_id)

  device:set_field("miot_protocol", nil, { persist = false })
  device:set_field("device_spec", nil, { persist = false })
  device:set_field("xiaomi_miot_data", nil, { persist = true })
  device:set_field("current_mode", nil, { persist = false })
  device:set_field("current_mode_name", nil, { persist = false })

  log.debug(string.format("Cleaned up device fields for: %s", device.label))
end

local function device_info_changed(driver, device, event, args)
  log.info(string.format("Changing Device Information: %s", device.label))

  if args.old_st_store.preferences then
    local old_prefs = args.old_st_store.preferences
    local new_prefs = device.preferences

    if old_prefs.token ~= new_prefs.token and new_prefs.token and new_prefs.token ~= "" then
      log.info("Device token has been changed. Re-initialize.")

      local device_data = get_device_data(device)
      device_data.token = new_prefs.token
      set_device_data(device, device_data)

      if get_and_store_device_info(device) then
        device_updater.stop_polling(device)
        device_updater.start_polling(driver, device, 30)
      end
    end
  end
end

local xiaomi_driver = Driver("xiaomi-miot", {
  discovery = discovery.discovery_handler,
  lifecycle_handlers = {
    init = device_init,
    added = device_added,
    removed = device_removed,
    infoChanged = device_info_changed,
  },
  capability_handlers = {
    [capabilities.refresh.ID] = {
      [capabilities.refresh.commands.refresh.NAME] = handle_refresh,
    },
    [capabilities.switch.ID] = {
      [capabilities.switch.commands.on.NAME] = capability_handlers.handle_switch_on,
      [capabilities.switch.commands.off.NAME] = capability_handlers.handle_switch_off,
    },
    [capabilities.switchLevel.ID] = {
      [capabilities.switchLevel.commands.setLevel.NAME] = capability_handlers.handle_switch_level,
    },
    [capabilities.colorTemperature.ID] = {
      [capabilities.colorTemperature.commands.setColorTemperature.NAME] = capability_handlers.handle_color_temperature,
    },
    [capabilities.fanSpeed.ID] = {
      [capabilities.fanSpeed.commands.setFanSpeed.NAME] = capability_handlers.handle_fan_speed,
    },
    [capabilities.fanSpeedPercent.ID] = {
      [capabilities.fanSpeedPercent.commands.setPercent.NAME] = capability_handlers.handle_fan_speed_percent,
    },
    [capabilities.fanOscillationMode.ID] = {
      [capabilities.fanOscillationMode.commands.setFanOscillationMode.NAME] = capability_handlers
          .handle_fan_oscillation_mode,
    },
    [capabilities.thermostatMode.ID] = {
      [capabilities.thermostatMode.commands.setThermostatMode.NAME] = capability_handlers.handle_thermostat_mode,
    },
    [capabilities.thermostatCoolingSetpoint.ID] = {
      [capabilities.thermostatCoolingSetpoint.commands.setCoolingSetpoint.NAME] = capability_handlers
          .handle_cooling_setpoint,
    },
    [capabilities.thermostatHeatingSetpoint.ID] = {
      [capabilities.thermostatHeatingSetpoint.commands.setHeatingSetpoint.NAME] = capability_handlers
          .handle_heating_setpoint,
    },
    [capabilities.windowShade.ID] = {
      [capabilities.windowShade.commands.open.NAME] = cover_handlers.handle_shade_open,
      [capabilities.windowShade.commands.close.NAME] = cover_handlers.handle_shade_close,
      [capabilities.windowShade.commands.pause.NAME] = cover_handlers.handle_shade_pause,
    },
    [capabilities.windowShadeLevel.ID] = {
      [capabilities.windowShadeLevel.commands.setShadeLevel.NAME] = cover_handlers.handle_shade_level,
    },
    [capabilities.colorControl.ID] = {
      [capabilities.colorControl.commands.setColor.NAME] = capability_handlers.handle_set_color,
      [capabilities.colorControl.commands.setHue.NAME] = capability_handlers.handle_set_hue,
      [capabilities.colorControl.commands.setSaturation.NAME] = capability_handlers.handle_set_saturation,
    },
    [capabilities["dictionaryangel05655.dehumidifierMode"].ID] = {
      [capabilities["dictionaryangel05655.dehumidifierMode"].commands.setDehumidifierMode.NAME] = dehumidifier_handlers
          .handle_dehumidifier_mode,
    },
    [capabilities["dictionaryangel05655.humidifierMode"].ID] = {
      [capabilities["dictionaryangel05655.humidifierMode"].commands.setHumidifierMode.NAME] = dehumidifier_handlers
          .handle_humidifier_mode,
    },
    [capabilities["dictionaryangel05655.fanMode"].ID] = {
      [capabilities["dictionaryangel05655.fanMode"].commands.setFanMode.NAME] = capability_handlers
          .handle_fan_mode,
    },
    [capabilities["dictionaryangel05655.airPurifierMode"].ID] = {
      [capabilities["dictionaryangel05655.airPurifierMode"].commands.setAirPurifierMode.NAME] = capability_handlers
          .handle_air_purifier_mode,
    },
    [capabilities["dictionaryangel05655.targetHumidity"].ID] = {
      [capabilities["dictionaryangel05655.targetHumidity"].commands.setTargetHumidity.NAME] = dehumidifier_handlers
          .handle_target_humidity,
    },
  }
})

xiaomi_driver:run()
