version = "0.5.0"
author = "Anaximander"

BeStride_Constants = {
	Settings = {
		Mount = {
			EnableNew = {element="CheckBox",label=BeStride_Locale.Settings.EnableNew,dbvalue="enablenew"},
			EmptyRandom = {element="CheckBox",label=BeStride_Locale.Settings.EmptyRandom,dbvalue="emptyrandom"},
			NoDismountWhileFlying = {element="CheckBox",label=BeStride_Locale.Settings.NoDismountWhileFlying,dbvalue="nodismountwhileflying"},
			ForceFlyingMount = {element="CheckBox",label=BeStride_Locale.Settings.ForceFlyingMount,dbvalue="forceflyingmount"},
			FlyingBroom = {element="CheckBox",label=BeStride_Locale.Settings.FlyingBroom,dbvalue="flyingbroom"},
			Telaari = {element="CheckBox",label=BeStride_Locale.Settings.Telaari,dbvalue="telaari"},
			Repair = {
				element="Group",
				dbvalue="repair",
				children={
					Use = {element="CheckBox",label=BeStride_Locale.Settings.Repair.Use,dbvalue="use"},
					Force = {element="CheckBox",label=BeStride_Locale.Settings.Repair.Repair,dbvalue="force"},
					Durability = {element="CheckBox",label=BeStride_Locale.Settings.Repair.Durability,dbvalue="durability"}
				}
			}
		}
	}
}
BeStride_Constants.spells = {}
BeStride_Constants.spells.druid = {}

mountData = {
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
	[5784] = {
		["name"] = "Felsteed",
		["type"] = "class",
		["class"] = "warlock",
	},
	[23161] = {
		["name"] = "Dreadsteed",
		["type"] = "class",
		["class"] = "warlock",
	},
	[23214] = {
		["name"] = "Charger",
		["type"] = "class",
		["class"] = "paladin",
	},
	[13819] = {
		["name"] = "Warhorse",
		["type"] = "class",
		["class"] = "paladin",
		["repair"] = false,
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
	[61448] = {
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
}

mountTypes = {
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
}

ridingSkill = {
	[33388] = {
		["name"] = "Apprentice Riding",
		["unlocks"] = "ground"
	},
	[33391] = {
		["name"] = "Journeyman Riding",
		["depends"] = 33388,
	},
	[34090] = {
		["name"] = "Expert Riding",
		["depends"] = 33391,
	},
	[34091] = {
		["name"] = "Artisan Riding",
		["depends"] = 34090,
	},
	[90265] = {
		["name"] = "Master Riding",
		["unlocks"] = "flying",
		["depends"] = 34091,
	},
	[90267] = {
		["name"] = "Flight Master's License",
		["depends"] = 34090
	},
	[54197] = {
		["name"] = "Cold Weather Flying",
		["unlocks"] = "flying",
		["zones"] = {
			[1] = "",
		},
		["depends"] = 34090
	},
	[115913] = {
		["name"] = "Wisdom of the Four Winds",
		["unlocks"] = "flying",
		["zones"] = {
			[1] = "",
		},
		["depends"] = 34090
	},
	[191645] = {
		["name"] = "Draenor Pathfinder",
		["unlocks"] = "flying",
		["zones"] = {
			[1] = "",
		},
		["depends"] = 34090
	},
	[226342] = {
		["name"] = "Broken Isles Pathfinder",
		["depends"] = 34090
	},
	[233368] = {
		["name"] = "Broken Isles Pathfinder",
		["unlocks"] = "flying",
		["zones"] = {
			[1] = "",
		},
		["depends"] = 226342
	},
	--[] = {
	--	["name"] = "",
	--	["unlocks"] = "zone",
	--	["zones"] = {
	--		[]
	--	},
	--	["depends"] = ""
	--},
	[281576] = {
		["name"] = "Battle for Azeroth Pathfinder",
		["depends"] = 34090
	},
}

BeStride_Constants.spells.druid.catform = 783
BeStride_Constants.spells.druid.aquaticform = 783
BeStride_Constants.spells.druid.travelform = 783
BeStride_Constants.spells.druid.flightform = 783