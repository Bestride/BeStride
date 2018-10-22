BeStride_Logic = {}

local class = UnitClass("player")
local canRepair = false

function BeStride_Logic:IsCombat()
	if InCombatLockdown() then
		return true
	else
		return false
	end
end

function BeStride_Logic:Regular()
	-- Check if we are mounted first
	
	if self:IsDeathKnightAndSpecial() then
		return self:DeathKnight()
	elseif self:IsDruidAndSpecial() then
		return self:Druid()
	elseif self:IsMageAndSpecial() then
		return self:Mage()
	elseif self:IsMonkAndSpecial() then
		--BeStride_Debug:Verbose("MonkSpecial")
		return self:Monk()
	elseif self:IsPaladinAndSpecial() then
		return self:Paladin()
	elseif self:IsPriestAndSpecial() then
		return self:Priest()
	elseif self:IsShamanAndSpecial() then
		return self:Shaman()
	elseif self:IsRogueAndSpecial() then
		return self:Rogue()
	elseif self:IsSpecialZone() then
		--BeStride_Debug:Error("[SpecialZoneError]This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/")
	elseif self:MovementCheck() then
		return nil
	elseif IsMounted() then
		if IsFlying() then
			if self:IsFlyable() and BeStride:DBGet("settings.mount.nodismountwhileflying") ~= true then
				Dismount()
				if BeStride:DBGet("settings.mount.remount") then
					return BeStride_Mount:Flying()
				else
					return nil
				end
			elseif BeStride_Logic:IsFlyable() and not self:NoDismountWhileFlying() then
				return nil
			else
				return nil
			end
		elseif IsSwimming() then
			return BeStride_Mount:Swimming()
		elseif self:IsFlyable() then
			Dismount()
			if BeStride:DBGet("settings.mount.remount") then
				return BeStride_Mount:Flying()
			else
				return nil
			end
		else
			Dismount()
			if BeStride:DBGet("settings.mount.remount") then
				return BeStride_Mount:Regular()
			else
				return nil
			end
		end
	elseif CanExitVehicle() then
		VehicleExit()
		return BeStride_Mount:Regular()
	elseif self:IsFlyable() then
		--BeStride_Debug:Verbose("Flyable")
		return BeStride_Mount:Flying()
	elseif self:IsMountable() then
		return BeStride_Mount:Regular()
	elseif IsOutdoors() then
		return BeStride_Mount:Ground()
	else
		return nil
	end
end



function BeStride_Logic:GroundMountButton()
	if self:IsDeathKnightAndSpecial() then
		return self:DeathKnight()
	elseif self:IsDruidAndSpecial() then
		return self:Druid()
	elseif self:IsMageAndSpecial() then
		return self:Mage()
	elseif self:IsMonkAndSpecial() then
		--BeStride_Debug:Verbose("MonkSpecial")
		return self:Monk()
	elseif self:IsPaladinAndSpecial() then
		return self:Paladin()
	elseif self:IsShamanAndSpecial() then
		return self:Shaman()
	elseif self:IsRogueAndSpecial() then
		return self:Rogue()
	elseif self:IsSpecialZone() then
		--BeStride_Debug:Error("[SpecialZoneError]This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/")
	elseif IsMounted() then
		if IsFlying() and self:IsFlyable() and BeStride:DBGet("settings.mount.nodismountwhileflying") == true then
			return nil
		elseif IsSwimming() then
			return BeStride_Mount:Swimming()
		else
			return BeStride_Mount:Ground()
		end
	elseif IsOutdoors() then
		return BeStride_Mount:Ground()
	else
		return nil
	end
end

function BeStride_Logic:RepairMountButton()
	if IsMounted() or IsOutdoors() then
		if IsFlying() and self:IsFlyable() and BeStride:DBGet("settings.mount.nodismountwhileflying") == true then
			return nil
		else
			return BeStride_Mount:Repair()
		end
	else
		return nil
	end
