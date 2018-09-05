BeStride_Logic = {}

local class = UnitClass("player")
local canRepair = false


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
	-- This Logic needs to be cleaned up more
	if IsMounted() and IsFlying() and BeStride_Logic:IsFlyable() then
		if BeStride_Logic:IsDruid() then
			if BeStride_Logic:DruidFlyingMTFF() then
				BeStride_Mount:DruidFlying()
			elseif BeStride_Logic:NoDismountWhileFlying() then
				BeStride_Mount:Regular()
			else
				Dismount()
				BeStride_Mount:Regular()
			end
		elseif BeStride_Logic:IsPriest() then
			if BeStride_Logic:PriestCanLevitate() then
				BeStride_Mount:Levitate()
			elseif BeStride_Logic:NoDismountWhileFlying() then
				BeStride_Mount:Regular()
			else
				Dismount()
				BeStride_Mount:Regular()
			end
		end
	-- Todo: Cleanup from here
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

-- Checks Player Speed
-- Returns: integer
function BeStride_Logic:SpeedCheck()
	return GetUnitSpeed("player")
end

function BeStride_Logic:IsFlyable()

end

-- +------------+ --
-- Special Checks --

-- Check whether we can dismount while flying
-- Returns: boolean
function BeStride_Logic:NoDismountWhileFlying()
	-- Todo: Bitwise Compare
	if self.db.profile.settings["nodismountwhileflying"] then
		return true
	else
		return false
	end
end

-- Check whether we force a repair mount
-- Returns: boolean
function BeStride_Logic:ForceRepair()
	if self.db.profile.settings["repair"]["force"] then
		return true
	else
		return false
	end
end

-- Checks whether we check to repair or not
-- Returns: boolean
function BeStride_Logic:UseRepair()
	if self.db.profile.settings["repair"]["use"] then
		return true
	else
		return false
	end
end

-- Get repair threshold
-- Returns: signed integer
function BeStride_Logic:GetRepairThreshold()
	if self.db.profile.settings["repair"]["durability"] then
		return self.db.profile.settings["repair"]["durability"]
	else
		return -1
	end
end

-- Check whether we can repair
-- Returns: boolean
function BeStride_Logic:CanRepair()
	if canRepair then
		return true
	end
	
	if BeStride_Mount:CountRepairMounts() > 0 then
	end
	
	return false
end

-- Check whether we need to repair
-- Returns: boolean
function BeStride_Logic:NeedToRepair()
	if BeStride_Logic:ForceRepair() then
		return true
	end
	
	if size(self.db.profile.misc.RepairMounts) > 0 and BeStride_Logic:UseRepair() then
		for i = 0, 17 do
			local current, maximum = GetInventoryItemDurability(i)
			if current ~= nil and maximum ~= nil and ( (current/maximum) <= BeStride_Logic:GetRepairThreshold() then
				return true
			end
		end
	end
	
	return false
end

-- +----------+ --
-- Class Checks --
-- +----------+ --

-- Check for Druid
function BeStride_Logic:IsDruid()
	if class["class"] == "DRUID" then
		return true
	else
		return false
	end
end

-- Check for Mage
function BeStride_Logic:IsMage()
	if class["class"] == "MAGE" then
		return true
	else
		return false
	end
end

-- Check for Priest
function BeStride_Logic:IsPriest()
	if class["class"] == "PRIEST" then
		return true
	else
		return false
	end
end

-- Check for Monk
function BeStride_Logic:IsMonk()
	if class["class"] == "MONK" then
		return true
	else
		return false
	end
end

-- Check for DeathKnight
function BeStride_Logic:IsDeathKnight()
end

-- +--------------------------+ --
-- Class Specific Spells Checks --
-- +--------------------------+ --
-- ------------ --
-- Druid Spells --
-- ------------ --

-- Check for Swim Form
-- Returns: boolean
function BeStride_Logic:DruidCanSwim()
end

-- Check for Travel Form
-- Returns: boolean
function BeStride_Logic:DruidCanTravel()
end

-- Check for Travel Form
-- Returns: boolean
function BeStride_Logic:DruidCanCat()
end

-- Check for Flight Form
-- Returns: boolean
function BeStride_Logic:DruidCanFly()
	if IsUsableSpell(783) then
		return true
	else
		return false
	end
end


-- +-------------------------+ --
-- Class Specific Mount Checks --
-- +-------------------------+ --

-- ----- --
-- Druid --
-- ----- --

-- Check for Flying, Mounted and Mount to Flight Form
-- Returns: boolean
function Bestride_Logic:DruidFlyingMTFF()
	-- Had a "GetUnitSpeed("player") ~= 0", unsure if we want to go with that
	-- Todo: Bitwise Compare
	if self.db.profile.settings["classes"]["druid"]["mountedtoflightform"] then
		return true
	else
		return false
	end
end