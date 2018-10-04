BeStride_Logic = {}

local class = UnitClass("player")
local canRepair = false


function BeStride:Mount(flags)
	
end

function BeStride_Logic:IsCombat()
	if InCombatLockdown() then
		return true
	else
		return false
	end
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
			print("Adding Mount: " .. name .. " Id: " .. value)
			mountTable["master"][value] = {
				["name"] = name,
				["spellID"] = spellID,
				["factionLocked"] = isFactionSpecific,
				["faction"] = faction,
				["description"] = description,
				["type"] = mountTypes[mountTypeID],
			}
			if mountTypes[mountTypeID] == "flying" then
			    break
			end
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
	if mount["type"] == "ground" then
		table.insert(mountTable["ground"],mountId)
	elseif mount["type"] == "flying" then
		table.insert(mountTable["ground"],mountId)
		table.insert(mountTable["flying"],mountId)
	elseif mount["type"] == "swimming" then
		table.insert(mountTable["swimming"],mountId)
	end
end

function BeStride:AddPassengerMount(mountId)
	if mountData[mountId] ~= nil and mountData[mountId]["type"] == "passenger" then
		table.insert(mountTable["passenger"],mountId)
	end
end

function BeStride:AddRepairMount(mountId)
	if mountData[mountId] ~= nil and mountData[mountId]["repair"] then
		table.insert(mountTable["repair"],mountId)
	end
end

function BeStride:GetRidingSkill()
	
end

function BeStride:WGActive()
	return true
end

function BeStride:GetMapUntil(locID,filter)
	local map = C_Map.GetMapInfo(locID)
	BeStride_Debug:Debug(locID .. ":" .. map["name"] .. ":" .. map["mapType"] .. ":" .. map["parentMapID"] .. ":" .. filter)
	if map["mapType"] ~= filter then
		return BeStride:GetMapUntil(map["parentMapID"],filter)
	else
		return map
	end
end

function BeStride_Logic:MountButton()
	local class = UnitClass("player")
	
	-- Dismount Logic
	-- This Logic needs to be cleaned up more
	--BeStride_Debug:Debug("Starting Mount Logic")
	if IsMounted() and IsFlying() and BeStride_Logic:IsFlyable() then
		--BeStride_Debug:Debug("Mounted, Flying, Flyable")
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
				BeStride_Mount:PriestLevitate()
			elseif BeStride_Logic:NoDismountWhileFlying() then
				BeStride_Mount:Regular()
			else
				Dismount()
				BeStride_Mount:Regular()
			end
		end
		--BeStride_Debug:Debug("End Mounted, Flying, Flyable")
	-- Todo: Cleanup from here
	elseif IsMounted() then
		--BeStride_Debug:Debug("Mounted")
		if IsSwimming() and Bestride_Logic:IsDruid() and BeStride_Logic:DruidCanSwim() and BeStride_Logic:MovementCheck() then -- Todo: Clean this logic up
			BeStride_Mount:DruidAuquaticForm()
		elseif IsSwimming() then
			BeStride_Mount:Swimming()
		else
			Dismount()
			BeStride_Mount:Regular()
		end
		--BeStride_Debug:Debug("Ending Mounted")
	elseif CanExitVehicle() then
		--BeStride_Debug:Debug("CanExitVehicle")
		VehicleExit()
		BeStride_Mount:Regular()
		--BeStride_Debug:Debug("Ending CanExitVehicle")
	elseif BeStride_Logic:IsMonk() and BeStride_Logic:IsFlyable() and BeStride:MonkCanZen() then
		--BeStride_Debug:Debug("IsMonk,IsFlyable,CanZen")
		BeStride_Mount:MonkZen()
		--BeStride_Debug:Debug("End IsMonk,IsFlyable,CanZen")
	elseif BeStride_Logic:IsPriest() and BeStride_Logic:PriestCanLevitate() and ( BeStride_Logic:IsFalling() or BeStride_Logic:MovementCheck() ) then
		BeStride_Debug:Debug("IsPriest, CanLevitate, IsFalling, MovementCheck")
		BeStride_Mount:PriestLevitate()
		--BeStride_Debug:Debug("End IsPriest, CanLevitate, IsFalling, MovementCheck")
	elseif BeStride_Logic:IsMage() and BeStride_Logic:CanSlowFall() and ( BeStride_Logic:IsFalling() or BeStride_Logic:MovementCheck() ) then
		--BeStride_Debug:Debug("IsMage, CanLevitate, IsFalling, MovementCheck")
		BeStride_Mount:MageSlowFall()
		--BeStride_Debug:Debug("IsMage, CanLevitate, IsFalling, MovementCheck")
	elseif BeStride_Logic:IsFlyable() and IsOutdoors() then
		BeStride_Debug:Debug("IsFlyable, IsOutdoors")
		if BeStride_Logic:CanBroom() then
			BeStride_Debug:Debug("--Broom")
			BeStride_Mount:Broom()
		elseif IsSwimming() then
			BeStride_Debug:Debug("--Swimming")
			BeStride_Mount:Swimming()
		elseif BeStride_Logic:IsDruid() then
			BeStride_Debug:Debug("--Druid")
			BeStride_Mount:DruidFlying()
		else
			BeStride_Debug:Debug("--Flying")
			BeStride_Mount:Flying()
		end
		--BeStride_Debug:Debug("End IsFlyable, IsOutdoors")
	elseif not BeStride_Logic:IsFlyable() and IsOutdoors() then
		BeStride_Debug:Debug("Not IsFlyable, IsOutdoors")
		if zone == BeStride_Locale.Zone.Oculus and Bestride:Filter(nil, zone) then
		elseif BeStride_Logic:CanBroom() then
			BeStride_Debug:Debug("--Broom")
			BeStride_Mount:Broom()
		elseif IsSwimming() then
			BeStride_Debug:Debug("--Swimming")
			BeStride_Mount:Swimming()
		elseif BeStride_Logic:HasLoanedMount() then
			BeStride_Debug:Debug("--Loaner")
			BeStride_Mount:LoanedMount()
		elseif BeStride_Logic:IsDruid() then
			BeStride_Debug:Debug("--Druid")
			BeStride_Mount:Druid()
		else
			BeStride_Mount:Regular()
		end
		--BeStride_Debug:Debug("End Not IsFlyable, IsOutdoors")
	elseif not IsOutdoors() then
		BeStride_Debug:Debug("IsOutdoors")
		if IsSwimming() then
			BeStride_Mount:Swimming()
		elseif BeStride_Logic:IsDruid() then
			BeStride_Logic:Druid()
		else
			BeStride_Mount:Regular()
		end
		--BeStride_Debug:Debug("Not IsOutdoors")
	else
		--BeStride_Debug:Debug("Final Test")
		BeStride_Logic:Regular()
		--BeStride_Debug:Debug("End Final Test")
	end
	--BeStride_Debug:Debug("End Logic")
