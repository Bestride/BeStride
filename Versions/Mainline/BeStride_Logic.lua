BeStride_Logic = {}
BeStride_Game = "Mainline"

local class = UnitClass("player")
local canRepair = false

function BeStride_Logic:isMountUsable(mount)
	local name,spellID,icon,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,faction,shouldHideOnChar,isCollected,mountID = C_MountJournal.GetMountInfoByID(mount)
	
	return spellID,mountID,isUsable
end

function BeStride_Logic:isZoneMount(mountId)
	spellId = mountTable.master[mountId].spellID
	if mountTable.master[mountId].type == "zone" and BeStride_Constants.Mount.Mounts[spellId] ~= nil and BeStride_Constants.Mount.Mounts[spellId].zone ~= nil then
		return true
	elseif BeStride_Game == "Mainline" and mountTable.master[mountId].type == "zone" and BeStride_Constants.Mount.Mounts[mountId] ~= nil and BeStride_Constants.Mount.Mounts[mountId].zone ~= nil then
		return true
	end

	return false
end

function BeStride_Logic:IsCombat()
	if InCombatLockdown() then
		return true
	else
		return false
	end
end

function BeStride_Logic:Regular()
	-- Aspect of the Cheetah is available from level 5
	if self:IsHunterAndSpecial() then
		return self:Hunter()
	-- Check if we are mounted
	elseif IsMounted() and self:NeedsChauffeur() then
		self:DismountAndExit()
		return BeStride_Mount:Chauffeur()
	elseif self:NeedsChauffeur() then
		self:DismountAndExit()
		return BeStride_Mount:Chauffeur()
	elseif self:IsHerbalismAndCanRobot() then
		self:DismountAndExit()
		return BeStride_Mount:Robot()
	elseif self:IsDeathKnightAndSpecial() then
		self:DismountAndExit()
		return self:DeathKnight()
	elseif self:IsDemonHunterAndSpecial() then
		self:DismountAndExit()
		return self:DemonHunter()
	elseif self:IsDruidAndSpecial() then
		self:DismountAndExit()
		return self:Druid()
	elseif self:IsMageAndSpecial() then
		self:DismountAndExit()
		return self:Mage()
	elseif self:IsMonkAndSpecial() then
		self:DismountAndExit()
		return self:Monk()
	elseif self:IsPaladinAndSpecial() then
		self:DismountAndExit()
		return self:Paladin()
	elseif self:IsPriestAndSpecial() then
		self:DismountAndExit()
		return self:Priest()
	elseif self:IsShamanAndSpecial() then
		self:DismountAndExit()
		return self:Shaman()
	elseif self:IsRogueAndSpecial() then
		self:DismountAndExit()
		return self:Rogue()
	elseif self:IsLoanedMount() then
		self:DismountAndExit()
		return BeStride_Mount:Loaned()
	elseif self:CanBroom() then
		self:DismountAndExit()
		return BeStride_Mount:Broom()
	elseif self:IsSpecialZone() then
		self:DismountAndExit()
		return BeStride_Mount:SpecialZone()
	elseif self:IsRepairable() then
		self:DismountAndExit()
		return BeStride_Mount:Repair()
	elseif IsMounted() then
		if IsFlying() then
			if self:IsFlyable() and BeStride:DBGet("settings.mount.nodismountwhileflying") ~= true then
				self:DismountAndExit()
				if BeStride:DBGet("settings.mount.remount") then
					return BeStride_Mount:Flying()
				else
					return nil
				end
			else
				return nil
			end
		elseif IsSwimming() and BeStride:DBGet("settings.mount.noswimming") == false then
			self:DismountAndExit()
			return BeStride_Mount:Swimming()
		elseif self:IsFlyable() and IsInGroup() == true and BeStride:DBGet("settings.mount.prioritizepassenger") == true then
			self:DismountAndExit()
			if BeStride:DBGet("settings.mount.remount") then
				return BeStride_Mount:Passenger("flying")
			else
				return nil
			end
		elseif self:IsFlyable() then
			self:DismountAndExit()
			if BeStride:DBGet("settings.mount.remount") then
				return BeStride_Mount:Flying()
			else
				return nil
			end
		elseif IsOutdoors() and IsInGroup() == true and BeStride:DBGet("settings.mount.prioritizepassenger") == true then
			self:DismountAndExit()
			if BeStride:DBGet("settings.mount.remount") then
				return BeStride_Mount:Passenger("ground")
			else
				return nil
			end
		else
			self:DismountAndExit()
			if BeStride:DBGet("settings.mount.remount") then
				return BeStride_Mount:Regular()
			else
				return nil
			end
		end
	elseif IsSwimming() and IsOutdoors() and BeStride:DBGet("settings.mount.noswimming") == false then
		self:DismountAndExit()
		return BeStride_Mount:Swimming()
	elseif CanExitVehicle() then
		self:DismountAndExit()
		return BeStride_Mount:Regular()
	elseif self:IsFlyable() and IsOutdoors() and IsInGroup() == true and BeStride:DBGet("settings.mount.prioritizepassenger") == true then
		return BeStride_Mount:Passenger("flying")
	elseif self:IsFlyable() then
		return BeStride_Mount:Flying()
	elseif IsOutdoors() and IsInGroup() == true and BeStride:DBGet("settings.mount.prioritizepassenger") == true then
		return BeStride_Mount:Passenger("ground")
	elseif self:IsMountable() then
		return BeStride_Mount:Regular()
	elseif IsOutdoors() then
		return BeStride_Mount:Ground()
	else
		return nil
	end
