
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

function BeStride:GetKnownMountFromTarget()
	local mountIdBySpellId = {}
	for i=1,GetNumCompanions("MOUNT"),1 do
		local mountID,name,spellID,icon,isSummoned = GetCompanionInfo("MOUNT", i)
		mountIdBySpellId[spellID] = mountID
	end
	-- look for unit aura that matches known AND usable mount ID
	for i=1,40,1 do
		local spellId = select(10,UnitBuff("target",i))
		if mountIdBySpellId[spellId] ~= nil then
            return spellId, mountIdBySpellId[spellId], true
		end
	end
end