end

function BeStride_Logic:GroundMountButton()
	
end

function BeStride_Logic:IsFlyableArea()
	local mapID = C_Map.GetBestMapForUnit("player")
	local zone = BeStride:GetMapUntil(mapID,3)
	local continent = BeStride:GetMapUntil(mapID,2)
	
	if ( not IsSpellKnown(34090) and not IsSpellKnown(34091) and not IsSpellKnown(90265) ) then
		return false
	end
	
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
		return not BeStride:WGActive()
	end
	
	return true
end

-- Checks Player Speed
-- Returns: integer
function BeStride_Logic:MovementCheck()
	if BeStride_Logic:SpeedCheck() ~= 0 then
		return true
	else
		return false
	end
end

-- Checks Player Speed
-- Returns: integer
function BeStride_Logic:SpeedCheck()
	return GetUnitSpeed("player")
end

function BeStride_Logic:IsFlyable()
	if BeStride_Logic:IsFlyableArea() then
		return true
	else
		return false
	end
end

function BeStride_Logic:IsFalling()
	return IsFalling()
end

-- +------------+ --
-- Special Checks --
-- +------------+ --

function BeStride_Logic:HasLoanedMount()
	local loanedMount = BeStride_Logic:CheckLoanerMount()
	
	if loanedMount then
		return true
	else
		return false
	end
end

function BeStride_Logic:CheckLoanerMount()
	return false
	--local zone = GetRealZoneText()
	--if zone == BestrideLocale.Zone.Dalaran then
	--	local subzone = GetSubZoneText()
	--	if subzone == BestrideLocale.Zone.DalaranSubZone.Underbelly or
	--			subzone == BestrideLocale.Zone.DalaranSubZone.UnderbellyDescent or
	--			subzone == BestrideLocale.Zone.DalaranSubZone.CircleofWills or
	--			subzone == BestrideLocale.Zone.DalaranSubZone.BlackMarket then
	--		if GetItemCount(139421, false) > 0 then
	--			return 139421
	--		else
	--			return nil
	--		end
	--	else
	--		return nil
	--	end
	--elseif zone == BestrideLocale.Zone.StormPeaks or zone == BestrideLocale.Zone.Icecrown then
	--	if GetItemCount(44221, false) > 0 then
	--		return 44221
	--	elseif GetItemCount(44229, false) > 0 then
	--		return 44229
	--	else
	--		return nil
	--	end
	--end
	--return nil