end

function BeStride_Logic:PassengerMountButton(type)
	if IsMounted() or IsOutdoors() then
		if IsFlying() and self:IsFlyable() and BeStride:DBGet("settings.mount.nodismountwhileflying") == true then
			return nil
		else
			return BeStride_Mount:Passenger(type)
		end
	else
		return nil
	end
end

function BeStride_Logic:Combat()
	if self:IsDeathKnight() and BeStride:DBGet("settings.classes.deathknight.wraithwalk") then
		--BeStride_Debug:Verbose("Mount: DeathKnight")
		return BeStride_Mount:DeathKnightWraithWalk()
	elseif self:IsDruid() and BeStride:DBGet("settings.classes.druid.traveltotravel") then
		--BeStride_Debug:Verbose("Mount: Druid")
		return BeStride_Mount:DruidTravel()
	elseif self:IsMage() and (BeStride:DBGet("settings.classes.mage.blink") or BeStride:DBGet("settings.classes.mage.slowfall"))  then
		--BeStride_Debug:Verbose("Mount: Mage")
		if self:MageBlink() and BeStride:DBGet("settings.classes.mage.blinkpriority") then
			return BeStride_Mount:MageBlink()
		else
			return BeStride_Mount:MageSlowFall()
		end
	elseif self:IsMonk() and BeStride:DBGet("settings.classes.monk.roll") then
		--BeStride_Debug:Verbose("Mount: Monk")
		return BeStride_Mount:MonkRoll()
	elseif self:IsPaladin() and BeStride:DBGet("settings.classes.paladin.steed") then
		--BeStride_Debug:Verbose("Mount: Paladin")
		return BeStride_Mount:PaladinDivineSteed()
	elseif self:IsPriest() and BeStride:DBGet("settings.classes.priest.levitate") then
		--BeStride_Debug:Verbose("Mount: Priest")
		return BeStride_Mount:PriestLevitate()
	elseif self:IsRogue() and BeStride:DBGet("settings.classes.rogue.sprint") then
		--BeStride_Debug:Verbose("Mount: Rogue")
		return BeStride_Mount:RogueSprint()
	elseif self:IsShaman() and BeStride:DBGet("settings.classes.shaman.ghostwolf") then
		--BeStride_Debug:Verbose("Mount: Shaman")
		return BeStride_Mount:ShamanGhostWolf()
	end
end

function BeStride_Logic:IsDeathKnightAndSpecial()
	if self:IsDeathKnight() then
		if not IsFlying() and not IsFalling() and self:MovementCheck() and self:DeathKnightWraithWalk() then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:IsDruidAndSpecial()
	if self:IsDruid() then
		if not self:DruidFlying() then
			return false
		elseif IsMounted() and IsFlying() and self:IsFlyable() and self:DruidFlying() and self:DruidFlyingMTFF() then
			return true
		elseif self:IsFlyable() and self:DruidFlying() and self:DruidFlightFormPriority() then
			return true
		elseif IsFalling() and self:DruidFlying() then
			return true
		elseif IsSwimming() and self:DruidSwimming() then
			return true
		elseif self:MovementCheck() then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:IsMageAndSpecial()
	if self:IsMage() then
		if IsMounted() and IsFlying() and (self:MageSlowFall() or self:MageBlink()) and not self:NoDismountWhileFlying() then
			return true
		elseif (self:MageSlowFall() or self:MageBlink()) and IsFalling() then
			return true
		elseif self:MageBlink() and self:MovementCheck() then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:IsMonkAndSpecial()
	if self:IsMonk() then
		if IsMounted() and IsFlying() and self:MonkZenFlight() and not self:NoDismountWhileFlying() then
			--BeStride_Debug:Verbose("MountedFlying")
			return true
		elseif (self:MonkZenFlight() or self:MonkRoll()) and IsFalling() then
			--BeStride_Debug:Verbose("Falling")
			return true
		elseif self:MonkRoll() and self:MovementCheck() then
			--BeStride_Debug:Verbose("Moving")
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:IsPaladinAndSpecial()
	if self:IsPaladin() then
		if self:PaladinDivineSteed() and self:MovementCheck() then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:IsPriestAndSpecial()
	if self:IsPriest() then
		if IsMounted() and IsFlying() and self:NoDismountWhileFlying() then
			return false
		elseif IsMounted() and IsFlying() and self:PriestLevitate() and self:NoDismountWhileFlying() then
			return true
		elseif self:PriestLevitate() and IsFalling() then
			return true
		elseif self:PriestLevitate() and self:MovementCheck() then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:IsRogueAndSpecial()
	if self:IsRogue() then
	
	else
		return false
	end
