version = "1.0.2"
author = "Anaximander"

BeStride_Constants = {
  spells = {
    druid = {
      catform = 783,
      aquaticform = 783,
      travelform = 783,
      flightform = 783,
    },
  },
  Riding = {
    Skill = {
      [33388] = {
        name = "Apprentice Riding",
        unlocks = "ground",
        level = 75,
      },
      [33391] = {
        name = "Journeyman Riding",
        depends = 33388,
        level = 150,
      },
      [34090] = {
        name = "Expert Riding",
        depends = 33391,
        level = 225,
      },
      [34091] = {
        name = "Artisan Riding",
        depends = 34090,
        level = 300,
      },
      [90265] = {
        name = "Master Riding",
        unlocks = "flying",
        depends = 34091,
        level = 375,
      },
      [90267] = {
        name = "Flight Master's License",
        depends = 34090,
        level = 450,
      },
      [54197] = {
        name = "Cold Weather Flying",
        unlocks = "flying",
        zones = {
          [1] = "",
        },
        depends = 34090,
        level = 525,
      },
      [115913] = {
        name = "Wisdom of the Four Winds",
        unlocks = "flying",
        zones = {
          [1] = "",
        },
        depends = 34090,
        level = 600,
      },
      [191645] = {
        name = "Draenor Pathfinder",
        unlocks = "flying",
        zones = {
          [1] = "",
        },
        depends = 34090,
        level = 675,
      },
      [226342] = {
        name = "Broken Isles Pathfinder",
        depends = 34090
      },
      [233368] = {
        name = "Broken Isles Pathfinder",
        unlocks = "flying",
        zones = {
          [1] = "",
        },
        depends = 226342,
        level = 750,
      },
      --[] = {
      --	name = "",
      --	unlocks = "zone",
      --	zones = {
      --		[]
      --	},
      --	depends = ""
      --},
      [281576] = {
        name = "Battle for Azeroth Pathfinder",
        depends = 34090,
        level = 825,
      },
    },
  },
  Mount = {
    Mounts = {
      [75207] = {
        ["type"] = "zone",
        ["subtype"] = "swimming",
        ["zone"] = "Vash'jir",
      },
      [25953] = {
        ["name"] = "Blue Qiraji Battle Tank",
        ["type"] = "zone",
        ["zone"] = "taq",
      },
      [26054] = {
        ["name"] = "Red Qiraji Battle Tank",
        ["type"] = "zone",
        ["zone"] = "taq",
      },
      [26055] = {
        ["name"] = "Yellow Qiraji Battle Tank",
        ["type"] = "zone",
        ["zone"] = "taq",
      },
      [26056] = {
        ["name"] = "Green Qiraji Battle Tank",
        ["type"] = "zone",
        ["zone"] = "taq",
      },
      [55531] = {
        ["name"] = "Mechano-Hog",
        ["type"] = "passenger",
        ["subtype"] = "ground",
        ["repair"] = false,
      },
      [60424] = {
        ["name"] = "Mekgineer's Chopper",
        ["type"] = "passenger",
        ["subtype"] = "ground",
        ["repair"] = false,
      },
      [61425] = {
        ["name"] = "Traveler's Tundra Mammoth",
        ["type"] = "passenger",
        ["subtype"] = "ground",
        ["repair"] = true,
      },
      [61447] = {
        ["name"] = "Traveler's Tundra Mammoth",
        ["type"] = "passenger",
        ["subtype"] = "ground",
        ["repair"] = true,
      },
      [61467] = {
        ["name"] = "Grand Black War Mammoth",
        ["type"] = "passenger",
        ["subtype"] = "ground",
        ["repair"] = false,
      },
      [61465] = {
        ["name"] = "Grand Black War Mammoth",
        ["type"] = "passenger",
        ["subtype"] = "ground",
        ["repair"] = false,
      },
      [61470] = {
        ["name"] = "Grand Ice Mammoth",
        ["type"] = "passenger",
        ["subtype"] = "ground",
        ["repair"] = false,
      },
      [61469] = {
        ["name"] = "Grand Ice Mammoth",
        ["type"] = "passenger",
        ["subtype"] = "ground",
        ["repair"] = false,
      },
      [122708] = {
        ["name"] = "Grand Expedition Yak",
        ["type"] = "passenger",
        ["subtype"] = "ground",
        ["repair"] = true,
      },
      [75973] = {
        ["name"] = "X-53 Touring Rocket",
        ["type"] = "passenger",
        ["subtype"] = "flying",
        ["repair"] = false,
      },
      [93326] = {
        ["name"] = "Sandstone Drake",
        ["type"] = "passenger",
        ["subtype"] = "flying",
        ["repair"] = false,
      },
      [121820] = {
        ["name"] = "Obsidian Nightwing",
        ["type"] = "passenger",
        ["subtype"] = "flying",
        ["repair"] = false,
      },
      [245725] = {
        ["name"] = "Orgrimmar Interceptor",
        ["type"] = "passenger",
        ["subtype"] = "flying",
        ["repair"] = false,
      },
      [245723] = {
        ["name"] = "Stormwind Skychaser",
        ["type"] = "passenger",
        ["subtype"] = "flying",
        ["repair"] = false,
      },
    },
    Types = {
      [230] = "ground",
      [231] = "swimming",
      [232] = "zone",
      [241] = "zone",
      [242] = "dead",
      [247] = "flying",
      [248] = "flying",
      [254] = "swimming",
      [269] = "ground",
      [270] = "flying",
      [284] = "chauffeured",
    },
  }
}