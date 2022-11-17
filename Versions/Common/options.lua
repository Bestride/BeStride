local filter = ""

local optionsTable = {
    name="BeStride",
    type = "group",
    args={
        about_header={
            type = "header",
            name = "About",
        },
        about_content={
            name = LibStub("AceLocale-3.0"):GetLocale("BeStride")["GUI.About"],
            type = "description",
        },
    },
}

local optionsTable_Options = {
    name="Options",
    type = "group",
    childGroups="tab",
    args = {
        mount_options = {
            name="Mount",
            type = "group",
            args = {
                ["mount.enablenew"]={
                    type="toggle",
                    name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.EnableNew"],
                    order=1,
                    width="full",
                    get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                    set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                },
                ["mount.emptyrandom"]={
                    type="toggle",
                    name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.EmptyRandom"],
                    order=2,
                    width="full",
                    get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                    set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                },
                ["mount.remount"]={
                    type="toggle",
                    name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.RemountAfterDismount"],
                    order=3,
                    width="full",
                    get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                    set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                },
                ["mount.nodismountwhileflying"]={
                    type="toggle",
                    name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.NoDismountWhileFlying"],
                    order=4,
                    width="full",
                    get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                    set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                },
                ["mount.useflyingmount"]={
                    type="toggle",
                    name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.UseFlyingMount"],
                    order=5,
                    width="full",
                    get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                    set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                },
                ["mount.forceflyingmount"]={
                    type="toggle",
                    name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.ForceFlyingMount"],
                    order=6,
                    width="full",
                    get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                    set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                    disabled=function(info) return not BeStride:DBGetSetting('mount.useflyingmount') end,
                },
                special_mounts = {
                    type="group",
                    inline=true,
                    order=7,
                    name="Special mounts",
                    args={
                        ["mount.prioritizepassenger"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.PrioritizePassenger"],
                            order=1,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                        ["mount.noswimming"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.NoSwimming"],
                            order=2,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                        ["mount.flyingbroom"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.FlyingBroom"],
                            order=3,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                        ["mount.telaari"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Telaari"],
                            order=4,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                        ["mount.forcerobot"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.ForceRobot"],
                            order=5,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                    },
                },
                repair_mounts = {
                    type="group",
                    name="Repair Mounts",
                    order=8,
                    width="full",
                    inline=true,
                    args={
                        ["mount.repair.use"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.Use"],
                            order=1,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                        ["mount.repair.force"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.Force"],
                            order=2,
                            width="full",
                            disabled=function(info) return not BeStride:DBGetSetting('mount.repair.use') end,
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                        ["mount.repair.durability"]={
                            type="range",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.Durability"],
                            order=3,
                            width="full",
                            isPercent=true,
                            max=1,
                            softMax=1,
                            disabled=function(info) return not (BeStride:DBGetSetting('mount.repair.use') and not BeStride:DBGetSetting('mount.repair.force')) end,
                            get=function (info) return BeStride:DBGetSetting(info[#info])/100 end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val*100) end,
                        },
                        ["mount.repair.globaldurability"]={
                            type="range",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.GlobalDurability"],
                            order=4,
                            width="full",
                            isPercent=true,
                            max=1,
                            softMax=1,
                            disabled=function(info) return not (BeStride:DBGetSetting('mount.repair.use') and not BeStride:DBGetSetting('mount.repair.force')) end,
                            get=function (info) return BeStride:DBGetSetting(info[#info])/100 end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val*100) end,
                        },
                        ["mount.repair.inventorydurability"]={
                            type="range",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Repair.InventoryDurability"],
                            order=5,
                            width="full",
                            isPercent=true,
                            max=1,
                            softMax=1,
                            disabled=function(info) return not (BeStride:DBGetSetting('mount.repair.use') and not BeStride:DBGetSetting('mount.repair.force')) end,
                            get=function (info) return BeStride:DBGetSetting(info[#info])/100 end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val*100) end,
                        },
                    }
                }
            },
        },
        class_options = {
            name="Class",
            type = "group",
            args = {
                deathknight = {
                    type="group",
                    name="Death Knight",
                    disabled = function (info) return BeStride:IsWrath() and not BeStride:IsMainline() end,
                    args = {
                        ["classes.deathknight.wraithwalk"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.DeathKnight.WraithWalk"],
                            order=1,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                    },
                },
                demonhunter = {
                    type="group",
                    name="Demon Hunter",
                    disabled = function (info) return BeStride:IsWrath() and not BeStride:IsMainline() end,
                    args = {
                        ["classes.demonhunter.felrush"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.DemonHunter.FelRush"],
                            order=1,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                        ["classes.demonhunter.glide"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.DemonHunter.Glide"],
                            order=1,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                    },
                },
                druid = {
                    type="group",
                    name="Druid",
                    args = {
                        ["classes.druid.traveltotravel"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Druid.TravelToTravel"],
                            order=1,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                        ["classes.druid.flightform"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Druid.FlightForm"],
                            order=2,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                        ["classes.druid.flightformpriority"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Druid.FlightFormPriority"],
                            order=3,
                            width="full",
                            disabled=function (info) return not BeStride:DBGetSetting('classes.druid.flightform') end,
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                        ["classes.druid.mountedtoflightform"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Druid.MountedToFlightForm"],
                            order=4,
                            width="full",
                            disabled=function (info) return not BeStride:DBGetSetting('classes.druid.flightform') end,
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                    },
                },
                evoker = {
                    type="group",
                    name="Evoker",
                    args={
                        ["classes.evoker.hover"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Evoker.Hover"],
                            order=1,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                    },
                },
                hunter = {
                    type="group",
                    name="Hunter",
                    args = {
                        ["classes.hunter.aspectofthecheetah"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Hunter.AspectOfTheCheetah"],
                            order=1,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                    },
                },
                mage = {
                    type="group",
                    name="Mage",
                    args = {
                        ["classes.mage.slowfall"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Mage.SlowFall"],
                            order=1,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                        ["classes.mage.blink"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Mage.Blink"],
                            order=2,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                        ["classes.mage.blinkpriority"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Mage.BlinkPriority"],
                            order=3,
                            width="full",
                            disabled=function (info) return not BeStride:DBGetSetting('classes.mage.blink') end,
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                    },
                },
                monk = {
                    type="group",
                    name="Monk",
                    disabled = function (info) return BeStride:IsWrath() and not BeStride:IsMainline() end,
                    args = {
                        ["classes.monk.roll"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Monk.Roll"],
                            order=1,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                        ["classes.monk.zenflight"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Monk.ZenFlight"],
                            order=2,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                    },
                },
                paladin = {
                    type="group",
                    name="Paladin",
                    disabled = function (info) return BeStride:IsWrath() and not BeStride:IsMainline() end,
                    args = {
                        ["classes.paladin.steed"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Paladin.DivineSteed"],
                            order=1,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                    },
                },
                priest = {
                    type="group",
                    name="Priest",
                    args = {
                        ["classes.priest.levitate"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Priest.Levitate"],
                            order=1,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                    },
                },
                rogue = {
                    type="group",
                    name="Rogue",
                    args = {
                        ["classes.rogue.sprint"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Rogue.Sprint"],
                            order=1,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                    },
                },
                shaman = {
                    type="group",
                    name="Shaman",
                    args = {
                        ["classes.shaman.ghostwolf"]={
                            type="toggle",
                            name=LibStub("AceLocale-3.0"):GetLocale("BeStride")["Settings.Classes.Shaman.GhostWolf"],
                            order=1,
                            width="full",
                            get=function (info) return BeStride:DBGetSetting(info[#info]) end,
                            set=function (info,val) BeStride:DBSetSetting(info[#info],val) end,
                        },
                    },
                },
            },
        },
    }
}

local optionsTable_Mounts = {
    name="Mounts",
    type = "group",
    childGroups="tab",
    args={
        filter = {
            type="group",
            name="",
            inline=true,
            args={
                filter = {        
                    type = "input",
                    order = 1,
                    name = "Filter",
                    set = function (info,val) filter = val end,
                    get = function (info) return filter end,
                },
                filter_clear = {        
                    type = "execute",
                    order = 100,
                    name = "Clear",
                    func = function (info) filter = "" end,
                }
            },
        },
        ground = {
            name="Ground",
            type = "group",
            order=1,
            hidden = toggleHidden,
            args = {},
        },
        flying = {
            name="Flying",
            type = "group",
            order=2,
            hidden = toggleHidden, 
            args = {},
        },
        swimming = {
            name="Swimming",
            type = "group",
            order=3,
            hidden = toggleHidden, 
            args = {},
        },
        repair = {
            name="Repair",
            type = "group",
            order=4,
            hidden = toggleHidden, 
            args = {},
        },
        passenger = {
            name="Passenger",
            type = "group",
            order=5,
            hidden = toggleHidden, 
            args = {},
        },
    },
}

local function generateMountTable()
    for _,group in pairs({"ground", "flying", "swimming", "repair", "passenger"}) do
        for key,mountID in pairs(mountTable[group]) do
            local mount = mountTable.master[mountID]
            local name = mount.name

            options = {
                name=name,
                type="toggle",
                get=function(info) return BeStride:DBGetMount(group,mount.mountID) end,
                set=function(info, val) BeStride:DBSetMount(group,mount.mountID,val) end
            }

            if filter == nil or (filter ~= nil and (string.len(filter) == 0 or string.find(string.lower(name), string.lower(filter)))) then
                options.hidden = false
            else
                options.hidden = true
            end
            optionsTable_Mounts.args[group].args[name] = options
        end
    end


    return optionsTable_Mounts
end


local function debugTable(table,depth)
	-- depth shouldn't be > 20 and shouldn't be nil
	if depth == nil or depth > 20 then
		return ""
	end
	
	local tab = ""
	local data = ""
	local lf = "\n"
	
	for i=0,depth do
		tab = tab .. "    "
	end
	
	for k,v in pairs(table) do
		local line = tab .. k
		if k == "source" then
			line = ""
		elseif type(v) == "table" then
			line = line .. " = { " .. lf .. debugTable(v,depth+1) .. tab .. "}," .. lf
		else
			line = line .. " = " .. tostring(v) .. "," .. lf
		end
		
		data = data .. line
	end
	
	return data
end


local function debugMap(mapID)
	if mapID == nil then
		mapID = C_Map.GetBestMapForUnit("player")
	end
	
	local map = C_Map.GetMapInfo(mapID)
	local data = {}
	
	if (map.parentMapID == 0 or map.parentMapID == nil) then
		table.insert(data,map)
		return data
	else
		local parent = debugMap(map.parentMapID)
		
		table.insert(data,map)
		
		for k,v in pairs(parent) do table.insert(data,v); end
		
		return data
	end
end


local function generateDebugOptions()

    local debugData = "Version = " .. version .. "\n"
    .. "maps = { " .. "\n" .. debugTable(debugMap(),0) .. "}" .. "\n"
    .. "mountTable = { " .. "\n" .. debugTable(mountTable,0) .. "}" .. "\n"
    .. "BeStride.db.profile = { " .. "\n" .. debugTable(BeStride.db.profile,0) .. "}" .. "\n"
    .. "BeStride_Variables = { " .. "\n" .. debugTable(BeStride_Variables,0) .. "}" .. "\n"
    .. "BeStride_Constants = { " .. "\n" .. debugTable(BeStride_Constants,0) .. "}" .. "\n"

    return {
        name = "Debug Information",
        type = "group",
        inline = true,
        width = "full",
        args = {
            debug = {
                name = "Debug",
                type = 'input',
                multiline = 25,
                width = "full",
                get = function (info) return debugData end,
                set = function (info, val) return end,
            },
        },
    }
end

function BeStride:OptionsTable()
    self.configDialogs.configuration = {}
    self.configDialogs.mounts = {}
    self.configDialogs.options = {}
    self.configDialogs.profiles = {}

    profiles = LibStub ("AceDBOptions-3.0"):GetOptionsTable (self.db)
    optionsTable.args.about = profile

    LibStub ("AceConfig-3.0"):RegisterOptionsTable ("BeStride", optionsTable)
	self.configDialogs.configuration.frame,self.configDialogs.configuration.id = LibStub ("AceConfigDialog-3.0"):AddToBlizOptions ("BeStride", "BeStride")

    LibStub ("AceConfig-3.0"):RegisterOptionsTable ("BeStride-Mounts", generateMountTable)
	self.configDialogs.mounts.frame,self.configDialogs.mounts.id = LibStub ("AceConfigDialog-3.0"):AddToBlizOptions ("BeStride-Mounts", "Mounts", "BeStride")

    LibStub ("AceConfig-3.0"):RegisterOptionsTable ("BeStride-Options", optionsTable_Options)
	self.configDialogs.options.frame,self.configDialogs.options.id = LibStub ("AceConfigDialog-3.0"):AddToBlizOptions ("BeStride-Options", "Options", "BeStride")
    
	LibStub ("AceConfig-3.0"):RegisterOptionsTable ("BeStride-Profiles", LibStub ("AceDBOptions-3.0"):GetOptionsTable (self.db))
	self.configDialogs.profiles.frame,self.configDialogs.profiles.id = LibStub ("AceConfigDialog-3.0"):AddToBlizOptions ("BeStride-Profiles", "Profiles", "BeStride")

    LibStub ("AceConfig-3.0"):RegisterOptionsTable ("BeStride-Debug", generateDebugOptions)
end

