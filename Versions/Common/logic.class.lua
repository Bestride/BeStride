function BeStride:IsDeathKnight()
	-- Check for DeathKnight
	if playerTable["class"]["id"] == 6 then
		return true
	else
		return false
	end
end

function BeStride:IsDemonHunter()
	-- Check for DemonHunter
	if playerTable["class"]["id"] == 12 then
		return true
	else
		return false
	end
end

function BeStride:IsDruid()
	-- Check for Druid
	if playerTable["class"]["id"] == 11 then
		return true
	else
		return false
	end
end

function BeStride:IsHunter()
	-- Check for Hunter
	if playerTable["class"]["id"] == 3 then
		return true
	else
		return false
	end
end

function BeStride:IsMage()
	-- Check for Mage
	if playerTable["class"]["id"] == 8 then
		return true
	else
		return false
	end
end

function BeStride:IsMonk()
	-- Check for Monk
	if playerTable["class"]["id"] == 10 then
		return true
	else
		return false
	end
end

function BeStride:IsPaladin()
	-- Check for Paladin
	if playerTable["class"]["id"] == 2 then
		return true
	else
		return false
	end
end

function BeStride:IsPriest()
	-- Check for Priest
	if playerTable["class"]["id"] == 5 then
		return true
	else
		return false
	end
end

function BeStride:IsRogue()
	-- Check for Rogue
	if playerTable["class"]["id"] == 4 then
		return true
	else
		return false
	end
end

function BeStride:IsShaman()
	-- Check for Shaman
	if playerTable["class"]["id"] == 7 then
		return true
	else
		return false
	end
end

function BeStride:IsDeathKnightAndSpecial()
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

function BeStride:IsDemonHunterAndSpecial()
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

function BeStride:IsDruidAndSpecial()
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

function BeStride:IsHunterAndSpecial()
	if self:IsHunter() and BeStride:DBGet("settings.classes.hunter.aspectofthecheetah") then
		if (self:MovementCheck() or self:IsCombat()) and self:HunterCanAspectOfTheCheetah() then
			return true
		end
	end
	return false
end

function BeStride:IsMageAndSpecial()
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

function BeStride:IsMonkAndSpecial()
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

function BeStride:IsPaladinAndSpecial()
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

function BeStride:IsPriestAndSpecial()
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

function BeStride:IsRogueAndSpecial()
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

function BeStride:IsShamanAndSpecial()
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



-- +--------------------------+ --
-- Class Specific Spells Checks --
-- +--------------------------+ --
-- ------------ --
-- Druid Spells --
-- ------------ --

-- Check for Swim Form
-- Returns: boolean
function BeStride:DruidCanSwim()
	if IsUsableSpell(BeStride_Constants.spells.druid.aquaticform) then
		return true
	else
		return false
	end
end

-- Check for Travel Form
-- Returns: boolean
function BeStride:DruidCanTravel()
	if IsUsableSpell(BeStride_Constants.spells.druid.travelform) then
		return true
	else
		return false
	end
end

-- Check for Travel Form
-- Returns: boolean
function BeStride:DruidCanCat()
	if IsSpellKnown(BeStride_Constants.spells.druid.catform) and IsUsableSpell(BeStride_Constants.spells.druid.catform) then
		return true
	else
		return false
	end
end

-- Check for Flight Form
-- Returns: boolean
function BeStride:DruidCanFly()
	if IsPlayerSpell(BeStride_Constants.spells.druid.flightform) then
		return true
	else
		return false
	end
end

-- ------------------ --
-- Deathknight Spells --
-- ------------------ --

function BeStride:DeathKnightCanWraithWalk()
	if IsUsableSpell(212552) then
		return true
	else
		return false
	end
end

-- ------------------- --
-- Demon Hunter Spells --
-- ------------------- --

function BeStride:DemonHunterCanFelRush()
	
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

function BeStride:DemonHunterCanGlide()
	if IsUsableSpell(131347) then
		return true
	else
		return false
	end
end

-- ------------- --
-- Hunter Spells --
-- ------------- --
function BeStride:HunterCanAspectOfTheCheetah()
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

function BeStride:MageCanSlowFall()
	if IsUsableSpell(1706) then
		return true
	else
		return false
	end
end

function BeStride:MageCanBlink()
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

function BeStride:MonkCanRoll()
	if IsUsableSpell(109132) or self:MonkCanTorpedo() then
		return true
	else
		return false
	end
end

function BeStride:MonkCanTorpedo()
	if IsUsableSpell(115008) then
		return true
	else
		return false
	end
end

function BeStride:MonkCanZenFlight()
	if IsUsableSpell(125883) then
		return true
	else
		return false
	end
end

-- ------------- --
-- Priest Spells --
-- ------------- --

function BeStride:PaladinCanDivineSteed()
	if IsUsableSpell(190784) then
		return true
	else
		return false
	end
end

-- ------------- --
-- Priest Spells --
-- ------------- --

function BeStride:PriestCanLevitate()
	if IsUsableSpell(1706) then
		return true
	else
		return false
	end
end

-- ------------- --
-- Shaman Spells --
-- ------------- --

function BeStride:ShamanCanGhostWolf()
	if IsUsableSpell(2645) then
		return true
	else
		return false
	end
end

-- ------------- --
-- Rogue Spells --
-- ------------- --

function BeStride:RogueCanSprint()
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

function BeStride:DeathKnightWraithWalk()
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

function BeStride:DemonHunterFelRush()
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

function BeStride:DemonHunterGlide()
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

function BeStride:IsDruidTraveling()
	if self:IsDruid() then
		local index = GetShapeshiftForm()
		if BeStride_Game == "Mainline" and index == 3 then
			return true
		elseif index == 2 or index == 4 or index == 6 then -- Wrath traveling forms (ground, swimming, flying)
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride:DruidFlying()
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

function BeStride:DruidUseFlightForm()
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

function BeStride:DruidTravelToTravel()
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

function BeStride:DruidFlightFormPriority()
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
function BeStride:DruidFlyingMTFF()
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

function BeStride:MageSpecial()
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

function BeStride:MageBlink()
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

function BeStride:MageSlowFall()
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

function BeStride:MonkRoll()
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

function BeStride:MonkZenFlight()
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

function BeStride:PaladinDivineSteed()
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

function BeStride:PriestLevitate()
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

function BeStride:RogueSprint()
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

function BeStride:ShamanGhostWolf()
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