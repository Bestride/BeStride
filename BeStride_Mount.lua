BeStride_Mount = {}

function BeStride_Mount:MountSpell()
	
end

function BeStride_Mount:CountRepairMounts()
end

function BeStride_Mount:Flying()
end

function BeStride_Mount:Swimming()
end

function BeStride_Mount:Regular()
end

function BeStride_Mount:Druid()
end

function BeStride_Mount:DruidFlying()
end

function BeStride_Mount:DruidAquaticForm()
end

function BeStride_Mount:PriestLevitate()
	if (not BeStride_Logic:IsCombat()) and IsFalling() and BeStride_Logic:IsPriest() and BeStride_Logic:MovementCheck() and BeStride_Logic:PriestCanLevitate() then
		Bestride:MountSpell("[@player] "..Bestride:SpellToName(1706).."\n/cancelaura "..Bestride:SpellToName(1706)) --Levitate
	end
end

function BeStride_Mount:MageSlowFall()
	--Activate SlowFall
	Bestride:MountSpell("[@player] "..Bestride:SpellToName(130))
end

function BeStride_Mount:MageBlink()
	--Blink
	Bestride:MountSpell("[@player] "..Bestride:SpellToName(1953))
end

function BeStride_Mount:MageBlinkNoSlowFall()
	--Blink and cancel Slowfall if active, we're running on the ground or swimming.
	Bestride:MountSpell("[@player] "..Bestride:SpellToName(1953).."\n/cancelaura "..Bestride:SpellToName(130))
end

function BeStride_Mount:MonkZen()
end