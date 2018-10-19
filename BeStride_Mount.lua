BeStride_Mount = {}

function BeStride_Mount:MountSpell(spell)
	--BeStride_Debug:Debug("Mounting")
	--BeStride_Debug:Verbose("Action: "..BeStride.buttons["mount"]:GetName())
	return "/cast " .. spell
end

function BeStride_Mount:Mount(spell)
	
	--BeStride_Debug:Debug("Mounting")
	--BeStride_Debug:Verbose("Action: "..BeStride.buttons["mount"]:GetAttribute("macrotext"))
	return "/use " .. spell
	--BeStride_Debug(debugstack(2,3,2))
end

function BeStride_Mount:CountRepairMounts()
end

function BeStride_Mount:DoMount(mounts)
	local mount = mounts[math.random(#mounts)]
	local spell = mountTable["master"][mount]["spellID"]
	local name = GetSpellInfo(spell)
	--BeStride_Debug:Debug("Mount: " .. mount)
    --BeStride_Debug:Debug("Spell: " .. spell)
	return BeStride_Mount:Mount(name)
end

function BeStride_Mount:IsUsable(mount)
	local name,spellID,icon,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,faction,shouldHideOnChar,isCollected,mountID = C_MountJournal.GetMountInfoByID(mount)
	
	if isUsable then
		return true
	else
		return false
	end
end

function BeStride_Mount:Regular()
	local mounts = {}
	
	
	for k,v in pairs(mountTable["ground"]) do if self:IsUsable(v) then table.insert(mounts,v) end end
	if BeStride:DBGet("settings.mount.useflyingmount") then
		for k,v in pairs(mountTable["flying"]) do if self:IsUsable(v) then table.insert(mounts,v) end end
	end
	
	if #mounts == 0 then
		BeStride_Debug:Debug("No Mounts")
		return nil
	end
	
	return BeStride_Mount:DoMount(mounts)
end

function BeStride_Mount:Flying()
	local mounts = {}
	
	for k,v in pairs(mountTable["flying"]) do if self:IsUsable(v) then table.insert(mounts,v) end end
	
	if #mounts == 0 then
		BeStride_Debug:Debug("No Mounts")
		return nil
	end
	
	
	return BeStride_Mount:DoMount(mounts)
end

function BeStride_Mount:Ground()
	local mounts = {}
	
	for k,v in pairs(mountTable["ground"]) do if self:IsUsable(v) then table.insert(mounts,v) end end
	
	if #mounts == 0 then
		BeStride_Debug:Debug("No Mounts")
		return nil
	end
	
	
	return BeStride_Mount:DoMount(mounts)
end

function BeStride_Mount:Swimming()
	local mounts = {}
	
	for k,v in pairs(mountTable["swimming"]) do if self:IsUsable(v) then table.insert(mounts,v) end end
	
	if #mounts == 0 then
		BeStride_Debug:Debug("No Mounts")
		return nil
	end
	
	
	return BeStride_Mount:DoMount(mounts)
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
	return BeStride_Mount:Mount(name)
end

function BeStride_Mount:DeathKnightWraithWalk()
	BeStride_Debug:Verbose("Wraith Walk")
	return nil
end

function BeStride_Mount:Druid()
	local travelForm, flightForm = 783, 783 -- 3 in 1 travel form

	if GetUnitSpeed("player") ~= 0 then
		return self:MountSpell(BeStride:SpellToName(783))
	elseif BeStride_Logic:DruidFlyingMTFF() or IsFalling() or IsFlying() or GetShapeshiftForm() == 3 then
		return self:MountSpell(BeStride:SpellToName(783))
	elseif IsFlying() then
		return self:Flying(name)
	else
		return self:Regular(name)
	end
end

function BeStride_Mount:DruidFlying()
	return self:Druid()
end

function BeStride_Mount:DruidAquaticForm()
end

function BeStride_Mount:DruidTravel()
	return self:MountSpell(BeStride:SpellToName(783))
end

function BeStride_Mount:PriestLevitate()
	return self:MountSpell("[@player] "..BeStride:SpellToName(1706).."\n/cancelaura "..BeStride:SpellToName(1706))
end

function BeStride_Mount:MageSlowFall()
	--Activate SlowFall
	return self:MountSpell("[@player] "..BeStride:SpellToName(130).."\n/cancelaura "..BeStride:SpellToName(130))
end

function BeStride_Mount:MageBlink()
	--Blink
	return self:MountSpell("[@player] "..BeStride:SpellToName(1953))
end

function BeStride_Mount:MageBlinkNoSlowFall()
	--Blink and cancel Slowfall if active, we're running on the ground or swimming.
	return self:MountSpell("[@player] "..BeStride:SpellToName(1953))
end

function BeStride_Mount:MonkRoll()
	BeStride_Debug:Verbose("Monk Roll")
	if IsUsableSpell(109132) then
		return self:MountSpell("[@player] " .. BeStride:SpellToName(109132))
	else
		return self:MountSpell("[@player] " .. BeStride:SpellToName(115008))
	end
end

function BeStride_Mount:MonkZenFlight()
	return self:MountSpell("[@player] " .. BeStride:SpellToName(125883))
end

function BeStride_Mount:Paladin()
	return self:PaladinDivineSteed()
end

function BeStride_Mount:PaladinDivineSteed()
	return self:MountSpell("[@player] "..BeStride:SpellToName(190784).."\n/cancelaura "..BeStride:SpellToName(190784))
end

function BeStride_Mount:Shaman()
	return self:ShamanGhostWolf()
end

function BeStride_Mount:ShamanGhostWolf()
	return self:MountSpell("[@player] "..BeStride:SpellToName(2645).."\n/cancelaura "..BeStride:SpellToName(2645))
end