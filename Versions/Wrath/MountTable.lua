function BeStride:BuildMasterMountTable()
    local num = GetNumCompanions("MOUNT")
	for i=1, GetNumCompanions("MOUNT") do
		local creatureID,creatureName,creatureSpellID,icon,issummoned,mountTypeID = GetCompanionInfo("MOUNT", i)
		
        BeStride:AddNewMount(value)
	end
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