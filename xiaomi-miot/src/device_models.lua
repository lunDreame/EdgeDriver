-- MIT License
-- Copyright (c) 2025 lunDreame

local M = {}

M.DEVICE_SPECS = {
  -- ====== Light Devices ======
  -- Yeelink Lights (yeelink.light.*)
  ["yeelink.light.ceiling1"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 4, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.ceiling2"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.ceiling3"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 4, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.ceiling4"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 4, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.ceiling10"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.color1"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 3, min = 1, max = 16777215, step = 1, unit = "rgb" },
      color_temperature = { siid = 2, piid = 4, min = 1700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "color",
      [2] = "day"
    }
  },
  ["yeelink.light.color2"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 4, min = 1, max = 16777215, step = 1, unit = "rgb" },
      color_temperature = { siid = 2, piid = 3, min = 1700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "color",
      [2] = "day"
    }
  },
  ["yeelink.light.lamp22"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [5] = "reading",
      [6] = "office",
      [7] = "leisure",
      [8] = "warmth",
      [9] = "computer"
    }
  },

  -- Philips Lights
  ["philips.light.bulb"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 4, min = 3000, max = 5700, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "lighting",
      [2] = "nightLight",
      [3] = "tv",
      [4] = "warmth"
    }
  },
  ["philips.light.downlight"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 3000, max = 5700, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "none",
      [1] = "lighting",
      [2] = "tv",
      [3] = "warmth",
      [4] = "nightLight"
    }
  },

  -- ====== Switch/Plug Devices ======
  -- Chuangmi Plugs
  ["chuangmi.plug.v1"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 }
    }
  },
  ["chuangmi.plug.v3"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 },
      temperature = { siid = 2, piid = 2, min = -40, max = 125, step = 0.1, unit = "celsius" }
    }
  },
  ["chuangmi.plug.212a01"] = {
    device_type = "switch",
    properties = {
      electric_current = { siid = 5, piid = 2, min = 0, max = 65535, step = 1 },
      electric_power = { siid = 5, piid = 6, min = 0, max = 6553500, step = 1, unit = "watt" },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 5, piid = 1, min = 0, max = 65535000, step = 1, unit = "none" },
      temperature = { siid = 2, piid = 6, min = 0, max = 255, step = 1, unit = "celsius" },
      voltage = { siid = 5, piid = 3, min = 0, max = 65535, step = 1 }
    }
  },

  -- Cuco Plugs
  ["cuco.plug.cp1"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 }
    }
  },
  ["cuco.plug.cp1m"] = {
    device_type = "switch",
    properties = {
      electric_current = { siid = 2, piid = 4, min = 0, max = 65535, step = 1, unit = "none" },
      power = { siid = 2, piid = 1, unit = "none" },
      power_consumption = { siid = 2, piid = 2, min = 0, max = 65535, step = 1, unit = "none" },
      voltage = { siid = 2, piid = 3, min = 0, max = 3000, step = 1, unit = "none" }
    }
  },
  ["cuco.plug.cp2"] = {
    device_type = "switch",
    properties = {
      electric_current = { siid = 2, piid = 4, min = 0, max = 65535, step = 1, unit = "none" },
      power = { siid = 2, piid = 1, unit = "none" },
      power_consumption = { siid = 2, piid = 2, min = 0, max = 65535, step = 1 },
      voltage = { siid = 2, piid = 3, min = 0, max = 3000, step = 1, unit = "none" }
    }
  },

  -- Xiaomi Plugs
  ["xiaomi.plug.mcn003"] = {
    device_type = "switch",
    properties = {
      electric_power = { siid = 3, piid = 6, min = 0, max = 2500, step = 1, unit = "watt" },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 3, piid = 1, min = 0, max = 65535, step = 0.01 }
    }
  },

  -- Lumi Plugs
  ["lumi.plug.v1"] = {
    device_type = "switch",
    properties = {
      electric_power = { siid = 3, piid = 2, min = 0, max = 10000, step = 0.01, unit = "watt" },
      power = { siid = 2, piid = 1 }
    }
  },

  -- Zimi Powerstrips
  ["zimi.powerstrip.v2"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 },
      temperature = { siid = 2, piid = 2, min = -40, max = 125, step = 0.01, unit = "celsius" }
    }
  },

  -- ====== Climate Devices (Air Conditioner) ======
  ["xiaomi.aircondition.mc1"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.mc2"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.ma1"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 7 },
      eco = { siid = 2, piid = 4 },
      fan_level = { siid = 3, piid = 1 },
      heater = { siid = 2, piid = 5 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 7, piid = 1, min = 0, max = 999999.999999, step = 1e-06 },
      sleep_mode = { siid = 2, piid = 6 },
      target_temperature = { siid = 2, piid = 3, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 1, min = -20, max = 80, step = 0.5, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 2 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.ma4"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 7 },
      eco = { siid = 2, piid = 4 },
      fan_level = { siid = 3, piid = 1 },
      heater = { siid = 2, piid = 5 },
      horizontal_swing = { siid = 3, piid = 3 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 6 },
      target_temperature = { siid = 2, piid = 3, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 1, min = -20, max = 80, step = 1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 2 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["lumi.acpartner.mcn02"] = {
    device_type = "climate",
    properties = {
      electric_power = { siid = 5, piid = 1, min = 0, max = 10000, step = 0.01, unit = "watt" },
      fan_level = { siid = 3, piid = 1 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      target_temperature = { siid = 2, piid = 3, min = 16, max = 30, step = 1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 2 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "cool",
      [2] = "dry",
      [3] = "heat",
      [4] = "fan"
    }
  },
  ["lumi.acpartner.mcn04"] = {
    device_type = "climate",
    properties = {
      ["air-conditioner_mode"] = { siid = 3, piid = 2 },
      electric_power = { siid = 7, piid = 2, min = 0, max = 3.4e+38, step = 1, unit = "watt" },
      fan_level = { siid = 4, piid = 2, unit = "none" },
      power = { siid = 3, piid = 1 },
      power_consumption = { siid = 7, piid = 1, min = 0, max = 3.4e+38, step = 0.001, unit = "none" },
      target_temperature = { siid = 3, piid = 4, min = 16, max = 30, step = 1, unit = "celsius" },
      vertical_swing = { siid = 4, piid = 4 }
    }
  },
  ["zhimi.aircondition.ma1"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, min = 0, max = 7, step = 1 },
      fan_level = { siid = 3, piid = 1 },
      heater = { siid = 2, piid = 4 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 5 },
      target_temperature = { siid = 2, piid = 3, min = 16, max = 32, step = 0.1, unit = "celsius" },
      temperature = { siid = 4, piid = 1, min = -40, max = 125, step = 0.1, unit = "celsius" },
      vertical_angle = { siid = 3, piid = 3, min = 0, max = 60, step = 1 },
      vertical_swing = { siid = 3, piid = 2 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "cool",
      [2] = "dry",
      [3] = "heat",
      [4] = "fan"
    }
  },

  -- ====== Fan Devices ======
  ["dmaker.fan.p5"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 4 },
      horizontal_angle = { siid = 2, piid = 7, min = -7, max = 7, step = 7 },
      horizontal_swing = { siid = 2, piid = 2 },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "naturalWind",
      [1] = "straightWind"
    }
  },
  ["dmaker.fan.p10"] = {
    device_type = "fan",
    properties = {
      brightness = { siid = 2, piid = 7, unit = "none" },
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_angle = { siid = 2, piid = 5, unit = "none" },
      horizontal_swing = { siid = 2, piid = 4, unit = "none" },
      mode = { siid = 2, piid = 3, unit = "none" },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 10, min = 1, max = 100, step = 1, unit = "none" }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },
  ["dmaker.fan.p11"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_angle = { siid = 2, piid = 5, unit = "none" },
      horizontal_swing = { siid = 2, piid = 4 },
      mode = { siid = 2, piid = 3, unit = "none" },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 6, min = 1, max = 100, step = 1, unit = "none" }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },
  ["dmaker.fan.p15"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_angle = { siid = 2, piid = 5, unit = "none" },
      horizontal_swing = { siid = 2, piid = 4 },
      mode = { siid = 2, piid = 3, unit = "none" },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 6, min = 1, max = 100, step = 1, unit = "none" }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },
  ["zhimi.fan.za3"] = {
    device_type = "fan",
    properties = {
      brightness = { siid = 5, piid = 1 },
      fan_level = { siid = 2, piid = 2 },
      horizontal_swing = { siid = 2, piid = 3 },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },
  ["zhimi.fan.za4"] = {
    device_type = "fan",
    properties = {
      brightness = { siid = 5, piid = 1 },
      fan_level = { siid = 2, piid = 2 },
      horizontal_swing = { siid = 2, piid = 3 },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },
  ["zhimi.fan.za5"] = {
    device_type = "fan",
    properties = {
      anion = { siid = 2, piid = 11 },
      brightness = { siid = 4, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_angle = { siid = 2, piid = 5, min = 30, max = 120, step = 1, unit = "none" },
      horizontal_swing = { siid = 2, piid = 3 },
      humidity = { siid = 7, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 7, unit = "none" },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 6, piid = 8, min = 1, max = 100, step = 1, unit = "none" },
      temperature = { siid = 7, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "naturalWind",
      [1] = "straightWind"
    }
  },

  -- ====== Air Purifier Devices ======
  ["zhimi.airpurifier.mb3"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 6, piid = 1, unit = "percentage" },
      fan_level = { siid = 2, piid = 4 },
      filter_life_level = { siid = 4, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 5 },
      pm25 = { siid = 3, piid = 6, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 2 },
      temperature = { siid = 3, piid = 8, min = -40, max = 125, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite",
      [3] = "none"
    }
  },
  ["zhimi.airpurifier.ma4"] = {
    device_type = "air-purifier",
    properties = {
      aqi_state = { siid = 13, piid = 8, min = 0, max = 5, step = 1, unit = "none" },
      brightness = { siid = 6, piid = 1, unit = "percentage" },
      fan_level = { siid = 2, piid = 4 },
      filter_life_level = { siid = 4, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 5 },
      pm25 = { siid = 3, piid = 6, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 2 },
      temperature = { siid = 3, piid = 8, min = -40, max = 125, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite",
      [3] = "none"
    }
  },
  ["xiaomi.airp.cpa4"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 13, piid = 2, unit = "percentage" },
      filter_left_time = { siid = 4, piid = 4, min = 0, max = 1000, step = 1, unit = "days" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      pm25 = { siid = 3, piid = 4, min = 0, max = 600, step = 1, unit = "μg/m3" },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite"
    }
  },

  -- ====== Vacuum Devices ======
  ["roborock.vacuum.a14"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [101] = "silent",
      [102] = "basic",
      [103] = "strong",
      [104] = "fullSpeed",
      [105] = "silent",
      [106] = "custom"
    }
  },
  ["roborock.vacuum.a15"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [101] = "silent",
      [102] = "basic",
      [103] = "strong",
      [104] = "fullSpeed",
      [105] = "silent",
      [106] = "custom"
    }
  },
  ["roborock.vacuum.a19"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [101] = "silent",
      [102] = "basic",
      [103] = "strong",
      [104] = "fullSpeed",
      [105] = "silent",
      [106] = "custom"
    }
  },
  ["dreame.vacuum.p2008"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 150, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },
  ["xiaomi.vacuum.b108gl"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2 },
      filter_left_time = { siid = 10, piid = 1, min = 0, max = 1000, step = 1, unit = "days" },
      filter_life_level = { siid = 10, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 16 },
      status = { siid = 2, piid = 1 },
      voltage = { siid = 3, piid = 3, min = 0, max = 65535, step = 1 }
    },
    mode_map = {
      [1] = "silent",
      [2] = "basic",
      [3] = "strong"
    }
  },

  -- ====== Humidifier/Dehumidifier Devices ======
  ["deerma.humidifier.mjjsq"] = {
    device_type = "humidifier",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      humidity = { siid = 3, piid = 1, min = 20, max = 99, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      target_humidity = { siid = 2, piid = 3, min = 40, max = 70, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 2, min = -10, max = 60, step = 1, unit = "celsius" }
    }
  },
  ["deerma.humidifier.jsq"] = {
    device_type = "humidifier",
    properties = {
      humidity = { siid = 3, piid = 1, min = 0, max = 90, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 2, min = -10, max = 60, step = 1, unit = "celsius" }
    }
  },
  ["zhimi.humidifier.ca1"] = {
    device_type = "humidifier",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 2, min = -40, max = 125, step = 0.1, unit = "celsius" },
      water_level = { siid = 2, piid = 3, min = 0, max = 127, step = 1 }
    }
  },
  ["zhimi.humidifier.cb1"] = {
    device_type = "humidifier",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 2, min = -40, max = 125, step = 0.1, unit = "celsius" },
      water_level = { siid = 2, piid = 3, min = 0, max = 127, step = 1 }
    }
  },
  ["xiaomi.humidifier.airmx"] = {
    device_type = "humidifier",
    properties = {
      brightness = { siid = 15, piid = 3, min = 1, max = 5, step = 1, unit = "percentage" },
      filter_life_level = { siid = 18, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      ["indicator-light_mode"] = { siid = 15, piid = 2 },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      target_humidity = { siid = 2, piid = 6, min = 40, max = 70, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 2, min = -50, max = 50, step = 0.1, unit = "celsius" },
      water_level = { siid = 2, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" }
    },
    mode_map = {
      [0] = "constantHumidity",
      [1] = "strong",
      [2] = "sleep",
      [3] = "airdry",
      [4] = "clean",
      [5] = "descale",
      [6] = "none"
    }
  },

  -- ====== Cover Devices (Curtain/Airer) ======
  ["dooya.curtain.m1"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 6, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 5 },
      status = { siid = 2, piid = 4 },
      target_position = { siid = 2, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" }
    },
    mode_map = {
      [0] = "back",
      [1] = "front"
    }
  },
  ["dooya.curtain.m2"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 6, min = 0, max = 100, step = 1, unit = "percentage" },
      status = { siid = 2, piid = 4 },
      target_position = { siid = 2, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["lumi.curtain.hagl05"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      status = { siid = 2, piid = 6 },
      target_position = { siid = 2, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["lumi.curtain.hagl08"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      status = { siid = 2, piid = 6, unit = "none" },
      target_position = { siid = 2, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["hyd.airer.znlyj2"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 3, min = 0, max = 2, step = 1, unit = "percentage" },
      power = { siid = 3, piid = 1 },
      status = { siid = 2, piid = 4 }
    }
  },
  ["mrbond.airer.m1pro"] = {
    device_type = "cover",
    properties = {
      dryer = { siid = 2, piid = 2 },
      power = { siid = 3, piid = 1 }
    }
  },

  -- ====== Wildcard Patterns ======
  -- Light wildcard patterns
  ["*.light.*"] = {
    device_type = "light",
    properties = { power = { siid = 2, piid = 1 }, brightness = { siid = 2, piid = 2 } }
  },
  ["yeelink.light.*"] = {
    device_type = "light",
    properties = { power = { siid = 2, piid = 1 }, brightness = { siid = 2, piid = 2 }, color_temperature = { siid = 2, piid = 3 } }
  },

  -- Switch/Plug wildcard patterns
  ["*.plug.*"] = {
    device_type = "switch",
    properties = { power = { siid = 2, piid = 1 } }
  },
  ["*.switch.*"] = {
    device_type = "switch",
    properties = { power = { siid = 2, piid = 1 } }
  },
  ["chuangmi.plug.*"] = {
    device_type = "switch",
    properties = { power = { siid = 2, piid = 1 } }
  },
  ["cuco.plug.*"] = {
    device_type = "switch",
    properties = { power = { siid = 2, piid = 1 } }
  },

  -- Climate wildcard patterns
  ["*.aircondition.*"] = {
    device_type = "climate",
    properties = {
      power = { siid = 2, piid = 1 },
      mode = { siid = 2, piid = 2 },
      target_temperature = { siid = 2, piid = 3 },
    }
  },
  ["*.airrtc.*"] = {
    device_type = "climate",
    properties = {
      power = { siid = 2, piid = 1 },
      mode = { siid = 2, piid = 2 },
      target_temperature = { siid = 2, piid = 3 },
    }
  },
  ["xiaomi.aircondition.*"] = {
    device_type = "climate",
    properties = {
      power = { siid = 2, piid = 1 },
      mode = { siid = 2, piid = 2 },
      target_temperature = { siid = 2, piid = 3 },
    }
  },

  -- Fan wildcard patterns
  ["*.fan.*"] = {
    device_type = "fan",
    properties = { power = { siid = 2, piid = 1 }, fan_level = { siid = 2, piid = 2 } }
  },
  ["dmaker.fan.*"] = {
    device_type = "fan",
    properties = { power = { siid = 2, piid = 1 }, fan_level = { siid = 2, piid = 2 } }
  },
  ["zhimi.fan.*"] = {
    device_type = "fan",
    properties = { power = { siid = 2, piid = 1 } }
  },

  -- Air Purifier wildcard patterns
  ["*.airpurifier.*"] = {
    device_type = "air-purifier",
    properties = { power = { siid = 2, piid = 1 }, mode = { siid = 2, piid = 2 } }
  },
  ["*.airp.*"] = {
    device_type = "air-purifier",
    properties = { power = { siid = 2, piid = 1 }, mode = { siid = 2, piid = 2 } }
  },
  ["zhimi.airpurifier.*"] = {
    device_type = "air-purifier",
    properties = { power = { siid = 2, piid = 1 }, mode = { siid = 2, piid = 2 } }
  },

  -- Vacuum wildcard patterns
  ["*.vacuum.*"] = {
    device_type = "vacuum",
    properties = { status = { siid = 2, piid = 1 }, battery = { siid = 3, piid = 1 } },
    actions = { start = { siid = 2, aiid = 1 }, stop = { siid = 2, aiid = 2 } }
  },
  ["roborock.vacuum.*"] = {
    device_type = "vacuum",
    properties = { status = { siid = 2, piid = 1 }, battery = { siid = 3, piid = 1 } },
    actions = { start = { siid = 2, aiid = 1 }, stop = { siid = 2, aiid = 2 }, charge = { siid = 3, aiid = 1 } }
  },
  ["dreame.vacuum.*"] = {
    device_type = "vacuum",
    properties = { status = { siid = 2, piid = 1 }, battery = { siid = 3, piid = 1 } }
  },

  -- Humidifier wildcard patterns
  ["*.humidifier.*"] = {
    device_type = "humidifier",
    properties = { power = { siid = 2, piid = 1 }, mode = { siid = 2, piid = 2 }, humidity = { siid = 3, piid = 1 } }
  },
  ["deerma.humidifier.*"] = {
    device_type = "humidifier",
    properties = { power = { siid = 2, piid = 1 } }
  },
  ["zhimi.humidifier.*"] = {
    device_type = "humidifier",
    properties = { power = { siid = 2, piid = 1 }, mode = { siid = 2, piid = 2 } }
  },

  -- Dehumidifier wildcard patterns
  ["*.derh.*"] = {
    device_type = "dehumidifier",
    properties = { power = { siid = 2, piid = 1 }, mode = { siid = 2, piid = 2 }, humidity = { siid = 3, piid = 1 }, temperature = { siid = 3, piid = 7 } }
  },
  ["dmaker.derh.*"] = {
    device_type = "dehumidifier",
    properties = { power = { siid = 2, piid = 1 }, mode = { siid = 2, piid = 2 }, fan_level = { siid = 2, piid = 5 }, humidity = { siid = 3, piid = 1 }, temperature = { siid = 3, piid = 7 } }
  },
  ["nwt.derh.*"] = {
    device_type = "dehumidifier",
    properties = { power = { siid = 2, piid = 1 }, mode = { siid = 2, piid = 2 }, humidity = { siid = 3, piid = 1 }, temperature = { siid = 3, piid = 7 } }
  },

  -- Cover wildcard patterns
  ["*.curtain.*"] = {
    device_type = "cover",
    properties = { status = { siid = 2, piid = 1 }, current_position = { siid = 2, piid = 2 } }
  },
  ["*.airer.*"] = {
    device_type = "cover",
    properties = { status = { siid = 2, piid = 1 }, current_position = { siid = 2, piid = 2 } }
  },
  ["dooya.curtain.*"] = {
    device_type = "cover",
    properties = { status = { siid = 2, piid = 1 }, current_position = { siid = 2, piid = 2 } }
  },

  -- ====== Extended Models ======
  -- Yeelink Extended
  ["yeelink.light.ceiling5"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 4, min = 2700, max = 5700, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.ceiling6"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.ceiling7"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.ceiling8"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.ceiling11"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.ceiling12"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.ceiling13"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.ceiling16"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 3000, max = 5700, step = 1, unit = "kelvin" },
      power = { siid = 2, piid = 1 }
    }
  },
  ["yeelink.light.ceiling18"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.ceiling19"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.ceiling20"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "day",
      [2] = "night"
    }
  },
  ["yeelink.light.bslamp1"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 3, min = 1, max = 16777215, step = 1, unit = "rgb" },
      color_temperature = { siid = 2, piid = 4, min = 1700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "color",
      [2] = "day"
    }
  },
  ["yeelink.light.bslamp2"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 4, min = 1, max = 16777215, step = 1, unit = "rgb" },
      color_temperature = { siid = 2, piid = 3, min = 1700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "color",
      [2] = "day"
    }
  },
  ["yeelink.light.bslamp3"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 5, min = 1, max = 16777215, step = 1, unit = "rgb" },
      color_temperature = { siid = 2, piid = 3, min = 1700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "day",
      [1] = "color"
    }
  },
  ["yeelink.light.color3"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 4, min = 1, max = 16777215, step = 1, unit = "rgb" },
      color_temperature = { siid = 2, piid = 3, min = 1700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "color",
      [2] = "day"
    }
  },
  ["yeelink.light.color4"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 4, min = 1, max = 16777215, step = 1, unit = "rgb" },
      color_temperature = { siid = 2, piid = 3, min = 1700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "color",
      [2] = "day"
    }
  },
  ["yeelink.light.color5"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 4, min = 1, max = 16777215, step = 1, unit = "rgb" },
      color_temperature = { siid = 2, piid = 3, min = 1700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "color",
      [2] = "day"
    }
  },
  ["yeelink.light.color8"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 4, min = 1, max = 16777215, step = 1, unit = "rgb" },
      color_temperature = { siid = 2, piid = 3, min = 1700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "color",
      [2] = "day"
    }
  },
  ["yeelink.light.strip1"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 3, min = 1, max = 16777215, step = 1, unit = "rgb" },
      color_temperature = { siid = 2, piid = 4, min = 1700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "color",
      [2] = "day"
    }
  },
  ["yeelink.light.strip2"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 3, min = 1, max = 16777215, step = 1, unit = "rgb" },
      power = { siid = 2, piid = 1 }
    }
  },
  ["yeelink.light.strip8"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 3, min = 1, max = 16777215, step = 1, unit = "rgb" },
      power = { siid = 2, piid = 1, unit = "none" }
    }
  },
  ["yeelink.light.lamp1"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "reading",
      [1] = "computer",
      [2] = "nightReading",
      [3] = "antiblue",
      [4] = "effectiveWork",
      [5] = "candle",
      [6] = "twinkle"
    }
  },
  ["yeelink.light.lamp15"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 4, min = 1, max = 16777215, step = 1, unit = "rgb" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 5, unit = "none" },
      power = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [2] = "ct"
    }
  },
  ["yeelink.light.mono1"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 }
    }
  },
  ["yeelink.light.mono6"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 }
    }
  },
  ["yeelink.light.mono7"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 }
    }
  },
  ["yeelink.light.panel1"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 }
    }
  },
  ["yeelink.bhf_light.v1"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 6500, step = 1, unit = "kelvin" },
      fan_level = { siid = 4, piid = 1 },
      horizontal_angle = { siid = 4, piid = 3, min = 60, max = 115, step = 1 },
      horizontal_swing = { siid = 4, piid = 2 },
      humidity = { siid = 5, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      ["ptc-bath-heater_mode"] = { siid = 3, piid = 1 },
      temperature = { siid = 3, piid = 2, min = -50, max = 50, step = 1, unit = "celsius" }
    }
  },
  ["yeelink.bhf_light.v2"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      fan_level = { siid = 4, piid = 1 },
      power = { siid = 2, piid = 1 },
      ["ptc-bath-heater_mode"] = { siid = 3, piid = 1 }
    }
  },
  ["yeelink.bhf_light.v3"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "heat",
      [2] = "ventilate",
      [3] = "dry",
      [4] = "fan",
      [5] = "idle"
    }
  },
  ["yeelink.bhf_light.v5"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      ["ptc-bath-heater_mode"] = { siid = 3, piid = 1 },
      target_temperature = { siid = 3, piid = 5, min = 25, max = 45, step = 1, unit = "celsius" },
      temperature = { siid = 3, piid = 6, min = 0, max = 50, step = 1, unit = "celsius" }
    },
    mode_map = {
      [1] = "lighting",
      [2] = "nightLight"
    }
  },
  ["yeelink.bhf_light.v6"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1, unit = "none" },
      ["ptc-bath-heater_mode"] = { siid = 3, piid = 1, unit = "none" },
      target_temperature = { siid = 3, piid = 2, min = 25, max = 45, step = 1, unit = "celsius" },
      temperature = { siid = 3, piid = 3, min = 0, max = 50, step = 1, unit = "celsius" }
    },
    mode_map = {
      [0] = "day",
      [1] = "night"
    }
  },
  ["yeelink.bhf_light.v10"] = {
    device_type = "light",
    properties = {
      heat_level = { siid = 3, piid = 5 },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1, unit = "none" },
      ["ptc-bath-heater_mode"] = { siid = 3, piid = 1 }
    },
    mode_map = {
      [0] = "day",
      [1] = "night"
    }
  },
  ["yeelink.bhf_light.v11"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "percentage" },
      heat_level = { siid = 3, piid = 5 },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 },
      ["ptc-bath-heater_mode"] = { siid = 3, piid = 1 }
    },
    mode_map = {
      [0] = "day",
      [1] = "night"
    }
  },
  ["yeelink.curtain.ctmt1"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 6, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 3 },
      status = { siid = 2, piid = 4, unit = "none" },
      target_position = { siid = 2, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" }
    },
    mode_map = {
      [0] = "unknownMode",
      [1] = "unknownMode",
      [2] = "unknownMode",
      [3] = "unknownMode"
    }
  },

  -- Philips Extended
  ["philips.light.bceil1"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 4, min = 2700, max = 5700, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 2, min = 0, max = 4, step = 1, unit = "none" },
      power = { siid = 2, piid = 1 }
    }
  },
  ["philips.light.bceil2"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 4, min = 2700, max = 5700, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 2, min = 0, max = 4, step = 1, unit = "none" },
      power = { siid = 2, piid = 1 }
    }
  },
  ["philips.light.ceil33"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 4, min = 2700, max = 5700, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "custom",
      [1] = "brightness",
      [2] = "tv",
      [3] = "warmth",
      [4] = "night"
    }
  },
  ["philips.light.strip2"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 5, min = 0, max = 16777215, step = 1, unit = "rgb" },
      color_temperature = { siid = 2, piid = 4, min = 1882, max = 7000, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "custom",
      [1] = "passionParty",
      [2] = "romanticTime",
      [3] = "brightness",
      [4] = "warmth"
    }
  },
  ["philips.light.strip3"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 4, min = 0, max = 16777215, step = 1, unit = "rgb" },
      mode = { siid = 2, piid = 2, min = 0, max = 8, step = 1 },
      power = { siid = 2, piid = 1 }
    }
  },
  ["philips.light.strip5"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 4, min = 0, max = 16777215, step = 1, unit = "rgb" },
      mode = { siid = 2, piid = 2, min = 0, max = 8, step = 1 },
      power = { siid = 2, piid = 1 }
    }
  },
  ["philips.light.sread3"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "none" },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "custom",
      [1] = "childMode",
      [2] = "adultReading",
      [3] = "mobilePhoneComputer"
    }
  },
  ["philips.light.sread4"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "none" },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "custom",
      [1] = "aA",
      [2] = "adultReading",
      [3] = "childReading",
      [4] = "screenReading"
    }
  },

  -- Mijia/Xiaomi Lights
  ["mijia.light.v1"] = {
    device_type = "light",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      brightness = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2 },
      color = { siid = 2, piid = 4, min = 0, max = 16777215, step = 1, unit = "rgb" },
      color_temperature = { siid = 2, piid = 5, min = 1000, max = 10000, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      voltage = { siid = 3, piid = 3, min = 0, max = 65535, step = 1 }
    },
    mode_map = {
      [0] = "auto"
    }
  },
  ["xiaomi.light.ceiling"] = { device_type = "light", properties = { power = { siid = 2, piid = 1 }, brightness = { siid = 2, piid = 2 } } },
  ["xiaomi.light.lamp30"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 }
    }
  },
  ["xiaomi.light.lamp31"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 2700, max = 5100, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 15 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "reading",
      [2] = "computer",
      [3] = "warmth",
      [4] = "leisure",
      [5] = "office",
      [6] = "entertainment"
    }
  },

  -- Opple Lights
  ["opple.light.ceiling"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      color = { siid = 2, piid = 4, min = 0, max = 16777215, step = 1, unit = "rgb" },
      color_temperature = { siid = 2, piid = 5, min = 1000, max = 10000, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "auto"
    }
  },
  ["opple.light.dcfan"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 4, min = 3000, max = 5700, step = 1, unit = "kelvin" },
      fan_level = { siid = 7, piid = 2 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 8, piid = 6, min = -20, max = 85, step = 1, unit = "celsius" }
    },
    mode_map = {
      [0] = "noMode",
      [1] = "hospitality",
      [2] = "tv",
      [3] = "entertainment",
      [4] = "night",
      [5] = "sunrise",
      [6] = "sunset",
      [7] = "sleep"
    }
  },
  ["opple.light.dcfan2"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 4, min = 3000, max = 5700, step = 1, unit = "kelvin" },
      fan_level = { siid = 7, piid = 2 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 8, piid = 6, min = -20, max = 85, step = 1, unit = "celsius" }
    },
    mode_map = {
      [0] = "noMode",
      [1] = "hospitality",
      [2] = "tv",
      [3] = "entertainment",
      [4] = "night",
      [5] = "sunrise",
      [6] = "sunset",
      [7] = "sleep"
    }
  },

  -- Leishi Lights
  ["leishi.light.wy0a06"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 3, min = 1, max = 255, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 5, min = 3000, max = 5700, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "reading",
      [2] = "night",
      [3] = "tv"
    }
  },
  ["leishi.light.wy0a10"] = {
    device_type = "light",
    properties = {
      brightness = { siid = 2, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 2, piid = 3, min = 3000, max = 6400, step = 1, unit = "kelvin" },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "wY",
      [4] = "day",
      [5] = "night",
      [7] = "warmth",
      [8] = "tv",
      [9] = "reading",
      [10] = "computer",
      [11] = "hospitality",
      [12] = "entertainment",
      [13] = "wakeup",
      [14] = "dusk",
      [15] = "sleeping",
      [16] = "winter",
      [17] = "summer",
      [18] = "rhythmic"
    }
  },

  -- Chuangmi Plugs Extended
  ["chuangmi.plug.hmi205"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 },
      temperature = { siid = 2, piid = 2, min = -40, max = 125, step = 0.1, unit = "celsius" }
    }
  },
  ["chuangmi.plug.hmi206"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 },
      temperature = { siid = 2, piid = 2, min = 0, max = 100, step = 1, unit = "celsius" }
    }
  },
  ["chuangmi.plug.hmi208"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 }
    }
  },
  ["chuangmi.plug.m1"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 },
      temperature = { siid = 2, piid = 2, min = -40, max = 125, step = 0.1, unit = "celsius" }
    }
  },
  ["chuangmi.plug.m3"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 },
      temperature = { siid = 2, piid = 2, min = 0, max = 100, step = 1, unit = "celsius" }
    }
  },

  -- Cuco Extended
  ["cuco.plug.cp1d"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 }
    }
  },
  ["cuco.plug.cp2a"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 },
      setting_mode = { siid = 7, piid = 3 },
      status = { siid = 3, piid = 2 }
    }
  },
  ["cuco.plug.cp2d"] = {
    device_type = "switch",
    properties = {
      electric_current = { siid = 3, piid = 2, min = 0, max = 65535, step = 1 },
      electric_power = { siid = 3, piid = 4, min = 0, max = 65535, step = 1, unit = "watt" },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 3, piid = 1, min = 0, max = 65535, step = 1 },
      temperature = { siid = 6, piid = 2, min = 0, max = 150, step = 1, unit = "celsius" },
      voltage = { siid = 3, piid = 3, min = 0, max = 65535, step = 1 }
    }
  },
  ["cuco.plug.cp4"] = {
    device_type = "switch",
    properties = {
      electric_current = { siid = 2, piid = 4, min = 0, max = 65535, step = 1, unit = "none" },
      power = { siid = 2, piid = 1, unit = "none" },
      power_consumption = { siid = 2, piid = 2, min = 0, max = 65535, step = 1, unit = "none" },
      voltage = { siid = 2, piid = 3, min = 0, max = 3000, step = 1, unit = "none" }
    }
  },
  ["cuco.plug.cp4am"] = {
    device_type = "switch",
    properties = {
      electric_current = { siid = 2, piid = 4, min = 0, max = 65535, step = 1, unit = "none" },
      power = { siid = 2, piid = 1, unit = "none" },
      power_consumption = { siid = 2, piid = 2, min = 0, max = 65535, step = 1 },
      voltage = { siid = 2, piid = 3, min = 0, max = 3000, step = 1, unit = "none" }
    }
  },
  ["cuco.plug.cp4m"] = {
    device_type = "switch",
    properties = {
      electric_current = { siid = 2, piid = 4, min = 0, max = 65535, step = 1, unit = "none" },
      power = { siid = 2, piid = 1, unit = "none" },
      power_consumption = { siid = 2, piid = 2, min = 0, max = 65535, step = 1, unit = "none" },
      voltage = { siid = 2, piid = 3, min = 0, max = 3000, step = 1, unit = "none" }
    }
  },
  ["cuco.plug.cp5d"] = {
    device_type = "switch",
    properties = {
      ["indicator-light_mode"] = { siid = 10, piid = 2 },
      power = { siid = 2, piid = 1 }
    }
  },
  ["cuco.plug.cp5prd"] = {
    device_type = "switch",
    properties = {
      electric_current = { siid = 10, piid = 2, min = 0, max = 255, step = 0.1 },
      electric_power = { siid = 10, piid = 4, min = 0, max = 65535, step = 0.1, unit = "watt" },
      ["indicator-light_mode"] = { siid = 12, piid = 2 },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 10, piid = 1, min = 0, max = 65535, step = 0.01 },
      status = { siid = 7, piid = 2 },
      switch_mode = { siid = 7, piid = 5 },
      voltage = { siid = 10, piid = 3, min = 0, max = 65535, step = 0.1 }
    }
  },
  ["cuco.plug.cp5pro"] = {
    device_type = "switch",
    properties = {
      electric_current = { siid = 10, piid = 2, min = 0, max = 255, step = 0.1 },
      electric_power = { siid = 10, piid = 4, min = 0, max = 65535, step = 0.1, unit = "watt" },
      ["indicator-light_mode"] = { siid = 12, piid = 2 },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 10, piid = 1, min = 0, max = 65535, step = 0.01 },
      status = { siid = 7, piid = 2 },
      switch_mode = { siid = 7, piid = 5 },
      voltage = { siid = 10, piid = 3, min = 0, max = 65535, step = 0.1 }
    }
  },
  ["cuco.plug.v2eur"] = {
    device_type = "switch",
    properties = {
      electric_power = { siid = 11, piid = 2, min = 0, max = 5000, step = 1, unit = "watt" },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 11, piid = 1, min = 0, max = 65535, step = 1 },
      status = { siid = 5, piid = 1 }
    }
  },
  ["cuco.plug.v3"] = {
    device_type = "switch",
    properties = {
      electric_power = { siid = 11, piid = 2, min = 0, max = 10000, step = 1, unit = "watt" },
      ["indicator-light_mode"] = { siid = 3, piid = 2 },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 11, piid = 1, min = 0, max = 65535, step = 1 },
      status = { siid = 5, piid = 1 },
      temperature = { siid = 12, piid = 2, min = 0, max = 150, step = 1, unit = "celsius" }
    }
  },
  ["cuco.plug.wp5m"] = {
    device_type = "switch",
    properties = {
      electric_power = { siid = 3, piid = 2, min = 0, max = 65535, step = 1, unit = "watt" },
      power = { siid = 2, piid = 1, unit = "none" },
      power_consumption = { siid = 3, piid = 1, min = 0, max = 65535, step = 1 },
      status = { siid = 5, piid = 1 }
    }
  },
  ["cuco.plug.wp12"] = {
    device_type = "switch",
    properties = {
      electric_power = { siid = 11, piid = 4, min = 0, max = 10000, step = 1, unit = "watt" },
      ["indicator-light_mode"] = { siid = 13, piid = 2 },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 11, piid = 1, min = 0, max = 65535, step = 0.01 },
      status = { siid = 7, piid = 2 }
    }
  },
  ["cuco.switch.cs1"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 },
      temperature = { siid = 5, piid = 2, unit = "none" }
    }
  },
  ["cuco.switch.cs1d"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 }
    }
  },
  ["cuco.switch.cs2"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1, unit = "none" },
      temperature = { siid = 5, piid = 2, unit = "none" }
    }
  },
  ["cuco.switch.cs2d"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 }
    }
  },
  ["cuco.switch.cs3"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 },
      temperature = { siid = 5, piid = 2, unit = "none" }
    }
  },
  ["cuco.switch.cs3d"] = {
    device_type = "switch",
    properties = {
      power = { siid = 2, piid = 1 }
    }
  },

  -- Lumi Extended
  ["lumi.ctrl_neutral1.v1"] = {
    device_type = "switch",
    properties = {
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "wiredAndWireless",
      [1] = "wireless"
    }
  },
  ["lumi.ctrl_neutral2.v1"] = {
    device_type = "switch",
    properties = {
      mode = { siid = 2, piid = 3, unit = "none" },
      power = { siid = 2, piid = 1 },
      switch_mode = { siid = 3, piid = 3, unit = "none" }
    },
    mode_map = {
      [0] = "wiredAndWireless",
      [1] = "wireless"
    }
  },
  ["lumi.switch.acn032"] = {
    device_type = "switch",
    properties = {
      brightness = { siid = 7, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      electric_power = { siid = 10, piid = 6, min = 0, max = 50000, step = 0.001, unit = "watt" },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 10, piid = 1, min = 0, max = 730000, step = 0.001, unit = "kWh" }
    }
  },
  ["lumi.curtain.acn02"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 5, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 2 },
      speed_level = { siid = 2, piid = 14 },
      status = { siid = 2, piid = 3 },
      target_position = { siid = 2, piid = 6, min = 0, max = 100, step = 1, unit = "percentage" }
    },
    mode_map = {
      [0] = "auto"
    }
  },
  ["lumi.curtain.acn014"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 4, min = 0, max = 100, step = 1, unit = "percentage" },
      status = { siid = 2, piid = 3 },
      target_position = { siid = 2, piid = 5, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["lumi.curtain.hmcn01"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      status = { siid = 2, piid = 6, unit = "none" },
      target_position = { siid = 2, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["lumi.curtain.mcn005"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 4, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 6, piid = 1 },
      status = { siid = 2, piid = 3 },
      target_position = { siid = 2, piid = 5, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["lumi.acpartner.v1"] = {
    device_type = "climate",
    properties = {
      fan_level = { siid = 3, piid = 1 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      target_temperature = { siid = 2, piid = 3, min = 17, max = 30, step = 1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 2 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "cool",
      [2] = "dry",
      [3] = "heat",
      [4] = "fan"
    }
  },
  ["lumi.acpartner.v2"] = {
    device_type = "climate",
    properties = {
      fan_level = { siid = 3, piid = 1 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      target_temperature = { siid = 2, piid = 3, min = 17, max = 30, step = 1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 2 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "cool",
      [2] = "dry",
      [3] = "heat",
      [4] = "fan"
    }
  },
  ["lumi.acpartner.v3"] = {
    device_type = "climate",
    properties = {
      fan_level = { siid = 3, piid = 1 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      target_temperature = { siid = 2, piid = 3, min = 17, max = 30, step = 1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 2 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "cool",
      [2] = "dry",
      [3] = "heat",
      [4] = "fan"
    }
  },

  -- QMI
  ["qmi.plug.tw02"] = {
    device_type = "switch",
    properties = {
      electric_current = { siid = 4, piid = 2, min = 0, max = 40000, step = 1 },
      electric_power = { siid = 4, piid = 4, min = 0, max = 10000000, step = 0.01, unit = "watt" },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 4, piid = 1, min = 0, max = 100, step = 0.01, unit = "kWh" },
      status = { siid = 2, piid = 3 },
      temperature = { siid = 2, piid = 6, min = -30, max = 100, step = 1, unit = "celsius" },
      voltage = { siid = 4, piid = 3, min = 0, max = 300000, step = 1 }
    }
  },
  ["qmi.plug.2a1c1"] = {
    device_type = "switch",
    properties = {
      electric_current = { siid = 3, piid = 4, min = 0, max = 20000, step = 1 },
      electric_power = { siid = 3, piid = 2, min = 0, max = 3000, step = 0.001, unit = "watt" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 3, piid = 1, min = 0, max = 200000, step = 0.01 },
      status = { siid = 6, piid = 3 },
      temperature = { siid = 2, piid = 3, min = -30, max = 125, step = 0.1, unit = "celsius" },
      voltage = { siid = 3, piid = 3, min = 0, max = 300000, step = 1 }
    }
  },
  ["qmi.plug.psv3"] = {
    device_type = "switch",
    properties = {
      electric_current = { siid = 3, piid = 4, min = 0, max = 100000, step = 1 },
      electric_power = { siid = 3, piid = 2, min = 0, max = 10000, step = 0.0001, unit = "watt" },
      mode = { siid = 2, piid = 2, min = 0, max = 1, step = 1 },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 3, piid = 1, min = 0, max = 20000000, step = 0.01 },
      status = { siid = 6, piid = 3 },
      temperature = { siid = 2, piid = 3, min = -30, max = 125, step = 0.1, unit = "celsius" },
      voltage = { siid = 3, piid = 3, min = 0, max = 500000, step = 1 }
    }
  },

  -- Xiaomi AC Extended
  ["xiaomi.aircondition.c12"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2, unit = "none" },
      heater = { siid = 2, piid = 9 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_angle = { siid = 3, piid = 6, unit = "none" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.c13"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2, unit = "none" },
      heater = { siid = 2, piid = 9 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_angle = { siid = 3, piid = 6, unit = "none" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.c15"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "lux" },
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2, unit = "none" },
      heater = { siid = 2, piid = 9 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.c16"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "lux" },
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2, unit = "none" },
      heater = { siid = 2, piid = 9 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.c24"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "lux" },
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      filter_life_level = { siid = 15, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      heater = { siid = 2, piid = 9 },
      horizontal_swing = { siid = 3, piid = 3 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" },
      vertical_angle = { siid = 3, piid = 6 },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat",
      [6] = "off"
    }
  },
  ["xiaomi.aircondition.c26"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "lux" },
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      horizontal_swing = { siid = 3, piid = 3 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" },
      vertical_angle = { siid = 3, piid = 6 },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat",
      [6] = "off"
    }
  },
  ["xiaomi.aircondition.c30"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "percentage" },
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      horizontal_angle = { siid = 3, piid = 5 },
      horizontal_swing = { siid = 3, piid = 3 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 20, piid = 1, min = 0, max = 999999.99, step = 0.01 },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat",
      [6] = "off"
    }
  },
  ["xiaomi.aircondition.c31"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "lux" },
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      horizontal_swing = { siid = 3, piid = 3 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 20, piid = 1, min = 0, max = 9999.99, step = 0.01 },
      sleep_mode = { siid = 2, piid = 11 },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" },
      vertical_angle = { siid = 3, piid = 6 },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat",
      [6] = "off"
    }
  },
  ["xiaomi.aircondition.c32"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2 },
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      horizontal_swing = { siid = 3, piid = 3 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 20, piid = 1, min = 0, max = 999999.99, step = 0.01 },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.c33"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "lux" },
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 20, piid = 1, min = 0, max = 99999999.99, step = 0.01 },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" },
      vertical_angle = { siid = 3, piid = 6 },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.mc3"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      status = { siid = 2, piid = 12 },
      target_humidity = { siid = 11, piid = 3, min = 1, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.mc4"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.mc5"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.mc6"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      horizontal_swing = { siid = 3, piid = 3 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.mc7"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      horizontal_swing = { siid = 3, piid = 3 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.mc8"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.mc9"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      horizontal_swing = { siid = 3, piid = 3 },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.m4"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "percentage" },
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      filter_life_level = { siid = 21, piid = 1, min = 0, max = 101, step = 1, unit = "percentage" },
      heater = { siid = 2, piid = 9 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -50, max = 150, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.m9"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "percentage" },
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      filter_life_level = { siid = 21, piid = 1, min = 0, max = 101, step = 1, unit = "percentage" },
      heater = { siid = 2, piid = 9 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 20, piid = 1, min = 0, max = 999999.99, step = 0.01, unit = "kWh" },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -50, max = 150, step = 0.1, unit = "celsius" },
      vertical_angle = { siid = 3, piid = 6 },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.m15"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "percentage" },
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      filter_life_level = { siid = 21, piid = 1, min = 0, max = 101, step = 1, unit = "percentage" },
      heater = { siid = 2, piid = 9 },
      horizontal_swing = { siid = 3, piid = 3 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 20, piid = 1, min = 0, max = 99999999.99, step = 0.01, unit = "kWh" },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -50, max = 150, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.m16"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "percentage" },
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      filter_life_level = { siid = 21, piid = 1, min = 0, max = 101, step = 1, unit = "percentage" },
      heater = { siid = 2, piid = 9 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 20, piid = 1, min = 0, max = 999999.99, step = 0.01, unit = "kWh" },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -50, max = 150, step = 0.1, unit = "celsius" },
      vertical_angle = { siid = 3, piid = 6 },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.mt0"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "lux" },
      co2 = { siid = 4, piid = 8, min = 0, max = 5000, step = 1, unit = "ppm" },
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      heater = { siid = 2, piid = 9 },
      horizontal_angle = { siid = 3, piid = 5 },
      horizontal_swing = { siid = 3, piid = 3 },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      uv = { siid = 2, piid = 13 },
      vertical_angle = { siid = 3, piid = 6 },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat",
      [6] = "off"
    }
  },
  ["xiaomi.aircondition.mt1"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2, unit = "none" },
      heater = { siid = 2, piid = 9 },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.mt5"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7, unit = "none" },
      fan_level = { siid = 3, piid = 2, unit = "none" },
      heater = { siid = 2, piid = 9 },
      horizontal_swing = { siid = 3, piid = 3 },
      mode = { siid = 2, piid = 2, unit = "none" },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.mt6"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "lux" },
      co2 = { siid = 4, piid = 8, min = 0, max = 5000, step = 1, unit = "ppm" },
      dryer = { siid = 2, piid = 10 },
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2, unit = "none" },
      heater = { siid = 2, piid = 9 },
      horizontal_angle = { siid = 3, piid = 5, unit = "none" },
      horizontal_swing = { siid = 3, piid = 3, unit = "none" },
      humidity = { siid = 4, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 14, min = 0, max = 100, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      uv = { siid = 2, piid = 13, unit = "none" },
      vertical_angle = { siid = 3, piid = 6 },
      vertical_swing = { siid = 3, piid = 4, unit = "none" }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat",
      [6] = "off"
    }
  },
  ["xiaomi.aircondition.ma2"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 7 },
      eco = { siid = 2, piid = 4 },
      fan_level = { siid = 3, piid = 1 },
      heater = { siid = 2, piid = 5 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      power_consumption = { siid = 7, piid = 1, min = 0, max = 999999.999999, step = 1e-06 },
      sleep_mode = { siid = 2, piid = 6 },
      target_temperature = { siid = 2, piid = 3, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 1, min = -20, max = 80, step = 0.5, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 2 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["xiaomi.aircondition.ma5"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 7 },
      eco = { siid = 2, piid = 4 },
      fan_level = { siid = 3, piid = 1 },
      heater = { siid = 2, piid = 5 },
      horizontal_swing = { siid = 3, piid = 3 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 6 },
      target_temperature = { siid = 2, piid = 3, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 1, min = -20, max = 80, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 2 }
    },
    mode_map = {
      [1] = "cool",
      [2] = "dry",
      [3] = "heat",
      [4] = "fan"
    }
  },
  ["xiaomi.aircondition.ma6"] = {
    device_type = "climate",
    properties = {
      dryer = { siid = 2, piid = 7 },
      eco = { siid = 2, piid = 4 },
      fan_level = { siid = 3, piid = 1 },
      heater = { siid = 2, piid = 5 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 6 },
      target_temperature = { siid = 2, piid = 3, min = 16, max = 31, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 1, min = -20, max = 80, step = 1, unit = "celsius" },
      vertical_swing = { siid = 3, piid = 2 }
    },
    mode_map = {
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },

  -- Zhimi AC Extended
  ["zhimi.aircondition.ma2"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, min = 0, max = 7, step = 1 },
      fan_level = { siid = 3, piid = 1 },
      heater = { siid = 2, piid = 4 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 5 },
      target_temperature = { siid = 2, piid = 3, min = 16, max = 32, step = 0.1, unit = "celsius" },
      temperature = { siid = 4, piid = 1, min = -40, max = 125, step = 0.1, unit = "celsius" },
      vertical_angle = { siid = 3, piid = 3, min = 0, max = 60, step = 1 },
      vertical_swing = { siid = 3, piid = 2 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "cool",
      [2] = "dry",
      [3] = "heat",
      [4] = "fan"
    }
  },
  ["zhimi.aircondition.ma3"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, min = 0, max = 7, step = 1 },
      fan_level = { siid = 3, piid = 1 },
      heater = { siid = 2, piid = 4 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 5 },
      target_temperature = { siid = 2, piid = 3, min = 16, max = 32, step = 0.5, unit = "celsius" },
      temperature = { siid = 4, piid = 1, min = -40, max = 125, step = 0.1, unit = "celsius" },
      vertical_angle = { siid = 3, piid = 3, min = 0, max = 60, step = 1 },
      vertical_swing = { siid = 3, piid = 2 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "cool",
      [2] = "dry",
      [3] = "heat",
      [4] = "fan"
    }
  },
  ["zhimi.aircondition.ma4"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 2, min = 0, max = 5, step = 1 },
      fan_level = { siid = 3, piid = 1 },
      heater = { siid = 2, piid = 4 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 5 },
      target_temperature = { siid = 2, piid = 3, min = 16, max = 32, step = 0.1, unit = "celsius" },
      temperature = { siid = 4, piid = 1, min = -40, max = 125, step = 0.1, unit = "celsius" },
      vertical_angle = { siid = 3, piid = 3, min = 0, max = 60, step = 1 },
      vertical_swing = { siid = 3, piid = 2 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "cool",
      [2] = "dry",
      [3] = "heat",
      [4] = "fan"
    }
  },
  ["zhimi.aircondition.v1"] = {
    device_type = "climate",
    properties = {
      brightness = { siid = 6, piid = 1, min = 0, max = 7, step = 1 },
      fan_level = { siid = 3, piid = 1 },
      heater = { siid = 2, piid = 5 },
      horizontal_swing = { siid = 3, piid = 2 },
      humidity = { siid = 4, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 4 },
      target_temperature = { siid = 2, piid = 3, min = 16, max = 32, step = 0.1, unit = "celsius" },
      temperature = { siid = 4, piid = 1, min = -40, max = 125, step = 0.1, unit = "celsius" },
      vertical_angle = { siid = 3, piid = 4, min = 20, max = 60, step = 20 },
      vertical_swing = { siid = 3, piid = 3 }
    },
    mode_map = {
      [1] = "cool",
      [2] = "dry",
      [3] = "heat",
      [4] = "fan"
    }
  },

  -- Viomi
  ["viomi.aircondition.y116"] = {
    device_type = "climate",
    properties = {
      eco = { siid = 2, piid = 7 },
      fan_level = { siid = 3, piid = 2 },
      horizontal_swing = { siid = 3, piid = 3 },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      sleep_mode = { siid = 2, piid = 13 },
      target_temperature = { siid = 2, piid = 4, min = 16, max = 32, step = 1, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      uv = { siid = 8, piid = 8 },
      vertical_swing = { siid = 3, piid = 4 }
    },
    mode_map = {
      [1] = "auto",
      [2] = "cool",
      [3] = "dry",
      [4] = "fan",
      [5] = "heat"
    }
  },
  ["viomi.fan.v6"] = {
    device_type = "fan",
    properties = {
      anion = { siid = 2, piid = 7 },
      fan_level = { siid = 2, piid = 2, min = 1, max = 99, step = 1 },
      horizontal_swing = { siid = 2, piid = 3 },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 5, unit = "none" },
      vertical_swing = { siid = 2, piid = 6 }
    },
    mode_map = {
      [0] = "none",
      [1] = "naturalWind",
      [2] = "babyCare",
      [3] = "strong",
      [4] = "sleep"
    }
  },
  ["viomi.fan.v7"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 2, min = 1, max = 100, step = 1 },
      horizontal_angle = { siid = 2, piid = 8 },
      horizontal_swing = { siid = 2, piid = 3 },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 5, unit = "none" }
    },
    mode_map = {
      [0] = "basic",
      [1] = "naturalWind",
      [4] = "sleep"
    }
  },
  ["viomi.hood.v5"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 10, piid = 2, unit = "none" },
      power = { siid = 2, piid = 2, unit = "none" },
      status = { siid = 7, piid = 1, unit = "none" }
    }
  },
  ["viomi.vacuum.v7"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 1 },
      status = { siid = 2, piid = 2 }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong"
    }
  },
  ["viomi.vacuum.v8"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "medium",
      [3] = "strong"
    }
  },
  ["viomi.vacuum.v18"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 19, unit = "none" },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "medium",
      [3] = "strong"
    }
  },
  ["viomi.airer.vcy102"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 7, unit = "none" },
      power = { siid = 3, piid = 1 },
      status = { siid = 2, piid = 4, unit = "none" }
    }
  },
  ["viomi.airer.vcy105"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 7, unit = "none" },
      power = { siid = 3, piid = 1 },
      status = { siid = 2, piid = 4, unit = "none" }
    }
  },

  -- Dmaker Fans Extended
  ["dmaker.fan.1c"] = {
    device_type = "fan",
    properties = {
      brightness = { siid = 2, piid = 12, unit = "none" },
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_swing = { siid = 2, piid = 3 },
      mode = { siid = 2, piid = 7, unit = "none" },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "sleep"
    }
  },
  ["dmaker.fan.1e"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_angle = { siid = 2, piid = 5, unit = "none" },
      horizontal_swing = { siid = 2, piid = 4 },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 8, piid = 1, min = 1, max = 100, step = 1 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },
  ["dmaker.fan.p8"] = {
    device_type = "fan",
    properties = {
      brightness = { siid = 2, piid = 12, unit = "none" },
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_swing = { siid = 2, piid = 3 },
      mode = { siid = 2, piid = 7, unit = "none" },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "sleep"
    }
  },
  ["dmaker.fan.p9"] = {
    device_type = "fan",
    properties = {
      brightness = { siid = 2, piid = 9, unit = "none" },
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_angle = { siid = 2, piid = 6, unit = "none" },
      horizontal_swing = { siid = 2, piid = 5, unit = "none" },
      mode = { siid = 2, piid = 4, unit = "none" },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 11, min = 1, max = 100, step = 1, unit = "none" }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind",
      [2] = "sleep"
    }
  },
  ["dmaker.fan.p18"] = {
    device_type = "fan",
    properties = {
      brightness = { siid = 2, piid = 7, unit = "none" },
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_angle = { siid = 2, piid = 5, unit = "none" },
      horizontal_swing = { siid = 2, piid = 4, unit = "none" },
      mode = { siid = 2, piid = 3, unit = "none" },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 10, min = 1, max = 100, step = 1, unit = "none" }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },
  ["dmaker.fan.p23"] = {
    device_type = "heater",
    properties = {
      fan_level = { siid = 5, piid = 2, min = 1, max = 10, step = 1 },
      fan_mode = { siid = 5, piid = 4 },
      horizontal_swing = { siid = 5, piid = 3 },
      humidity = { siid = 4, piid = 1, min = 0, max = 100, step = 0.1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 8, piid = 1, min = 1, max = 100, step = 1 },
      target_temperature = { siid = 2, piid = 5, min = 18, max = 28, step = 1, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "constantTemperature"
    }
  },
  ["dmaker.fan.p28"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_swing = { siid = 2, piid = 4 },
      humidity = { siid = 9, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 8, piid = 1, min = 1, max = 100, step = 1 },
      temperature = { siid = 9, piid = 1, min = 0, max = 45, step = 0.1, unit = "celsius" },
      vertical_swing = { siid = 2, piid = 7 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind",
      [2] = "smart",
      [3] = "sleep"
    }
  },
  ["dmaker.fan.p30"] = {
    device_type = "fan",
    properties = {
      brightness = { siid = 2, piid = 7, unit = "none" },
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_angle = { siid = 2, piid = 5, unit = "none" },
      horizontal_swing = { siid = 2, piid = 4, unit = "none" },
      mode = { siid = 2, piid = 3, unit = "none" },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 10, min = 1, max = 100, step = 1, unit = "none" }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },
  ["dmaker.fan.p33"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_angle = { siid = 2, piid = 5, unit = "none" },
      horizontal_swing = { siid = 2, piid = 4 },
      mode = { siid = 2, piid = 3, unit = "none" },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 6, min = 1, max = 100, step = 1, unit = "none" }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },
  ["dmaker.fan.p39"] = {
    device_type = "fan",
    properties = {
      brightness = { siid = 2, piid = 9, unit = "none" },
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_angle = { siid = 2, piid = 6, unit = "none" },
      horizontal_swing = { siid = 2, piid = 5, unit = "none" },
      mode = { siid = 2, piid = 4, unit = "none" },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 11, min = 1, max = 100, step = 1, unit = "none" }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind",
      [2] = "sleep"
    }
  },
  ["dmaker.fan.p42"] = {
    device_type = "fan",
    properties = {
      brightness = { siid = 2, piid = 7, unit = "none" },
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_angle = { siid = 2, piid = 5, unit = "none" },
      horizontal_swing = { siid = 2, piid = 4, unit = "none" },
      mode = { siid = 2, piid = 3, unit = "none" },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 10, min = 1, max = 100, step = 1, unit = "none" }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },
  ["dmaker.fan.p44"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      horizontal_swing = { siid = 2, piid = 4 },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind",
      [2] = "sleep",
      [3] = "coldAir"
    }
  },
  ["dmaker.fan.p45"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      horizontal_swing = { siid = 2, piid = 4 },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 8, piid = 1, min = 1, max = 100, step = 1 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind",
      [2] = "sleep"
    }
  },
  ["dmaker.fan.p5c"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      horizontal_swing = { siid = 2, piid = 4 },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 6 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },
  ["dmaker.fan.p220"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_swing = { siid = 2, piid = 4 },
      humidity = { siid = 9, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 8, piid = 1, min = 1, max = 100, step = 1 },
      temperature = { siid = 8, piid = 5, min = 15, max = 36, step = 1, unit = "celsius" },
      vertical_swing = { siid = 2, piid = 7 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind",
      [2] = "smart",
      [3] = "sleep"
    }
  },
  ["dmaker.fan.p221"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 2, unit = "none" },
      horizontal_swing = { siid = 2, piid = 4 },
      humidity = { siid = 9, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 8, piid = 1, min = 1, max = 100, step = 1 },
      temperature = { siid = 8, piid = 5, min = 15, max = 36, step = 1, unit = "celsius" },
      vertical_swing = { siid = 2, piid = 7 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind",
      [2] = "smart",
      [3] = "sleep"
    }
  },

  -- Dmaker Air Purifiers
  ["dmaker.airp.swift"] = {
    device_type = "air-purifier",
    properties = {
      anion = { siid = 2, piid = 8 },
      brightness = { siid = 7, piid = 2 },
      fan_level = { siid = 2, piid = 7 },
      filter_left_time = { siid = 4, piid = 2, min = 0, max = 1000, step = 1, unit = "days" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      horizontal_swing = { siid = 10, piid = 3 },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      pm25 = { siid = 3, piid = 4, min = 0, max = 999, step = 1, unit = "μg/m3" },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 7, min = 0, max = 45, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "smart",
      [1] = "sleep",
      [2] = "purification",
      [3] = "fan"
    }
  },
  ["dmaker.airp.swift2"] = {
    device_type = "air-purifier",
    properties = {
      anion = { siid = 2, piid = 8 },
      brightness = { siid = 7, piid = 2 },
      fan_level = { siid = 2, piid = 7 },
      filter_left_time = { siid = 4, piid = 2, min = 0, max = 1000, step = 1, unit = "days" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      horizontal_swing = { siid = 10, piid = 3 },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      pm25 = { siid = 3, piid = 4, min = 0, max = 999, step = 1, unit = "μg/m3" },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 7, min = 0, max = 45, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "smart",
      [1] = "sleep",
      [2] = "purification",
      [3] = "fan"
    }
  },
  ["dmaker.airpurifier.f20"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 7, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      fan_level = { siid = 2, piid = 7, unit = "none" },
      filter_left_time = { siid = 4, piid = 2, min = 0, max = 1000, step = 1, unit = "hours" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      pm25 = { siid = 3, piid = 4, min = 0, max = 1000, step = 1 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "level1",
      [3] = "level2",
      [4] = "level3",
      [5] = "favorite"
    }
  },

  -- Zhimi Fans Extended
  ["zhimi.fan.v2"] = {
    device_type = "fan",
    properties = {
      battery = { siid = 4, piid = 1, min = 0, max = 100, step = 1 },
      charging_state = { siid = 4, piid = 2 },
      fan_level = { siid = 2, piid = 2, min = 1, max = 4, step = 1 },
      horizontal_angle = { siid = 2, piid = 4, min = 30, max = 120, step = 1 },
      horizontal_swing = { siid = 2, piid = 3 },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },
  ["zhimi.fan.v3"] = {
    device_type = "fan",
    properties = {
      battery = { siid = 4, piid = 1, min = 0, max = 100, step = 1 },
      brightness = { siid = 6, piid = 1 },
      charging_state = { siid = 4, piid = 2 },
      fan_level = { siid = 2, piid = 2 },
      horizontal_swing = { siid = 2, piid = 3 },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },
  ["zhimi.fan.sa1"] = {
    device_type = "fan",
    properties = {
      brightness = { siid = 5, piid = 1 },
      fan_level = { siid = 2, piid = 2 },
      horizontal_swing = { siid = 2, piid = 3 },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "naturalWind",
      [2] = "straightWind"
    }
  },
  ["zhimi.fan.za1"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 2, min = 1, max = 4, step = 1 },
      horizontal_angle = { siid = 2, piid = 4, min = 0, max = 120, step = 1 },
      horizontal_swing = { siid = 2, piid = 3 },
      mode = { siid = 2, piid = 5 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "naturalWind",
      [2] = "straightWind"
    }
  },
  ["zhimi.fan.fb1"] = {
    device_type = "fan",
    properties = {
      brightness = { siid = 2, piid = 10, min = 0, max = 1, step = 1, unit = "none" },
      fan_level = { siid = 2, piid = 2, min = 1, max = 5, step = 1, unit = "none" },
      horizontal_angle = { siid = 2, piid = 5, min = 0, max = 120, step = 1, unit = "none" },
      horizontal_swing = { siid = 2, piid = 3 },
      mode = { siid = 2, piid = 7, unit = "none" },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 8 },
      vertical_angle = { siid = 2, piid = 6, min = 0, max = 90, step = 1, unit = "none" },
      vertical_swing = { siid = 2, piid = 4 }
    },
    mode_map = {
      [0] = "naturalWind",
      [1] = "straightWind"
    }
  },
  ["zhimi.fan.fa1"] = {
    device_type = "fan",
    properties = {
      brightness = { siid = 2, piid = 10, min = 0, max = 1, step = 1, unit = "none" },
      fan_level = { siid = 2, piid = 2 },
      horizontal_angle = { siid = 2, piid = 5, min = 0, max = 120, step = 1, unit = "none" },
      horizontal_swing = { siid = 2, piid = 3 },
      mode = { siid = 2, piid = 7, unit = "none" },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 8 },
      vertical_angle = { siid = 2, piid = 6, min = 0, max = 90, step = 1, unit = "none" },
      vertical_swing = { siid = 2, piid = 4 }
    },
    mode_map = {
      [0] = "naturalWind",
      [1] = "straightWind"
    }
  },
  ["zhimi.fan.fa2"] = {
    device_type = "fan",
    properties = {
      brightness = { siid = 2, piid = 10, min = 0, max = 1, step = 1, unit = "none" },
      fan_level = { siid = 2, piid = 2 },
      horizontal_angle = { siid = 2, piid = 12, min = 0, max = 120, step = 1 },
      horizontal_swing = { siid = 2, piid = 3 },
      mode = { siid = 2, piid = 7 },
      power = { siid = 2, piid = 1 },
      vertical_angle = { siid = 2, piid = 14, min = 0, max = 100, step = 1 },
      vertical_swing = { siid = 2, piid = 4 }
    },
    mode_map = {
      [0] = "naturalWind",
      [1] = "straightWind",
      [2] = "tempWind"
    }
  },

  -- Xiaomi Fans
  ["xiaomi.fan.p43"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      horizontal_swing = { siid = 2, piid = 4 },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      speed_level = { siid = 2, piid = 7 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind",
      [2] = "smart"
    }
  },
  ["xiaomi.fan.p45"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 4 },
      horizontal_swing = { siid = 2, piid = 6 },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind",
      [2] = "sleep"
    }
  },
  ["xiaomi.fan.p51"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      horizontal_swing = { siid = 2, piid = 4 },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },
  ["xiaomi.fan.p69"] = {
    device_type = "fan",
    properties = {
      fan_level = { siid = 2, piid = 4 },
      horizontal_swing = { siid = 2, piid = 6 },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      vertical_swing = { siid = 2, piid = 8 }
    },
    mode_map = {
      [0] = "straightWind",
      [1] = "naturalWind"
    }
  },

  -- Zhimi Air Purifiers Complete
  ["zhimi.airpurifier.m1"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 5, piid = 2, unit = "none" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      pm25 = { siid = 3, piid = 2, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 3, min = -40, max = 125, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite"
    }
  },
  ["zhimi.airpurifier.m2"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 5, piid = 2, unit = "none" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      pm25 = { siid = 3, piid = 2, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 3, min = -40, max = 125, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite"
    }
  },
  ["zhimi.airpurifier.v1"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 5, piid = 2, min = 5, max = 10, step = 1, unit = "none" },
      fan_level = { siid = 2, piid = 2 },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      pm25 = { siid = 3, piid = 1, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "strong",
      [3] = "none"
    }
  },
  ["zhimi.airpurifier.v2"] = {
    device_type = "air-purifier",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      filter_left_time = { siid = 4, piid = 2, unit = "hours" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      pm25 = { siid = 3, piid = 1, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 1 }
    }
  },
  ["zhimi.airpurifier.v3"] = {
    device_type = "air-purifier",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      filter_left_time = { siid = 4, piid = 2, unit = "hours" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      pm25 = { siid = 3, piid = 1, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "strong",
      [3] = "none"
    }
  },
  ["zhimi.airpurifier.v5"] = {
    device_type = "air-purifier",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      filter_left_time = { siid = 4, piid = 2, unit = "hours" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      pm25 = { siid = 3, piid = 1, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 1 }
    }
  },
  ["zhimi.airpurifier.v6"] = {
    device_type = "air-purifier",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      pm25 = { siid = 3, piid = 2, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 3, min = -40, max = 125, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite"
    }
  },
  ["zhimi.airpurifier.v7"] = {
    device_type = "air-purifier",
    properties = {
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      pm25 = { siid = 3, piid = 2, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 3, min = -40, max = 125, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite"
    }
  },
  ["zhimi.airpurifier.ma2"] = {
    device_type = "air-purifier",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      pm25 = { siid = 3, piid = 2, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 3, min = -40, max = 125, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite"
    }
  },
  ["zhimi.airpurifier.mc1"] = {
    device_type = "air-purifier",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      filter_left_time = { siid = 4, piid = 2, unit = "hours" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      pm25 = { siid = 3, piid = 2, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 3, min = -40, max = 125, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite"
    }
  },
  ["zhimi.airpurifier.mc2"] = {
    device_type = "air-purifier",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      filter_left_time = { siid = 4, piid = 2, unit = "hours" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      pm25 = { siid = 3, piid = 2, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 3, min = -40, max = 125, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite"
    }
  },
  ["zhimi.airpurifier.sa2"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "none" },
      fan_level = { siid = 2, piid = 2 },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      pm25 = { siid = 3, piid = 2, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 3, min = -40, max = 125, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite",
      [3] = "none"
    }
  },
  ["zhimi.airpurifier.va1"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 6, piid = 1 },
      fan_level = { siid = 2, piid = 4 },
      filter_life_level = { siid = 4, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 5 },
      pm25 = { siid = 3, piid = 6, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 2 },
      temperature = { siid = 3, piid = 8, min = -40, max = 125, step = 0.1 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite",
      [3] = "none"
    }
  },
  ["zhimi.airpurifier.vb2"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 6, piid = 1 },
      fan_level = { siid = 2, piid = 4 },
      filter_life_level = { siid = 4, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 5 },
      pm25 = { siid = 3, piid = 6, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 2 },
      temperature = { siid = 3, piid = 8, min = -40, max = 125, step = 0.1 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite",
      [3] = "none"
    }
  },
  ["zhimi.airpurifier.xa1"] = {
    device_type = "air-purifier",
    properties = {
      anion = { siid = 2, piid = 5 },
      fan_level = { siid = 2, piid = 3, unit = "none" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      pm25 = { siid = 3, piid = 4, min = 0, max = 1000, step = 1, unit = "μg/m3" },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" },
      tvoc = { siid = 3, piid = 8, min = 0, max = 500, step = 1, unit = "μg/m3" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite",
      [3] = "none"
    }
  },
  ["zhimi.airpurifier.za1"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 6, piid = 1, unit = "percentage" },
      filter_life_level = { siid = 4, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 5 },
      pm25 = { siid = 3, piid = 6, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 8, min = -30, max = 100, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite"
    }
  },
  ["zhimi.airpurifier.oa1"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 2, piid = 6, unit = "none" },
      fan_level = { siid = 2, piid = 5, unit = "none" },
      filter_life_level = { siid = 4, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 }
    }
  },
  ["zhimi.airp.mb3a"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 6, piid = 1, unit = "percentage" },
      fan_level = { siid = 2, piid = 4 },
      filter_life_level = { siid = 4, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 5 },
      pm25 = { siid = 3, piid = 6, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 2 },
      temperature = { siid = 3, piid = 8, min = -40, max = 125, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite",
      [3] = "none"
    }
  },
  ["zhimi.airp.mb4a"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 7, piid = 2, min = 0, max = 8, step = 1, unit = "none" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      pm25 = { siid = 3, piid = 4, min = 0, max = 600, step = 1, unit = "none" },
      power = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite"
    }
  },
  ["zhimi.airp.mb5"] = {
    device_type = "air-purifier",
    properties = {
      anion = { siid = 2, piid = 6 },
      brightness = { siid = 13, piid = 2, unit = "percentage" },
      fan_level = { siid = 2, piid = 5 },
      filter_left_time = { siid = 4, piid = 4, min = 0, max = 1000, step = 1, unit = "days" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      pm25 = { siid = 3, piid = 4, min = 0, max = 1000, step = 1, unit = "μg/m3" },
      power = { siid = 2, piid = 1, unit = "none" },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite",
      [3] = "manual"
    }
  },
  ["zhimi.airp.mb5a"] = {
    device_type = "air-purifier",
    properties = {
      anion = { siid = 2, piid = 6 },
      brightness = { siid = 13, piid = 2, unit = "percentage" },
      fan_level = { siid = 2, piid = 5 },
      filter_left_time = { siid = 4, piid = 4, min = 0, max = 1000, step = 1, unit = "days" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      pm25 = { siid = 3, piid = 4, min = 0, max = 1000, step = 1, unit = "μg/m3" },
      power = { siid = 2, piid = 1, unit = "none" },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite",
      [3] = "manual"
    }
  },
  ["zhimi.airp.rmb1"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 13, piid = 2, unit = "percentage" },
      filter_left_time = { siid = 4, piid = 4, min = 0, max = 1000, step = 1, unit = "days" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      pm25 = { siid = 3, piid = 4, min = 0, max = 600, step = 1, unit = "μg/m3" },
      power = { siid = 2, piid = 1, unit = "none" },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite"
    }
  },
  ["zhimi.airp.rma2"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 7, piid = 2, unit = "percentage" },
      fan_level = { siid = 11, piid = 1 },
      filter_left_time = { siid = 4, piid = 4, min = 0, max = 1000, step = 1, unit = "days" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      pm25 = { siid = 3, piid = 4, min = 0, max = 600, step = 1 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite"
    }
  },
  ["zhimi.airp.rma3"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 7, piid = 2, unit = "percentage" },
      fan_level = { siid = 11, piid = 1 },
      filter_left_time = { siid = 4, piid = 4, min = 0, max = 1000, step = 1, unit = "days" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      pm25 = { siid = 3, piid = 4, min = 0, max = 1000, step = 1, unit = "μg/m3" },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite"
    }
  },
  ["zhimi.airp.sa4"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 7, piid = 2 },
      fan_level = { siid = 2, piid = 5 },
      filter_left_time = { siid = 4, piid = 2, min = 0, max = 7000, step = 1, unit = "hours" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      hcho = { siid = 3, piid = 11, min = 0, max = 5, step = 0.001, unit = "mg/m3" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      pm25 = { siid = 3, piid = 4, min = 0, max = 600, step = 1, unit = "μg/m3" },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "sleep",
      [2] = "favorite",
      [3] = "manual"
    }
  },
  ["xiaomi.airp.va2b"] = {
    device_type = "air-purifier",
    properties = {
      anion = { siid = 2, piid = 6 },
      brightness = { siid = 13, piid = 1 },
      fan_level = { siid = 2, piid = 5 },
      filter_left_time = { siid = 4, piid = 3, min = 0, max = 5000, step = 1, unit = "hours" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      pm25 = { siid = 3, piid = 4, min = 0, max = 600, step = 1, unit = "μg/m3" },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 2, min = -30, max = 100, step = 1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [3] = "sleep",
      [5] = "favorite",
      [6] = "none"
    }
  },
  ["xiaomi.airp.va4"] = {
    device_type = "air-purifier",
    properties = {
      anion = { siid = 2, piid = 6 },
      brightness = { siid = 7, piid = 2 },
      fan_level = { siid = 2, piid = 5 },
      filter_left_time = { siid = 4, piid = 2, min = 0, max = 8000, step = 1, unit = "hours" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      hcho = { siid = 3, piid = 11, min = 0, max = 5, step = 0.001, unit = "mg/m3" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      pm25 = { siid = 3, piid = 4, min = 1, max = 600, step = 1, unit = "μg/m3" },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" },
      uv = { siid = 2, piid = 7 }
    },
    mode_map = {
      [0] = "auto",
      [3] = "sleep",
      [5] = "favorite",
      [6] = "none"
    }
  },
  ["xiaomi.airp.va5"] = {
    device_type = "air-purifier",
    properties = {
      brightness = { siid = 6, piid = 2 },
      fan_level = { siid = 2, piid = 4 },
      filter_left_time = { siid = 4, piid = 2, min = 0, max = 10000, step = 1, unit = "hours" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      hcho = { siid = 3, piid = 6, min = 0, max = 0.5, step = 0.001, unit = "mg/m3" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      pm25 = { siid = 3, piid = 4, min = 0, max = 600, step = 1, unit = "μg/m3" },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 2, min = -30, max = 100, step = 0.1, unit = "celsius" },
      uv = { siid = 2, piid = 6 }
    },
    mode_map = {
      [0] = "auto",
      [3] = "sleep",
      [5] = "favorite",
      [6] = "none"
    }
  },

  -- Roborock Vacuums Extended
  ["roborock.vacuum.a26"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [101] = "silent",
      [102] = "basic",
      [103] = "strong",
      [104] = "fullSpeed",
      [105] = "silent",
      [106] = "custom"
    }
  },
  ["roborock.vacuum.a27"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [101] = "silent",
      [102] = "basic",
      [103] = "strong",
      [104] = "fullSpeed",
      [105] = "silent",
      [106] = "custom"
    }
  },
  ["roborock.vacuum.a29"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [101] = "silent",
      [102] = "basic",
      [103] = "strong",
      [104] = "fullSpeed",
      [105] = "silent",
      [106] = "custom"
    }
  },
  ["roborock.vacuum.a30"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [101] = "silent",
      [102] = "basic",
      [103] = "strong",
      [104] = "fullSpeed",
      [105] = "silent",
      [106] = "custom"
    }
  },
  ["roborock.vacuum.a34"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [101] = "silent",
      [102] = "basic",
      [103] = "strong",
      [104] = "fullSpeed",
      [105] = "silent",
      [106] = "custom"
    }
  },
  ["roborock.vacuum.a37"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [101] = "silent",
      [102] = "basic",
      [103] = "strong",
      [104] = "fullSpeed",
      [105] = "silent",
      [106] = "custom"
    }
  },
  ["roborock.vacuum.a38"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [101] = "silent",
      [102] = "basic",
      [103] = "strong",
      [104] = "fullSpeed",
      [105] = "silent",
      [106] = "custom"
    }
  },
  ["roborock.vacuum.a40"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [101] = "silent",
      [102] = "basic",
      [103] = "strong",
      [104] = "fullSpeed",
      [105] = "silent",
      [106] = "custom"
    }
  },
  ["roborock.vacuum.a46"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [101] = "silent",
      [102] = "basic",
      [103] = "strong",
      [104] = "fullSpeed",
      [105] = "silent",
      [106] = "custom"
    }
  },
  ["roborock.vacuum.s5"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2 },
      mode = { siid = 2, piid = 2 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [101] = "silent",
      [102] = "basic",
      [103] = "strong",
      [104] = "fullSpeed"
    }
  },
  ["roborock.vacuum.s6"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },
  ["roborock.vacuum.t6"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "silent",
      [2] = "basic",
      [3] = "strong",
      [4] = "fullSpeed"
    }
  },
  ["roborock.vacuum.m1s"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 1 },
      status = { siid = 2, piid = 3 }
    },
    mode_map = {
      [1] = "silent",
      [2] = "basic",
      [3] = "strong",
      [4] = "fullSpeed"
    }
  },
  ["roborock.vacuum.a01"] = {
    device_type = "vacuum",
    properties = {
      mode = { siid = 2, piid = 2 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "silent",
      [2] = "basic",
      [3] = "strong",
      [4] = "fullSpeed"
    }
  },
  ["roborock.vacuum.a08"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [101] = "silent",
      [102] = "basic",
      [103] = "strong",
      [104] = "fullSpeed"
    }
  },
  ["roborock.vacuum.a09"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "silent",
      [2] = "basic",
      [3] = "strong",
      [4] = "fullSpeed"
    }
  },
  ["roborock.vacuum.a10"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "silent",
      [2] = "basic",
      [3] = "strong",
      [4] = "fullSpeed"
    }
  },
  ["roborock.vacuum.a11"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [1] = "silent",
      [2] = "basic",
      [3] = "strong",
      [4] = "fullSpeed"
    }
  },

  -- Dreame Vacuums Complete
  ["dreame.vacuum.mb1808"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 2, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 2, piid = 2 },
      clean_mode = { siid = 18, piid = 6, unit = "none" },
      filter_left_time = { siid = 27, piid = 2, min = 0, max = 300, step = 1, unit = "hour" },
      filter_life_level = { siid = 27, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      status = { siid = 3, piid = 2 }
    }
  },
  ["dreame.vacuum.mc1808"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 2, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 2, piid = 2 },
      clean_mode = { siid = 18, piid = 6, unit = "none" },
      filter_left_time = { siid = 27, piid = 2, min = 0, max = 300, step = 1, unit = "hour" },
      filter_life_level = { siid = 27, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      status = { siid = 3, piid = 2 }
    }
  },
  ["dreame.vacuum.md1808"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 2, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 2, piid = 2 },
      clean_mode = { siid = 18, piid = 6, unit = "none" },
      filter_left_time = { siid = 27, piid = 2, min = 0, max = 300, step = 1, unit = "hour" },
      filter_life_level = { siid = 27, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      status = { siid = 3, piid = 2 }
    }
  },
  ["dreame.vacuum.p2009"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 150, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },
  ["dreame.vacuum.p2027"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 150, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },
  ["dreame.vacuum.p2028"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 150, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },
  ["dreame.vacuum.p2028a"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 150, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },
  ["dreame.vacuum.p2029"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 150, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },
  ["dreame.vacuum.p2036"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 150, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },
  ["dreame.vacuum.p2041"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 150, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3, unit = "none" },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },
  ["dreame.vacuum.p2140"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 150, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3, unit = "none" },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },
  ["dreame.vacuum.p2140a"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 150, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3, unit = "none" },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },
  ["dreame.vacuum.p2140p"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 150, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3, unit = "none" },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },
  ["dreame.vacuum.p2150a"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 150, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },
  ["dreame.vacuum.p2150b"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 150, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      status = { siid = 2, piid = 1, unit = "none" }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },
  ["dreame.vacuum.r2228"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2 },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 1000, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    }
  },

  -- Xiaomi Vacuums Complete
  ["xiaomi.vacuum.b106gl"] = { device_type = "vacuum", properties = { status = { siid = 2, piid = 1 }, battery = { siid = 3, piid = 1 } } },
  ["xiaomi.vacuum.b112gl"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "sweep",
      [1] = "sweepAndMop",
      [2] = "mop"
    }
  },
  ["xiaomi.vacuum.c101"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_left_time = { siid = 15, piid = 2, min = 0, max = 1000, step = 1, unit = "days" },
      filter_life_level = { siid = 15, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 9 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "sweep",
      [1] = "sweepAndMop",
      [2] = "mop",
      [3] = "sweepThenMop"
    }
  },
  ["xiaomi.vacuum.c102gl"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2 },
      filter_left_time = { siid = 11, piid = 2, min = 0, max = 1000, step = 1, unit = "hours" },
      filter_life_level = { siid = 11, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      status = { siid = 2, piid = 1 }
    },
    actions = {
      start_sweep = { siid = 2, aiid = 1 },
      stop_sweeping = { siid = 2, aiid = 2 },
      start_room_sweep = { siid = 2, aiid = 3 },
      start_dust_arrest = { siid = 2, aiid = 4 },
      start_mop_wash = { siid = 2, aiid = 6 },
      start_dry = { siid = 2, aiid = 8 },
      stop_dry = { siid = 2, aiid = 9 },
      start_eject = { siid = 2, aiid = 10 }
    },
    mode_map = {
      [0] = "silent",
      [1] = "basic",
      [2] = "strong",
      [3] = "fullSpeed"
    },
    status_map = {
      [1] = "sweeping",
      [2] = "idle",
      [3] = "paused",
      [4] = "error",
      [5] = "goCharging",
      [6] = "charging",
      [7] = "mopping",
      [8] = "drying",
      [9] = "washing",
      [10] = "goWashing",
      [11] = "building",
      [12] = "sweepingAndMopping",
      [13] = "chargingCompleted",
      [14] = "upgrading",
      [19] = "waterInspecting",
      [21] = "washingMopPause",
      [22] = "dustCollecting",
      [23] = "remoteClean"
    },
    charging_state_map = {
      [1] = "charging", -- Charging
      [2] = "stopped",  -- Not Charging
      [5] = "charging"  -- Go Charging
    }
  },
  ["xiaomi.vacuum.c103"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_left_time = { siid = 15, piid = 2, min = 0, max = 1000, step = 1, unit = "hours" },
      filter_life_level = { siid = 15, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 9 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "sweep",
      [1] = "sweepAndMop",
      [2] = "mop",
      [3] = "sweepThenMop"
    }
  },
  ["xiaomi.vacuum.c104"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_left_time = { siid = 13, piid = 2, min = 0, max = 1000, step = 1, unit = "hours" },
      filter_life_level = { siid = 13, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "sweep",
      [1] = "sweepAndMop",
      [2] = "mop"
    }
  },
  ["xiaomi.vacuum.c107"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2 },
      filter_left_time = { siid = 14, piid = 2, min = 0, max = 1000, step = 1, unit = "hours" },
      filter_life_level = { siid = 14, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 9 },
      status = { siid = 2, piid = 2 },
      voltage = { siid = 3, piid = 3, min = 0, max = 65535, step = 1 }
    },
    mode_map = {
      [1] = "silent",
      [2] = "basic",
      [3] = "strong",
      [4] = "fullSpeed"
    }
  },
  ["xiaomi.vacuum.c108"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2 },
      filter_left_time = { siid = 6, piid = 2, min = 0, max = 18000, step = 1, unit = "minutes" },
      filter_life_level = { siid = 6, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      status = { siid = 2, piid = 1 }
    }
  },
  ["xiaomi.vacuum.d102gl"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2 },
      filter_left_time = { siid = 14, piid = 2, min = 0, max = 1000, step = 1, unit = "hours" },
      filter_life_level = { siid = 14, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 9 },
      status = { siid = 2, piid = 2 },
      voltage = { siid = 3, piid = 3, min = 0, max = 65535, step = 1 }
    },
    mode_map = {
      [1] = "silent",
      [2] = "basic",
      [3] = "strong",
      [4] = "fullSpeed"
    }
  },
  ["xiaomi.vacuum.d109gl"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2 },
      filter_left_time = { siid = 14, piid = 2, min = 0, max = 1000, step = 1, unit = "hours" },
      filter_life_level = { siid = 14, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 9 },
      status = { siid = 2, piid = 2 },
      voltage = { siid = 3, piid = 3, min = 0, max = 65535, step = 1 }
    },
    mode_map = {
      [1] = "silent",
      [2] = "basic",
      [3] = "strong",
      [4] = "fullSpeed"
    }
  },

  -- Roidmi Vacuums
  ["roidmi.vacuum.v60"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 10, piid = 2, min = 0, max = 10000, step = 1, unit = "minutes" },
      filter_life_level = { siid = 10, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      power = { siid = 2, piid = 10, unit = "none" },
      status = { siid = 2, piid = 1, unit = "none" },
      water_level = { siid = 8, piid = 11, unit = "none" }
    },
    mode_map = {
      [0] = "sweep",
      [1] = "silent",
      [2] = "basic",
      [3] = "strong",
      [4] = "fullSpeed"
    }
  },
  ["roidmi.vacuum.v62"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      filter_left_time = { siid = 15, piid = 2, min = 0, max = 1000, step = 1, unit = "days" },
      filter_life_level = { siid = 15, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 9 },
      status = { siid = 2, piid = 1 }
    },
    mode_map = {
      [0] = "sweep",
      [1] = "sweepMop",
      [2] = "mop",
      [3] = "sweepandMop"
    }
  },
  ["roidmi.vacuum.v66"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2, unit = "none" },
      filter_left_time = { siid = 10, piid = 2, min = 0, max = 99999999, step = 1, unit = "hours" },
      filter_life_level = { siid = 10, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 10 },
      status = { siid = 2, piid = 1 },
      water_level = { siid = 8, piid = 11, unit = "none" }
    },
    mode_map = {
      [0] = "sweep",
      [1] = "silent",
      [2] = "basic",
      [3] = "strong",
      [4] = "fullSpeed"
    }
  },
  ["ijai.vacuum.v1"] = {
    device_type = "vacuum",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 9 },
      status = { siid = 2, piid = 1 },
    },
    mode_map = {
      [0] = "sweep",
      [1] = "sweepAndMop",
      [2] = "mop"
    },
    status_map = {
      [0] = "sleep",
      [1] = "idle",
      [2] = "paused",
      [3] = "goCharging",
      [4] = "charging",
      [5] = "sweeping",
      [6] = "sweepingAndMopping",
      [7] = "mopping",
      [8] = "upgrading"
    },
    actions = {
      start_sweep = { siid = 2, aiid = 1 },
      stop_sweeping = { siid = 2, aiid = 2 },
      start_only_sweep = { siid = 2, aiid = 3 },
      start_sweep_mop = { siid = 2, aiid = 5 },
      start_mop = { siid = 2, aiid = 6 },
      start_room_sweep = { siid = 2, aiid = 7, in_params = { room_ids = { piid = 10 } } }
    }
  },

  -- Deerma Humidifiers Complete
  ["deerma.humidifier.jsq1"] = {
    device_type = "humidifier",
    properties = {
      fan_level = { siid = 2, piid = 2 },
      humidity = { siid = 3, piid = 1, min = 20, max = 99, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      target_humidity = { siid = 2, piid = 3, min = 40, max = 70, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 2, min = -10, max = 60, step = 1, unit = "celsius" }
    }
  },
  ["deerma.humidifier.jsq2w"] = {
    device_type = "humidifier",
    properties = {
      fan_level = { siid = 2, piid = 5 },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 8 },
      power = { siid = 2, piid = 1 },
      status = { siid = 2, piid = 7 },
      target_humidity = { siid = 2, piid = 6, min = 40, max = 70, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" }
    },
    mode_map = {
      [0] = "none",
      [1] = "constantHumidity"
    }
  },
  ["deerma.humidifier.jsq2g"] = {
    device_type = "humidifier",
    properties = {
      fan_level = { siid = 2, piid = 5 },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 8 },
      power = { siid = 2, piid = 1 },
      status = { siid = 2, piid = 7 },
      target_humidity = { siid = 2, piid = 6, min = 40, max = 70, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" }
    },
    mode_map = {
      [0] = "none",
      [1] = "constantHumidity"
    }
  },
  ["deerma.humidifier.jsq3"] = {
    device_type = "humidifier",
    properties = {
      fan_level = { siid = 2, piid = 5, unit = "none" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      target_humidity = { siid = 2, piid = 6, min = 40, max = 80, step = 1, unit = "percentage" },
      target_temperature = { siid = 2, piid = 7, min = 16, max = 32, step = 1, unit = "celsius" },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" }
    }
  },
  ["deerma.humidifier.jsq4"] = {
    device_type = "humidifier",
    properties = {
      fan_level = { siid = 2, piid = 5, unit = "none" },
      filter_left_time = { siid = 8, piid = 2, min = 0, max = 1000, step = 1, unit = "hours" },
      filter_life_level = { siid = 8, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      target_humidity = { siid = 2, piid = 6, min = 40, max = 80, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" }
    }
  },
  ["deerma.humidifier.jsq5"] = {
    device_type = "humidifier",
    properties = {
      fan_level = { siid = 2, piid = 5 },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      target_humidity = { siid = 2, piid = 6, min = 40, max = 80, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" }
    }
  },
  ["deerma.humidifier.990dw"] = {
    device_type = "humidifier",
    properties = {
      fan_level = { siid = 2, piid = 3 },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      status = { siid = 2, piid = 4 },
      target_humidity = { siid = 2, piid = 5, min = 40, max = 70, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 2, min = -30, max = 100, step = 1, unit = "celsius" }
    }
  },
  ["deerma.humidifier.ct500"] = {
    device_type = "humidifier",
    properties = {
      fan_level = { siid = 2, piid = 5, unit = "none" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" },
      water_level = { siid = 2, piid = 6, unit = "percentage" }
    }
  },
  ["deerma.humidifier.rz300"] = {
    device_type = "humidifier",
    properties = {
      fan_level = { siid = 2, piid = 5, unit = "none" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" }
    }
  },

  -- Zhimi Humidifiers Complete
  ["zhimi.humidifier.ca4"] = {
    device_type = "humidifier",
    properties = {
      brightness = { siid = 5, piid = 2, unit = "percentage" },
      fan_level = { siid = 2, piid = 5, unit = "none" },
      humidity = { siid = 3, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1, unit = "none" },
      speed_level = { siid = 2, piid = 11, min = 200, max = 2000, step = 10, unit = "none" },
      target_humidity = { siid = 2, piid = 6, min = 30, max = 80, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 7, min = -40, max = 125, step = 0.1, unit = "celsius" },
      water_level = { siid = 2, piid = 7, min = 0, max = 128, step = 1 }
    }
  },
  ["zhimi.humidifier.ca6"] = {
    device_type = "humidifier",
    properties = {
      brightness = { siid = 5, piid = 2, unit = "percentage" },
      fan_level = { siid = 2, piid = 5 },
      humidity = { siid = 3, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      status = { siid = 2, piid = 9 },
      target_humidity = { siid = 2, piid = 6, min = 30, max = 60, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 7, min = -40, max = 125, step = 0.1, unit = "celsius" },
      water_level = { siid = 2, piid = 7, min = 0, max = 2, step = 1, unit = "percentage" }
    }
  },
  ["zhimi.humidifier.ca7"] = {
    device_type = "humidifier",
    properties = {
      brightness = { siid = 6, piid = 2 },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      status = { siid = 2, piid = 11 },
      target_humidity = { siid = 2, piid = 5, min = 30, max = 60, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 2, min = -40, max = 125, step = 0.1, unit = "celsius" },
      water_level = { siid = 2, piid = 6, min = 0, max = 2, step = 1, unit = "percentage" }
    },
    mode_map = {
      [2] = "sleep",
      [3] = "auto",
      [4] = "favorite"
    }
  },
  ["zhimi.humidifier.cb2"] = {
    device_type = "humidifier",
    properties = {
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 2, min = -40, max = 125, step = 0.1, unit = "celsius" },
      water_level = { siid = 2, piid = 3, min = 0, max = 127, step = 1 }
    },
    mode_map = {
      [0] = "auto",
      [1] = "silent",
      [2] = "medium",
      [3] = "high"
    }
  },
  ["zhimi.humidifier.va1"] = {
    device_type = "humidifier",
    properties = {
      brightness = { siid = 7, piid = 3, unit = "percentage" },
      fan_level = { siid = 2, piid = 5, unit = "none" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      target_humidity = { siid = 2, piid = 6, min = 30, max = 80, step = 10, unit = "percentage" },
      temperature = { siid = 3, piid = 7, min = -40, max = 125, step = 0.1, unit = "celsius" }
    }
  },
  ["zhimi.humidifier.cb1a"] = {
    device_type = "humidifier",
    properties = {
      brightness = { siid = 5, piid = 2, unit = "percentage" },
      fan_level = { siid = 2, piid = 5, unit = "none" },
      humidity = { siid = 3, piid = 9, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1, unit = "none" },
      speed_level = { siid = 7, piid = 6, min = 200, max = 2000, step = 10 },
      target_humidity = { siid = 2, piid = 6, min = 30, max = 80, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 7, min = -40, max = 125, step = 0.1, unit = "celsius" },
      water_level = { siid = 2, piid = 7, min = 0, max = 128, step = 1 }
    }
  },

  -- Xiaomi Humidifiers
  ["xiaomi.humidifier.p800"] = {
    device_type = "humidifier",
    properties = {
      brightness = { siid = 6, piid = 2, unit = "percentage" },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      target_humidity = { siid = 2, piid = 6, min = 40, max = 70, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 2, min = -30, max = 100, step = 1, unit = "celsius" },
      water_level = { siid = 2, piid = 13, min = 0, max = 100, step = 1, unit = "percentage" }
    },
    mode_map = {
      [0] = "constantHumidity",
      [1] = "sleep",
      [2] = "strong"
    }
  },
  ["xiaomi.humidifier.p1200"] = {
    device_type = "humidifier",
    properties = {
      brightness = { siid = 7, piid = 2 },
      filter_life_level = { siid = 8, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      target_humidity = { siid = 2, piid = 4, min = 40, max = 70, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 2, min = -30, max = 100, step = 1, unit = "celsius" },
      water_level = { siid = 6, piid = 7, unit = "percentage" }
    },
    mode_map = {
      [0] = "constantHumidity",
      [1] = "sleep",
      [2] = "strong"
    }
  },
  ["xiaomi.humidifier.3lite"] = {
    device_type = "humidifier",
    properties = {
      brightness = { siid = 6, piid = 2 },
      filter_life_level = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      target_humidity = { siid = 2, piid = 5, min = 40, max = 70, step = 1, unit = "percentage" }
    },
    mode_map = {
      [0] = "constantHumidity",
      [1] = "sleep",
      [2] = "strong"
    }
  },
  ["dmaker.humidifier.p2"] = {
    device_type = "humidifier",
    properties = {
      brightness = { siid = 8, piid = 2 },
      filter_life_level = { siid = 9, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      humidity = { siid = 3, piid = 1, min = 10, max = 99, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      target_humidity = { siid = 2, piid = 6, min = 40, max = 70, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 7, min = 0, max = 45, step = 0.1, unit = "celsius" },
      water_level = { siid = 7, piid = 3, min = 0, max = 16, step = 1 }
    },
    mode_map = {
      [0] = "constantHumidity",
      [1] = "sleep",
      [2] = "strong"
    }
  },
  ["leshow.humidifier.jsq3"] = {
    device_type = "humidifier",
    properties = {
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      target_humidity = { siid = 2, piid = 5, min = 40, max = 70, step = 1, unit = "percentage" },
    },
    mode_map = {
      [0] = "constantHumidity",
      [1] = "strong",
      [2] = "sleep",
      [3] = "dry",
      [4] = "wash",
    }
  },

  -- Dehumidifiers
  ["dmaker.derh.22ht"] = {
    device_type = "dehumidifier",
    properties = {
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      ["indicator-light_mode"] = { siid = 5, piid = 2 },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      target_humidity = { siid = 2, piid = 5, min = 40, max = 70, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 2, min = -30, max = 100, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "smart",
      [1] = "sleep",
      [2] = "clothesDrying"
    }
  },
  ["dmaker.derh.22l"] = {
    device_type = "dehumidifier",
    properties = {
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      ["indicator-light_mode"] = { siid = 5, piid = 2 },
      mode = { siid = 2, piid = 3 },
      power = { siid = 2, piid = 1 },
      target_humidity = { siid = 2, piid = 5, min = 30, max = 70, step = 1, unit = "percentage" },
      temperature = { siid = 3, piid = 2, min = -30, max = 100, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "smart",
      [1] = "sleep",
      [2] = "clothesDrying"
    }
  },
  ["dmaker.derh.312en"] = { device_type = "dehumidifier", properties = { power = { siid = 2, piid = 1 }, mode = { siid = 2, piid = 3 }, humidity = { siid = 3, piid = 1 } } },
  ["dmaker.derh.wdhe320"] = { device_type = "dehumidifier", properties = { power = { siid = 2, piid = 1 }, mode = { siid = 2, piid = 3 }, humidity = { siid = 3, piid = 1 } } },
  ["nwt.derh.wdh318efw1"] = {
    device_type = "dehumidifier",
    properties = {
      fan_level = { siid = 2, piid = 3 },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 2 },
      power = { siid = 2, piid = 1 },
      temperature = { siid = 3, piid = 2, min = -30, max = 100, step = 1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "smart",
      [2] = "clothesDrying"
    }
  },
  ["nwt.derh.wdh312efw1"] = { device_type = "dehumidifier", properties = { power = { siid = 2, piid = 1 }, mode = { siid = 2, piid = 3 }, humidity = { siid = 3, piid = 1 } } },
  ["nwt.derh.wdh316efw1"] = { device_type = "dehumidifier", properties = { power = { siid = 2, piid = 1 }, mode = { siid = 2, piid = 3 }, humidity = { siid = 3, piid = 1 } } },
  ["nwt.derh.312en"] = {
    device_type = "dehumidifier",
    properties = {
      power = { siid = 2, piid = 1 },
      mode = { siid = 2, piid = 3 },
      humidity = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      target_humidity = { siid = 2, piid = 5, min = 30, max = 70, step = 10, unit = "percentage" },
      temperature = { siid = 3, piid = 7, min = -30, max = 100, step = 1, unit = "celsius" }
    },
    mode_map = {
      [1] = "smart",
      [2] = "clothesDrying"
    }
  },

  -- Dooya Curtains Complete
  ["dooya.curtain.c1"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 6, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 5, unit = "none" },
      power = { siid = 2, piid = 8 },
      status = { siid = 2, piid = 4, unit = "none" },
      target_position = { siid = 2, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["dooya.curtain.d1xc"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 6, min = 0, max = 100, step = 1, unit = "percentage" },
      status = { siid = 2, piid = 4 },
      target_position = { siid = 2, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["dooya.curtain.m5"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 6, min = 0, max = 100, step = 1, unit = "percentage" },
      status = { siid = 2, piid = 4, unit = "none" },
      target_position = { siid = 2, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["dooya.curtain.m7"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 5, min = 0, max = 100, step = 1, unit = "percentage" },
      target_position = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["dooya.curtain.m7li"] = {
    device_type = "cover",
    properties = {
      battery = { siid = 3, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      charging_state = { siid = 3, piid = 2 },
      current_position = { siid = 2, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      status = { siid = 2, piid = 5 },
      target_position = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["dooya.curtain.x7"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 6, min = 0, max = 100, step = 1, unit = "percentage" },
      status = { siid = 2, piid = 4 },
      target_position = { siid = 2, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["dooya.curtain.x7pro"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 6, min = 0, max = 100, step = 1, unit = "percentage" },
      target_position = { siid = 2, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },

  -- Babai Curtains Complete
  ["babai.curtain.190812"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      target_position = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" }
    },
    mode_map = {
      [0] = "normal",
      [1] = "reversal",
      [2] = "calibrate"
    }
  },
  ["babai.curtain.at5810"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      target_position = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" }
    },
    mode_map = {
      [0] = "normal",
      [1] = "reversal",
      [2] = "calibrate"
    }
  },
  ["babai.curtain.bb82cb"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 5, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      target_position = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" }
    },
    mode_map = {
      [0] = "normal",
      [1] = "reversal",
      [2] = "calibration"
    }
  },
  ["babai.curtain.bb82mj"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      target_position = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" }
    },
    mode_map = {
      [0] = "normal",
      [1] = "reversal",
      [2] = "calibrate"
    }
  },
  ["babai.curtain.lsxf83"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 5, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4 },
      speed_level = { siid = 2, piid = 6 },
      target_position = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" }
    },
    mode_map = {
      [0] = "normal",
      [1] = "reversal",
      [2] = "calibration"
    }
  },
  ["babai.curtain.m515e"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      target_position = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" }
    },
    mode_map = {
      [0] = "normal",
      [1] = "reversal"
    }
  },
  ["babai.curtain.mtx850"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      target_position = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" }
    },
    mode_map = {
      [0] = "normal",
      [1] = "reversal",
      [2] = "calibrate"
    }
  },
  ["babai.curtain.yilc3"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 2, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 4, unit = "none" },
      target_position = { siid = 2, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" }
    },
    mode_map = {
      [0] = "normal",
      [1] = "reversal",
      [2] = "calibrate"
    }
  },

  -- Hyd Airers Complete
  ["hyd.airer.znlyj1"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 3, min = 0, max = 2, step = 1 },
      power = { siid = 3, piid = 1, unit = "none" },
      status = { siid = 2, piid = 4, unit = "none" }
    }
  },
  ["hyd.airer.znlyj3"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 3, min = 0, max = 2, step = 1, unit = "percentage" },
      power = { siid = 3, piid = 1 },
      status = { siid = 2, piid = 4 }
    }
  },
  ["hyd.airer.znlyj4"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 3, min = 0, max = 2, step = 1, unit = "percentage" },
      power = { siid = 3, piid = 1 },
      status = { siid = 2, piid = 4 }
    }
  },
  ["hyd.airer.znlyj5"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 3, min = 0, max = 2, step = 1, unit = "percentage" },
      power = { siid = 3, piid = 1 },
      status = { siid = 2, piid = 4 }
    }
  },
  ["hyd.airer.1s"] = {
    device_type = "cover",
    properties = {
      brightness = { siid = 3, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      current_position = { siid = 4, piid = 11, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 3, piid = 1 },
      status = { siid = 2, piid = 4 },
      target_position = { siid = 2, piid = 6, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["hyd.airer.1s1"] = {
    device_type = "cover",
    properties = {
      brightness = { siid = 3, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      current_position = { siid = 4, piid = 11, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 3, piid = 1 },
      status = { siid = 2, piid = 4 },
      target_position = { siid = 2, piid = 6, min = 0, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["hyd.airer.pro"] = {
    device_type = "cover",
    properties = {
      brightness = { siid = 3, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      current_position = { siid = 4, piid = 11, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 5 },
      power = { siid = 3, piid = 1 },
      status = { siid = 2, piid = 4 }
    },
    mode_map = {
      [0] = "off",
      [1] = "on"
    }
  },
  ["hyd.airer.pro2"] = {
    device_type = "cover",
    properties = {
      brightness = { siid = 3, piid = 3, min = 0, max = 100, step = 1, unit = "percentage" },
      current_position = { siid = 4, piid = 11, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 5 },
      power = { siid = 3, piid = 1 },
      status = { siid = 2, piid = 4 }
    },
    mode_map = {
      [0] = "off",
      [1] = "on"
    }
  },

  -- Mrbond Airers
  ["mrbond.airer.m1s"] = {
    device_type = "cover",
    properties = {
      power = { siid = 3, piid = 1 }
    }
  },
  ["mrbond.airer.m2"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 3, min = 0, max = 2, step = 1, unit = "none" },
      power = { siid = 3, piid = 1, min = 0, max = 1, step = 1, unit = "none" },
      uv = { siid = 2, piid = 4, min = 0, max = 1, step = 1, unit = "none" }
    }
  },
  ["mrbond.airer.m2pro"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 3, min = 0, max = 2, step = 1, unit = "percentage" },
      dryer = { siid = 2, piid = 8, unit = "none" },
      power = { siid = 3, piid = 1, unit = "none" },
      uv = { siid = 2, piid = 4, min = 0, max = 1, step = 1, unit = "none" }
    }
  },
  ["mrbond.airer.m33a"] = {
    device_type = "cover",
    properties = {
      brightness = { siid = 3, piid = 2, min = 1, max = 100, step = 1, unit = "percentage" },
      color_temperature = { siid = 3, piid = 3, min = 0, max = 100, step = 1, unit = "kelvin" },
      current_position = { siid = 2, piid = 3, min = 0, max = 2, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 12, unit = "none" },
      status = { siid = 2, piid = 4, unit = "none" },
      target_position = { siid = 2, piid = 13, min = 10, max = 100, step = 1, unit = "percentage" }
    }
  },
  ["mrbond.airer.m53pro"] = {
    device_type = "cover",
    properties = {
      current_position = { siid = 2, piid = 3, unit = "none" },
      dryer = { siid = 2, piid = 5, unit = "none" },
      power = { siid = 3, piid = 1 },
      status = { siid = 2, piid = 4, unit = "none" }
    }
  },

  -- Zhimi Heaters
  ["zhimi.heater.ma2"] = {
    device_type = "heater",
    properties = {
      brightness = { siid = 7, piid = 3, min = 0, max = 1, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      target_temperature = { siid = 2, piid = 5, min = 18, max = 28, step = 1, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" }
    }
  },
  ["zhimi.heater.ma2a"] = {
    device_type = "heater",
    properties = {
      brightness = { siid = 7, piid = 1 },
      power = { siid = 2, piid = 1 },
      target_temperature = { siid = 2, piid = 5, min = 18, max = 28, step = 1, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" }
    }
  },
  ["zhimi.heater.ma3"] = {
    device_type = "heater",
    properties = {
      brightness = { siid = 7, piid = 3, unit = "percentage" },
      mode = { siid = 2, piid = 6, unit = "none" },
      power = { siid = 2, piid = 1 },
      target_temperature = { siid = 2, piid = 5, min = 16, max = 28, step = 1, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "lLMode",
      [2] = "hHMode"
    }
  },
  ["zhimi.heater.ma4"] = {
    device_type = "heater",
    properties = {
      humidity = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 7 },
      power = { siid = 2, piid = 1 },
      status = { siid = 2, piid = 3 },
      target_temperature = { siid = 2, piid = 5, min = 18, max = 28, step = 1, unit = "celsius" },
      temperature = { siid = 2, piid = 6, min = -30, max = 100, step = 1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "continusHeating"
    }
  },
  ["zhimi.heater.ma5"] = {
    device_type = "heater",
    properties = {
      humidity = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      mode = { siid = 2, piid = 7 },
      power = { siid = 2, piid = 1 },
      status = { siid = 2, piid = 3 },
      target_temperature = { siid = 2, piid = 5, min = 16, max = 28, step = 1, unit = "celsius" },
      temperature = { siid = 2, piid = 6, min = -30, max = 100, step = 1, unit = "celsius" }
    },
    mode_map = {
      [0] = "auto",
      [1] = "lLHeating",
      [2] = "continusHeating"
    }
  },
  ["zhimi.heater.na1"] = {
    device_type = "heater",
    properties = {
      brightness = { siid = 6, piid = 1, min = 0, max = 2, step = 1 },
      heat_level = { siid = 2, piid = 3, unit = "none" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 2 }
    },
    mode_map = {
      [0] = "fanNotSwing",
      [1] = "fanSwing"
    }
  },
  ["zhimi.heater.nb1"] = {
    device_type = "heater",
    properties = {
      brightness = { siid = 6, piid = 1, min = 0, max = 2, step = 1 },
      heat_level = { siid = 2, piid = 3, unit = "none" },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 2 },
      target_temperature = { siid = 2, piid = 5, min = 16, max = 30, step = 1, unit = "celsius" },
      temperature = { siid = 9, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "fanNotSwing",
      [1] = "fanSwing"
    }
  },
  ["zhimi.heater.za2"] = {
    device_type = "heater",
    properties = {
      brightness = { siid = 6, piid = 1, min = 0, max = 2, step = 1, unit = "percentage" },
      humidity = { siid = 5, piid = 7, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 2 },
      target_temperature = { siid = 2, piid = 6, min = 16, max = 28, step = 1, unit = "celsius" },
      temperature = { siid = 5, piid = 8, min = -30, max = 100, step = 0.1, unit = "celsius" }
    }
  },
  ["xiaomi.heater.ma4"] = {
    device_type = "heater",
    properties = {
      heat_level = { siid = 2, piid = 7 },
      humidity = { siid = 4, piid = 1, min = 0, max = 100, step = 1, unit = "percentage" },
      power = { siid = 2, piid = 1 },
      status = { siid = 2, piid = 3 },
      target_temperature = { siid = 2, piid = 5, min = 18, max = 28, step = 1, unit = "celsius" },
      temperature = { siid = 2, piid = 6, min = -30, max = 100, step = 1, unit = "celsius" }
    }
  },
  ["xiaomi.heater.ma7"] = {
    device_type = "heater",
    properties = {
      heat_level = { siid = 2, piid = 6 },
      power = { siid = 2, piid = 1 },
      status = { siid = 2, piid = 3 },
      target_temperature = { siid = 2, piid = 5, min = 16, max = 28, step = 1, unit = "celsius" },
      temperature = { siid = 4, piid = 7, min = -30, max = 100, step = 0.1, unit = "celsius" }
    }
  },
  ["xiaomi.heater.ma8"] = {
    device_type = "heater",
    properties = {
      horizontal_swing = { siid = 8, piid = 3 },
      mode = { siid = 2, piid = 4 },
      power = { siid = 2, piid = 1 },
      target_temperature = { siid = 2, piid = 5, min = 22, max = 28, step = 1, unit = "celsius" },
      temperature = { siid = 4, piid = 1, min = -30, max = 100, step = 0.1, unit = "celsius" }
    },
    mode_map = {
      [0] = "constantTemperature",
      [1] = "naturalWind",
      [2] = "warm",
      [3] = "heat"
    }
  },
}

-- Helper function to check if pattern matches
local function pattern_matches(pattern, model)
  -- Convert wildcard pattern to Lua pattern
  local lua_pattern = pattern:gsub("%*", "[^.]+")
  lua_pattern = "^" .. lua_pattern .. "$"
  return model:match(lua_pattern) ~= nil
end

-- Wildcard model matching
function M.get_device_spec(model)
  if not model then
    return nil
  end

  -- 1. Exact model matching
  if M.DEVICE_SPECS[model] then
    return M.DEVICE_SPECS[model]
  end

  -- 2. brand.category.* pattern matching (example: yeelink.light.*)
  local brand, category = model:match("^([^.]+)%.([^.]+)%.")
  if brand and category then
    local wildcard_pattern = string.format("%s.%s.*", brand, category)
    if M.DEVICE_SPECS[wildcard_pattern] then
      return M.DEVICE_SPECS[wildcard_pattern]
    end
  end

  -- 3. *.category.* wildcard pattern matching (example: *.light.*)
  if category then
    local wildcard_pattern = string.format("*.%s.*", category)
    if M.DEVICE_SPECS[wildcard_pattern] then
      return M.DEVICE_SPECS[wildcard_pattern]
    end
  end

  -- 4. Wildcard pattern search
  for pattern, spec in pairs(M.DEVICE_SPECS) do
    if pattern:find("*") and pattern_matches(pattern, model) then
      return spec
    end
  end

  return nil
end

-- Get device type from model
function M.get_device_type(model)
  local spec = M.get_device_spec(model)
  if spec then
    return spec.device_type
  end

  -- Infer device type from model name
  if model:find("light") or model:find("lamp") or model:find("ceiling") then
    return "light"
  elseif model:find("plug") or model:find("switch") or model:find("outlet") then
    return "switch"
  elseif model:find("aircondition") or model:find("acpartner") or model:find("airrtc") then
    return "climate"
  elseif model:find("airpurifier") or model:find("airp%.") then
    return "air-purifier"
  elseif model:find("fan") or model:find("airfresh") then
    return "fan"
  elseif model:find("vacuum") then
    return "vacuum"
  elseif model:find("curtain") or model:find("airer") or model:find("wopener") then
    return "cover"
  elseif model:find("derh") then
    return "dehumidifier"
  elseif model:find("humidifier") then
    return "humidifier"
  elseif model:find("heater") then
    return "heater"
  elseif model:find("bhf_light") then
    return "light"
  end

  return "generic"
end

return M
