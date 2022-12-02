function BeStride:OnInitialize()
	self.configDialogs = {}
	self.db = LibStub("AceDB-3.0"):New("BeStrideDB", defaults, "Default")
	self:RegisterChatCommand("bestride","ChatCommand")
	self:RegisterChatCommand("br","ChatCommand")
	
	BeStride:OptionsTable()
	
	self.buttons = {
		["mount"] = nil,
		["ground"] = nil,
		["repair"] = nil,
		["passenger"] = nil,
	}
	
	self.buttons["regular"] = BeStride:CreateActionButton('Regular')
	self.buttons["ground"] = BeStride:CreateActionButton('Ground')
	self.buttons["repair"] = BeStride:CreateActionButton('Repair')
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
end

function BeStride:OnEnable()
	BeStride:Version_OnEnable()
	BeStride:buildMountTables()
	
	if BeStride_Game == "Mainline" then
		BeStride:RegisterEvent("NEW_MOUNT_ADDED", "EventNewMount")
	else
		BeStride:RegisterEvent("COMPANION_LEARNED", "EventNewMount")
	end
	
	BeStride:RegisterEvent("PLAYER_REGEN_DISABLED", "EventCombatEnter")
	BeStride:RegisterEvent("PLAYER_REGEN_ENABLED", "EventCombatExit")
	
	BeStride:Upgrade()
end

function BeStride:GetProfiles()
	local profiles = BeStride.db:GetProfiles()
	table.sort(profiles)
	return profiles
end

function BeStride:UpdateBindings()
	BeStride:SetKeyBindings(self.buttons["regular"])
	BeStride:SetKeyBindings(self.buttons["ground"])
	BeStride:SetKeyBindings(self.buttons["passenger"])
	BeStride:SetKeyBindings(self.buttons["repair"])
	
	SaveBindings(GetCurrentBindingSet())
end

function BeStride:UpdateOverrideBindings()
	BeStride:SetKeyBindingsOverrides(self.buttons["regular"])
	BeStride:SetKeyBindingsOverrides(self.buttons["ground"])
	BeStride:SetKeyBindingsOverrides(self.buttons["passenger"])
	BeStride:SetKeyBindingsOverrides(self.buttons["repair"])
	
	SaveBindings(GetCurrentBindingSet())
end

function BeStride:SetKeyBindings(button)
	local primaryKey,secondaryKey = GetBindingKey("CLICK " .. button:GetName() .. ":LeftButton")
	
	if primaryKey then
      SetBindingClick(primaryKey,button:GetName())
    end
	
	if secondaryKey then
      SetBindingClick(secondaryKey,button:GetName())
    end
end

function BeStride:SetKeyBindingsOverrides(button)
	ClearOverrideBindings(button)
	
	local primaryKey,secondaryKey = GetBindingKey(button:GetName())
	if primaryKey then
      SetOverrideBindingClick(button, true, primaryKey, button:GetName())
    end
	
	if secondaryKey then
      SetOverrideBindingClick(button, true, secondaryKey, button:GetName())
    end
end

function BeStride:ChatCommand(input)
	local command,args = strsplit(" ", input, 2)
	if command == "help" then
		print("/br - Open Main Configuration Dialog")
		print("/br about - Open about Dialog")
		print("/br help - This help")
		print("/br reload - Rebuild the mount table")
		print("/br map - Print the current map layers")
	elseif command == "locale" then
		local L = LibStub("AceLocale-3.0"):GetLocale("BeStride")
		print(L["Open.GUI"])
	elseif command == "speed" then
		print(BeStride:SpeedCheck())
	elseif command == "mountdb" then
		self:ListMountDB()
	elseif command == "mountsTable" then
		self:ListGameMounts()
	elseif command == "reload" then
		BeStride:buildMountTables()
	elseif command == "map" then
		local locID = C_Map.GetBestMapForUnit("player")
		print("mapID:name:mapType:parentMapID")
		local map = self:GetMapUntil(locID,0,true)
		print("Final: ")
		print(map.mapID .. ":" .. map.name .. ":" .. map.mapType .. ":" .. map.parentMapID)
	elseif command == "maplast" then
		local locID = C_Map.GetBestMapForUnit("player")
		print("mapID:name:mapType:parentMapID")
		local map = self:GetMapUntilLast(locID,0,true)
		print("Final: ")
		print(map.mapID .. ":" .. map.name .. ":" .. map.mapType .. ":" .. map.parentMapID)
	elseif command == "underwater" then
		BeStride:IsUnderwater()
	elseif command == "mountID" then
		mount = BeStride:GetMountInfoByMountID(args)
		print(mount.creatureName)
	elseif command == "spellID" then
		mount = BeStride:GetMountInfoBySpellID(args)
		print(mount.creatureName)
	elseif command == "mounts" then
		LibStub("AceConfigDialog-3.0"):Open("BeStride-Mounts")
	elseif command == "options" then
		if self.IsMainline() then
			InterfaceOptionsFrame_OpenToCategory(self.configDialogs.configuration.frame)
		else
			InterfaceOptionsFrame_OpenToCategory(self.configDialogs.options.frame)
			InterfaceOptionsFrame_OpenToCategory(self.configDialogs.options.frame)
		end
	elseif command == "profiles" then
		if self.IsMainline() then
			InterfaceOptionsFrame_OpenToCategory(self.configDialogs.configuration.frame)
		else
			InterfaceOptionsFrame_OpenToCategory(self.configDialogs.profiles.frame)
			InterfaceOptionsFrame_OpenToCategory(self.configDialogs.profiles.frame)
		end
	elseif command == "debug" or input == "bug" then
		LibStub("AceConfigDialog-3.0"):Open("BeStride-Debug")
	elseif command == "about" then
		LibStub("AceConfigDialog-3.0"):Open("BeStride")
	else
		print("/br - Open Main Configuration Dialog and print help")
		print("/br options - Open options Dialog")
		print("/br about - Open about Dialog")
		print("/br help - This help")
		print("/br reload - Rebuild the mount table")
		print("/br map - Print the current map layers")
		InterfaceOptionsFrame_OpenToCategory(self.configDialogs.profiles.frame)
		InterfaceOptionsFrame_OpenToCategory(self.configDialogs.profiles.frame)
		InterfaceOptionsFrame_OpenToCategory("BeStride")
	end
end

function BeStride:ListGameMounts()
	print("Mount (index):name:spellID:mountID:isActive")
	for i=1, GetNumCompanions("MOUNT") do
		local mountID,name,spellID,icon,isSummoned = GetCompanionInfo("MOUNT", i)
		print("Mount (" .. i .. "):" .. (name or "")..":"..(spellID or "")..":"..(mountID or "")..":"..tostring(isSummoned or ""))
	end
end

function BeStride:ListMountDB()
	print("Mount (mountID):name:spellID:mountID:isActive:faction:source:type")
	for key,value in pairs(mountTable["master"]) do
		print("Mount (" .. key .. "):" .. (value.name or "")..":"..(value.spellID or "")..":"..(value.mountID or "")..":"..tostring(value.isActive or "")..":"..tostring(value.faction or "")..":"..(value.source or "")..":"..(value.type or ""))
	end
end