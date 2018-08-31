BeStride_Logic = {}

function BeStride:Mount(flags)
	
end

function BeStride:buildMountTables()
	BeStride:BuildMasterMountTable()
	BeStride:LoadMountTables()
end

function BeStride:AddNewMount(mountId)
	local name,spellID,_,_,_,_,_,isFactionSpecific,faction,isCollected,_ = C_MountJournal.GetMountInfoByID(value)
	local _,description,_,_,mountTypeID,_ = C_MountJournal.GetMountInfoExtraByID(value)
			
	if isFactionSpecific then
		faction = faction
	else
		faction = ""
	end

	mountTable["master"][mountId] = {
		["name"] = name,
		["spellID"] = spellID,
		["factionLocked"] = isFactionSpecific,
		["faction"] = faction,
		["description"] = description,
		["type"] = mountTypes[mountTypeID],
	}
	
	
end

function BeStride:BuildMasterMountTable()
	for key,value in pairs(C_MountJournal.GetMountIDs()) do
		local name,spellID,_,_,_,_,_,isFactionSpecific,faction,isCollected,_ = C_MountJournal.GetMountInfoByID(value)
		
		if isCollected then
			local _,description,_,_,mountTypeID,_ = C_MountJournal.GetMountInfoExtraByID(value)
			
			if isFactionSpecific then
				faction = faction
			else
				faction = ""
			end
			
			mountTable["master"][mountId] = {
				["name"] = name,
				["spellID"] = spellID,
				["factionLocked"] = isFactionSpecific,
				["faction"] = faction,
				["description"] = description,
				["type"] = mountTypes[mountTypeID],
			}
		end
	end
end

function BeStride:LoadMountTables()
	mountTable["ground"] = {}
	mountTable["flying"] = {}
	mountTable["swimming"] = {}
	mountTable["passenger"] = {}
	mountTable["repair"] = {}
	for key,value in pairs(mountTable["master"]) do
		BeStride:AddCommonMount(key)
		BeStride:AddPassengerMount(key)
		BeStride:AddRepairMount(key)
	end
end

function BeStride:AddCommonMount(mountId)
	local mount = mountTable["master"][mountId]
	if mountTypes[mount["type"]] == "ground" then
		table.insert(mountTable["ground"],key)
	elseif mountTypes[mount["type"]] == "flying" then
		table.insert(mountTable["flying"],key)
	elseif mountTypes[mount["type"]] == "swimming" then
		table.insert(mountTable["swimming"],key)
	end
end

function BeStride:AddPassengerMount(mountId)
	if mountData[mountId]["type"] == "passenger" then
		table.insert(mountTable["passenger"],mountId)
	end
end

function BeStride:AddRepairMount()
	if mountData[mountId]["repair"] then
		table.insert(mountTable["repair"],mountId)
	end
end

function BeStride:GetRidingSkill()
	
end

function BeStride:IsFlyableArea()
	local mapID = C_Map.GetBestMapForUnit(unitToken)
	local zone = BeStride:GetMapUntil(mapID,3)
	local continent = BeStride:GetMapUntil(mapID,2)
	
	-- Northrend Flying
	-- Mists Flying
	
	-- Draenor Flying
	if ( continent["name"] == "Draenor"  and not IsSpellKnown(191645)) then
		return false
	end
	
	-- Legion Flying
	if ( continent["name"] == "Broken Isles" and not IsSpellKnown(233368) ) then
		return false
	end
	
	-- Wintergrasp Flying
	if zone == "Wintergrasp" then 
		isFlyable = not BeStride:WGActive()
	end
end

function BeStride:WGActive()
	return true
end

function BeStride:GetMapUntil(locID,filter)
	local map = C_Map.GetMapInfo(locID)
	
	if map["mapType"] ~= filter then
		return BeStride:GetMap(map["parentMapID"])
	else
		return map
	end
end

