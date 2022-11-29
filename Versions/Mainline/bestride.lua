
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