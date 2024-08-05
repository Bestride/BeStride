function BeStride:Regular()
	if self:IsKnownSpecialCombatEncounter() then
		self:DismountAndExit()
		return self:KnownSpecialCombatEncounter()
	elseif self:CanUseTargetsMount() then
		self:DismountAndExit()
		return self:UseTargetsMount()
	-- Aspect of the Cheetah is available from level 5
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
	if IsMounted() then
		action = BeStride_Mount:Dismount() .. "\n"
	else
		action = ""
	end
	if self:IsDeathKnight() and BeStride:DBGet("settings.classes.deathknight.wraithwalk") and BeStride:CanWraithWalk() then
		special = BeStride_Mount:DeathKnightWraithWalk()
		if special ~= nil then
			action = action .. special
		end
	elseif self:IsDemonHunter() and self:DemonHunterFelRush() then
		special = BeStride_Mount:DemonHunterFelRush()
		if special ~= nil then
			action = action .. special
		end
	elseif self:IsDruid() and BeStride:DBGet("settings.classes.druid.traveltotravel") then
		special = BeStride_Mount:DruidTravelForm()
		if special ~= nil then
			action = action .. special
		end
	elseif self:IsHunterAndSpecial() then
		action = action .. self:Hunter()
		if special ~= nil then
			action = action .. special
		end
	elseif self:IsMage() and (BeStride:DBGet("settings.classes.mage.blink") or BeStride:DBGet("settings.classes.mage.slowfall"))  then
		if self:MageBlink() and BeStride:DBGet("settings.classes.mage.blinkpriority") then
			special = BeStride_Mount:MageBlink()
			if special ~= nil then
				action = action .. special
			end
		else
			special = BeStride_Mount:MageSlowFall()
			if special ~= nil then
				action = action .. special
			end
		end
	elseif self:IsMonk() and BeStride:DBGet("settings.classes.monk.roll") then
		special = BeStride_Mount:MonkRoll()
		if special ~= nil then
			action = action .. special
		end
	elseif self:IsPaladin() and BeStride:DBGet("settings.classes.paladin.steed") then
		special = BeStride_Mount:PaladinDivineSteed()
		if special ~= nil then
			action = action .. special
		end
	elseif self:IsPriest() and BeStride:DBGet("settings.classes.priest.levitate") then
		special = BeStride_Mount:PriestLevitate()
		if special ~= nil then
			action = action .. special
		end
	elseif self:IsRogue() and BeStride:DBGet("settings.classes.rogue.sprint") then
		special = BeStride_Mount:RogueSprint()
		if special ~= nil then
			action = action .. special
		end
	elseif self:IsShaman() and BeStride:DBGet("settings.classes.shaman.ghostwolf") then
		special = BeStride_Mount:ShamanGhostWolf()	
		if special ~= nil then
			action = action .. special
		end
	elseif self:IsEvoker() and BeStride:DBGet("settings.classes.evoker.hover") then
		special = BeStride_Mount:EvokerHover()
		if special ~= nil then
			action = action .. special
		end
	elseif self:IsSpecialZone() then
		special = BeStride_Mount:SpecialZone()
		if special ~= nil then
			action = action .. special
		end
	end

	return action
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
