BeStride_Debug = {}

function BeStride_Debug:Emergency(message)
    -- Debug Level 1
	if debugLevel >= 1 then
		ChatFrame1:AddMessage("[Emerg]" .. message,1.0,0,0);
	end
end

function BeStride_Debug:Critical(message)
	if debugLevel >= 2 then
		ChatFrame1:AddMessage("[Crit]" .. message,0,1.0,0);
	end
end

function BeStride_Debug:Error(message)
	if debugLevel >= 3 then
		ChatFrame1:AddMessage("[Error]" .. message,1.0,0,0);
	end
end


function BeStride_Debug:Info(message)
	if debugLevel >= 4 then
		ChatFrame1:AddMessage("[Info]" .. message,1.0,1.0,1.0);
	end
end


function BeStride_Debug:Informational(message)
	if debugLevel >= 4 then
		ChatFrame1:AddMessage("[Info]" .. message,1.0,1.0,1.0);
	end
end

function BeStride_Debug:Notice(message)
	if debugLevel >= 5 then
		ChatFrame1:AddMessage("[Notice]" .. message,1.0,0.9,0);
	end
end

function BeStride_Debug:Verbose(message)
	if debugLevel >= 6 then
		ChatFrame1:AddMessage("[Verbose]" .. message,0,1.0,1.0);
	end
end

function BeStride_Debug:Debug(message)
	if debugLevel >= 7 then
		ChatFrame1:AddMessage("[Debug]" .. message,1.0,0,0);
	end
end



function BeStride_Debug:DebugGetMaps()
	local locID = C_Map.GetBestMapForUnit("player")
	self:DebugGetMapUntil(locID,0)
end

function BeStride_Debug:DebugGetMapName(locID,filter)
	local map = self:DebugGetMapUntil(locID,filter)
	return map.name
end

function BeStride_Debug:DebugGetMapUntil(locID,filter)
	local map = C_Map.GetMapInfo(locID)
	
	if map ~= nil then
		self:Debug(map.mapID .. "," .. map.name .. "," .. map.mapType .. "," .. map.parentMapID)
	end
	if map["mapType"] ~= filter and map["mapType"] > filter then
		return self:DebugGetMapUntil(map["parentMapID"],filter)
	else
		return map
	end
end