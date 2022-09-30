function BeStride:BuildMasterMountTable()
    local num = GetNumCompanions("MOUNT")
	print("Start mount table")
	for i=1, GetNumCompanions("MOUNT") do
		local creatureID,creatureName,creatureSpellID,icon,issummoned,mountTypeID = GetCompanionInfo("MOUNT", i)
		--BeStride_Debug:Info("Mount Info: " + creatureID + ":" + creatureName + ":" + creatureSpellID + ":" + mountTypeID + "")
        print("Mount Info: " + creatureID + ":" + creatureName + ":" + creatureSpellID + ":" + mountTypeID + "")
		BeStride:AddNewMount(value)
	end
	print("End mount table")
end


function BeStride:AddNewMount(mountId)
    local mountID,name,spellID,icon,isSummoned,mountTypeID = GetCompanionInfo("MOUNT", i)
			
	if isFactionSpecific then
		faction = faction
	else
		faction = nil
	end
	
	mountTable["master"][mountId] = {
		["name"] = name,
		["spellID"] = spellID,
		["mountID"] = mountID,
		["isActive"] = isSummoned,
		["type"] = BeStride_Constants.Mount.Types[mountTypeID],
	}
end