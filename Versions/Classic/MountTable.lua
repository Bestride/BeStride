function BeStride:BuildMasterMountTable()
    local num = GetNumCompanions("MOUNT")
	for i=1, GetNumCompanions("MOUNT") do
		local mountID,name,spellID,icon,isSummoned, mountTypeID = GetCompanionInfo("MOUNT", i)
		if mountTable["master"][spellID] == nil then
			BeStride:AddNewMount(i)
		end
	end
	--print("End mount table")
end


function BeStride:AddNewMount(mountId)
    local mountID,name,spellID,icon,isSummoned = GetCompanionInfo("MOUNT", mountId)
	if not BeStride_MountDB[spellID] then	
		print("Mount not in DB:")
		print("\tMount Number:" .. mountId)
		print("\tSpell ID:" .. spellID)
		print("\tMount ID:" .. mountID)
		if name then
		    print("\tName: " .. name)
		end
		return
	end

	if BeStride_MountDB[spellID].attributes.flying == true then
		mountType = "flying"
	elseif BeStride_MountDB[spellID].attributes.ground == true then
		mountType = "ground"
	else
		mountType = "unknown"
	end

	if not name and BeStride_MountDB[spellID].name then
		name = BeStride_MountDB[spellID].name
	end

	mountTable["master"][mountID] = {
		["name"] = name,
		["spellID"] = spellID,
		["mountID"] = mountID,
		["isActive"] = isSummoned,
		["faction"] = nil,
		["icon"] = icon,
		["source"] = BeStride_MountDB[spellID].source,
		["type"] = mountType,
	}
end