local mountTable = {
	["master"] = {},
	["ground"] = {},
	["flying"] = {},
	["swimming"] = {},
	["repair"] = {},
	["passenger"] = {},
}

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

local function BeStride:BuildMasterMountTable()
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

local function BeStride:LoadMountTables()
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

local function BeStride:AddCommonMount(mountId)
	local mount = mountTable["master"][mountId]
	if mountTypes[mount["type"]] == "ground" then
		table.insert(mountTable["ground"],key)
	elseif mountTypes[mount["type"]] == "flying" then
		table.insert(mountTable["flying"],key)
	elseif mountTypes[mount["type"]] == "swimming" then
		table.insert(mountTable["swimming"],key)
	end
end

local function BeStride:AddPassengerMount(mountId)
	if mountData[mountId]["type"] == "passenger" then
		table.insert(mountTable["passenger"],mountId)
	end
end

local function BeStride:AddRepairMount()
	if mountData[mountId]["repair"] then
		table.insert(mountTable["repair"],mountId)
	end
end

local function BeStride:GetRidingSkill()
	
end

function BeStride:IsFlyableArea()
	local mapID = C_Map.GetBestMapForUnit(unitToken)
	local zone = BeStride:GetMapUntil(mapID,3)
	local continent = BeStride:GetMapUntil(mapID,2)
	
	-- Northrend Flying
	-- Mists Flying
	
	-- Draenor Flying
	if(( continent["name"] == "Draenor"  and not IsSpellKnown(191645)) then
		return false
	end
	
	-- Legion Flying
	if ( ( continent["name"] == "Broken Isles" and not IsSpellKnown(233368) ) then
		return false
	end
	
	-- Wintergrasp Flying
	if zone == "Wintergrasp" then 
		isFlyable = not BeStride:WGActive()
	end
end

local function BeStride:WGActive()
	return true
end

local function BeStride:GetMapUntil(locID,filter)
	local map = C_Map.GetMapInfo(locID)
	
	if map["mapType"] ~= filter then
		return BeStride:GetMap(map["parentMapID"])
	else
		return map
	end
end