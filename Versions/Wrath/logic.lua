BeStride_Game = "Wrath"


function BeStride:isMountUsable(mountId)
	--print("isMountUsable: " .. mountId)
	spellID = mountTable["master"][mountId].spellID
	
	return spellID,mountID,true
end

function BeStride:isZoneMount(mountId)
	return false
end

function BeStride:IsCombat()
	if InCombatLockdown() then
		return true
	else
		return false
	end
end