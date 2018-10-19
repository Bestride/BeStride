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
			migrated = false,
			bindingsMigrated = false,
			mount = {
				emptyrandom = true, --ER
				hasmount = false, --HM
				enablenew = false, --ENABLENEW
				useflyingmount = false,
				forceflyingmount = false, --FFM
				nodismountwhileflying = false, --NDWF
				flyingbroom = false,
				telaari = true,
				repair = {
					use = false,
					force = false,
					durability = 20,
				},
			},
			classes = {
				deathknight = {
					wraithwalk = true,
				},
				druid = {
					flightform = true,
					traveltotravel = false,
					flightformpriority = false,
					mountedtoflightform = false,
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
	
	print("Faction: " .. factionId)
end

function BeStride:OnEnable()
	BeStride:buildMountTables()
	
	self:RegisterEvent("UPDATE_BINDINGS", "UpdateBindings")
	self:RegisterEvent("NEW_MOUNT_ADDED", "NewMount")
	
	BeStride:RegisterEvent("PLAYER_REGEN_DISABLED", "CombatEnter")
	BeStride:RegisterEvent("PLAYER_REGEN_ENABLED", "CombatExit")
	
	--BeStride:UpdateBindings()
	BeStride:Upgrade()
end

function BeStride:NewMount(...)
	BeStride_Debug:Debug("NewMount")
	table.foreach(args,function (k,v) print("Arg: " .. k) end)
end

function BeStride:CombatEnter()
	BeStride_Debug:Verbose("Entering Combat")
	local combatButton = BeStride_Logic:Combat()
	
	if combatButton ~= nil then
		BeStride_Debug:Verbose("Mount: " .. combatButton)
		BeStride_ABRegularMount:SetAttribute("macrotext",combatButton)
		BeStride_ABGroundMount:SetAttribute("macrotext",combatButton)
		BeStride_ABPassengerMount:SetAttribute("macrotext",combatButton)
		BeStride_ABRepairMount:SetAttribute("macrotext",combatButton)
	end
end

function BeStride:CombatExit()
	BeStride_Debug:Verbose("Exiting Combat")
	BeStride_ABRegularMount:SetAttribute("macrotext",nil)
	BeStride_ABGroundMount:SetAttribute("macrotext",nil)
	BeStride_ABPassengerMount:SetAttribute("macrotext",nil)
	BeStride_ABRepairMount:SetAttribute("macrotext",nil)
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
	
	--if self.db.profile.settings.bindingsMigrated == false then
		table.foreach({BeStride_ABRegularMount,BeStride_ABGroundMount,BeStride_ABPassengerMount,BeStride_ABRepairMount},function (key,button)
			BeStride_Debug:Debug("Start Set Bindings: " .. button:GetName())
			local primaryKey,secondaryKey = GetBindingKey(button:GetName())
			if primaryKey then
				SetBindingClick(primaryKey,button:GetName())
			end
		
			if secondaryKey then
				SetBindingClick(secondaryKey,button:GetName())
			end
			BeStride_Debug:Debug("End Set Bindings")
		end)
	--end
	--self.db.profile.settings.bindingsMigrated = true
	
	if db.profile.settings and self.db.profile.settings.migrated == false then
		print("Old Settings Exist, Upgrading")
		
		table.foreach(db.profile.settings,function (key,value)
			if key == "HM" then
				self.db.profile.settings.mount.hasmount = value
			elseif key == "ER" then
				self.db.profile.settings.mount.emptyrandom = value
			elseif key == "FBP" then
				self.db.profile.settings.mount.flyingbroom = value
			elseif key == "TTT" then
				self.db.profile.settings.mount.druid.traveltotravel = value
			elseif key == "MTFF" then
				self.db.profile.settings.mount.druid.mountedtoflightform = value
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
					if mountData[mountTable.master[mountID].spellID] and mountData[mountTable.master[mountID].spellID].type == "zone" then
						self.db.profile.mounts[mountType][mountID] = status
					end
				end
			end
		end)
	end
	
	self.db.profile.settings.migrated = true
end

function BeStride:SetKeyBindings(button)
    BeStride_Debug:Debug("Start Set Bindings: " .. button:GetName())
	
	local primaryKey,secondaryKey = GetBindingKey("CLICK " .. button:GetName() .. ":LeftButton")
	
	if primaryKey then
	  print("1st Key: " .. primaryKey .. " Set!")
      SetBindingClick(primaryKey,button:GetName())
    end
	
	if secondaryKey then
	  print("2nd Key: " .. secondaryKey .. " Set!")
      SetBindingClick(secondaryKey,button:GetName())
    end
	BeStride_Debug:Debug("End Set Bindings")
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
	elseif input == "testpathwalk" then
		print("Path: settings.mount.emptyrandom (" .. tostring(BeStride:DBGet("settings.emptyrandom")) ..")")
		BeStride:DBSet("settings.mount.emptyrandom",false)
		print("Path: settings.mount.emptyrandom (" .. tostring(BeStride:DBGet("settings.emptyrandom")) ..")")
		print("Path: settings.mount.repair.durability (" .. tostring(BeStride:DBGet("settings.repair.durability")) ..")")
		BeStride:DBSet("settings.mount.repair.durability",50)
		print("Path: settings.mount.repair.durability (" .. tostring(BeStride:DBGet("settings.repair.durability")) ..")")
		print("Path: settings.mount.repair.dura (" .. tostring(BeStride:DBGet("settings.repair.dura")) ..")")
		BeStride:DBSet("settings.mount.repair.dura",50)
		print("Path: settings.mount.repair.dura (" .. tostring(BeStride:DBGet("settings.repair.dura")) ..")")
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

function BeStride:DBGet(path,parent)
	local child,nextPath = strsplit(".",path,2)
	
	if child ~= nil and parent ~= nil and parent[child] ~= nil and nextPath == nil then
		return parent[child]
	elseif child ~= nil and parent ~= nil and parent[child] ~= nil and nextPath ~= nil then
		--BeStride_Debug:Debug("Return: BeStride:DBGet(" .. nextPath .. "parent[" .. child .. "]" .. ")")
		return BeStride:DBGet(nextPath,parent[child])
	elseif child ~= nil and parent == nil and nextPath == nil then
		--BeStride_Debug:Debug("Return: self.db.profile[child]:" .. tostring(self.db.profile[child]))
		return self.db.profile[child]
	elseif child ~= nil and parent == nil and nextPath ~= nil then
		if self.db.profile[child] ~= nil then
			--BeStride_Debug:Debug("Return: BeStride:DBGet(" .. nextPath .. ",self.db.profile[" .. child .. "]" .. ")")
			return BeStride:DBGet(nextPath,self.db.profile[child])
		else
			BeStride_Debug:Debug("Fatal: self.db.profile[child(" .. child .. ")] == nil")
			return nil
		end
	else
		BeStride_Debug:Debug("Fatal: Unmatch")
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
		
		self.db.profile.mounts[mountType][mountID] = true
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