local log = require "log"

local profiles = {
  light = "bridge-light",
  switch = "bridge-switch",
  fan = "bridge-fan",
  climate = "bridge-climate",
}

local M = {}

function M.ensure_children(parent, entities)
  local existing = {}
  for _, c in ipairs(parent:get_child_list() or {}) do
    existing[c.device_network_id] = c
  end
  for _, e in ipairs(entities or {}) do
    local prof = profiles[e.domain] or "bridge-switch"
    local dni = e.entity_id
    if not existing[dni] then
      parent.driver:try_create_device({
        type = "EDGE_CHILD",
        label = e.friendly_name or dni,
        profile = prof,
        parent_device_id = parent.id,
        parent_assigned_child_key = dni,
      })
    end
  end
end

return M
