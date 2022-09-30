BeStride = LibStub("AceAddon-3.0"):NewAddon("Bestride","AceConsole-3.0", "AceEvent-3.0")

debugLevel = 8

function sortTable(unsortedTable)
	keys = {}
	sortedTable = {}
	for key in pairs(unsortedTable) do table.insert(keys,key) end
	table.sort(keys)
	for _,key in ipairs(keys) do sortedTable[key] = unsortedTable[key] end
	return sortedTable
end

function searchTableForValue(haystack,needle)
	for k,v in pairs(haystack) do
		if v == needle then
			return k
		end
	end
	
	return nil
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

function countTable(t)
	assert(type(t) == 'table', 'bad parameter #1: must be table')
	local count = 0
	for k, v in pairs(t) do
		count = count + 1
	end
	
	return count
end

function BeStride:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("BeStrideDB", defaults, "Default")
	self:RegisterChatCommand("bestride","ChatCommand")
	self:RegisterChatCommand("br","ChatCommand")
	
	local bestrideOptions = LibStub("AceConfigRegistry-3.0")
	bestrideOptions:RegisterOptionsTable("BeStride",BeStride_Options)
	self.bestrideOptionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("BeStride","BeStride")
	
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

function BeStride:Frame()
	BeStride_GUI:Frame()
end

function BeStride:OnEnable()
	BeStride:buildMountTables()
	
	--BeStride:RegisterEvent("NEW_MOUNT_ADDED", "EventNewMount")
	
	BeStride:RegisterEvent("PLAYER_REGEN_DISABLED", "EventCombatEnter")
	BeStride:RegisterEvent("PLAYER_REGEN_ENABLED", "EventCombatExit")
	
	BeStride:Upgrade()
end

function BeStride:GetProfiles()
	local profiles = BeStride.db:GetProfiles()
	table.sort(profiles)
	return profiles
end

function BeStride:NewMount(...)
	--BeStride_Debug:Debug("NewMount")
	table.foreach(args,function (k,v) print("Arg: " .. k) end)
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


function BeStride:Upgrade()
	local db = LibStub("AceDB-3.0"):New("BestrideDB")
	
	local mountButtons = {
		BRMOUNT = BeStride_ABRegularMount,
		BRFORCEGROUND = BeStride_ABGroundMount,
		BRFORCEPASSENGER = BeStride_ABPassengerMount,
		BRFORCEREPAIR = BeStride_ABRepairMount
	}
	
	if self.db.profile.settings.ymBindingsMigrated == false then
		table.foreach(mountButtons,function (binding,button)
			local primaryKey,secondaryKey = GetBindingKey(binding)
			if primaryKey then
				SetBindingClick(primaryKey,button:GetName())
			end
		
			if secondaryKey then
				SetBindingClick(secondaryKey,button:GetName())
			end
		end)
	end
	if self.db.profile.settings.bindingsMigrated == false then
		table.foreach({BeStride_ABRegularMount,BeStride_ABGroundMount,BeStride_ABPassengerMount,BeStride_ABRepairMount},function (key,button)
			local primaryKey,secondaryKey = GetBindingKey(button:GetName())
			if primaryKey then
				SetBindingClick(primaryKey,button:GetName())
			end
		
			if secondaryKey then
				SetBindingClick(secondaryKey,button:GetName())
			end
		end)
	end
	self.db.profile.settings.bindingsMigrated = true
	self.db.profile.settings.ymBindingsMigrated = true
	
	if db.profile.settings and self.db.profile.settings.migrated == false then
		table.foreach(db.profile.settings,function (key,value)
			if key == "HM" then
				self.db.profile.settings.mount.hasmount = value
			elseif key == "ER" then
				self.db.profile.settings.mount.emptyrandom = value
			elseif key == "FBP" then
				self.db.profile.settings.mount.flyingbroom = value
			elseif key == "TTT" then
				self.db.profile.settings.classes.druid.traveltotravel = value
			elseif key == "MTFF" then
				self.db.profile.settings.classes.druid.mountedtoflightform = value
			elseif key == "NDWF" then
				self.db.profile.settings.mount.nodismountwhileflying = value
			elseif key == "FFM" then
				self.db.profile.settings.mount.useflyingmount = value
			elseif key == "URM" then
				self.db.profile.settings.mount.repair.use = value
			elseif key == "ENABLENEW" then
				self.db.profile.settings.mount.enablenew = value
			elseif key == "TELAARI" then
				self.db.profile.settings.mount.telaari = value
			elseif key == "DEATHKNIGHT" then
				self.db.profile.settings.classes.deathknight.wraithwalk = value
			elseif key == "PALADIN" then
				self.db.profile.settings.classes.paladin.steed = value
			elseif key == "SHAMAN" then
				self.db.profile.settings.classes.shaman.ghostwolf = value
			elseif key == "MONK" then
				self.db.profile.settings.classes.monk.roll = value
			elseif key == "MONKZENUSE" then
				self.db.profile.settings.classes.monk.zenflight = value
			elseif key == "ROGUE" then
				self.db.profile.settings.classes.rogue.sprint = value
			elseif key == "PRIEST" then
				self.db.profile.settings.classes.levitate = value
			elseif key == "MAGE" then
				self.db.profile.settings.classes.mage.slowfall = value
				self.db.profile.settings.classes.mage.blink = value
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
					if BeStride_Constants.Mount.Mounts[mountTable.master[mountID].spellID] and BeStride_Constants.Mount.Mounts[mountTable.master[mountID].spellID].type == "zone" then
						self.db.profile.mounts[mountType][mountID] = status
					end
				end
			end
		end)
	end
	
	self.db.profile.settings.migrated = true
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
	if input == "reload" then
		BeStride:buildMountTables()
	elseif input == "map" then
		local locID = C_Map.GetBestMapForUnit("player")
		print("mapID:name:mapType:parentMapID")
		local map = self:GetMapUntil(locID,0,true)
		print("Final: ")
		print(map.mapID .. ":" .. map.name .. ":" .. map.mapType .. ":" .. map.parentMapID)
	elseif input == "maplast" then
		local locID = C_Map.GetBestMapForUnit("player")
		print("mapID:name:mapType:parentMapID")
		local map = self:GetMapUntilLast(locID,0,true)
		print("Final: ")
		print(map.mapID .. ":" .. map.name .. ":" .. map.mapType .. ":" .. map.parentMapID)
	elseif input == "underwater" then
		BeStride_Logic:IsUnderwater()
	elseif input == "bug" then
		BeStride_GUI:BugReport()
	elseif input == "depth" then
		BeStride_GUI:DebugTable({},0)
	else
		BeStride_GUI:Frame(input)
	end
