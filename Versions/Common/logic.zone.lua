function BeStride:IsFlyableArea()
	return IsFlyableArea()
end

function BeStride:IsMountable()
	if self:IsFlyable() and IsOutdoors() then
		return true
	elseif not self:IsFlyable() and IsOutdoors() then
		return true
	elseif not IsOutdoors() then
		return false
	else
		return false
	end
end

function BeStride:IsFlyable()
	if IsOutdoors() then
		local skill,spells = self:GetRidingSkill()
		local mapID = C_Map.GetBestMapForUnit("player")
		
		if countTable(BeStride_Constants.Riding.Flight.Restricted.Continents) > 0 then
			local continent = BeStride:GetMapUntil(mapID,2)
			if continent ~= nil then
				for key,value in pairsByKeys(BeStride_Constants.Riding.Flight.Restricted.Continents) do
					if continent.mapID == key and value.blocked == true then
						return false
					elseif continent.mapID == key and value.requires ~= nil and spells[value.requires] == true then
						break
					elseif continent.mapID == key and value.requires ~= nil then
						return false
					end
				end
			end
		end
		
		if countTable(BeStride_Constants.Riding.Flight.Restricted.Continents) > 0 then
			local zone = BeStride:GetMapUntil(mapID,3)
			if zone ~= nil then
				for key,value in pairsByKeys(BeStride_Constants.Riding.Flight.Restricted.Zones) do
					if zone.mapID == key and value.blocked == true and (not value.except or (value.except and value.except ~= GetSubZoneText())) then
						return false
					elseif zone.mapID == key and value.requires ~= nil and spells[value.requires] == true then
						break
					elseif zone.mapID == key and value.requires ~= nil then
						return false
					end
				end
			end
		end
				
		if self:IsFlyableArea() and skill >= 225 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride:IsUnderwater()
	if IsSwimming() and BeStride:DBGet("settings.mount.noswimming") == false then
		local timer, initial, maxvalue, scale, paused, label = GetMirrorTimerInfo(2)
		if timer ~= nil and timer == "BREATH" and scale < 0 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride:IsSpecialZone()
	local mapID = C_Map.GetBestMapForUnit("player")
	local micro = BeStride:GetMapUntil(mapID,5)
	local continent = BeStride:GetMapUntil(mapID,2)

	if continent == nil or micro == nil then
		return false
	end
	
	if continent.name == LibStub("AceLocale-3.0"):GetLocale("BeStride")["Continent.Draenor"] and micro.name == LibStub("AceLocale-3.0"):GetLocale("BeStride")["Zone.Nagrand"] and self:DBGet("settings.mount.telaari") == true then
		local spellID = BeStride:GetSpellInfo(161691).spellID
		if(spellID == 165803 or spellID == 164222) then
			return true
		end
	end
	
	return false
end

-- { DungeonEncounterID, maybeEnablingSpellId, BeStride_Mount:FnName }
BeStride.knownEncounters = {
	{
		2786, -- Tindral Sageswift, Seer of the Flame; Amirdrassil, the Dream's Hope
		415095, -- Empowered Feather is the buff that enables Dragonriding
		"Flying" -- BeStride_Mount Function to call - This is a dragonriding encounter, so call flying (TWW makes it flying and not Dragonriding specific)
	}
}

-- Some encounters, such as Tindral Sageswift in 10.2's Amirdrassil, require mounting
-- as a part of the encounter. Check for known cases and enable BeStride Mounting during
-- these encounters.
function BeStride:IsKnownSpecialCombatEncounter()
	if not BeStride:IsCombat() or BeStride.encounterId == nil then
		return nil
	end

	for _, encounter in pairs(BeStride.knownEncounters) do
		local encounterId, maybeEnablingSpellId = unpack(encounter)
		if BeStride.encounterId == encounterId then
			if maybeEnablingSpellId ~= nil then
				local isProperAuraCurrentlyApplied = C_UnitAuras.GetPlayerAuraBySpellID(maybeEnablingSpellId) ~= nil
				return isProperAuraCurrentlyApplied and encounter or nil
			else
				-- If we're in a known encounter but there's no Spell ID required, assume we can mount I guess?
				return encounter
			end
		end
	end
end

function BeStride:WGActive()
	return true
end