end

function BeStride_Logic:IsShamanAndSpecial()
	if self:IsShaman() then
		if self:ShamanGhostWolf() and self:MovementCheck() then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:DeathKnight()
	if not IsFlying() and self:MovementCheck() and self:DeathKnightWraithWalk() then
		return BeStride_Mount:DeathKnightWraithWalk()
	else
		BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: DKBSL")
	end
end

function BeStride_Logic:Druid()
	if self:MovementCheck() then
		--BeStride_Debug:Verbose("Druid: Moving")
		return BeStride_Mount:MountSpell(BeStride:SpellToName(783))
	elseif GetShapeshiftForm() == 3 then
		--BeStride_Debug:Verbose("Druid: Shapeshifted")
		return BeStride_Mount:MountSpell(BeStride:SpellToName(783))
	elseif IsMounted() and IsFlying() and self:IsFlyable() and self:DruidCanFly() and self:DruidFlyingMTFF() then
		--BeStride_Debug:Verbose("Druid: Flying, Flyable, MTFF")
		return BeStride_Mount:MountSpell(BeStride:SpellToName(783))
	elseif self:IsFlyable() and self:DruidCanFly() and self:DruidFlightFormPriority() then
		--BeStride_Debug:Verbose("Druid: FlightFormPriority")
		return BeStride_Mount:MountSpell(BeStride:SpellToName(783))
	elseif IsFalling() and self:DruidCanFly() then
		--BeStride_Debug:Verbose("Druid: Falling")
		return BeStride_Mount:MountSpell(BeStride:SpellToName(783))
	else
		BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: DRBSL")
	end
end

function BeStride_Logic:Mage()
	if IsMounted() and IsFlying() and (self:MageSlowFall() or self:MageBlink()) and not self:NoDismountWhileFlying() then
		return BeStride_Mount:MageSlowFall()
	elseif (self:MageSlowFall() or self:MageBlink()) and IsFalling() then
		return BeStride_Mount:MageSlowFall()
	elseif self:MageBlink() and self:MovementCheck() then
		return BeStride_Mount:MageBlink()
	end
end

function BeStride_Logic:Monk()
	if not IsFlying() and not IsFalling() and self:MovementCheck() and self:MonkRoll() then
		return BeStride_Mount:MonkRoll()
	elseif IsFalling() and self:MonkZenFlight() then
		return BeStride_Mount:MonkZenFlight()
	elseif IsMounted() and self:IsFlyable() and self:MonkZenFlight() then
		--BeStride_Debug:Verbose("Trying Flight")
		return BeStride_Mount:MonkZenFlight()
	elseif not IsFlying() and self:IsFlyableArea() and self:MonkZenFlight() then
		--BeStride_Debug:Verbose("Trying Flight")
		return BeStride_Mount:MonkZenFlight()
	elseif not self:IsFlyable() and self:MovementCheck() and self:MonkZenFlight() then
		return BeStride_Mount:MonkZenFlight()
	else
		BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: MONKBSL")
	end
end

