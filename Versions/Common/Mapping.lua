
function BeStride:GetMapName(locID,filter)
	local map = self:GetMapUntil(locID,filter)
	return map.name
end

function BeStride:GetMap()
	return C_Map.GetBestMapForUnit("player")
end

function BeStride:GetMapUntil(locID,filter,printOut)
	if not locID then
		return nil
	end
	local map = C_Map.GetMapInfo(locID)
	
	if printOut == true then
		print(map.mapID .. ":" .. map.name .. ":" .. map.mapType .. ":" .. map.parentMapID)
	end
	
	if map.mapType == filter then
		return map
	elseif map.mapType > filter and map.parentMapID ~= nil and map.parentMapID ~= 0 then
		return self:GetMapUntil(map.parentMapID,filter,printOut) or map
	else
		return nil
	end
end

function BeStride:GetMapUntilLast(locID,filter,printOut)
	local map = C_Map.GetMapInfo(locID)
	
	if printOut == true then
		print(map.mapID .. ":" .. map.name .. ":" .. map.mapType .. ":" .. map.parentMapID)
	end
	
	if (map.parentMapID == 0 or map.parentMapID == nil) and map.mapType >= filter then
		return map
	elseif map.parentMapID ~= 0 and map.parentMapID ~= nil and map.mapType >= filter then
		local parentMap = self:GetMapUntilLast(map.parentMapID,filter,printOut)
		if parentMap ~= nil then
			return parentMap
		else
			return map
		end
	else
		return nil
	end
end
