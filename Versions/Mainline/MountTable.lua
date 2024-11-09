function BeStride:BuildMasterMountTable()
	for key,value in pairs(C_MountJournal.GetMountIDs()) do
		local name,spellID,icon,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,faction,shouldHideOnChar,isCollected,mountID,isSteadyFlight = C_MountJournal.GetMountInfoByID(value)
		
		if isCollected then
			BeStride:AddNewMount(value)
		end
	end

	for _,value in pairs(C_MountJournal.GetCollectedDragonridingMounts()) do
		-- With dynamic flying, we can treat any 'dragonriding' mount as a flying mount
		-- Note that some mounts can steady flight but NOT dynamic fly (ie. Otterworldy Ottuk)
		mountTable["master"][value]["canFly"] = true
	end
end



function BeStride:AddNewMount(mountId)
	local name,spellID,icon,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,faction,shouldHideOnChar,isCollected,mountID,isSteadyFlight = C_MountJournal.GetMountInfoByID(mountId)
	local creatureDisplayInfoID,description,source,isSelfMount,mountTypeID,uiModelSceneID,animID,spellVisualKitID,disablePlayerMountPreview = C_MountJournal.GetMountInfoExtraByID(mountId)
			
	if isFactionSpecific then
		faction = faction
	else
		faction = nil
	end
	
	if BeStride_Constants.Mount.Types[mountTypeID] == 'flying' then
	    canFly = true
	else
	    canFly = false
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
		["isSteadyFlight"] = isSteadyFlight,
		["type"] = BeStride_Constants.Mount.Types[mountTypeID],
		["subtype"] = nil,
		["canFly"] = canFly
	}
	
	if BeStride_Constants.Mount.Mounts[spellID]  then
		mountOverrides = BeStride_Constants.Mount.Mounts[spellID]
		if mountOverrides["subtype"] then
		    mountTable["master"][mountId]["subtype"] = mountOverrides["subtype"]
		end
	end
	
end

function BeStride:PrintAllMounts()
	for key,value in pairs(C_MountJournal.GetMountIDs()) do
		local name,spellID,icon,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,faction,shouldHideOnChar,isCollected,mountID,isSteadyFlight = C_MountJournal.GetMountInfoByID(value)
		
		if mountID == nil then
		    print("" .. key .. ":" .. value .. ":" .. name .. ":" )
		end
		local creatureDisplayInfoID,description,source,isSelfMount,mountTypeID,uiModelSceneID,animID,spellVisualKitID,disablePlayerMountPreview = C_MountJournal.GetMountInfoExtraByID(value)
		if isCollected then
			print("" .. mountID .. ":" .. name .. ":" .. spellID  .. ":" .. icon .. ":" .. ":" .. mountTypeID .. "")
		end
	end
end