function BeStride_Logic:MountButton()
	local loanedMount = Bestride:CheckLoanerMount()
	local isFlyable = BeStride:IsFlyableArea()
	local class = UnitClass("player")
	
	-- Dismount Logic
	-- This Logic needs to be cleaned up
	if IsMounted() and IsFlying() and isFlyable then
		if class["class"] == "DRUID" then
			if self.db.settings["classes"]["druid"]["mountedtoflightform"] and GetUnitSpeed("player") ~= 0 then
				BeStride_Logic:DruidFlying()
			elseif self.db.settings["nodismountwhileflying"] then
				BeStride_Logic:RegularMount()
			else
				Dismount()
				BeStride_Logic:RegularMount()
			end
		elseif class["class"] == "PRIEST" then
			if self.db.settings["classes"]["priest"]["levitate"] then
				BeStride_Logic:Levitate()
			elseif self.db.settings["nodismountwhileflying"] then
				BeStride_Logic:RegularMount()
			else
				Dismount()
				BeStride_Logic:RegularMount()
			end
		end
	elseif IsMounted() then
		if IsSwimming() and class == "DRUID" and IsUsableSpell(783) and GetUnitSpeed("player") ~= 0 then -- Todo: Clean this logic up
			BeStride_Logic:DruidAuquaticForm()
		elseif IsSwimming() then
			BeStride_Logic:SwimmingMount()
		else
			Dismount()
			BeStride_Logic:RegularMount()
		end
	elseif CanExitVehicle() then
		VehicleExit()
		BeStride_Logic:SetRegularMount()
	elseif BestrideState.class == "MONK" and isFlyable and BeStride:MonkSpecial() then
		BeStride_Logic:MonkSpecial()
	elseif BeStride_Logic:PriestOrMageSpecial() then
		BeStride_Logic:PriestOrMageSpecial()
	elseif BeStride_Logic:ClassCheck() or BeStride_Logic:PriestOrMageSpecial() then
		BeStride_Logic:ClassSpecial()
	elseif isFlyable and IsOutdoors() then
		if BeStride_Logic:canBroom() then
			BeStride_Logic:Broom()
		elseif IsSwimming() then
			BeStride_Logic:SwimmingMount()
		elseif class == "DRUID" then
			BeStride_Logic:Druid()
		else
			BeStride_Logic:FlyingMount()
		end
	elseif not isFlyable and IsOutdoors() then
		if zone == BestrideLocale.Zone.Oculus and Bestride:Filter(nil, zone) then
		elseif BeStride_Logic:canBroom() then
			BeStride_Logic:Broom()
		elseif IsSwimming() then
			BeStride_Logic:SwimmingMount()
		elseif loanedMount then
			BeStride_Logic:LoanedMount()
		elseif class == "DRUID" then
			BeStride_Logic:Druid()
		end
	elseif not IsOutdoors() then
		if IsSwimming() then
			Bestride_Logic:SwimmingMount()
		elseif class == "DRUID" then
			BeStride_Logic:Druid()
		end
	else
		BeStride_Logic:Mount()
	end
end

function BeStride_Logic:DruidAuquaticForm()
end

function BeStride_Logic:Levitate()
end

function BeStride_Logic:RegularMount()
end

function BeStride_Logic:SetButton(text,button)
	if not BeStride_Logic:CheckCombat() then
		if text and button == "FORCEGROUND" then
			BeStrideButtonGround:SetAttribute("macrotext","/use " .. text)
		elseif text and button = "FORCEPASSENGER" then
			BeStrideButtonPassenger:SetAttribute("macrotext","/use " .. text)
		elseif text and button = "FORCEREPAIR" then
			BeStrideButtonRepair:SetAttribute("macrotext","/use " .. text)
		elseif text then
			BeStrideButton:SetAttribute("macrotext","/use " .. text)
		else
			BestrideButtonMount:SetAttribute("macrotext", nil)
		end
	end
end