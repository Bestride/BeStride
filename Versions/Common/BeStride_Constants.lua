BeStride_Constants = {
	map = {
		cosmic = 0,
		world = 1,
		continent = 2,
		zone = 3,
		dungeon = 4,
		micro = 5,
		orphan = 6,
	},
	ClassmovementAbilityDefaults = {
		[1] = 0,-- warrior
        [2] = 0, -- paladin		
        [3] = 186257, -- hunter, aspect of the cheetah	
        [4] = 0, -- rogue			
        [5] = 0, -- priest			
        [6] = 212552, -- deathknight, wraithwalk
        [7] = 0, -- shaman
        [8] = 0, -- mage
        [9] = 0,-- warlock
        [10] = 0, -- monk
        [11] = 0, -- druid
        [12] = 0, -- demonhunter
		[13] = 394784, -- evoker, soar
	},
	spells = {
        druid = {
			catform = 768,
			aquaticform = 783,
			travelform = 783,
			flightform = 783,
		},
		hunter = {
			aspectofthecheetah = 186257,
		},
		evoker = {
			hover = 394784,
			soar = 369536
		}
	},
	Zone = {
		Vashjir = {
			id = 203,
			KelptharForest = {
				id = 201,
			},
			ShimmeringExpanse = {
				id = 205,
			},
			AbyssalDepths = {
				id = 204,
			},
		},
	},
	Riding = {
		Skill = {
			[33388] = {
				name = "Apprentice Riding",
				unlocks = "ground",
				level = 75,
				active = true,
			},
			[33391] = {
				name = "Journeyman Riding",
				--depends = 33388,
				level = 150,
				active = true,
			},
			[34090] = {
				name = "Expert Riding",
				unlocks = "flying",
				--depends = 33391,
				level = 225,
				active = true,
			},
			[34091] = {
				name = "Artisan Riding",
				--depends = 34090,
				level = 300,
				active = true,
			},
			[90265] = {
				name = "Master Riding",
				--depends = 34091,
				level = 375,
				active = true,
			},
			-- Alt Spell ID
			[33389] = {
				name = "Apprentice Riding",
				unlocks = "ground",
				level = 75,
				active = true,
			},
			[33392] = {
				name = "Journeyman Riding",
				--depends = 33389,
				level = 150,
				active = true,
			},
			[34092] = {
				name = "Expert Riding",
				unlocks = "flying",
				--depends = 33391,
				level = 225,
				active = true,
			},
			[34093] = {
				name = "Artisan Riding",
				--depends = 34092,
				level = 300,
				active = true,
			},
			-- Wrath
			[54197] = {
				name = "Cold Weather Flying",
				unlocks = "flying",
				active = false,
				zones = {
					[1] = "",
				},
			},
			-- Cata
			[90267] = {
				name = "Flight Master's License",
				unlocks = "flying",
				active = true,
			},
			-- MoP
			[115913] = {
				name = "Wisdom of the Four Winds",
				unlocks = "flying",
				active = false,
				zones = {
					[1] = "",
				},
			},
			-- WoD
			[191645] = {
				name = "Draenor Pathfinder",
				unlocks = "flying",
				zones = {
					[1] = "",
				},
			},
			[226342] = {
				name = "Broken Isles Pathfinder",
			},
			[233368] = {
				name = "Broken Isles Pathfinder",
				unlocks = "flying",
				zones = {
					[1] = "",
				},
			},
			--[] = {
				--name = "",
				--unlocks = "zone",
				--zones = {
					--[]
				--},
				--depends = ""
			--},
			[281576] = {
				name = "Battle for Azeroth Pathfinder",
				depends = 34090,
				level = 825,
			},
			[278833] = {
				name = "Battle for Azeroth Pathfinder",
				unlocks = "flying",
				zones = {
					[1] = "",
				},
			},
		},
		Flight = {
			Restricted = {
				Worlds = {
				},
				Continents = {
					[905] = {
						blocked = true,
					},
					[875] = {
						requires = 278833,
					},
					[876] = {                                                 
						requires = 278833,
					},
--					[619] = {
--						requires = 233368,
--					},
--					[572] = {
--						requires = 191645,
--					},
				},
				Zones = {
					[106] = {
						blocked = true,
					},
					[97] = {
						blocked = true,
					},
					[103] = {
						blocked = true,
					},
					[94] = {
						blocked = true,
					},
					[95] = {
						blocked = true,
					},
					[122] = {
						blocked = true,
					},
					[1355] = {
						requires = 278833,
					},
					[125] = {
						blocked = true,
						except = LibStub("AceLocale-3.0"):GetLocale("BeStride")["Zone.Dalaran.SubZone.KrasusLanding"]
					},
					[127] = {
						blocked = true,
					},
				},
			},
		},
	},
	Mount = {
		Mounts = {
			[75207] = {
				["mountID"] = 373,
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
			[373] = {
				zone = 203,
				zones = { 203 }
			},
			[264058] = {
				["name"] = "Mighty Caravan Brutosaur",
				["type"] = "passenger",
				["subtype"] = "ground",
				["repair"] = true,
			}
		},
		Types = {
			[229] = "flying",
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
			[398] = "flying",
			[402] = "flying",
			[407] = "flying",
			[408] = "ground",
			[412] = "ground", --ottuks
			[424] = "flying",
			[428] = "flying",
			[429] = "flying"
		},
	}
}