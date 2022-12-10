
function BeStride:Version_OnEnable()
end

function BeStride:IsWrath()
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

function BeStride:GetMountInfoByMountID(id)
    local creatureName,spellID,icon,active,isUsable,sourceType,isFavorite,isFactionSpecific,faction,hideOnChar,isCollected,mountID,isForDragonriding = C_MountJournal.GetMountInfoByID(id)
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
        isForDragonriding = isForDragonriding
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