end

function BeStride:SpellToName(spellID)
	local name, rank, icon, castTime, minRange, maxRange, spellID = GetSpellInfo(spellID)
	
	return name
end

function BeStride:DBGet(path,parent)
	local child,nextPath = strsplit(".",path,2)
	
	if child ~= nil and parent ~= nil and parent[child] ~= nil and nextPath == nil then
		return parent[child]
	elseif child ~= nil and parent ~= nil and parent[child] ~= nil and nextPath ~= nil then
		return BeStride:DBGet(nextPath,parent[child])
	elseif child ~= nil and parent == nil and nextPath == nil then
		return self.db.profile[child]
	elseif child ~= nil and parent == nil and nextPath ~= nil then
		if self.db.profile[child] ~= nil then
			return BeStride:DBGet(nextPath,self.db.profile[child])
		else
			BeStride_Debug:Debug("Fatal: self.db.profile[child(" .. child .. ")] == nil")
			return nil
		end
	else
		BeStride_Debug:Debug("Fatal: Unmatch (" .. path .. ")")
		return nil
	end
end

function BeStride:DBSet(path,value,parent)
	local child,nextPath = strsplit(".",path,2)
	
	if child ~= nil and parent ~= nil and nextPath == nil then
		parent[child] = value
	elseif child ~= nil and parent ~= nil and parent[child] == nil and nextPath ~= nil then
		parent[child] = {}
		BeStride:DBSet(nextPath,value,parent[child])
	elseif child ~= nil and parent ~= nil and parent[child] ~= nil and nextPath ~= nil then
		BeStride:DBSet(nextPath,value,parent[child])
	elseif child ~= nil and parent == nil and nextPath == nil then
		self.db.profile[child] = value
	elseif child ~= nil and parent == nil and nextPath ~= nil then
		if self.db.profile[child] == nil then
			self.db.profile[child] = {}
		end
		BeStride:DBSet(nextPath,value,self.db.profile[child])
	end
end

function BeStride:DBGetMount(mountType,mountID)
	if self.db.profile.mounts[mountType][mountID] ~= nil then
		return self.db.profile.mounts[mountType][mountID]
	else
		if self.db.profile.settings.mount.enablenew ~= nil and self.db.profile.settings.mount.enablenew == true then
			self.db.profile.mounts[mountType][mountID] = true
		else
			self.db.profile.mounts[mountType][mountID] = true
		end
		return self.db.profile.mounts[mountType][mountID]
	end
end

function BeStride:DBSetMount(mountType,mountID,value)
	self.db.profile.mounts[mountType][mountID] = value
end

function BeStride:DBGetSetting(setting)
	return self:DBGet("settings." .. setting)
end

function BeStride:DBSetSetting(setting, value)
	return self:DBSet("settings." .. setting,value)
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
		if mountId == 373 then
			table.insert(mountTable["swimming"],mountId)
		end
		table.insert(mountTable["zone"],mountId)
	end
end

function BeStride:AddPassengerMount(mountId)
	if BeStride_Constants.Mount.Mounts[mountTable["master"][mountId]["spellID"]] ~= nil and BeStride_Constants.Mount.Mounts[mountTable["master"][mountId]["spellID"]]["type"] == "passenger" then
		table.insert(mountTable["passenger"],mountId)
	end
end

function BeStride:AddRepairMount(mountId)
	if BeStride_Constants.Mount.Mounts[mountTable["master"][mountId]["spellID"]] ~= nil and BeStride_Constants.Mount.Mounts[mountTable["master"][mountId]["spellID"]]["repair"] then
		table.insert(mountTable["repair"],mountId)
	end
end

function BeStride:ItemToName(itemID)
	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent = GetItemInfo(itemID)
	
	return itemName
end

