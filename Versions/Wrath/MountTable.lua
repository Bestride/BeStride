function BeStride:BuildMasterMountTable()
	for key,value in pairs(C_MountJournal.GetMountIDs()) do
		local name,spellID,icon,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,faction,shouldHideOnChar,isCollected,mountID,isSteadyFlight = C_MountJournal.GetMountInfoByID(value)
		
		--print("" .. name .. ":" .. mountID .. ":" .. spellID )
		if isCollected then
			BeStride:AddNewMount(value)
		end
	end
end



function BeStride:AddNewMount(mountId)
	local name,spellID,icon,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,faction,shouldHideOnChar,isCollected,mountID,isSteadyFlight = C_MountJournal.GetMountInfoByID(mountId)
	local creatureDisplayInfoID,description,source,isSelfMount,mountTypeID,uiModelSceneID = C_MountJournal.GetMountInfoExtraByID(mountId)

	if BeStride_Constants.Mount.Types[mountTypeID] == nil then
		print("" .. name .. ":" .. mountID .. ":" .. spellID .. ":" .. mountTypeID)
	--elseif mountId == 678 then
	--		print("" .. name .. ":" .. mountID .. ":" .. spellID .. ":" .. mountTypeID)
	end
			
	if isFactionSpecific then
		faction = faction
	else
		faction = nil
	end
	
	mountTable["master"][mountId] = {
		["name"] = name,
		["spellID"] = spellID,
		["mountID"] = mountID,
		["factionLocked"] = isFactionSpecific,
		["faction"] = faction,
		["description"] = description,
		["isActive"] = isActive,
		["isUsable"] = isUsable,
		["isCollected"] = isCollected,
		["icon"] = icon,
		["source"] = source,
		["sourceType"] = sourceType,
		["type"] = BeStride_Constants.Mount.Types[mountTypeID],
	}
end

function BeStride:PrintAllMounts()
	for key,value in pairs(C_MountJournal.GetMountIDs()) do
		local name,spellID,icon,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,faction,shouldHideOnChar,isCollected,mountID,isSteadyFlight = C_MountJournal.GetMountInfoByID(value)
		local creatureDisplayInfoID,description,source,isSelfMount,mountTypeID,uiModelSceneID = C_MountJournal.GetMountInfoExtraByID(mountId)
		if isCollected then
			print("" + mountID + ":" + name + ":" + spellID  + ":" + icon + ":" + isSummoned + ":" + mountTypeID+"")
		end
	end
end