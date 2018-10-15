BeStride = LibStub("AceAddon-3.0"):NewAddon("Bestride","AceConsole-3.0", "AceEvent-3.0")

debugLevel = 8

playerTable = {}

mountTable = {
	["master"] = {},
	["ground"] = {},
	["flying"] = {},
	["swimming"] = {},
	["repair"] = {},
	["passenger"] = {},
}

local defaults = {
	["version"] = version,
	
	profile = {
		settings = {
			["emptyrandom"] = true,
			["hasmount"] = false,
			["enablenew"] = false,
			["traveltotravel"] = false,
			["forceflyingmount"] = false,
			["nodismountwhileflying"] = false,
			["repair"] = {
				["use"] = false,
				["force"] = false,
				["durability"] = 0.2,
			},
			["priorities"] = {
				["flyingbroom"] = false,
				["repairmount"] = true,
				["telaari"] = true
			},
			["classes"] = {
				["deathknight"] = {
					["wraithwalk"] = true,
				},
				["druid"] = {
					["flightform"] = true,
					["flightformpriority"] = false,
					["mountedtoflightform"] = false,
				},
				["paladin"] = {
					["steed"] = true,
				},
				["shaman"] = {
					["ghostwolf"] = true,
				},
				["monk"] = {
					["roll"] = true,
					["zenflight"] = true,
				},
				["priest"] = {
					["levitate"] = true,
				},
				["mage"] = {
					["slowfall"] = true,
				},
			},
		},
		["mounts"] = {}
	}
}

function BeStride:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("BeStride", defaults, "Default")
	self:RegisterChatCommand("bestride","ChatCommand")
	self:RegisterChatCommand("br","ChatCommand")
	
	self.buttons = {
		["mount"] = nil,
		["ground"] = nil,
		["repair"] = nil,
		["passenger"] = nil,
	}
	
	self.buttons["mount"] = BeStride_ABMountMount
	self.buttons["ground"] = BeStride_ABGroundMount
	self.buttons["repair"] = BeStride_ABRepairMount
	self.buttons["passenger"] = BeStride_ABPassengerMount
	
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
	
	--BeStride_ABMountMount:SetAttribute("macrotext", "/script print('hello world')\n/use Azure Water Strider")
	
	--local b = CreateFrame("Button", "TestButton", UIParent, "SecureActionButtonTemplate,ActionButtonTemplate")
	--b:SetSize(64 ,64)
	--b:SetPoint("CENTER")
	--b:SetAttribute("type1", "macro")
	--b:SetAttribute("macrotext", "/script print('hello world')\n/use Azure Water Strider")
end

function BeStride:OnEnable()
	BeStride:buildMountTables()
	BeStride:SetBindings()
end

function BeStride:SetBindings()
    BeStride_Debug:Debug("Start Set Bindings")
	ClearOverrideBindings(BeStride_ABMountMount)
	local ABMountKey = GetBindingKey("BeStride_ABMountMount")
	if ABMountKey then
      SetOverrideBindingClick(BeStride_ABMountMount, true, ABMountKey, BeStride_ABMountMount:GetName())
    end
	
	ClearOverrideBindings(BeStride_ABGroundMount)
	local ABGroundKey = GetBindingKey("BeStride_ABGroundMount")
	if ABGroundKey then
      SetOverrideBindingClick(BeStride_ABGroundMount, true, ABGroundKey, BeStride_ABGroundMount:GetName())
    end
	
	ClearOverrideBindings(BeStride_ABRepairMount)
	local ABRepairKey = GetBindingKey("BeStride_ABRepairMount")
	if ABRepairKey then
      SetOverrideBindingClick(BeStride_ABRepairMount, true, ABRepairKey, BeStride_ABRepairMount:GetName())
    end
	
	ClearOverrideBindings(BeStride_ABPassengerMount)
	local ABPassengerKey = GetBindingKey("BeStride_ABPassengerMount")
	if ABRepaidKey then
      SetOverrideBindingClick(BeStride_ABPassengerMount, true, ABRepaidKey, BeStride_ABPassengerMount:GetName())
    end
	BeStride_Debug:Debug("End Set Bindings")
end

function BeStride:ChatCommand(input)
	if input == "reload" then
		BeStride:buildMountTables()
	elseif input == "enum" then
		local types = {}
		for key,value in pairs(C_MountJournal.GetMountIDs()) do
			local name,spellID,_,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,_,isCollected,mountId = C_MountJournal.GetMountInfoByID(value)
			local creatureDisplayInfoId,description,source,isSelfMount,mountTypeID,uiModelSceneID = C_MountJournal.GetMountInfoExtraByID(value)
			
			if mountTypes[mountTypeID] then
				types[mountTypeID] = mountTypes[mountTypeID]
			else
				types[mountTypeID] = mountTypeID
			end
			
			if isCollected == true then
				if mountTypes[mountTypeID] then
					self:Print("|" .. name .. "|" .. mountTypes[mountTypeID] .. "|")
				end
			end
		end
		
		for k,v in pairs(types) do
			self:Print("|" .. k .. "|" .. v .. "|")
		end
	elseif input == "map" then
		BeStride:GetMaps()
	elseif input == "dbtest" then
		BeStride:DBGetMount(2929)
	elseif input  == "factiontest" then
		local name,spellID,icon,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,faction,shouldHideOnChar,isCollected,mountID = C_MountJournal.GetMountInfoByID(61469)
		print(":" .. name .. ":" .. faction .. ":")
	elseif input == "mount" then
		-- BeStride_Logic:MountButton()
		self.buttons["mount"]:PreClick()
		self.buttons["mount"]:Click("left")
		self.buttons["mount"]:PostClick()
	else
		BeStride_GUI:Frame()
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

function BeStride:DBGetMount(mountID)
	if self.db.profile.mounts[mountID] ~= nil then
		return self.db.profile.mounts[mountID]
	else
		--BeStride_Debug:Debug("MountID: " .. mountID)
		self.db.profile.mounts[mountID] = true
		return self.db.profile.mounts[mountID]
	end
end

function BeStride:DBSetMount(mountID,value)
	self.db.profile.mounts[mountID] = value
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
		--if not value["isUsable"] then
			--print("Adding Mount: " .. value["name"] .. " Id: " .. key .. " Type: " .. value["type"] .. " Faction: " .. value["faction"])
		--end
		
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