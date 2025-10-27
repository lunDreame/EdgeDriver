local log = require "log"
local caps = require "st.capabilities"
local tcp = require "tcp_client"
local entity_factory = require "entity_factory"
local cmap = require "capability_map"
local ssdp = require "discovery_ssdp"
local helper = require "helper"

local parent_sessions = {}      -- parent.id -> { session = ... }
local pending_discovered = {}   -- dni -> { ip=..., port=..., usn=? }

-- 주기적 재탐색 간격(초)
local RESCAN_BASE = 600  -- 10분
local RESCAN_JITTER = 30 -- ±30초 지터

local M = {}

local function on_msg(parent, msg)
  if msg.type == "hello" then
    log.info(string.format("[%s] received hello from bridge", parent.device_network_id))
    parent:online()
  elseif msg.type == "entity_list" then
    entity_factory.ensure_children(parent, msg.entities)
  elseif msg.type == "state" then
    cmap.emit_state(parent, msg)
  elseif msg.type == "error" then
    log.error(string.format("[%s] error from bridge: %s", parent.device_network_id, tostring(msg.code or "unknown")))
    parent:offline()
  end
end

local function connect_parent(device)
  local ip = device:get_field("ha_ip")
  local port = device:get_field("ha_port")
  if not ip or not port then
    log.warn("Missing IP/Port fields for parent (ha_ip/ha_port). Did discovery run?")
    return
  end
  local session, err = tcp.connect(ip, port,
    function(m) on_msg(device, m) end,
    function(e) log.error(e) end)
  if not session then
    log.error(string.format("connect failed: %s:%s (%s)", tostring(ip), tostring(port), err or "unknown"))
    return
  end
  parent_sessions[device.id] = { session = session }
end

-- ===== lifecycle =====
function M.init_device(driver, device)
  -- parent or child 모두 이 경로를 탄다.
end

function M.added_device(driver, device)
  if not device:get_parent_device() then
    -- 부모: discovery로 생성되며, pending_discovered로부터 IP/PORT를 채움
    local dni = device.device_network_id
    local pd = pending_discovered[dni]
    if pd then
      if pd.usn then device:set_field("usn", pd.usn, {persist=true}) end
      device:set_field("ha_ip", pd.ip, {persist=true})
      device:set_field("ha_port", pd.port, {persist=true})
      pending_discovered[dni] = nil
    end
    connect_parent(device)
  end
end

function M.removed_device(driver, device)
  if not device:get_parent_device() then
    local s = parent_sessions[device.id]
    if s and s.session then s.session.close() end
    parent_sessions[device.id] = nil
  end
end

function M.info_changed(driver, device, event, args)
  if not device:get_parent_device() then
    -- 필드/업데이트 시 재연결 보장
    local s = parent_sessions[device.id]
    if s and s.session then s.session.close() end
    parent_sessions[device.id] = nil
    connect_parent(device)
  end
end