function BeStride_Logic:Paladin()
	if not IsFlying() and self:MovementCheck() and self:PaladinDivineSteed() then
		return BeStride_Mount:Paladin()
	else
		--BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/")
	end
end

function BeStride_Logic:Priest()
	if self:MovementCheck() then
		return BeStride_Mount:PriestLevitate()
	elseif IsMounted() and IsFlying() and self:PriestLevitate() and not self:NoDismountWhileFlying() then
		return BeStride_Mount:PriestLevitate()
	elseif IsFalling() and self:PriestLevitate() then
		return BeStride_Mount:PriestLevitate()
	elseif self:MovementCheck() and self:PriestLevitate() then
		return BeStride_Mount:PriestLevitate()
	else
		BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: SHBSL")
	end
end

function BeStride_Logic:Shaman()
	if not IsFlying() and self:MovementCheck() and self:ShamanGhostWolf() then
		return BeStride_Mount:Shaman()
	end
end

function BeStride_Logic:Rogue()
	if not IsFlying() and self:MovementCheck() and self:RogueSprint() then
		--BeStride_Debug:Error("Sprinting")
		return nil
	else
		BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: RGBSL")
	end
end

function BeStride_Logic:MountButton()
	-- Dismount Logic
	-- This Logic needs to be cleaned up more
	--BeStride_Debug:Debug("Starting Mount Logic")
	if IsMounted() and IsFlying() and BeStride_Logic:IsFlyable() then
		--BeStride_Debug:Debug("Mounted, Flying, Flyable")
		if BeStride_Logic:IsDruid() then
			if BeStride_Logic:DruidFlyingMTFF() then
				--BeStride_Debug:Debug("DruidFlyingMTFF")
				return BeStride_Mount:DruidFlying()
			elseif BeStride_Logic:NoDismountWhileFlying() then
				--BeStride_Debug:Debug("DruidNoDismountWhileFlying")
				return BeStride_Mount:Flying()
			else
				--BeStride_Debug:Debug("DruidDismountAndmount")
				Dismount()
				return BeStride_Mount:Flying()
			end
		elseif BeStride_Logic:IsPriest() then
			if BeStride_Logic:PriestCanLevitate() then
				--BeStride_Debug:Debug("PriestCanLevitate")
				return BeStride_Mount:PriestLevitate()
			elseif BeStride_Logic:NoDismountWhileFlying() then
				--BeStride_Debug:Debug("PriestNoDismountWhileFlying")
				return BeStride_Mount:Flying()
			else
				--BeStride_Debug:Debug("Priest Dismounting")
				Dismount()
				return BeStride_Mount:Flying()
			end
		else
			--BeStride_Debug:Debug("No Action")
			return nil
		end
		--BeStride_Debug:Debug("End Mounted, Flying, Flyable")
	-- Todo: Cleanup from here
	elseif IsMounted() then
		--BeStride_Debug:Debug("Mounted")
		if IsSwimming() and Bestride_Logic:IsDruid() and BeStride_Logic:DruidCanSwim() and BeStride_Logic:MovementCheck() then -- Todo: Clean this logic up
			return BeStride_Mount:DruidAuquaticForm()
		elseif IsSwimming() then
			return BeStride_Mount:Swimming()
		elseif BeStride_Logic:IsFlyable() then
			Dismount()
			if BeStride:DBGet("settings.mount.remount") then
				return BeStride_Mount:Flying()
			end
		else
			Dismount()
			if BeStride:DBGet("settings.mount.remount") then
				return BeStride_Mount:Ground()
			end
		end
		--BeStride_Debug:Debug("Ending Mounted")
	elseif CanExitVehicle() then
		--BeStride_Debug:Debug("CanExitVehicle")
		VehicleExit()
		return BeStride_Mount:Ground()
		--BeStride_Debug:Debug("Ending CanExitVehicle")
	elseif BeStride_Logic:IsMonk() and BeStride_Logic:IsFlyable() and BeStride:MonkCanZen() then
		--BeStride_Debug:Debug("IsMonk,IsFlyable,CanZen")
		return BeStride_Mount:MonkZen()
		--BeStride_Debug:Debug("End IsMonk,IsFlyable,CanZen")
	elseif BeStride_Logic:IsPriest() and BeStride_Logic:PriestCanLevitate() and ( BeStride_Logic:IsFalling() or BeStride_Logic:MovementCheck() ) then
		--BeStride_Debug:Debug("IsPriest, CanLevitate, IsFalling, MovementCheck")
		return BeStride_Mount:PriestLevitate()
		--BeStride_Debug:Debug("End IsPriest, CanLevitate, IsFalling, MovementCheck")
	elseif BeStride_Logic:IsMage() and BeStride_Logic:CanSlowFall() and ( BeStride_Logic:IsFalling() or BeStride_Logic:MovementCheck() ) then
		--BeStride_Debug:Debug("IsMage, CanLevitate, IsFalling, MovementCheck")
		return BeStride_Mount:MageSlowFall()
		--BeStride_Debug:Debug("IsMage, CanLevitate, IsFalling, MovementCheck")
	elseif BeStride_Logic:IsFlyable() and IsOutdoors() then
		--BeStride_Debug:Debug("IsFlyable, IsOutdoors")
		if BeStride_Logic:CanBroom() then
			--BeStride_Debug:Debug("--Broom")
			return BeStride_Mount:Broom()
		elseif IsSwimming() then
			--BeStride_Debug:Debug("--Swimming")
			return BeStride_Mount:Swimming()
		elseif BeStride_Logic:IsDruid() then
			--BeStride_Debug:Debug("--Druid")
			return BeStride_Mount:DruidFlying()
		else
			--BeStride_Debug:Debug("--Flying")
			return BeStride_Mount:Flying()
		end
		--BeStride_Debug:Debug("End IsFlyable, IsOutdoors")
	elseif not BeStride_Logic:IsFlyable() and IsOutdoors() then
		--BeStride_Debug:Debug("Not IsFlyable, IsOutdoors")
		if zone == BeStride_Locale.Zone.Oculus and Bestride:Filter(nil, zone) then
			return nil
		elseif BeStride_Logic:CanBroom() then
			--BeStride_Debug:Debug("--Broom")
			return BeStride_Mount:Broom()
		elseif IsSwimming() then
			--BeStride_Debug:Debug("--Swimming")
			return BeStride_Mount:Swimming()
		elseif BeStride_Logic:HasLoanedMount() then
			--BeStride_Debug:Debug("--Loaner")
			return BeStride_Mount:LoanedMount()
		elseif BeStride_Logic:IsDruid() then
			--BeStride_Debug:Debug("--Druid")
			return BeStride_Mount:Druid()
		else
			return BeStride_Mount:Ground()
		end
		--BeStride_Debug:Debug("End Not IsFlyable, IsOutdoors")
	elseif not IsOutdoors() then
		--BeStride_Debug:Debug("IsOutdoors")
		if IsSwimming() then
			return BeStride_Mount:Swimming()
		elseif BeStride_Logic:IsDruid() then
			return BeStride_Logic:Druid()
		else
			return BeStride_Mount:Regular()
		end
		--BeStride_Debug:Debug("Not IsOutdoors")
	else
		--BeStride_Debug:Debug("Final Test")
		return BeStride_Mount:Regular()
		--BeStride_Debug:Debug("End Final Test")
	end
	--BeStride_Debug:Debug("End Logic")
