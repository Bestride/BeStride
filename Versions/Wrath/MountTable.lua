function BeStride:BuildMasterMountTable()
    local num = GetNumCompanions("MOUNT")
	--print("Start mount table")
	for i=1, GetNumCompanions("MOUNT") do
		local mountID,name,spellID,icon,isSummoned = GetCompanionInfo("MOUNT", i)

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
		print("\tName: " .. name)
		print("\tMount ID:" .. mountID)
		print("\tSpell ID:" .. spellID)
		return

	if BeStride_MountDB[spellID][10] == true then
		mountType = "flying"
	elseif BeStride_MountDB[spellID][9] == true then
		mountType = "ground"
	else
		mountType = "unknown"
	end

	mountTable["master"][mountID] = {
		["name"] = name,
		["spellID"] = spellID,
		["mountID"] = mountID,
		["isActive"] = isSummoned,
		["faction"] = nil,
		["icon"] = icon,
		["source"] = BeStride_MountDB[spellID][8],
		["type"] = mountType,
	}
end