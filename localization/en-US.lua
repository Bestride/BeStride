
BeStride_Locale = {
	Options = {
		OpenGUI = "Open GUI"
	},
	GUI = {
		BUTTON = {
			SelectAll = "Select All",
			ClearAll = "Clear All",
			Filter = "Filter",
			Copy = "Copy",
			Delete = "Delete"
		},
		TAB = {
			Mounts = "Mounts",
			MountOptions = "Mount Options",
			ClassOptions = "Class Options",
			Keybinds = "Keybinds",
			Profile = "Profiles",
			About = "About",
			Ground = "Ground",
			Flying = "Flying",
			Repair = "Repair",
			Swimming = "Swimming",
			Passenger = "Passenger",
			Special = "Special"
		}
	},
	About = "Version: " .. version .. "\n" .. "Author: " .. author .. "\n" .. "Discord: https://discord.gg/6bZf5PF" .. "\n" .. "Description: " .. "\n\n" .. "        " .. "BeStride originally started out as YayMounts by Cyrae on Windrunner US and Anzu on Kirin Tor US" .. "\n" .. "        " .. "Later, Anaximander from Burning Legion US found the project was neglected and had several bugs which needed to be resolved" .. "\n" .. "        " .. "as part of the bug resolution process, the addon was modernized to make the code cleaner to follow as well as more modular." .. "\n\n" .. "Special Thanks:" .. "\n\n" .. "        " .. "Mindlessgalaxy: For helping with the beta testing",
	Bindings = {
		Header = "BeStride",
		Regular = "Mount Button",
		Ground = "Force Ground Mount Button",
		Repair = "Force Repair Mount Button",
		Passenger = "Force Passenger Mount Button"
	},
	Zone = {
		AzuremystIsle = {
			Name = "Azuremyst Isle"
		},
		BloodmystIsle = {
			Name = "Bloodmyst Isle"
		},
		Deadmines = {
			Name = "The Deadmines"
		},
		AQ = {
			Name = "Ahn'Qiraj"
		},
		Dalaran = {
			Name = "Dalaran",
			SubZone = {
				Underbelly = {
					Name = "The Underbelly"
				},
				UnderbellyDescent = {
					Name = "The Underbelly Descent"
				},
				CircleofWills = {
					Name = "Circle of Wills"
				},
				BlackMarket = {
					Name = "The Black Market"
				}
			}
		},
		Icecrown = {
			Name = "Icecrown"
		},
		Oculus = {
			Name = "The Oculus"
		},
		StormPeaks = {
			Name = "The Storm Peaks"
		},
		SholazarBasin = {
			Name = "Sholazar Basin"
		},
		Wintergrasp = {
			Name = "Wintergrasp"
		},
		Vashjir = {
			Name = "Vashj'ir",
			SubZone = {
				KelptharForest = {
					Name = "Kelp'thar Forest"
				},
				ShimmeringExpanse = {
					Name = "Shimmering Expanse"
				},
				AbyssalDepths = {
					Name = "Abyssal Depths"
				},
				DamplightChamber = {
					Name = "Damplight Chamber"
				},
				Nespirah = {
					Name = "Nespirah"
				},
				LGhorek = {
					Name = "L'Ghorek"
				}
			}
		},
		VortexPinnacle = {
			Name = "The Vortex Pinnacle"
		},
		Nagrand = {
			Name = "Nagrand"
		}
	},
	Continent = {
		Draenor = {
			Name = "Draenor",
		},
	},
	Settings = {
		EnableNew = "Automatically enable new mounts upon learning them",
		EmptyRandom = "Choose random usable mount if no usable mounts selected",
		RemountAfterDismount = "Remount Immediately After Dismounting",
		NoDismountWhileFlying = "Don't dismount while flying. You'll have to land or (if enabled in Blizzard options) cast a spell",
		UseFlyingMount = "Use Flying type mounts even in areas where you cannot fly",
		ForceFlyingMount = "Force Flying type mounts even in areas where you cannot fly",
		PrioritizePassenger = "Prioritize Passenger Mounts when in group",
		NoSwimming = "Never use underwater mounts even when swimming",
		FlyingBroom = "Always use Flying Broom instead of a normal mount",
		Telaari = "Always use the Telaari Talbuk or Frostwolf War Wolf while in Nagrand",
		ForceRobot = "Always use Sky Golem or Mechanized Lumber Extractor when you have learned Herbalism",
		Repair = {
			Use = "Use a Repair mount if player owns one and if meets durability threshold",
			Force = "Force a Repair mount if player owns one",
			Durability = "Item Low Durability %",
			GlobalDurability = "Global Low Durability %",
			InventoryDurability = "Inventory Item Low Durability %"
		},
		Classes = {
			DeathKnight = {
				WraithWalk = "Death Knight: Wraith Walk"
			},
			DemonHunter = {
				FelRush = "Demon Hunter: Use Fel Rush",
				Glide = "Demon Hunter: Use Gliding"
			},
			Druid = {
				FlightForm = "Druid: Use Flight Form",
				TravelToTravel = "Druid: When in combat, shift from Travel or Aquatic form directly back to that form",
				FlightFormPriority = "Druid: Prioritize using Flight Form over a regular mount even when not moving",
				MountedToFlightForm = "Druid: When on a flying mount and flying + moving, shift into Flight Form"
			},
			Hunter = {
				AspectOfTheCheetah = "Hunter: Aspect of the Cheetah",
			},
			Mage = {
				SlowFall = "Mage: Slowfall",
				Blink = "Mage: Blink",
				BlinkPriority = "Mage: Prioritize Blink before Slowfall (even when falling)"
			},
			Monk = {
				Roll = "Monk: Roll",
				ZenFlight = "Monk: Use Zen Flight while moving or falling"
			},
			Paladin = {
				DivineSteed = "Paladin: Divine Steed"
			},
			Priest = {
				Levitate = "Priest: Levitate"
			},
			Rogue = {
				Sprint = "Rogue: Sprint"
			},
			Shaman = {
				GhostWolf = "Shaman: Ghost Wolf"
			}
		},
		Profiles = {
			CreateNew = "Create new Profile:",
			Current = "Current Profile:",
			CopyFrom = "Copy settings from:",
			Delete = "Delete profile:"
		}
	}
}