end



function BeStride_Logic:GroundMountButton()
	-- Aspect of the Cheetah is available from level 5
	if self:IsHunterAndSpecial() then
		return self:Hunter()
	-- Check if we are mounted
	elseif IsMounted() and self:NeedsChauffeur() then
		self:DismountAndExit()
		return BeStride_Mount:Chauffeur()
	elseif self:NeedsChauffeur() then
		self:DismountAndExit()
		return BeStride_Mount:Chauffeur()
	elseif self:IsHerbalismAndCanRobot() then
		self:DismountAndExit()
		return BeStride_Mount:Robot()
	elseif self:IsDeathKnightAndSpecial() then
		self:DismountAndExit()
		return self:DeathKnight()
	elseif self:IsDemonHunterAndSpecial() then
		self:DismountAndExit()
		return self:DemonHunter()
	elseif self:IsDruidAndSpecial() then
		self:DismountAndExit()
		return self:Druid()
	elseif self:IsMageAndSpecial() then
		self:DismountAndExit()
		return self:Mage()
	elseif self:IsMonkAndSpecial() then
		self:DismountAndExit()
		return self:Monk()
	elseif self:IsPaladinAndSpecial() then
		self:DismountAndExit()
		return self:Paladin()
	elseif self:IsShamanAndSpecial() then
		self:DismountAndExit()
		return self:Shaman()
	elseif self:IsRogueAndSpecial() then
		self:DismountAndExit()
		return self:Rogue()
	elseif self:CanBroom() then
		self:DismountAndExit()
		return BeStride_Mount:Broom()
	elseif self:IsLoanedMount() then
		self:DismountAndExit()
		return BeStride_Mount:Loaned()
	elseif self:IsSpecialZone() then
		self:DismountAndExit()
		return BeStride_Mount:SpecialZone()
	elseif self:IsRepairable() then
		self:DismountAndExit()
		return BeStride_Mount:Repair()
	elseif IsMounted() then
		if IsFlying() and self:IsFlyable() and BeStride:DBGet("settings.mount.nodismountwhileflying") == true then
			return nil
		elseif IsOutdoors() and IsInGroup() == true and BeStride:DBGet("settings.mount.prioritizepassenger") == true then
			self:DismountAndExit()
			if BeStride:DBGet("settings.mount.remount") then
				return BeStride_Mount:Passenger("ground")
			else
				return nil
			end
		elseif IsSwimming() and BeStride:DBGet("settings.mount.noswimming") == false then
			self:DismountAndExit()
			return BeStride_Mount:Swimming()
		else
			return BeStride_Mount:Ground()
		end
	elseif IsOutdoors() and IsInGroup() == true and BeStride:DBGet("settings.mount.prioritizepassenger") == true then
		return BeStride_Mount:Passenger("ground")
	elseif IsSwimming() and IsOutdoors() and BeStride:DBGet("settings.mount.noswimming") == false then
		self:DismountAndExit()
		return BeStride_Mount:Swimming()
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
			self:DismountAndExit()
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
			self:DismountAndExit()
			return BeStride_Mount:Passenger(type)
		end
	else
		return nil
	end
