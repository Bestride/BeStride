BeStride_Mount = {}

function BeStride_Mount:MountSpell(spell)
	BeStride_ABMountMount:SetAttribute("macrotext", "/cast " .. spell)
	BeStride_Debug:Debug("Mounting")
	BeStride_Debug:Verbose("Action: "..BeStride.buttons["mount"]:GetAttribute("macrotext"))
end

function BeStride_Mount:Mount(spell)
	BeStride_ABMountMount:SetAttribute("macrotext", "/use " .. spell)
	BeStride_Debug:Debug("Mounting")
	BeStride_Debug:Verbose("Action: "..BeStride.buttons["mount"]:GetAttribute("macrotext"))
	--BeStride_Debug(debugstack(2,3,2))
end

function BeStride_Mount:CountRepairMounts()
end

function BeStride_Mount:Repair()
	if #mountTable["repair"] == 0 then
		BeStride_Debug:Debug("No Mounts")
		return nil
	end
	
	local mount = mountTable["repair"][math.random(#mountTable["repair"])]
	local spell = mountTable["master"][mount]["spellID"]
	local name = GetSpellInfo(spell)
	BeStride_Debug:Debug("Mount: " .. mount)
    BeStride_Debug:Debug("Spell: " .. spell)
	BeStride_Mount:Mount(name)
end

function BeStride_Mount:Flying()
	if #mountTable["flying"] == 0 then
		BeStride_Debug:Debug("Flying no Mounts")
		return nil
	end
	
	local mount = mountTable["flying"][math.random(#mountTable["flying"])]
	local spell = mountTable["master"][mount]["spellID"]
	local name = GetSpellInfo(spell)
	BeStride_Debug:Debug("Mount: " .. mount)
    BeStride_Debug:Debug("Spell: " .. spell)
	BeStride_Mount:Mount(name)
end

function BeStride_Mount:Swimming()
	if #mountTable["swimming"] == 0 then
		BeStride_Debug:Debug("No Mounts")
		return nil
	end
	
	local mount = mountTable["swimming"][math.random(#mountTable["swimming"])]
	local spell = mountTable["master"][mount]["spellID"]
	local name = GetSpellInfo(spell)
	BeStride_Debug:Debug("Mount: " .. mount)
    BeStride_Debug:Debug("Spell: " .. spell)
	BeStride_Mount:Mount(name)
end

function BeStride_Mount:Regular()
	local ground = mountTable["ground"]
	
	for k,v in pairs(mountTable["flying"]) do table.insert(ground,v) end
	
	if #ground == 0 then
		BeStride_Debug:Debug("No Mounts")
		return nil
	end
	
	local mount = ground[math.random(#ground)]
	local spell = mountTable["master"][mount]["spellID"]
	local name = GetSpellInfo(spell)
	BeStride_Debug:Debug("Mount: " .. mount)
    BeStride_Debug:Debug("Spell: " .. spell)
	BeStride_Mount:Mount(name)
end

function BeStride_Mount:Druid()
	local travelForm, flightForm = 783, 783 -- 3 in 1 travel form

	if GetUnitSpeed("player") ~= 0 then
		BeStride_Mount:MountSpell(BeStride:SpellToName(783))
	elseif BeStride_Logic:DruidFlyingMTFF() or IsFalling() or IsFlying() or GetShapeshiftForm() == 3 then
		BeStride_Mount:MountSpell(BeStride:SpellToName(783))
	elseif IsFlying() then
		BeStride_Mount:Flying(name)
	else
		BeStride_Mount:Regular(name)
	end
end

function BeStride_Mount:DruidFlying()
	BeStride_Mount:Druid()
end

function BeStride_Mount:DruidAquaticForm()
end

function BeStride_Mount:PriestLevitate()
	if (not BeStride_Logic:IsCombat()) and BeStride_Logic:IsPriest() then
		BeStride_Debug:Debug("Can Levitate #2")
		BeStride_Mount:MountSpell("[@player] "..BeStride:SpellToName(1706).."\n/cancelaura "..BeStride:SpellToName(1706)) --Levitate
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