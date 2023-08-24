function BeStride:DeathKnight()
	if not IsFlying() and self:MovementCheck() and self:DeathKnightWraithWalk() then
		return BeStride_Mount:DeathKnightWraithWalk()
	else
		BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: DKBSL")
	end
end

function BeStride:DemonHunter()
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

function BeStride:Druid()
	if IsOutdoors() ~= true and self:DruidCanCat() then
		return BeStride_Mount:DruidCatForm()
	elseif IsFalling() then
		if self:IsFlyable() and self:DruidCanFly() then
			return BeStride_Mount:DruidFlightForm()
		elseif self:DruidCanCat() then
			return BeStride_Mount:DruidCatForm() -- limit fall damage
		end
	elseif GetShapeshiftFormID() == 3 then
		if self:IsFlyable() and self:DruidCanFly() and self:DruidFlightFormPriority() then
			return BeStride_Mount:DruidFlightForm() -- assume we always prefer the fly form
		else
			return BeStride_Mount:DruidNoForm()
		end
	elseif self:IsDruidTraveling() then
		return BeStride_Mount:DruidNoForm() -- dismount like logic for druids
	elseif IsSwimming() and self:DruidCanSwim() and BeStride:DBGet("settings.mount.noswimming") == false then
		return BeStride_Mount:DruidAquaticForm()
	elseif IsMounted() and IsFlying() and self:IsFlyable() and self:DruidCanFly() and self:DruidFlyingMTFF() then
		return BeStride_Mount:DruidFlightForm()
	elseif self:IsFlyable() and self:DruidCanFly() and self:DruidFlightFormPriority() then
		return BeStride_Mount:DruidFlightForm()
	elseif self:MovementCheck() and IsOutdoors() then
		return BeStride_Mount:DruidTravelForm()
	else
		BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: DRBSL")
	end
end

function BeStride:Hunter()
	if IsMounted() and IsFlying() and self:NoDismountWhileFlying() then
		return false
	else
		return BeStride_Mount:HunterAspectOfTheCheetah()
	end

	BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: HUBSL")
end

function BeStride:Mage()
	if IsMounted() and IsFlying() and (self:MageSlowFall() or self:MageBlink()) and not self:NoDismountWhileFlying() then
		return BeStride_Mount:MageSlowFall()
	elseif (self:MageSlowFall() or self:MageBlink()) and IsFalling() then
		return BeStride_Mount:MageSlowFall()
	elseif self:MageBlink() and self:MovementCheck() then
		return BeStride_Mount:MageBlink()
	end
	BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: MABSL")
end

function BeStride:Monk()
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

function BeStride:Paladin()
	if not IsFlying() and self:MovementCheck() and self:PaladinDivineSteed() then
		return BeStride_Mount:Paladin()
	end
	BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: PABSL")
end

function BeStride:Priest()
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

function BeStride:Shaman()
	if not IsFlying() and (self:MovementCheck() or IsOutdoors ~= true) and self:ShamanGhostWolf() then
		return BeStride_Mount:Shaman()
	end
end

function BeStride:Evoker()
	if not IsFlying() and self:MovementCheck() and self:EvokerHover() then
		return BeStride_Mount:Evoker()
	end
end

function BeStride:Rogue()
	if not IsFlying() and self:MovementCheck() and self:RogueSprint() then
		return BeStride_Mount:Rogue()
	else
		BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: RGBSL")
	end
end

function BeStride:Warlock()
    if not IsFlying() and self:MovementCheck() and self:WarlockBurningRush() then
            return BeStride_Mount:Warlock()
    end
    BeStride_Debug:Error("This is a error.  Please report to the maintainer at https://www.github.com/dansheps/bestride/issues/. ID: PABSL")
end