-- ===== capability handlers =====
M.capability_handlers = {
  -- LIGHT
  [caps.switch.ID] = {
    [caps.switch.commands.on.NAME] = function(driver, device)
      local parent = device:get_parent_device()
      cmap.handlers.light.switch_on(parent, parent_sessions, device)
    end,
    [caps.switch.commands.off.NAME] = function(driver, device)
      local parent = device:get_parent_device()
      cmap.handlers.light.switch_off(parent, parent_sessions, device)
    end,
  },
  [caps.switchLevel.ID] = {
    [caps.switchLevel.commands.setLevel.NAME] = function(driver, device, cmd)
      local lvl = math.max(0, math.min(100, math.floor(cmd.args.level or 0)))
      local parent = device:get_parent_device()
      cmap.handlers.light.level(parent, parent_sessions, device, lvl)
    end
  },
  [caps.colorTemperature.ID] = {
    [caps.colorTemperature.commands.setColorTemperature.NAME] = function(driver, device, cmd)
      local mireds = math.floor(cmd.args.temperature or 0)
      local parent = device:get_parent_device()
      cmap.handlers.light.color_temp(parent, parent_sessions, device, mireds)
    end
  },
  [caps.colorControl.ID] = {
    [caps.colorControl.commands.setColor.NAME] = function(driver, device, cmd)
      local color = cmd.args.color or {}
      local parent = device:get_parent_device()
      cmap.handlers.light.hue_sat(parent, parent_sessions, device, color.hue or 0, color.saturation or 0)
    end
  },

  -- SWITCH
  -- (already covered by caps.switch above; applies to switch children as well)

  -- FAN
  [caps.fanSpeedPercent.ID] = {
    [caps.fanSpeedPercent.commands.setPercent.NAME] = function(driver, device, cmd)
      local pct = math.max(0, math.min(100, math.floor(cmd.args.percent or 0)))
      local parent = device:get_parent_device()
      cmap.handlers.fan.percent(parent, parent_sessions, device, pct)
    end
  },
  [caps.fanOscillationMode.ID] = {
    [caps.fanOscillationMode.commands.setFanOscillationMode.NAME] = function(driver, device, cmd)
      local mode = cmd.args.mode -- "oscillating"/"fixed"
      local parent = device:get_parent_device()
      cmap.handlers.fan.oscillate(parent, parent_sessions, device, mode)
    end
  },

  -- CLIMATE
  [caps.thermostatMode.ID] = {
    [caps.thermostatMode.commands.setThermostatMode.NAME] = function(driver, device, cmd)
      local mode = tostring(cmd.args.mode)
      local parent = device:get_parent_device()
      cmap.handlers.climate.set_mode(parent, parent_sessions, device, mode)
    end
  },
  [caps.thermostatHeatingSetpoint.ID] = {
    [caps.thermostatHeatingSetpoint.commands.setHeatingSetpoint.NAME] = function(driver, device, cmd)
      local t = tonumber(cmd.args.setpoint) or tonumber(cmd.args.heatingSetpoint)
      local parent = device:get_parent_device()
      if t then cmap.handlers.climate.heat_sp(parent, parent_sessions, device, t) end
    end
  },
  [caps.thermostatCoolingSetpoint.ID] = {
    [caps.thermostatCoolingSetpoint.commands.setCoolingSetpoint.NAME] = function(driver, device, cmd)
      local t = tonumber(cmd.args.setpoint) or tonumber(cmd.args.coolingSetpoint)
      local parent = device:get_parent_device()
      if t then cmap.handlers.climate.cool_sp(parent, parent_sessions, device, t) end
    end
  },
}

-- ===== discovery =====
local function run_discovery_once(driver)
  log.info("Running SSDP discovery for st-bridge...")
  local hits = ssdp.scan(2.0)
  local created, updated = 0, 0
  for _, d in ipairs(hits) do
    local dni = d.usn and ("stbridge|" .. d.usn) or string.format("stbridge|%s|%d", d.ip, d.port)
    local existing = helper.find_device_by_dni(driver, dni)
    if existing then
      -- 이미 있으면 IP/PORT만 갱신
      local cur_ip = existing:get_field("ha_ip")
      local cur_pt = existing:get_field("ha_port")
      if cur_ip ~= d.ip or cur_pt ~= d.port then
        existing:set_field("ha_ip", d.ip, { persist = true })
        existing:set_field("ha_port", d.port, { persist = true })
        updated = updated + 1
        log.info(string.format("Updated bridge %s -> %s:%d", dni, d.ip, d.port))
      end
    else
      pending_discovered[dni] = { ip = d.ip, port = d.port, usn = d.usn }
      driver:try_create_device({
        type = "LAN",
        device_network_id = dni,
        label = string.format("ST Bridge (%s:%d)", d.ip, d.port),
        profile = "bridge-parent",
        manufacturer = "st-bridge",
        model = "parent",
      })
      created = created + 1
    end
  end
  log.info(string.format("SSDP discovery done: created=%d, updated=%d", created, updated))
end

function M.discovery(driver, opts, cont)
  run_discovery_once(driver)
end

function M.start_periodic_discovery(driver)
  local function schedule_next()
    local jitter = math.random(-RESCAN_JITTER, RESCAN_JITTER)
    local wait_s = math.max(60, RESCAN_BASE + jitter)
    driver:call_with_delay(wait_s, function()
      pcall(run_discovery_once, driver)
      schedule_next()
    end)
  end
  schedule_next()
end

return M
