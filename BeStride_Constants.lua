version = "0.5.0"
author = "Anaximander"

BeStride_Constants = {
	Settings = {
		Mount = {
			{name="mount.enablenew",element="CheckBox",label=BeStride_Locale.Settings.EnableNew},
			{name="mount.remount",element="CheckBox",label=BeStride_Locale.Settings.RemountAfterDismount},
			{name="mount.emptyrandom",element="CheckBox",label=BeStride_Locale.Settings.EmptyRandom},
			{name="mount.nodismountwhileflying",element="CheckBox",label=BeStride_Locale.Settings.NoDismountWhileFlying},
			{name="mount.useflyingmount",element="CheckBox",label=BeStride_Locale.Settings.UseFlyingMount, dependants = {"mount.forceflyingmount"}},
			{name="mount.forceflyingmount",element="CheckBox",label=BeStride_Locale.Settings.ForceFlyingMount, depends = {"mount.useflyingmount"}},
			{name="mount.prioritizepassenger",element="CheckBox",label=BeStride_Locale.Settings.PrioritizePassenger},
			{name="mount.flyingbroom",element="CheckBox",label=BeStride_Locale.Settings.FlyingBroom},
			{name="mount.telaari",element="CheckBox",label=BeStride_Locale.Settings.Telaari},
			{
				element="Group",
				children={
					{name="mount.repair.use",element="CheckBox",label=BeStride_Locale.Settings.Repair.Use, dependants = {"mount.repair.force"} },
					{name="mount.repair.force",element="CheckBox",label=BeStride_Locale.Settings.Repair.Force, depends = {"mount.repair.use"}},
					{name="mount.repair.durability",element="Slider",label=BeStride_Locale.Settings.Repair.Durability,minDurability=0,maxDurability=100, increment=5, depends = {"mount.repair.use"}}
				}
			}
		},
		Classes = {
			{
				{name="classes.deathknight.wraithwalk",element="CheckBox",label=BeStride_Locale.Settings.Classes.DeathKnight.WraithWalk,class="deathknight"},
			},
			{
				{name="classes.demonhunter.felrush",element="CheckBox",label=BeStride_Locale.Settings.Classes.DemonHunter.FelRush,class="demonhunter"},
				{name="classes.demonhunter.glide",element="CheckBox",label=BeStride_Locale.Settings.Classes.DemonHunter.Glide,class="demonhunter"},
			},
			{
				{name="classes.druid.flightform",element="CheckBox",label=BeStride_Locale.Settings.Classes.Druid.FlightForm,class="druid", dependants = {"classes.druid.traveltotravel","classes.druid.flightformpriority","classes.druid.mountedtoflightform"}},
				{name="classes.druid.traveltotravel",element="CheckBox",label=BeStride_Locale.Settings.Classes.Druid.TravelToTravel,class="druid", depends = {"classes.druid.flightform"}},
				{name="classes.druid.flightformpriority",element="CheckBox",label=BeStride_Locale.Settings.Classes.Druid.FlightFormPriority,class="druid", depends = {"classes.druid.flightform"}},
				{name="classes.druid.mountedtoflightform",element="CheckBox",label=BeStride_Locale.Settings.Classes.Druid.MountedToFlightForm,class="druid", depends = {"classes.druid.flightform"}},
			},
			{
				{name="classes.mage.slowfall",element="CheckBox",label=BeStride_Locale.Settings.Classes.Mage.SlowFall,class="mage"},
				{name="classes.mage.blink",element="CheckBox",label=BeStride_Locale.Settings.Classes.Mage.Blink,class="mage"},
				{name="classes.mage.blinkpriority",element="CheckBox",label=BeStride_Locale.Settings.Classes.Mage.BlinkPriority,class="mage"},
			},
			{
				{name="classes.monk.roll",element="CheckBox",label=BeStride_Locale.Settings.Classes.Monk.Roll,class="monk"},
				{name="classes.monk.zenflight",element="CheckBox",label=BeStride_Locale.Settings.Classes.Monk.ZenFlight,class="monk"},
			},
			{
				{name="classes.paladin.steed",element="CheckBox",label=BeStride_Locale.Settings.Classes.Paladin.DivineSteed,class="paladin"},
			},
			{
				{name="classes.priest.levitate",element="CheckBox",label=BeStride_Locale.Settings.Classes.Priest.Levitate,class="priest"},
			},
			{
				{name="classes.rogue.sprint",element="CheckBox",label=BeStride_Locale.Settings.Classes.Rogue.Sprint,class="rogue"},
			},
			{
				{name="classes.shaman.ghostwolf",element="CheckBox",label=BeStride_Locale.Settings.Classes.Shaman.GhostWolf,class="shaman"},
			},
		}
	}
}
BeStride_Constants.spells = {}
BeStride_Constants.spells.druid = {}

mountData = {
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