end

function BeStride_Logic:Combat()
	if self:IsDeathKnight() and BeStride:DBGet("settings.classes.deathknight.wraithwalk") then
		return BeStride_Mount:DeathKnightWraithWalk()
	elseif self:IsDemonHunter() and self:DemonHunterFelRush() then
		return BeStride_Mount:DemonHunterFelRush()
	elseif self:IsDruid() and BeStride:DBGet("settings.classes.druid.traveltotravel") then
		return BeStride_Mount:DruidTravel()
	elseif self:IsHunterAndSpecial() then
		return self:Hunter()
	elseif self:IsMage() and (BeStride:DBGet("settings.classes.mage.blink") or BeStride:DBGet("settings.classes.mage.slowfall"))  then
		if self:MageBlink() and BeStride:DBGet("settings.classes.mage.blinkpriority") then
			return BeStride_Mount:MageBlink()
		else
			return BeStride_Mount:MageSlowFall()
		end
	elseif self:IsMonk() and BeStride:DBGet("settings.classes.monk.roll") then
		return BeStride_Mount:MonkRoll()
	elseif self:IsPaladin() and BeStride:DBGet("settings.classes.paladin.steed") then
		return BeStride_Mount:PaladinDivineSteed()
	elseif self:IsPriest() and BeStride:DBGet("settings.classes.priest.levitate") then
		return BeStride_Mount:PriestLevitate()
	elseif self:IsRogue() and BeStride:DBGet("settings.classes.rogue.sprint") then
		return BeStride_Mount:RogueSprint()
	elseif self:IsShaman() and BeStride:DBGet("settings.classes.shaman.ghostwolf") then
		return BeStride_Mount:ShamanGhostWolf()
	elseif self:IsSpecialZone() then
		return BeStride_Mount:SpecialZone()
	end
end

function BeStride_Logic:DismountAndExit()
	if CanExitVehicle() then
		VehicleExit()
	elseif IsMounted() then
		Dismount()
	end
end

function BeStride_Logic:NeedsChauffeur()
	local skill,spells = self:GetRidingSkill()
	if skill == 0 then
		if IsUsableSpell(179245) or IsUsableSpell(179244)  then
			return true
		else
			return false
		end
	else
		return false
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

function BeStride_Logic:IsDemonHunterAndSpecial()
	if ( IsFlying() or IsFalling() ) and self:DemonHunterGlide() then
		if IsFlying() and self:NoDismountWhileFlying() then
			return false
		elseif IsFalling() and self:DemonHunterGlide() then
			return true
		else
			return false
		end
	elseif self:MovementCheck() and self:DemonHunterFelRush()  then
		return true
	else
		return false
	end
end

function BeStride_Logic:IsDruidAndSpecial()
	if self:IsDruid() then
		if IsOutdoors() ~= true and self:DruidCanCat() then
			return true
		elseif (IsMounted() or self:IsDruidTraveling()) and IsFlying() and self:IsFlyable() and self:DruidFlying() and self:DruidFlyingMTFF() then
			return true
		elseif IsFlying() and self:DruidFlying() == true and self:DruidUseFlightForm() == false then
			return false
		elseif IsFlying() and self:NoDismountWhileFlying() then
			return false
		elseif self:IsFlyable() and self:DruidFlying() and self:DruidFlightFormPriority() then
			return true
		elseif IsFalling() and self:DruidFlying() then
			return true
		elseif IsSwimming() and self:DruidCanSwim() and BeStride:DBGet("settings.mount.noswimming") == false then
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

function BeStride_Logic:IsHunterAndSpecial()
	if self:IsHunter() and BeStride:DBGet("settings.classes.hunter.aspectofthecheetah") then
		if (self:MovementCheck() or self:IsCombat()) and self:HunterCanAspectOfTheCheetah() then
			return true
		end
	end
	return false
end

