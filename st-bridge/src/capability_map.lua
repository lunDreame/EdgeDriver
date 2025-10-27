local caps = require "st.capabilities"

local M = {}

-- ---- Emitters from HA -> ST ----
function M.emit_state(parent, msg)
  local child = parent:get_child_by_parent_assigned_key(msg.entity_id)
  if not child then return end
  local domain = msg.entity_id:match("^(%w+)%.")
  local a = msg.attributes or {}
  local s = tostring(msg.state or "")

  if domain == "light" then
    child:emit_event((s=="on") and caps.switch.switch.on() or caps.switch.switch.off())
    if a.brightness then
      local lvl = math.floor((tonumber(a.brightness) or 0) * 100 / 255 + 0.5)
      child:emit_event(caps.switchLevel.level(lvl))
    end
    if a.color_temp or a.color_temp_kelvin then
      if a.color_temp then child:emit_event(caps.colorTemperature.colorTemperature(a.color_temp)) end
      -- kelvin은 UI로 직접 매핑 없음. 그대로 유지.
    end
    if a.hs_color then
      local h, sat = a.hs_color[1], a.hs_color[2]
      if h then child:emit_event(caps.colorControl.hue(h)) end
      if sat then child:emit_event(caps.colorControl.saturation(sat)) end
    end
  elseif domain == "switch" then
    child:emit_event((s=="on") and caps.switch.switch.on() or caps.switch.switch.off())

  elseif domain == "fan" then
    child:emit_event((s=="on") and caps.switch.switch.on() or caps.switch.switch.off())
    if a.percentage then
      child:emit_event(caps.fanSpeedPercent.percent(math.floor(tonumber(a.percentage) or 0)))
    end
    if a.oscillating ~= nil then
      child:emit_event(caps.fanOscillationMode.fanOscillationMode(a.oscillating and "oscillating" or "fixed"))
    end
    if a.direction then
      -- pass
    end

  elseif domain == "climate" then
    -- state: hvac mode(HA의 state가 'off','heat','cool','auto' 등인 경우가 많음)
    if s ~= "" then child:emit_event(caps.thermostatMode.thermostatMode(s)) end
    if a.temperature then child:emit_event(caps.temperatureMeasurement.temperature(a.temperature)) end
    if a.current_temperature then child:emit_event(caps.temperatureMeasurement.temperature(a.current_temperature)) end
    if a.humidity then child:emit_event(caps.relativeHumidityMeasurement.humidity(a.humidity)) end
    if a.target_temp_high then child:emit_event(caps.thermostatCoolingSetpoint.coolingSetpoint(a.target_temp_high)) end
    if a.target_temp_low then child:emit_event(caps.thermostatHeatingSetpoint.heatingSetpoint(a.target_temp_low)) end
    if a.temperature and not (a.target_temp_low or a.target_temp_high) then
      -- 단일 setpoint 장치의 경우: 냉난방 모드에 따라 분배(가능 시)
      if s == "cool" then child:emit_event(caps.thermostatCoolingSetpoint.coolingSetpoint(a.temperature))
      elseif s == "heat" then child:emit_event(caps.thermostatHeatingSetpoint.heatingSetpoint(a.temperature)) end
    end
  end
end

-- ---- Commands ST -> HA ----
local function parent_session(parent, sessions)
  local ps = sessions[parent.id]
  return ps and ps.session
end

M.handlers = {
  light = {
    switch_on = function(parent, sessions, child)
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="turn_on"})
    end,
    switch_off = function(parent, sessions, child)
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="turn_off"})
    end,
    level = function(parent, sessions, child, lvl)
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="turn_on", args={level=lvl}})
    end,
    color_temp = function(parent, sessions, child, mireds)
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="turn_on", args={color_temp_mireds=mireds}})
    end,
    hue_sat = function(parent, sessions, child, hue, sat)
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="turn_on", args={hs_color={hue, sat}}})
    end
  },
  switch = {
    switch_on = function(parent, sessions, child)
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="turn_on"})
    end,
    switch_off = function(parent, sessions, child)
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="turn_off"})
    end
  },
  fan = {
    switch_on = function(parent, sessions, child)
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="turn_on"})
    end,
    switch_off = function(parent, sessions, child)
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="turn_off"})
    end,
    percent = function(parent, sessions, child, pct)
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="set_percentage", args={percentage=pct}})
    end,
    oscillate = function(parent, sessions, child, mode)
      local on = (mode == "oscillating")
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="oscillate", args={oscillating=on}})
    end,
    direction = function(parent, sessions, child, dir)
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="set_direction", args={direction=dir}})
    end
  },
  climate = {
    set_mode = function(parent, sessions, child, mode)
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="set_hvac_mode", args={hvac_mode=mode}})
    end,
    heat_sp = function(parent, sessions, child, temp)
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="set_temperature", args={target_temp_low=temp, hvac_mode="heat"}})
    end,
    cool_sp = function(parent, sessions, child, temp)
      parent_session(parent, sessions).send({type="command", entity_id=child.device_network_id, command="set_temperature", args={target_temp_high=temp, hvac_mode="cool"}})
    end
  }
}

return M
