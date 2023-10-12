BeStride_Variables = {
	Settings = {
		Mount = {
			{name="mount.enablenew",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.EnableNew"]},
			{name="mount.remount",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.RemountAfterDismount"]},
			{name="mount.emptyrandom",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.EmptyRandom"]},
			{name="mount.nodismountwhileflying",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.NoDismountWhileFlying"]},
			{name="mount.useflyingmount",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.UseFlyingMount"], dependants = {"mount.forceflyingmount"}},
			{name="mount.forceflyingmount",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.ForceFlyingMount"], depends = {"mount.useflyingmount"}},
			{name="mount.copytargetmount",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.CopyTargetMount"], era={classic=false}},
			{name="mount.prioritizepassenger",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.PrioritizePassenger"]},
			{name="mount.noswimming",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.NoSwimming"]},
			{name="mount.flyingbroom",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.FlyingBroom"]},
			{name="mount.telaari",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Telaari"]},
			{name="mount.forcerobot",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.ForceRobot"]},
			{
				element="Group",
				children={
					{name="mount.repair.use",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.Use"], dependants = {"mount.repair.force","mount.repair.durability","mount.repair.globaldurability","mount.repair.inventorydurability"} },
					{name="mount.repair.force",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.Force"], depends = {"mount.repair.use"}},
					{name="mount.repair.durability",element="Slider",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.Durability"],minDurability=0,maxDurability=100, increment=5, depends = {"mount.repair.use"}},
					{name="mount.repair.globaldurability",element="Slider",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.GlobalDurability"],minDurability=0,maxDurability=100, increment=5, depends = {"mount.repair.use"}},
					{name="mount.repair.inventorydurability",element="Slider",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.InventoryDurability"],minDurability=0,maxDurability=100, increment=5, depends = {"mount.repair.use"}},
				}
			}
		},
		Classes = {
			{
				{name="classes.deathknight.wraithwalk",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.DeathKnight.WraithWalk"],class="deathknight"},
			},
			{
				{name="classes.demonhunter.felrush",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.DemonHunter.FelRush"],class="demonhunter"},
				{name="classes.demonhunter.glide",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.DemonHunter.Glide"],class="demonhunter"},
			},
			{
				{name="classes.druid.flightform",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Druid.FlightForm"],class="druid", dependants = {"classes.druid.traveltotravel","classes.druid.flightformpriority","classes.druid.mountedtoflightform"}},
				{name="classes.druid.traveltotravel",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Druid.TravelToTravel"],class="druid", depends = {"classes.druid.flightform"}},
				{name="classes.druid.flightformpriority",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Druid.FlightFormPriority"],class="druid", depends = {"classes.druid.flightform"}},
				{name="classes.druid.mountedtoflightform",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Druid.MountedToFlightForm"],class="druid", depends = {"classes.druid.flightform"}},
			},
			{
				{name="classes.hunter.aspectofthecheetah",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Hunter.AspectOfTheCheetah"],class="hunter"},
			},
			{
				{name="classes.mage.slowfall",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Mage.SlowFall"],class="mage"},
				{name="classes.mage.blink",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Mage.Blink"],class="mage"},
				{name="classes.mage.blinkpriority",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Mage.BlinkPriority"],class="mage"},
			},
			{
				{name="classes.monk.roll",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Monk.Roll"],class="monk"},
				{name="classes.monk.zenflight",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Monk.ZenFlight"],class="monk"},
			},
			{
				{name="classes.paladin.steed",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Paladin.DivineSteed"],class="paladin"},
			},
			{
				{name="classes.priest.levitate",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Priest.Levitate"],class="priest"},
			},
			{
				{name="classes.rogue.sprint",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Rogue.Sprint"],class="rogue"},
			},
			{
				{name="classes.shaman.ghostwolf",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Shaman.GhostWolf"],class="shaman"},
			},
			{
				{name="classes.evoker.hover",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Evoker.Hover"],class="evoker"},
			},
			{
				{name="classes.warlock.rush",element="CheckBox",label=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Warlock.BurningRush"],class="warlock"},
			},
		}
	},
}

mountTable = {
	["master"] = {},
	["ground"] = {},
	["flying"] = {},
	["dragonriding"] = {},
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
				},
				warlock = {
					rush = true,
				},
			},
		},
		mounts = {
			ground = {},
			flying = {},
			dragonriding = {},
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