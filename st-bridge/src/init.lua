local Driver = require "st.driver"
local log = require "log"
local dm = require "device_manager"

local driver = Driver("st-bridge", {
  discovery = dm.discovery,
  lifecycle_handlers = {
    init = dm.init_device,
    added = dm.added_device,
    infoChanged = dm.info_changed,
    removed = dm.removed_device,
  },
  capability_handlers = dm.capability_handlers,
})

dm.start_periodic_discovery(driver)

driver:run()
