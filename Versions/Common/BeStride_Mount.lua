BeStride_Mount = {}

function BeStride_Mount:MountSpell(spell)
	return "/cast " .. spell
end

function BeStride_Mount:Mount(spell)
	return "/use " .. spell
end

function BeStride_Mount:Dismount()
	return "/dismount"
end

function BeStride_Mount:CountRepairMounts()
end

function BeStride_Mount:DoMount(mounts)
	local mount = mounts[math.random(#mounts)]
	local spell = mountTable["master"][mount]["spellID"]
	local name = BeStride:GetSpellInfo(spell).name
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
	--print("" .. mount)
	local spellID,mountID,isUsable = BeStride:isMountUsable(mount)
	if BeStride:isZoneMount(mountID) then
		
		if zone ~= nil and zone.mapID == BeStride_Constants.Mount.Mounts[spellID].zone then
			return true
		elseif zone ~= nil and zone.mapID == BeStride_Constants.Mount.Mounts[mountID].zone then
			return true
		else
			return false
		end
	elseif isUsable then
		return true
	else
		return false
	end
end

function BeStride_Mount:Failback()
	local mounts = {}
	if BeStride:DBGetSetting("mount.emptyrandom") then
		
		for k,v in pairs(mountTable["master"]) do
		    if BeStride:DBGetSetting("mount.emptyrandomflying") and v.type == "flying" and BeStride:IsFlyable() then
			    table.insert(mounts,k)
			elseif BeStride:DBGetSetting("mount.emptyrandomflying") and v.type == "ground" and not BeStride:IsFlyable() then
			    table.insert(mounts,k)
		    elseif not BeStride:DBGetSetting("mount.emptyrandomflying") and self:IsUsable(k) then
			    table.insert(mounts,k)
		    end
		end
		
		if #mounts == 0 then
			BeStride_Debug:Debug("No Mounts")
			return nil
		end
		
		return self:DoMount(mounts)
	else
		return nil
	end
end

function BeStride_Mount:Regular()
	local mounts = {}
	
	
	for k,v in pairs(mountTable["ground"]) do
		--print("" .. k .. ":" .. v .. "")
		if self:IsUsable(v) and self:DBGetMountStatus("ground",v) then
			table.insert(mounts,v)
		end
	end
	if BeStride:DBGet("settings.mount.useflyingmount") and BeStride_Gaming ~= 'Wrath' then
		for k,v in pairs(mountTable["flying"]) do
			if self:IsUsable(v) and self:DBGetMountStatus("flying",v) then
				table.insert(mounts,v)
			end
		end
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
	return self:Mount(ItemToName(37011))
end

function BeStride_Mount:Loaned()
	local mount = BeStride:CheckLoanedMount()
	
	return self:MountSpell(SpellToName(mount))
end

function BeStride_Mount:VashjirSeahorse()
	if BeStride:IsSpellUsable(75207) then
		return 75207
	else
		return nil
	end
end

function BeStride_Mount:Chauffeur()
	if BeStride:IsSpellUsable(179245) then
		return self:MountSpell(SpellToName(179245))
	elseif BeStride:IsSpellUsable(179244) then
		return self:MountSpell(SpellToName(179244))
	end
end

function BeStride_Mount:Robot()
	local mounts={}

	if BeStride:IsSpellUsable(134359) then
		table.insert(mounts,134359)
	end
	if BeStride:IsSpellUsable(223814) then
		table.insert(mounts,223814)
	end

	return self:MountSpell(SpellToName(mounts[math.random(#mounts)]))
end

function BeStride_Mount:Nagrand()
	return self:MountSpell(SpellToName(164222))
end

function BeStride_Mount:ClassMovementAbility()
	local _, englishClass, index = UnitClass("player")

	local customAbility = BeStride:DBGet("settings.classes."..string.lower(englishClass)..".custom")
	if customAbility ~= nil then
		local info = BeStride:GetSpellInfo(customAbility)
		if info then
			return info.name
		end
	end
		
	return SpellToName(BeStride_Constants.ClassmovementAbilityDefaults[index])
end

function BeStride_Mount:DeathKnightWraithWalk()
	return self:MountSpell(BeStride_Mount:ClassMovementAbility())
	-- return self:MountSpell(SpellToName(212552))
end

function BeStride_Mount:DemonHunterFelRush()
	return self:MountSpell(SpellToName(195072))
end

function BeStride_Mount:DemonHunterGlide()
	return self:MountSpell(SpellToName(131347))
end

function BeStride_Mount:DruidCatForm()
	return self:MountSpell(SpellToName(BeStride_Constants.spells.druid.catform))
end

function BeStride_Mount:DruidTravelForm()
	return self:MountSpell(SpellToName(BeStride_Constants.spells.druid.travelform))
end

function BeStride_Mount:DruidAquaticForm()
	return self:MountSpell(SpellToName(BeStride_Constants.spells.druid.aquaticform))
end

function BeStride_Mount:DruidFlightForm()
	return self:MountSpell(SpellToName(BeStride_Constants.spells.druid.flightform))
end

function BeStride_Mount:DruidNoForm()
	return "/cancelform"
end

function BeStride_Mount:EvokerSoar()
	return self:MountSpell(SpellToName(BeStride_Constants.spells.evoker.soar))
end

function BeStride_Mount:HunterAspectOfTheCheetah()
	return self:MountSpell(SpellToName(186257))
end

function BeStride_Mount:PriestLevitate()
	return self:MountSpell("[@player] "..SpellToName(1706).."\n/cancelaura "..SpellToName(1706))
end

function BeStride_Mount:MageSlowFall()
	--Activate SlowFall
	return self:MountSpell("[@player] "..SpellToName(130).."\n/cancelaura "..SpellToName(130))
end

function BeStride_Mount:MageBlink()
	--Blink
	return self:MountSpell("[@player] "..SpellToName(1953))
end

function BeStride_Mount:MageBlinkNoSlowFall()
	--Blink and cancel Slowfall if active, we're running on the ground or swimming.
	return self:MountSpell("[@player] "..SpellToName(1953))
end

function BeStride_Mount:MonkRoll()
	if BeStride:IsSpellUsable(109132) then
		return self:MountSpell("[@player] " .. SpellToName(109132))
	else
		return self:MountSpell("[@player] " .. SpellToName(115008))
	end
end

function BeStride_Mount:MonkZenFlight()
	return self:MountSpell("[@player] " .. SpellToName(125883))
end

function BeStride_Mount:Paladin()
	return self:PaladinDivineSteed()
end

function BeStride_Mount:PaladinDivineSteed()
	spell = SpellToName(190784)
	if spell ~= nil and spell then
		return self:MountSpell("[@player] " .. spell .. "\n/cancelaura " .. spell)
	else
		return nil
	end
end

function BeStride_Mount:Shaman()
	return self:ShamanGhostWolf()
end

function BeStride_Mount:ShamanGhostWolf()
	return self:MountSpell("[@player] "..SpellToName(2645).."\n/cancelaura "..SpellToName(2645))
end

function BeStride_Mount:Evoker()
	return self:EvokerHover()
end

function BeStride_Mount:EvokerHover()
	return self:MountSpell("[@player] "..SpellToName(358267))
end

function BeStride_Mount:Rogue()
	return self:RogueSprint()
end

function BeStride_Mount:RogueSprint()
	return self:MountSpell("[@player] "..SpellToName(2983))
end

function BeStride_Mount:Warlock()
      return self:WarlockBurningRush()
end

function BeStride_Mount:WarlockBurningRush()
    spell = SpellToName(111400)
    if spell then
        return self:MountSpell("[@player] " .. spell .. "\n/cancelaura " .. spell)
    else
        return nil
    end
end
