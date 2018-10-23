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
	--print(mount .. ":" .. spell .. ":" .. name)
	--BeStride_Debug:Debug("Mount: " .. mount)
    --BeStride_Debug:Debug("Spell: " .. spell)
	return BeStride_Mount:Mount(name)
end

function BeStride_Mount:DBGetMountStatus(mountType,key)

	local mounts = BeStride:DBGet("mounts." .. mountType)
	local status = mounts[key]
	if status ~= nil and status then
		return true
	elseif status == nil and BeStride:DBGet("settings.mount.enablenew") then
		return true
	else
		return false
	end
end

function BeStride_Mount:IsUsable(mount)
	local name,spellID,icon,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,faction,shouldHideOnChar,isCollected,mountID = C_MountJournal.GetMountInfoByID(mount)
	
	if isUsable then
		return true
	else
		return false
	end
end

function BeStride_Mount:Failback()
	local mounts = {}
	
	for k,v in pairs(mountTable["master"]) do if self:IsUsable(k) then table.insert(mounts,k) end end
	
	if #mounts == 0 then
		BeStride_Debug:Debug("No Mounts")
		return nil
	end
	
	return self:DoMount(mounts)
end

function BeStride_Mount:Regular()
	local mounts = {}
	
	
	for k,v in pairs(mountTable["ground"]) do if self:IsUsable(v) and self:DBGetMountStatus("ground",v) then table.insert(mounts,v) end end
	if BeStride:DBGet("settings.mount.useflyingmount") then
		for k,v in pairs(mountTable["flying"]) do if self:IsUsable(v) and self:DBGetMountStatus("flying",v) then table.insert(mounts,v) end end
	end
	
	if #mounts == 0 then
		return self:Failback()
	end
	
	return self:DoMount(mounts)
end

function BeStride_Mount:Flying()
	local mounts = {}
	
	for k,v in pairs(mountTable["flying"]) do if self:IsUsable(v) and self:DBGetMountStatus("flying",v) then table.insert(mounts,v) end end
	
	if #mounts == 0 then
		return self:Failback()
	end
	
	return BeStride_Mount:DoMount(mounts)
end

function BeStride_Mount:Ground()
	local mounts = {}
	
	for k,v in pairs(mountTable["ground"]) do if self:IsUsable(v) and self:DBGetMountStatus("ground",v) then table.insert(mounts,v) end end
	
	if #mounts == 0 then
		return self:Failback()
	end
	
	return BeStride_Mount:DoMount(mounts)
end

function BeStride_Mount:Swimming()
	local mounts = {}
	
	for k,v in pairs(mountTable["swimming"]) do if self:IsUsable(v) and self:DBGetMountStatus("swimming",v) then table.insert(mounts,v) end end
	
	if #mounts == 0 then
		for k,v in pairs(mountTable["swimming"]) do if self:IsUsable(v) then table.insert(mounts,v) end end
		if #mounts == 0 then
			return self:Failback()
		end
	end
	
	
	return BeStride_Mount:DoMount(mounts)
end

function BeStride_Mount:Repair()
	local mounts = {}
	
	for k,v in pairs(mountTable["repair"]) do if self:IsUsable(v) and self:DBGetMountStatus("repair",v) then table.insert(mounts,v) end end
	
	if #mounts == 0 then
		for k,v in pairs(mountTable["repair"]) do if self:IsUsable(v) then table.insert(mounts,v) end end
		if #mounts == 0 then
			return self:Failback()
		end
	end
	
	
	return BeStride_Mount:DoMount(mounts)
end

function BeStride_Mount:Passenger(type)
	local mounts = {}
	
	for k,v in pairs(mountTable["passenger"]) do if self:IsUsable(v) and self:DBGetMountStatus("passenger",v) and ( (type ~= nil and mountTable.master[v].type) or type == nil ) then table.insert(mounts,v) end end
	
	if #mounts == 0 then
		for k,v in pairs(mountTable["passenger"]) do if self:IsUsable(v) then table.insert(mounts,v) end end
		if #mounts == 0 then
			return self:Failback()
		end
	end
	
	
	return BeStride_Mount:DoMount(mounts)
end

function BeStride_Mount:Broom()
	self:Mount(BeStride:ItemToName(37011))
end

function BeStride_Mount:Loaned()
	local mount = BeStride_Logic:CheckLoanedMount()
	
	self:MountSpell(BeStride:SpellToName(mount))
end

function BeStride_Mount:Chauffeur()
	if IsUsableSpell(179245) then
		self:MountSpell(BeStride:SpellToName(179245))
	elseif IsUsableSpell(179244) then
		self:MountSpell(BeStride:SpellToName(179244))
	end
end

function BeStride_Mount:Nagrand()
	return self:MountSpell(BeStride:SpellToName(164222))
end

function BeStride_Mount:DeathKnightWraithWalk()
	return self:MountSpell(BeStride:SpellToName(212552))
end

function BeStride_Mount:DemonHunterFelRush()
	return self:MountSpell(BeStride:SpellToName(195072))
end

function BeStride_Mount:DemonHunterGlide()
	return self:MountSpell(BeStride:SpellToName(131347))
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
	--BeStride_Debug:Verbose("Monk Roll")
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

function BeStride_Mount:Rogue()
	return self:RogueSprint()
end

function BeStride_Mount:RogueSprint()
	return self:MountSpell("[@player] "..BeStride:SpellToName(2983))
end