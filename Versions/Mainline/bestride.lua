
function BeStride:Version_OnEnable()
end

function BeStride:IsClassicEra()
    return false
end

function BeStride:IsWrath()
    return false
end

function BeStride:IsCata()
    return false
end

function BeStride:IsMainline()
    return true
end

function BeStride:GetMountInfoBySpellID(id)
    local mountID = C_MountJournal.GetMountFromSpell(id)
    if mountID then
        return self:GetMountInfoByMountID(mountID)
    end
end

function BeStride:IsSpellUsable(spell)
    if C_Spell.IsSpellUsable then
        return C_Spell.IsSpellUsable(spell)
    elseif C_Spell.IsUsableSpell then
        return C_Spell.IsUsableSpell(spell)
    elseif IsUsableSpell then
        return IsUsableSpell(spell)
    else
        return false
    end
end

function BeStride:GetSpellInfo(spell)
	if C_Spell.GetSpellInfo then
		local info = C_Spell.GetSpellInfo(spell)
		if info and type(info) == "table" then
			return { name = info.name, spellID = info.spellID }
        elseif info then
			local name,_,_,_,_,_,spellID = C_Spell.GetSpellInfo(spell)
			return { name = name, spellID = spellID }
        else
            return nil
		end
	elseif GetSpellInfo then
		local name,_,_,_,_,_,spellID = GetSpellInfo(spell)
        if name then
		    return { name = name, spellID = spellID }
        else
            return nil    
        end
	else
		return nil
	end
end

function BeStride:GetSpellOnCooldown(spell)
    if C_Spell.GetSpellCooldown then
		local info = C_Spell.GetSpellCooldown(spell)
		if info and type(info) == "table" then
			return info.duration ~= 0
		else
			local onCooldown, _, _, _ = GetSpellCooldown(195072)
			return onCooldown ~= 0
		end
	elseif GetSpellCooldown then
		local onCooldown, _, _, _ = GetSpellCooldown(195072)
		return onCooldown ~= 0
	else
		return nil
	end
end

function BeStride:GetMountInfoByMountID(id)
    local creatureName,spellID,icon,active,isUsable,sourceType,isFavorite,isFactionSpecific,faction,hideOnChar,isCollected,mountID,isSteadyFlight = C_MountJournal.GetMountInfoByID(id)
    return {
        creatureName = creatureName,
        spellID = spellID,
        mountID = mountID,
        icon = icon,
        active = active,
        isUsable = isUsable,
        sourceType = sourceType,
        isFavorite = isFavorite,
        isFactionSpecific = isFactionSpecific,
        faction = faction,
        hideOnChar = hideOnChar,
        isCollected = isCollected,
        isSteadyFlight = isSteadyFlight
    }
end

function BeStride:GetMountInfoByIndex(index)
    return nil
end

function BeStride:GetKnownMountFromTarget()
    for i=1,40,1 do
        local info = C_UnitAuras.GetBuffDataByIndex("target", i)
        if not info then return end
        local mountId = C_MountJournal.GetMountFromSpell(info.spellId)
        if mountId ~= nil then
            return self:isMountUsable(mountId)
        end
    end
end