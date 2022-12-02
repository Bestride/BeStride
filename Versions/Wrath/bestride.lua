
function BeStride:Version_OnEnable()
    BeStride_Constants.spells.druid.flightform = 33943
    if IsPlayerSpell(40120) then
        BeStride_Constants.spells.druid.flightform = 40120
    end
    BeStride_Constants.spells.druid.aquaticform = 1066
end

function BeStride:IsWrath()
    return true
end

function BeStride:IsMainline()
    return false
end

function BeStride:GetMountInfoBySpellID(id)
    for i=1, GetNumCompanions("MOUNT") do
		mount = self:GetMountInfoByIndex(i)
        if mount.spellID == id then
            return mount
        end
	end
end

function BeStride:GetMountInfoByMountID(id)
    for i=1, GetNumCompanions("MOUNT") do
		mount = self:GetMountInfoByIndex(i)
        if mount.mountID == id then
            return mount
        end
	end
end

function BeStride:GetMountInfoByIndex(index)
    local mountID,creatureName,spellID,icon,isSummoned = GetCompanionInfo("MOUNT", index)
    return {
        creatureName = creatureName,
        spellID = spellID,
        mountID = mountID,
        icon = icon,
        active = nil,
        isUsable = nil,
        sourceType = nil,
        isFavorite = nil,
        isFactionSpecific = nil,
        faction = nil,
        hideOnChar = nil,
        isCollected = true,
        isForDragonriding = nil
    }
end