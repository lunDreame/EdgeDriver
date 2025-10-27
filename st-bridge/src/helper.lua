local M = {}

function M.find_device_by_dni(driver, dni)
  local list = driver:get_devices()
  for _, d in ipairs(list) do
    if not d:get_parent_device() and d.device_network_id == dni then
      return d
    end
  end
end

return M
