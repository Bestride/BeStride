BeStride_Variables = {
	Settings = {
		Mount = {
			["mount.enablenew"]={name="mount.enablenew",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.EnableNew"]},
			["mount.remount"]={name="mount.remount",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.RemountAfterDismount"]},
			["mount.emptyrandom"]={name="mount.emptyrandom",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.EmptyRandom"]},
			["mount.emptyrandomflying"]={name="mount.emptyrandomflying",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.EmptyRandomFlying"]},
			["mount.nodismountwhileflying"]={name="mount.nodismountwhileflying",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.NoDismountWhileFlying"]},
			["mount.useflyingmount"]={name="mount.useflyingmount",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.UseFlyingMount"], dependants = {"mount.forceflyingmount"}},
			["mount.forceflyingmount"]={name="mount.forceflyingmount",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.ForceFlyingMount"], depends = {"mount.useflyingmount"}},
			["mount.copytargetmount"]={name="mount.copytargetmount",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.CopyTargetMount"], era={classic=false}},
			["mount.prioritizepassenger"]={name="mount.prioritizepassenger",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.PrioritizePassenger"]},
			["mount.noswimming"]={name="mount.noswimming",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.NoSwimming"]},
			["mount.flyingbroom"]={name="mount.flyingbroom",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.FlyingBroom"]},
			["mount.telaari"]={name="mount.telaari",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Telaari"]},
			["mount.forcerobot"]={name="mount.forcerobot",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.ForceRobot"]},
			{
				element="Group",
				children={
					["mount.repair.use"]={name="mount.repair.use",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.Use"], dependants = {"mount.repair.force","mount.repair.durability","mount.repair.globaldurability","mount.repair.inventorydurability"} },
					["mount.repair.force"]={name="mount.repair.force",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.Force"], depends = {"mount.repair.use"}},
					["mount.repair.durability"]={name="mount.repair.durability",element="Slider",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.Durability"],minDurability=0,maxDurability=100, increment=5, depends = {"mount.repair.use"}},
					["mount.repair.globaldurability"]={name="mount.repair.globaldurability",element="Slider",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.GlobalDurability"],minDurability=0,maxDurability=100, increment=5, depends = {"mount.repair.use"}},
					["mount.repair.inventorydurability"]={name="mount.repair.inventorydurability",element="Slider",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.InventoryDurability"],minDurability=0,maxDurability=100, increment=5, depends = {"mount.repair.use"}},
				}
			}
		},
		Classes = {
			{
				["classes.deathknight.wraithwalk"]={name="classes.deathknight.wraithwalk",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.DeathKnight.WraithWalk"],class="deathknight"},
			},
			{
				["classes.demonhunter.felrush"]={name="classes.demonhunter.felrush",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.DemonHunter.FelRush"],class="demonhunter"},
				["classes.demonhunter.glide"]={name="classes.demonhunter.glide",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.DemonHunter.Glide"],class="demonhunter"},
			},
			{
				["classes.druid.flightform"]={name="classes.druid.flightform",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Druid.FlightForm"],class="druid", dependants = {"classes.druid.traveltotravel","classes.druid.flightformpriority","classes.druid.mountedtoflightform"}},
				["classes.druid.traveltotravel"]={name="classes.druid.traveltotravel",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Druid.TravelToTravel"],class="druid", depends = {"classes.druid.flightform"}},
				["classes.druid.flightformpriority"]={name="classes.druid.flightformpriority",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Druid.FlightFormPriority"],class="druid", depends = {"classes.druid.flightform"}},
				["classes.druid.mountedtoflightform"]={name="classes.druid.mountedtoflightform",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Druid.MountedToFlightForm"],class="druid", depends = {"classes.druid.flightform"}},
			},
			{
				["classes.hunter.aspectofthecheetah"]={name="classes.hunter.aspectofthecheetah",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Hunter.AspectOfTheCheetah"],class="hunter"},
			},
			{
				["classes.mage.slowfall"]={name="classes.mage.slowfall",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Mage.SlowFall"],class="mage"},
				["classes.mage.blink"]={name="classes.mage.blink",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Mage.Blink"],class="mage"},
				["classes.mage.blinkpriority"]={name="classes.mage.blinkpriority",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Mage.BlinkPriority"],class="mage"},
			},
			{
				["classes.monk.roll"]={name="classes.monk.roll",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Monk.Roll"],class="monk"},
				["classes.monk.zenflight"]={name="classes.monk.zenflight",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Monk.ZenFlight"],class="monk"},
			},
			{
				["classes.paladin.steed"]={name="classes.paladin.steed",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Paladin.DivineSteed"],class="paladin"},
			},
			{
				["classes.priest.levitate"]={name="classes.priest.levitate",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Priest.Levitate"],class="priest"},
			},
			{
				["classes.rogue.sprint"]={name="classes.rogue.sprint",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Rogue.Sprint"],class="rogue"},
			},
			{
				["classes.shaman.ghostwolf"]={name="classes.shaman.ghostwolf",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Shaman.GhostWolf"],class="shaman"},
			},
			{
				["classes.evoker.hover"]={name="classes.evoker.hover",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Evoker.Hover"],class="evoker"},
				["classes.evoker.soar"]={name="classes.evoker.soar",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Evoker.Soar"],class="evoker"},
			},
			{
				["classes.warlock.rush"]={name="classes.warlock.rush",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Warlock.BurningRush"],class="warlock"},
			},
		}
	},
}

mountTable = {
	["master"] = {},
	["ground"] = {},
	["flying"] = {},
	["swimming"] = {},
	["repair"] = {},
	["passenger"] = {},
	["zone"] = {},
}

playerTable = {}

defaults = {
	profile = {
		settings = {
			migrated = false,
			bindingsMigrated = false,
			ymBindingsMigrated = false,
			mount = {
				emptyrandom = true, --ER
				hasmount = false, --HM
				remount = false,
				enablenew = false, --ENABLENEW
				useflyingmount = false,
				forceflyingmount = false, --FFM
				copytargetmount = true,
				nodismountwhileflying = false, --NDWF
				noswimming = false,
				flyingbroom = false,
				forcerobot = false,
				prioritizepassenger = false,
				telaari = true,
				repair = {
					use = false,
					force = false,
					durability = 20,
					globaldurability = 20,
					inventorydurability = 5,
				},
			},
			classes = {
				deathknight = {
					wraithwalk = true,
					custom = nil,
				},
				demonhunter = {
					felrush = true,
					glide = true,
				},
				druid = {
					flightform = true,
					traveltotravel = false,
					flightformpriority = false,
					mountedtoflightform = false,
				},
				hunter = {
					aspectofthecheetah = false,
				},
				mage = {
					blink = true,
					slowfall = true,
					blinkpriority = true,
				},
				monk = {
					roll = true,
					zenflight = true,
				},
				paladin = {
					steed = true,
				},
				priest = {
					levitate = true,
				},
				rogue = {
					sprint = true,
				},
				shaman = {
					ghostwolf = true,
				},
				evoker = {
					hover = true,
					soar = true,
				},
				warlock = {
					rush = true,
				},
			},
		},
		mounts = {
			ground = {},
			flying = {},
			repair = {},
			passenger = {},
			swimming = {},
			zone = {
				aq = {}
			},
		}
	}
}

_G["BINDING_HEADER_BESTRIDE_TITLE"] = LibStub("AceLocale-3.0"):GetLocale("BeStride")["Bindings.Header"]
_G["BINDING_NAME_CLICK BeStride_ABRegularMount:LeftButton"] = LibStub("AceLocale-3.0"):GetLocale("BeStride")["Bindings.Regular"]
_G["BINDING_NAME_CLICK BeStride_ABGroundMount:LeftButton"] = LibStub("AceLocale-3.0"):GetLocale("BeStride")["Bindings.Ground"]
_G["BINDING_NAME_CLICK BeStride_ABRepairMount:LeftButton"] = LibStub("AceLocale-3.0"):GetLocale("BeStride")["Bindings.Repair"]
_G["BINDING_NAME_CLICK BeStride_ABPassengerMount:LeftButton"] = LibStub("AceLocale-3.0"):GetLocale("BeStride")["Bindings.Passenger"]