end

function BeStride_Logic:IsFlyableArea()
	return IsFlyableArea()
end

function BeStride_Logic:IsMountable()
	if self:IsFlyable() and IsOutdoors() then
		return true
	elseif not self:IsFlyable() and IsOutdoors() then
		return true
	elseif not IsOutdoors() then
		return false
	else
		return false
	end
end

function BeStride_Logic:IsSpecialZone()
	return false
end

function BeStride_Logic:OldIsFlyableArea()
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
	if IsOutdoors() then
		if self:IsFlyableArea() then
			return true
		else
			return false
		end
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
	return BeStride:DBGet("settings.mount.flyingbroom")
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

-- Check for DeathKnight
function BeStride_Logic:IsDeathKnight()
	if string.lower(playerTable["class"]["name"]) == "death knight" then
		return true
	else
		return false
	end
end

-- Check for Druid
function BeStride_Logic:IsDruid()
	if string.lower(playerTable["class"]["name"]) == "druid" then
		return true
	else
		return false
	end
end

-- Check for Mage
function BeStride_Logic:IsMage()
	if string.lower(playerTable["class"]["name"]) == "mage" then
		return true
	else
		return false
	end
end

-- Check for Monk
function BeStride_Logic:IsMonk()
	if string.lower(playerTable["class"]["name"]) == "monk" then
		return true
	else
		return false
	end
