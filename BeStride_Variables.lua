BeStride_Variables = {
	Settings = {
		Mount = {
			{name="mount.enablenew",element="CheckBox",label=BeStride_Locale.Settings.EnableNew},
			{name="mount.remount",element="CheckBox",label=BeStride_Locale.Settings.RemountAfterDismount},
			{name="mount.emptyrandom",element="CheckBox",label=BeStride_Locale.Settings.EmptyRandom},
			{name="mount.nodismountwhileflying",element="CheckBox",label=BeStride_Locale.Settings.NoDismountWhileFlying},
			{name="mount.useflyingmount",element="CheckBox",label=BeStride_Locale.Settings.UseFlyingMount, dependants = {"mount.forceflyingmount"}},
			{name="mount.forceflyingmount",element="CheckBox",label=BeStride_Locale.Settings.ForceFlyingMount, depends = {"mount.useflyingmount"}},
			{name="mount.prioritizepassenger",element="CheckBox",label=BeStride_Locale.Settings.PrioritizePassenger},
			{name="mount.noswimming",element="CheckBox",label=BeStride_Locale.Settings.NoSwimming},
			{name="mount.flyingbroom",element="CheckBox",label=BeStride_Locale.Settings.FlyingBroom},
			{name="mount.telaari",element="CheckBox",label=BeStride_Locale.Settings.Telaari},
			{name="mount.forcerobot",element="CheckBox",label=BeStride_Locale.Settings.ForceRobot},
			{
				element="Group",
				children={
					{name="mount.repair.use",element="CheckBox",label=BeStride_Locale.Settings.Repair.Use, dependants = {"mount.repair.force","mount.repair.durability","mount.repair.globaldurability","mount.repair.inventorydurability"} },
					{name="mount.repair.force",element="CheckBox",label=BeStride_Locale.Settings.Repair.Force, depends = {"mount.repair.use"}},
					{name="mount.repair.durability",element="Slider",label=BeStride_Locale.Settings.Repair.Durability,minDurability=0,maxDurability=100, increment=5, depends = {"mount.repair.use"}},
					{name="mount.repair.globaldurability",element="Slider",label=BeStride_Locale.Settings.Repair.GlobalDurability,minDurability=0,maxDurability=100, increment=5, depends = {"mount.repair.use"}},
					{name="mount.repair.inventorydurability",element="Slider",label=BeStride_Locale.Settings.Repair.InventoryDurability,minDurability=0,maxDurability=100, increment=5, depends = {"mount.repair.use"}},
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
				{name="classes.hunter.aspectofthecheetah",element="CheckBox",label=BeStride_Locale.Settings.Classes.Hunter.AspectOfTheCheetah,class="hunter"},
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

BeStride_Options = {
  name="BeStride",
  handler = BeStride,
  type = "group",
  args = {
    enable = {
      type = "execute",
      name = BeStride_Locale.Options.OpenGUI,
      func = "Frame",
    },
  }
}

defaults = {
	version = BeStride_Constants.Version,
	
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

_G["BINDING_HEADER_BESTRIDE_TITLE"] = BeStride_Locale.Bindings.Header
_G["BINDING_NAME_CLICK BeStride_ABRegularMount:LeftButton"] = BeStride_Locale.Bindings.Regular
_G["BINDING_NAME_CLICK BeStride_ABGroundMount:LeftButton"] = BeStride_Locale.Bindings.Ground
_G["BINDING_NAME_CLICK BeStride_ABRepairMount:LeftButton"] = BeStride_Locale.Bindings.Repair
_G["BINDING_NAME_CLICK BeStride_ABPassengerMount:LeftButton"] = BeStride_Locale.Bindings.Passenger