function BeStride:Regular()
	-- Aspect of the Cheetah is available from level 5
	if self:CanUseTargetsMount() then
		self:DismountAndExit()
		return self:UseTargetsMount()
	elseif self:IsHunterAndSpecial() then
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
	elseif self:IsEvokerAndSpecial() then
		self:DismountAndExit()
		return self:Evoker()
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
	elseif self:IsDragonRidingZone() then
		return BeStride_Mount:Dragonriding()
	elseif self:IsFlyable() and IsOutdoors() and IsInGroup() == true and BeStride:DBGet("settings.mount.prioritizepassenger") == true and #mountTable["passenger"] > 0 then
		return BeStride_Mount:Passenger("flying")
	elseif self:IsFlyable() then
		return BeStride_Mount:Flying()
	elseif IsOutdoors() and IsInGroup() == true and BeStride:DBGet("settings.mount.prioritizepassenger") == true and #mountTable["passenger"] > 0  then
		return BeStride_Mount:Passenger("ground")
	elseif self:IsMountable() then
		return BeStride_Mount:Regular()
	elseif IsOutdoors() then
		return BeStride_Mount:Ground()
	else
		return nil
	end
end

function BeStride:GroundMountButton()
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

function BeStride:RepairMountButton()
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

function BeStride:PassengerMountButton(type)
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

function BeStride:Combat()
	if self:IsDeathKnight() and BeStride:DBGet("settings.classes.deathknight.wraithwalk") and BeStride:CanWraithWalk() then
		return BeStride_Mount:DeathKnightWraithWalk()
	elseif self:IsDemonHunter() and self:DemonHunterFelRush() then
		return BeStride_Mount:DemonHunterFelRush()
	elseif self:IsDruid() and BeStride:DBGet("settings.classes.druid.traveltotravel") then
		return BeStride_Mount:DruidTravelForm()
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
	elseif self:IsEvoker() and BeStride:DBGet("settings.classes.evoker.hover") then
			return BeStride_Mount:EvokerHover()
	elseif self:IsSpecialZone() then
		return BeStride_Mount:SpecialZone()
	end
end

function BeStride:DismountAndExit()
	if CanExitVehicle() then
		VehicleExit()
	elseif IsMounted() then
		Dismount()
	end
end

function BeStride:UseTargetsMount()
	local spellId = self:GetKnownMountFromTarget()
	return BeStride_Mount:MountSpell(GetSpellInfo(spellId))
end