end

-- Check for Paladin
function BeStride_Logic:IsPaladin()
	if string.lower(playerTable["class"]["name"]) == "paladin" then
		return true
	else
		return false
	end
end

-- Check for Priest
function BeStride_Logic:IsPriest()
	if string.lower(playerTable["class"]["name"]) == "priest" then
		return true
	else
		return false
	end
end

-- Check for Rogue
function BeStride_Logic:IsRogue()
	if string.lower(playerTable["class"]["name"]) == "rogue" then
		return true
	else
		return false
	end
end

-- Check for Shaman
function BeStride_Logic:IsShaman()
	if string.lower(playerTable["class"]["name"]) == "shaman" then
		return true
	else
		return false
	end
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

-- ------------------ --
-- Deathknight Spells --
-- ------------------ --

function BeStride_Logic:DeathKnightCanWraithWalk()
	if IsUsableSpell(212552) then
		return true
	else
		return false
	end
end

-- ----------- --
-- Mage Spells --
-- ----------- --

function BeStride_Logic:MageCanSlowFall()
	if IsUsableSpell(1706) then
		return true
	else
		return false
	end
end

function BeStride_Logic:MageCanBlink()
	if IsUsableSpell(1953) then
		local BlinkOnCooldown, _, _, _ = GetSpellCooldown(1953)
		if BlinkOnCooldown == 0 then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- ----------- --
-- Monk Spells --
-- ----------- --

function BeStride_Logic:MonkCanRoll()
	if IsUsableSpell(109132) or self:MonkCanTorpedo() then
		return true
	else
		return false
	end
end

function BeStride_Logic:MonkCanTorpedo()
	if IsUsableSpell(115008) then
		return true
	else
		return false
	end
end

function BeStride_Logic:MonkCanZenFlight()
	if IsUsableSpell(125883) then
		return true
	else
		return false
	end
end

-- ------------- --
-- Priest Spells --
-- ------------- --

function BeStride_Logic:PaladinCanDivineSteed()
	if IsUsableSpell(190784) then
		return true
	else
		return false
	end
end

-- ------------- --
-- Priest Spells --
-- ------------- --

function BeStride_Logic:PriestCanLevitate()
	if IsUsableSpell(1706) then
		return true
	else
		return false
	end
end

-- ------------- --
-- Shaman Spells --
-- ------------- --

function BeStride_Logic:ShamanCanGhostWolf()
	if IsUsableSpell(2645) then
		return true
	else
		return false
	end
end

-- ------------- --
-- Rogue Spells --
-- ------------- --

function BeStride_Logic:RogueCanSprint()
	if IsUsableSpell(2983) then
		return true
	else
		return false
	end
end

-- +-------------------------+ --
-- Class Specific Mount Checks --
-- +-------------------------+ --
-- ----------- --
-- DeathKnight --
-- ----------- --