function BeStride_Logic:IsMageAndSpecial()
	if self:IsMage() then
		if IsFlying() and self:NoDismountWhileFlying() then
			return false
		elseif IsMounted() and IsFlying() and (self:MageSlowFall() or self:MageBlink()) then
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
		if IsMounted() and IsFlying() and self:NoDismountWhileFlying() then
			return false
		elseif IsFlying() and self:MonkZenFlight() then
			return true
		elseif (self:MonkZenFlight() or self:MonkRoll()) and IsFalling() then
			return true
		elseif self:MonkRoll() and self:MovementCheck() then
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
		if IsFlying() then
			return false
		elseif not IsFlying() and self:MovementCheck() and self:RogueSprint() then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:IsShamanAndSpecial()
	if self:IsShaman() then
		if IsFlying() and self:NoDismountWhileFlying() then
			return false
		elseif self:ShamanGhostWolf() and (self:MovementCheck() or IsOutdoors() ~= true) then
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

function BeStride_Logic:DemonHunter()
	if ( IsFlying() or IsFalling() ) and self:DemonHunterGlide() then
		if IsFlying() and self:NoDismountWhileFlying() then
			return BeStride_Mount:DemonHunterGlide()
		elseif IsFalling() and self:DemonHunterGlide() then
			return BeStride_Mount:DemonHunterGlide()
		else
			return false
		end
	elseif self:MovementCheck() and self:DemonHunterFelRush() then
		return BeStride_Mount:DemonHunterFelRush()
	else
		BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: DHBSL")
	end
end

function BeStride_Logic:Druid()
	if IsOutdoors() ~= true and self:DruidCanCat() then
		return BeStride_Mount:MountSpell(BeStride:SpellToName(768))
	elseif IsSwimming() and self:DruidCanSwim() and BeStride:DBGet("settings.mount.noswimming") == false then
		return BeStride_Mount:MountSpell(BeStride:SpellToName(783))
	elseif self:MovementCheck() and IsOutdoors() then
		return BeStride_Mount:MountSpell(BeStride:SpellToName(783))
	elseif GetShapeshiftForm() == 3 then
		return BeStride_Mount:MountSpell(BeStride:SpellToName(783))
	elseif IsMounted() and IsFlying() and self:IsFlyable() and self:DruidCanFly() and self:DruidFlyingMTFF() then
		return BeStride_Mount:MountSpell(BeStride:SpellToName(783))
	elseif self:IsFlyable() and self:DruidCanFly() and self:DruidFlightFormPriority() then
		return BeStride_Mount:MountSpell(BeStride:SpellToName(783))
	elseif IsFalling() and self:DruidCanFly() then
		return BeStride_Mount:MountSpell(BeStride:SpellToName(783))
	else
		BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: DRBSL")
	end
end

function BeStride_Logic:Hunter()
	if IsMounted() and IsFlying() and self:NoDismountWhileFlying() then
		return false
	else
		return BeStride_Mount:HunterAspectOfTheCheetah()
	end

	BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: HUBSL")
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
	if IsMounted() and IsFlying() and self:NoDismountWhileFlying() then
		return false
	elseif IsFlying() and self:MonkZenFlight() then
		return BeStride_Mount:MonkZenFlight()
	elseif (self:MonkZenFlight() or self:MonkRoll()) and IsFalling() then
		if self:MonkZenFlight() then
			return BeStride_Mount:MonkZenFlight()
		else
			return BeStride_Mount:MonkRoll()
		end
	elseif self:MonkRoll() and self:MovementCheck() then
		return BeStride_Mount:MonkRoll()
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
	if not IsFlying() and (self:MovementCheck() or IsOutdoors ~= true) and self:ShamanGhostWolf() then
		return BeStride_Mount:Shaman()
	end
end

function BeStride_Logic:Rogue()
	if not IsFlying() and self:MovementCheck() and self:RogueSprint() then
		return BeStride_Mount:Rogue()
	else
		BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: RGBSL")
	end
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