end

-- Check whether we can dismount while flying
-- Returns: boolean
function BeStride_Logic:NoDismountWhileFlying()
	-- Todo: Bitwise Compare
	if BeStride.db.profile.settings["nodismountwhileflying"] then
		return true
	else
		return false
	end
end

-- Check whether we force a repair mount
-- Returns: boolean
function BeStride_Logic:ForceRepair()
	if BeStride.db.profile.settings["repair"]["force"] then
		return true
	else
		return false
	end
end

-- Checks whether we check to repair or not
-- Returns: boolean
function BeStride_Logic:UseRepair()
	if BeStride.db.profile.settings["repair"]["use"] then
		return true
	else
		return false
	end
end

-- Get repair threshold
-- Returns: signed integer
function BeStride_Logic:GetRepairThreshold()
	if BeStride.db.profile.settings["repair"]["durability"] then
		return BeStride.db.profile.settings["repair"]["durability"]
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

function BeStride_Logic:CanBroom()
	if GetItemCount(37011, false) > 0 and not BeStride_Logic:IsCombat() and BeStride_Logic:CanBroomSetting() == true then
		return true
	end
end

function BeStride_Logic:CanBroomSetting()
	return self.db.profile.settings["priorities"]["flyingbroom"]
end

-- Check whether we need to repair
-- Returns: boolean
function BeStride_Logic:NeedToRepair()
	if BeStride_Logic:ForceRepair() then
		return true
	end
	
	if size(BeStride.db.profile.misc.RepairMounts) > 0 and BeStride_Logic:UseRepair() then
		for i = 0, 17 do
			local current, maximum = GetInventoryItemDurability(i)
			if current ~= nil and maximum ~= nil and ( (current/maximum) <= BeStride_Logic:GetRepairThreshold() ) then
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
	if IsUsableSpell(783) then
		return true
	else
		return false
	end
end

-- Check for Travel Form
-- Returns: boolean
function BeStride_Logic:DruidCanTravel()
	if IsUsableSpell(783) then
		return true
	else
		return false
	end
end

-- Check for Travel Form
-- Returns: boolean
function BeStride_Logic:DruidCanCat()
	if IsUsableSpell(783) then
		return true
	else
		return false
	end
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
function BeStride_Logic:DruidFlyingMTFF()
	-- Had a "GetUnitSpeed("player") ~= 0", unsure if we want to go with that
	-- Todo: Bitwise Compare
	if BeStride.db.profile.settings["classes"]["druid"]["mountedtoflightform"] then
		return true
	else
		return false
	end
end

-- ------ --
-- Priest --
-- ------ --

function BeStride_Logic:PriestCanLevitate()
	-- Todo: Bitwise Compare
	if BeStride_Logic:PriestSpellCanLevitate() and BeStride.db.profile.settings["classes"]["priest"]["levitate"] then
		return true
	else
		return false
	end
end

function BeStride_Logic:PriestSpellCanLevitate()
	if IsUsableSpell(1706) then
		return true
	else
		return false
	end
end

-- ---- --
-- Mage --
-- ---- --

function BeStride_Logic:MageSpecial()
	if BeStride_Logic:IsMage() and (not BeStride_Logic:IsCombat()) then
		local BlinkOnCooldown, _, _, _ = GetSpellCooldown(1953)
		if not BlinkOnCooldown and IsFalling() and BeStride_Logic:MovementCheck() and BeStride_Logic:MageCanBlink() then
			BeStride_Mount:MageBlinkNoSlowFall()
		elseif not BlinkOnCooldown and not IsFalling() and BeStride_Logic:MovementCheck() and BeStride_Logic:MageCanBlink() and BeStride_Logic:MageIsSlowFalling() then
			BeStride_Mount:MageBlink()
		elseif IsFalling() then
			BeStride_Mount:MageSlowFall()
		end
	end
end

function BeStride_Logic:MageCanSlowFall()
	-- Todo: Bitwise Compare
	if BeStride_Logic:MageSpellCanSlowFall() and BeStride.db.profile.settings["classes"]["priest"]["levitate"] then
		return true
	else
		return false
	end
end

function BeStride_Logic:MageSpellCanSlowFall()
	if IsUsableSpell(1706) then
		return true
	else
		return false
	end
end