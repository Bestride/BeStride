BeStride_Game = "Mainline"

local class = UnitClass("player")

function BeStride:isMountUsable(mount)
	local name,spellID,icon,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,faction,shouldHideOnChar,isCollected,mountID = C_MountJournal.GetMountInfoByID(mount)
	
	return spellID,mountID,isUsable
end

function BeStride:IsZoneMount(mountId)
	spellId = mountTable.master[mountId].spellID
	if mountTable.master[mountId].type == "zone" and BeStride_Constants.Mount.Mounts[spellId] ~= nil and BeStride_Constants.Mount.Mounts[spellId].zone ~= nil then
		return true
	elseif BeStride_Game == "Mainline" and mountTable.master[mountId].type == "zone" and BeStride_Constants.Mount.Mounts[mountId] ~= nil and BeStride_Constants.Mount.Mounts[mountId].zone ~= nil then
		return true
	end

	return false
end