function BeStride_Logic:IsUnderwater()
	if IsSwimming() and BeStride:DBGet("settings.mount.noswimming") == false then
		local timer, initial, maxvalue, scale, paused, label = GetMirrorTimerInfo(2)
		if timer ~= nil and timer == "BREATH" and scale < 0 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:IsSpecialZone()
	local mapID = C_Map.GetBestMapForUnit("player")
	local micro = BeStride:GetMapUntil(mapID,5)
	local dungeon = BeStride:GetMapUntil(mapID,4)
	local zone = BeStride:GetMapUntil(mapID,3)
	local continent = BeStride:GetMapUntil(mapID,2)
	
	if continent ~= nil and continent.name == BeStride_Locale.Continent.Draenor and micro.name == BeStride_Locale.Zone.Nagrand and self:DBGet("settings.mount.telaari") == true then
		local garrisonAbilityName = GetSpellInfo(161691)
		local _,_,_,_,_,_,spellID = GetSpellInfo(garrisonAbilityName)
		if(spellID == 165803 or spellID == 164222) then
			return true
		end
	end
	
	return false
end

function BeStride_Logic:SpecialZone()
	local mapID = C_Map.GetBestMapForUnit("player")
	local micro = BeStride:GetMapUntil(mapID,5)
	local dungeon = BeStride:GetMapUntil(mapID,4)
	local zone = BeStride:GetMapUntil(mapID,3)
	local continent = BeStride:GetMapUntil(mapID,2)
	
	if continent ~= nil and continent.name == BeStride_Locale.Continent.Draenor and micro.name == BeStride_Locale.Zone.Nagrand and self:DBGet("settings.mount.telaari") == true then
		return BeStride_Mount:Nagrand()
	end
	
	return nil
end

function BeStride_Logic:IsRepairable()
	if not self:IsMountable() or IsFlying() or not IsOutdoors() then
		return false
	end
	mounts = BeStride:DBGet("mounts.repair")
	local mountCount = {}
	
	table.foreach(mounts,function (key,value) table.insert(mountCount,key) end )
	
	if #mountCount ~= 0 then
		local globalDurability,count = 0,0
		for i = 0, 17 do
			local current, maximum = GetInventoryItemDurability(i)
			if current ~= nil and maximum ~= nil then
				local durability = (current / maximum)
				count = count + 1
				globalDurability = globalDurability + durability
				if (durability * 100) <= BeStride:DBGet("settings.mount.repair.durability") then
					return true
				end
			end
		end
		
		if ((globalDurability/count)*100) <= BeStride:DBGet("settings.mount.repair.globaldurability") then
			return true
		end
		
		for i = 0, 4 do
			for j = 0, GetContainerNumSlots(i) do
				local current, maximum = GetContainerItemDurability(i, j)
				if current ~= nil and maximum ~= nil then
					if ((current / maximum)*100) <= BeStride:DBGet("settings.mount.repair.inventorydurability") then
						return true
					end
				end
			end
		end
	else
		return false
	end
end

function BeStride_Logic:MovementCheck()
	-- Checks Player Speed
	-- Returns: integer
	if BeStride_Logic:SpeedCheck() ~= 0 then
		return true
	else
		return false
	end
end

function BeStride_Logic:SpeedCheck()
	-- Checks Player Speed
	-- Returns: integer
	return GetUnitSpeed("player")
end

function BeStride_Logic:IsMountable()
	if IsOutdoors() then
		return true
	else
		return false
	end
end

function BeStride_Logic:IsFlyable()
	if IsOutdoors() then
		local skill,spells = self:GetRidingSkill()
		local mapID = C_Map.GetBestMapForUnit("player")
		
		if countTable(BeStride_Constants.Riding.Flight.Restricted.Continents) > 0 then
			local continent = BeStride:GetMapUntil(mapID,2)
			if continent ~= nil then
				for key,value in pairsByKeys(BeStride_Constants.Riding.Flight.Restricted.Continents) do
					if continent.mapID == key and value.blocked == true then
						return false
					elseif continent.mapID == key and value.requires ~= nil and spells[value.requires] == true then
						break
					elseif continent.mapID == key and value.requires ~= nil then
						return false
					end
				end
			end
		end
		
		if countTable(BeStride_Constants.Riding.Flight.Restricted.Continents) > 0 then
			local zone = BeStride:GetMapUntil(mapID,3)
			if zone ~= nil then
				for key,value in pairsByKeys(BeStride_Constants.Riding.Flight.Restricted.Zones) do
					if zone.mapID == key and value.blocked == true then
						return false
					elseif zone.mapID == key and value.requires ~= nil and spells[value.requires] == true then
						break
					elseif zone.mapID == key then
						return false
					end
				end
			end
		end
				
		if self:IsFlyableArea() and skill >= 225 then
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

