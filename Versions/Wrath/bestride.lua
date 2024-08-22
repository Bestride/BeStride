
function BeStride:Version_OnEnable()
    BeStride_Constants.spells.druid.flightform = 33943
    if IsPlayerSpell(40120) then
        BeStride_Constants.spells.druid.flightform = 40120
    end
    BeStride_Constants.spells.druid.aquaticform = 1066
end

function BeStride:IsClassicEra()
    return false
end

function BeStride:IsWrath()
    return true
end

function BeStride:IsCata()
    return false
end

function BeStride:IsMainline()
    return false
end

function BeStride:GetMountInfoBySpellID(id)
    local mountID = C_MountJournal.GetMountFromSpell(id)
    if mountID then
        return self:GetMountInfoByMountID(mountID)
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
        local spellId = select(10, UnitBuff("target", i))
        if not spellId then return end
        local mountId = C_MountJournal.GetMountFromSpell(spellId)
        if mountId ~= nil then
            return self:isMountUsable(mountId)
        end
    end
end
