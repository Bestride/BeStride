BeStride_Mount = {}

function BeStride_Mount:MountSpell(spell)
	BeStride_ABMountMount:SetAttribute("macrotext", "/script print('hello world')\n/use " .. spell)
	BeStride_Debug:Debug("Mounting")
	BeStride_Debug:Debug("Action: "..BeStride.buttons["mount"]:GetAttribute("macrotext"))
	--BeStride_Debug(debugstack(2,3,2))
end

function BeStride_Mount:CountRepairMounts()
end

function BeStride_Mount:Flying()
	local flying = mountTable["flying"]
	print(#flying)
	if #mountTable["flying"] == 0 then
		BeStride_Debug:Debug("No Mounts")
		return nil
	end
	
	local mount = mountTable["flying"][math.random(#mountTable["flying"])]
	local spell = mountTable["master"][mount]["spellID"]
	local name = GetSpellInfo(spell)
	BeStride_Debug:Debug("Mount: " .. mount)
    BeStride_Debug:Debug("Spell: " .. spell)
	BeStride_Mount:MountSpell(name)
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
		Bestride_Mount:MountSpell("[@player] "..Bestride:SpellToName(1706).."\n/cancelaura "..Bestride:SpellToName(1706)) --Levitate
	end
end

function BeStride_Mount:MageSlowFall()
	--Activate SlowFall
	Bestride_Mount:MountSpell("[@player] "..Bestride:SpellToName(130))
end

function BeStride_Mount:MageBlink()
	--Blink
	Bestride_Mount:MountSpell("[@player] "..Bestride:SpellToName(1953))
end

function BeStride_Mount:MageBlinkNoSlowFall()
	--Blink and cancel Slowfall if active, we're running on the ground or swimming.
	Bestride_Mount:MountSpell("[@player] "..Bestride:SpellToName(1953).."\n/cancelaura "..Bestride:SpellToName(130))
end

function BeStride_Mount:MonkZen()
end