function BeStride_Logic:IsLoanedMount()
	local loanedMount = BeStride_Logic:CheckLoanedMount()
	if loanedMount ~= nil then
		return true
	else
		return false
	end
end

function BeStride_Logic:CheckLoanedMount()
	local mapID = C_Map.GetBestMapForUnit("player")
	local zone = BeStride:GetMapUntil(mapID,3)
	if zone == nil then
		return nil
	elseif IsSwimming() and (
		zone.mapID == BeStride_Constants.Zone.Vashjir.KelptharForest.id or
		zone.mapID == BeStride_Constants.Zone.Vashjir.ShimmeringExpanse.id or
		zone.mapID == BeStride_Constants.Zone.Vashjir.AbyssalDepths.id or
		zone.mapID == BeStride_Constants.Zone.Vashjir.id
	) then
		return BeStride_Mount:VashjirSeahorse()
	elseif zone.name == BeStride_Locale.Zone.Dalaran.Name then
		local subzone = GetSubZoneText()
		if subzone == BeStride_Locale.Zone.Dalaran.SubZone.Underbelly.Name or
				subzone == BeStride_Locale.Zone.Dalaran.SubZone.UnderbellyDescent.Name or
				subzone == BeStride_Locale.Zone.Dalaran.SubZone.CircleofWills.Name or
				subzone == BeStride_Locale.Zone.Dalaran.SubZone.BlackMarket.Name then
			if GetItemCount(139421, false) > 0 then
				return 139421
			end
		end
	elseif zone.name == BeStride_Locale.Zone.Oculus.Name then
		if GetItemCount(37859) == 1 then
			return 37859
		elseif GetItemCount(37860) == 1 then
			return 37860
		elseif GetItemCount(37815) == 1 then
			return 37815
		end
	elseif zone.name == BeStride_Locale.Zone.StormPeaks.Name or zone.name == BeStride_Locale.Zone.Icecrown.Name or zone.name == BeStride_Locale.Zone.SholazarBasin.Name then
		if GetItemCount(44221, false) > 0 then
			return 44221
		elseif GetItemCount(44229, false) > 0 then
			return 44229
		end
	end
	
	return nil
end

function BeStride_Logic:NoDismountWhileFlying()
	-- Check whether we can dismount while flying
	-- Returns: boolean
	-- Todo: Bitwise Compare
	if BeStride:DBGet("settings.mount.nodismountwhileflying") then
		return true
	else
		return false
	end
end

function BeStride_Logic:ForceRepair()
	-- Check whether we force a repair mount
	-- Returns: boolean
	if BeStride.db.profile.settings["repair"]["force"] then
		return true
	else
		return false
	end
end

function BeStride_Logic:UseRepair()
	-- Checks whether we check to repair or not
	-- Returns: boolean
	if BeStride.db.profile.settings["repair"]["use"] then
		return true
	else
		return false
	end
end

function BeStride_Logic:GetRepairThreshold()
	-- Get repair threshold
	-- Returns: signed integer
	if BeStride.db.profile.settings["repair"]["durability"] then
		return BeStride.db.profile.settings["repair"]["durability"]
	else
		return -1
	end
end

function BeStride_Logic:CanRepair()
	-- Check whether we can repair
	-- Returns: boolean
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

function BeStride_Logic:NeedToRepair()
	-- Check whether we need to repair
	-- Returns: boolean
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

function BeStride_Logic:IsHerbalismAndCanRobot()
	if BeStride_Logic:IsHerbalism() and not BeStride_Logic:IsCombat() and BeStride_Logic:CanRobotSetting() then
		if IsUsableSpell(134359) or IsUsableSpell(223814) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:IsHerbalism()
	local prof1,prof2 = GetProfessions()
	-- 182 = Herbalism
	-- ref: http://wowwiki.wikia.com/wiki/API_GetProfessionInfo
	if (prof1 and select(7,GetProfessionInfo(prof1)) == 182) or (prof2 and select(7,GetProfessionInfo(prof2)) == 182) then
		return true
	else
		return false
	end
end