function BeStride_Logic:DeathKnightWraithWalk()
	if self:IsDeathKnight() then
		if self:DeathKnightCanWraithWalk() and BeStride:DBGet("settings.classes.deathknight.wraithwalk") then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- ----- --
-- Druid --
-- ----- --

function BeStride_Logic:DruidFlying()
	if self:IsDruid() then
		if self:DruidCanFly() then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:DruidTravelToTravel()
	if self:IsDruid() then
		if BeStride:DBGet("settings.classes.druid.traveltotravel") then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:DruidFlightFormPriority()
	if self:IsDruid() then
		if self:DruidFlying() and BeStride:DBGet("settings.classes.druid.flightformpriority") == true then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Check for Flying, Mounted and Mount to Flight Form
-- Returns: boolean
function BeStride_Logic:DruidFlyingMTFF()
	-- Had a "GetUnitSpeed("player") ~= 0", unsure if we want to go with that
	-- Todo: Bitwise Compare
	if self:IsDruid() then
		if self:DruidFlying() and BeStride:DBGet("settings.classes.druid.mountedtoflightform") then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- ---- --
-- Mage --
-- ---- --

function BeStride_Logic:MageSpecial()
	if self:IsMage() then
		if (not self:IsCombat()) then
			local BlinkOnCooldown, _, _, _ = GetSpellCooldown(1953)
			if not BlinkOnCooldown and IsFalling() and self:MovementCheck() and self:MageCanBlink() then
				BeStride_Mount:MageBlinkNoSlowFall()
			elseif not BlinkOnCooldown and not IsFalling() and self:MovementCheck() and self:MageCanBlink() and self:MageIsSlowFalling() then
				BeStride_Mount:MageBlink()
			elseif IsFalling() then
				BeStride_Mount:MageSlowFall()
			end
		end
	else
		return false
	end
end

function BeStride_Logic:MageBlink()
	-- Todo: Bitwise Compare
	if self:IsMage() then
		if self:MageCanBlink() then
		end
		if self:MageCanBlink() and BeStride:DBGet("settings.classes.mage.blink") then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:MageSlowFall()
	-- Todo: Bitwise Compare
	if self:IsMage() then
		if self:MageCanSlowFall() and BeStride:DBGet("settings.classes.mage.slowfall") then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- ---- --
-- Monk --
-- ---- --

function BeStride_Logic:MonkRoll()
	if self:IsMonk() then
		if self:MonkCanRoll() and BeStride:DBGet("settings.classes.monk.roll") then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:MonkZenFlight()
	if self:IsMonk() then
		if self:MonkCanZenFlight() and BeStride:DBGet("settings.classes.monk.zenflight") then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- ------- --
-- Paladin --
-- ------- --

function BeStride_Logic:PaladinDivineSteed()
	-- Todo: Bitwise Compare
	if self:IsPaladin() then
		if self:PaladinCanDivineSteed() and BeStride:DBGet("settings.classes.paladin.steed") then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- ------ --
-- Priest --
-- ------ --

function BeStride_Logic:PriestLevitate()
	-- Todo: Bitwise Compare
	if self:IsPriest() then
		if self:PriestCanLevitate() and BeStride:DBGet("settings.classes.priest.levitate") then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- ----- --
-- Rogue --
-- ----- --

function BeStride_Logic:RogueSprint()
	-- Todo: Bitwise Compare
	if self:IsRogue() then
		if self:RogueCanSprint() and BeStride:DBGet("settings.classes.rogue.sprint") then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- ------ --
-- Shaman --
-- ------ --

function BeStride_Logic:ShamanGhostWolf()
	-- Todo: Bitwise Compare
	if self:IsShaman() then
		if self:ShamanCanGhostWolf() and BeStride:DBGet("settings.classes.shaman.ghostwolf") then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:GetRidingSkill()
	
end

function BeStride_Logic:WGActive()
	return true
end