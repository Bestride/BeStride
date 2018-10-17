BeStride = LibStub("AceAddon-3.0"):NewAddon("Bestride","AceConsole-3.0", "AceEvent-3.0")

debugLevel = 8

playerTable = {}

function sortTable(unsortedTable)
	keys = {}
	sortedTable = {}
	for key in pairs(unsortedTable) do table.insert(keys,key) end
	table.sort(keys)
	for _,key in ipairs(keys) do sortedTable[key] = unsortedTable[key] end
	return sortedTable
end

function pairsByKeys (t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, f)
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if a[i] == nil then return nil
		else return a[i], t[a[i]]
		end
	end
	return iter
end

mountTable = {
	["master"] = {},
	["ground"] = {},
	["flying"] = {},
	["swimming"] = {},
	["repair"] = {},
	["passenger"] = {},
	["zone"] = {},
}

local defaults = {
	["version"] = version,
	
	profile = {
		settings = {
			["emptyrandom"] = true, --ER
			["hasmount"] = false, --HM
			["enablenew"] = false, --ENABLENEW
			["useflyingmount"] = false,
			["forceflyingmount"] = false, --FFM
			["nodismountwhileflying"] = false, --NDWF
			["flyingbroom"] = false,
			["telaari"] = true,
			["repair"] = {
				["use"] = false,
				["force"] = false,
				["durability"] = 20,
			},
			["classes"] = {
				["deathknight"] = {
					["wraithwalk"] = true,
				},
				["druid"] = {
					["flightform"] = true,
					["traveltotravel"] = false,
					["flightformpriority"] = false,
					["mountedtoflightform"] = false,
				},
				["mage"] = {
					["blink"] = true,
					["slowfall"] = true,
				},
				["monk"] = {
					["roll"] = true,
					["zenflight"] = true,
				},
				["paladin"] = {
					["steed"] = true,
				},
				["priest"] = {
					["levitate"] = true,
				},
				["rogue"] = {
					["sprint"] = true,
				},
				["shaman"] = {
					["ghostwolf"] = true,
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

function BeStride:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("BeStrideDB", defaults, "Default")
	self:RegisterChatCommand("bestride","ChatCommand")
	self:RegisterChatCommand("br","ChatCommand")
	
	self.buttons = {
		["mount"] = nil,
		["ground"] = nil,
		["repair"] = nil,
		["passenger"] = nil,
	}
	
	--self.buttons["mount"] = BeStride_ABMountMount
	self.buttons["regular"] = BeStride:CreateActionButton('Regular')
	--self.buttons["ground"] = BeStride_ABGroundMount
	self.buttons["ground"] = BeStride:CreateActionButton('Ground')
	--self.buttons["repair"] = BeStride_ABRepairMount
	self.buttons["repair"] = BeStride:CreateActionButton('Repair')
	--self.buttons["passenger"] = BeStride_ABPassengerMount
	self.buttons["passenger"] = BeStride:CreateActionButton('Passenger')
	
	local className,classFilename,classID = UnitClass("player")
	local raceName,raceFile,raceID = UnitRace("player")
	local factionName,factionLocalized =  UnitFactionGroup("player")
	local factionId = nil
	
	if factionName == "Alliance" then
		factionId = 1
	else
		factionId = 0
	end
	
	playerTable["class"] = {}
	playerTable["class"]["id"] = classID
	playerTable["class"]["name"] = className
	playerTable["race"] = {}
	playerTable["race"]["name"] = raceName
	playerTable["race"]["id"] = raceID
	playerTable["faction"] = {}
	playerTable["faction"]["name"] = factionName
	playerTable["faction"]["id"] = factionId
	playerTable["faction"]["localization"] = factionLocalized
	
	print("Faction: " .. factionId)
end

function BeStride:OnEnable()
	BeStride:buildMountTables()
	
	self:RegisterEvent("UPDATE_BINDINGS", "UpdateBindings")
	self:RegisterEvent("NEW_MOUNT_ADDED", "NewMount")
	
	BeStride:UpdateBindings()
	BeStride:Upgrade()
end

function BeStride:NewMount(...)
	BeStride_Debug:Debug("NewMount")
	table.foreach(args,function (k,v) print("Arg: " .. k) end)
end

function BeStride:UpdateBindings()
	BeStride:SetKeyBindingsOverrides(self.buttons["regular"])
	BeStride:SetKeyBindingsOverrides(self.buttons["ground"])
	BeStride:SetKeyBindingsOverrides(self.buttons["passenger"])
	BeStride:SetKeyBindingsOverrides(self.buttons["repair"])
	
	SaveBindings(GetCurrentBindingSet())
end


function BeStride:Upgrade()
	local db = LibStub("AceDB-3.0"):New("BestrideDB")
	if db.profile.settings then
		print("Old Settings Exist, Upgrading")
		
		table.foreach(db.profile.settings,function (key,value)
			if key == "HM" then
				self.db.profile.settings.hasmount = value
			elseif key == "ER" then
				self.db.profile.settings.emptyrandom = value
			elseif key == "FBP" then
				self.db.profile.settings.flyingbroom = value
			elseif key == "TTT" then
				self.db.profile.settings.druid.traveltotravel = value
			elseif key == "MTFF" then
				self.db.profile.settings.druid.mountedtoflightform = value
			elseif key == "NDWF" then
				self.db.profile.settings.nodismountwhileflying = value
			elseif key == "FFM" then
				self.db.profile.settings.useflyingmount = value
			elseif key == "URM" then
				self.db.profile.settings.repair.use = value
			elseif key == "ENABLENEW" then
				self.db.profile.settings.enablenew = value
			elseif key == "TELAARI" then
				self.db.profile.settings.telaari = value
			elseif key == "DEATHKNIGHT" then
				self.db.profile.settings.deathknight.wraithwalk = value
			elseif key == "PALADIN" then
				self.db.profile.settings.paladin.steed = value
			elseif key == "SHAMAN" then
				self.db.profile.settings.shaman.ghostwolf = value
			elseif key == "MONK" then
				self.db.profile.settings.monk.roll = value
			elseif key == "MONKZENUSE" then
				self.db.profile.settings.monk.zenflight = value
			elseif key == "ROGUE" then
				self.db.profile.settings.rogue.sprint = value
			elseif key == "PRIEST" then
				self.db.profile.settings.levitate = value
			elseif key == "MAGE" then
				self.db.profile.settings.mage.slowfall = value
				self.db.profile.settings.mage.blink = value
			end
		end)
		
		table.foreach(db.profile.mounts,function (key,value)
			if mountTable.master[value[3]] and mountTable.master[value[3]].spellID == key then
				local mountID,spellID,status,savedType = value[3],key,value[1],value[2]
				local mountType = mountTable.master[mountID].type
				
				if mountType == "ground" or mountType == "flying" or mountType == "swimming" then
					self.db.profile.mounts[mountType][mountID] = status
				end
				
				if savedType == "special" then
					if mountData[mountTable.master[mountID].spellID] and mountData[mountTable.master[mountID].spellID].type == "zone" then
						self.db.profile.mounts[mountType][mountID] = status
					end
				end
			end
		end)
	end
end

function BeStride:SetKeyBindings(button)
    --BeStride_Debug:Debug("Start Set Bindings: " .. button:GetName())
	
	local primaryKey,secondaryKey = GetBindingKey(button:GetName())
	
	if primaryKey then
	  --print("1st Key: " .. primaryKey .. " Set!")
      SetBindingClick(primaryKey,button:GetName())
    end
	
	if secondaryKey then
	  print("2nd Key: " .. secondaryKey .. " Set!")
      SetBindingClick(secondaryKey,button:GetName())
    end
	--BeStride_Debug:Debug("End Set Bindings")
end

function BeStride:SetKeyBindingsOverrides(button)
    --BeStride_Debug:Debug("Start Set Override Bindings: " .. button:GetName())
	ClearOverrideBindings(button)
	
	local primaryKey,secondaryKey = GetBindingKey(button:GetName())
	if primaryKey then
	  --print("1st Key: " .. primaryKey .. " Set!")
      SetOverrideBindingClick(button, true, primaryKey, button:GetName())
    end
	
	if secondaryKey then
	  --print("2nd Key: " .. secondaryKey .. " Set!")
      SetOverrideBindingClick(button, true, secondaryKey, button:GetName())
    end
	--BeStride_Debug:Debug("End Set Override Bindings")
end

function BeStride:ChatCommand(input)
	if input == "reload" then
		BeStride:buildMountTables()
	elseif input == "map" then
		BeStride:GetMaps()
	else
		BeStride_GUI:Frame(input)
	end
end

function BeStride:SpellToName(spellID)
	local name, rank, icon, castTime, minRange, maxRange, spellID = GetSpellInfo(spellID)
	
	return name
end

function BeStride:GetMaps()
	local locID = C_Map.GetBestMapForUnit("player")
	BeStride:GetMap(locID)
end

function BeStride:GetMap(locID)
	local map = C_Map.GetMapInfo(locID)
	
	print(locID .. ":" .. map["name"] .. ":" .. map["mapType"])
	
	if map["mapType"] ~= 0 then
		BeStride:GetMap(map["parentMapID"])
	end
end

function BeStride:DBGetMount(mountType,mountID)
	if self.db.profile.mounts[mountType][mountID] ~= nil then
		return self.db.profile.mounts[mountType][mountID]
	else
		
		self.db.profile.mounts[mountType][mountID] = true
		return self.db.profile.mounts[mountType][mountID]
	end
end

function BeStride:DBSetMount(mountType,mountID,value)
	self.db.profile.mounts[mountType][mountID] = value
end

function BeStride:DBGetSetting(parent,setting)
	if parent and self.db.profile.settings[parent] ~= nil and self.db.profile.settings[parent][setting] ~= nil then
		return self.db.profile.settings[parent][setting]
	elseif self.db.profile.settings[setting] ~= nil then
		return self.db.profile.settings[setting]
	else
		return nil
	end
end

function BeStride:DBSetSetting(parent,setting, value)
	if parent and self.db.profile.settings[parent] ~= nil then
		self.db.profile.settings[parent][setting] = value
	elseif self.db.profile.settings[setting] ~= nil then
		self.db.profile.settings[setting] = value
	end
end

function BeStride:DBGetClassSetting(parent,setting)
	if parent and self.db.profile.settings.classes[parent] ~= nil and self.db.profile.settings.classes[parent][setting] ~= nil then
		return self.db.profile.settings.classes[parent][setting]
	else
		return nil
	end
end

function BeStride:DBSetClassSetting(parent,setting, value)
	if parent and self.db.profile.settings.classes[parent] ~= nil then
		self.db.profile.settings.classes[parent][setting] = value
	end
end

function BeStride:buildMountTables()
	BeStride:BuildMasterMountTable()
	BeStride:LoadMountTables()
end

function BeStride:BuildMasterMountTable()
	for key,value in pairs(C_MountJournal.GetMountIDs()) do
		local name,spellID,icon,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,faction,shouldHideOnChar,isCollected,mountID = C_MountJournal.GetMountInfoByID(value)
		
		if isCollected then
			BeStride:AddNewMount(value)
		end
	end
end



function BeStride:AddNewMount(mountId)
	local name,spellID,icon,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,faction,shouldHideOnChar,isCollected,mountID = C_MountJournal.GetMountInfoByID(mountId)
	local creatureDisplayInfoID,description,source,isSelfMount,mountTypeID,uiModelSceneID = C_MountJournal.GetMountInfoExtraByID(mountId)
			
	if isFactionSpecific then
		faction = faction
	else
		faction = nil
	end

	mountTable["master"][mountId] = {
		["name"] = name,
		["spellID"] = spellID,
		["mountID"] = mountID,
		["factionLocked"] = isFactionSpecific,
		["faction"] = faction,
		["description"] = description,
		["isActive"] = isActive,
		["isUsable"] = isUsable,
		["isCollected"] = isCollected,
		["icon"] = icon,
		["source"] = source,
		["sourceType"] = sourceType,
		["type"] = mountTypes[mountTypeID],
	}
end

function BeStride:LoadMountTables()
	mountTable["ground"] = {}
	mountTable["flying"] = {}
	mountTable["swimming"] = {}
	mountTable["passenger"] = {}
	mountTable["repair"] = {}
	for key,value in pairs(mountTable["master"]) do
		if value["faction"] == nil or value["faction"] == playerTable["faction"]["id"] then
			--if value["faction"] then
				--print("Adding Mount: " .. value["name"] .. " Id: " .. key .. " Type: " .. value["type"] .. " Faction: " .. value["faction"] .. " Player Faction: " .. playerTable["faction"]["id"] .. " SID: " .. value["spellID"] .. " MID: " .. value["mountID"])
			--end
			BeStride:AddCommonMount(key)
			BeStride:AddPassengerMount(key)
			BeStride:AddRepairMount(key)
		end
	end
end

function BeStride:AddCommonMount(mountId)
	local mount = mountTable["master"][mountId]
	--print("Adding Mount: " .. mount["name"] .. " Id: " .. mountId .. " Type: " .. mount["type"])
	if mount["type"] == "ground" then
		table.insert(mountTable["ground"],mountId)
	elseif mount["type"] == "flying" then
		table.insert(mountTable["flying"],mountId)
	elseif mount["type"] == "swimming" then
		table.insert(mountTable["swimming"],mountId)
	elseif mount["type"] == "zone" then
		table.insert(mountTable["zone"],mountId)
	end
end

function BeStride:AddPassengerMount(mountId)
	if mountData[mountTable["master"][mountId]["spellID"]] ~= nil and mountData[mountTable["master"][mountId]["spellID"]]["type"] == "passenger" then
		--print("Adding Mount: " .. mountTable["master"][mountId]["name"] .. " Type: " .. mountTable["master"][mountId]["type"])
		table.insert(mountTable["passenger"],mountId)
	end
end

function BeStride:AddRepairMount(mountId)
	if mountData[mountTable["master"][mountId]["spellID"]] ~= nil and mountData[mountTable["master"][mountId]["spellID"]]["repair"] then
		--print("Adding Mount: " .. mountTable["master"][mountId]["name"] .. " Type: " .. mountTable["master"][mountId]["type"])
		table.insert(mountTable["repair"],mountId)
	end
end

function BeStride:GetMapUntil(locID,filter)
	local map = C_Map.GetMapInfo(locID)
	--BeStride_Debug:Debug(locID .. ":" .. map["name"] .. ":" .. map["mapType"] .. ":" .. map["parentMapID"] .. ":" .. filter)
	if map["mapType"] ~= filter and map["mapType"] > filter then
		return BeStride:GetMapUntil(map["parentMapID"],filter)
	else
		return map
	end
end