function BeStride_Logic:CanRobotSetting()
	return BeStride:DBGet("settings.mount.forcerobot")
end

-- +----------+ --
-- Class Checks --
-- +----------+ --
function BeStride_Logic:IsDeathKnight()
	-- Check for DeathKnight
	if playerTable["class"]["id"] == 6 then
		return true
	else
		return false
	end
end

function BeStride_Logic:IsDemonHunter()
	-- Check for DemonHunter
	if playerTable["class"]["id"] == 12 then
		return true
	else
		return false
	end
end

function BeStride_Logic:IsDruid()
	-- Check for Druid
	if playerTable["class"]["id"] == 11 then
		return true
	else
		return false
	end
end

function BeStride_Logic:IsHunter()
	-- Check for Hunter
	if playerTable["class"]["id"] == 3 then
		return true
	else
		return false
	end
end

function BeStride_Logic:IsMage()
	-- Check for Mage
	if playerTable["class"]["id"] == 8 then
		return true
	else
		return false
	end
end

function BeStride_Logic:IsMonk()
	-- Check for Monk
	if playerTable["class"]["id"] == 10 then
		return true
	else
		return false
	end
end

function BeStride_Logic:IsPaladin()
	-- Check for Paladin
	if playerTable["class"]["id"] == 2 then
		return true
	else
		return false
	end
end

function BeStride_Logic:IsPriest()
	-- Check for Priest
	if playerTable["class"]["id"] == 5 then
		return true
	else
		return false
	end
end

function BeStride_Logic:IsRogue()
	-- Check for Rogue
	if playerTable["class"]["id"] == 4 then
		return true
	else
		return false
	end
end

function BeStride_Logic:IsShaman()
	-- Check for Shaman
	if playerTable["class"]["id"] == 7 then
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
	if IsSpellKnown(768) and IsUsableSpell(768) then
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

-- ------------------- --
-- Demon Hunter Spells --
-- ------------------- --

function BeStride_Logic:DemonHunterCanFelRush()
	
	if IsUsableSpell(195072) then
		local OnCooldown, _, _, _ = GetSpellCooldown(195072)
		if OnCooldown == 0 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:DemonHunterCanGlide()
	if IsUsableSpell(131347) then
		return true
	else
		return false
	end
end

-- ------------- --
-- Hunter Spells --
-- ------------- --
function BeStride_Logic:HunterCanAspectOfTheCheetah()
	if IsSpellKnown(186257) and IsUsableSpell(186257) then
		local OnCooldown, _, _, _ = GetSpellCooldown(186257)
		if OnCooldown == 0 then
			return true
		else
			return false
		end
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
		local OnCooldown, _, _, _ = GetSpellCooldown(1953)
		if OnCooldown == 0 then
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

-- ------------ --
-- Demon Hunter --
-- ------------ --

function BeStride_Logic:DemonHunterFelRush()
	if self:IsDemonHunter() then
		if self:DemonHunterCanFelRush() and BeStride:DBGet("settings.classes.demonhunter.felrush") then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:DemonHunterGlide()
	if self:IsDemonHunter() then
		if self:DemonHunterCanGlide() and BeStride:DBGet("settings.classes.demonhunter.glide") then
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

function BeStride_Logic:IsDruidTraveling()
  if self:IsDruid() then
    local index = GetShapeshiftForm()
    if index == 3 then
      return true
    end
  end
end

function BeStride_Logic:DruidFlying()
	if self:IsDruid() then
		if self:DruidCanFly() and self:DruidUseFlightForm() then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride_Logic:DruidUseFlightForm()
	if self:IsDruid() then
		if BeStride:DBGet("settings.classes.druid.flightform") then
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
	local ridingSkillLevel = 0
	local ridingSpells = {}
	
  
	for spellID,skill in pairsByKeys(BeStride_Constants.Riding.Skill) do
		if IsSpellKnown(spellID) and skill.level ~= nil and skill.level > ridingSkillLevel then
			ridingSkillLevel = skill.level
			ridingSpells[spellID] = true
		elseif IsSpellKnown(spellID) and skill.level == nil then
			ridingSpells[spellID] = true
		end
	end
	
	return ridingSkillLevel,ridingSpells
end

function BeStride_Logic:WGActive()
	return true
end