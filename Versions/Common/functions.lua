function sortTable(unsortedTable)
	keys = {}
	sortedTable = {}
	for key in pairs(unsortedTable) do table.insert(keys,key) end
	table.sort(keys)
	for _,key in ipairs(keys) do sortedTable[key] = unsortedTable[key] end
	return sortedTable
end

function searchTableForValue(haystack,needle)
	for k,v in pairs(haystack) do
		if v == needle then
			return k
		end
	end
	
	return nil
end

function pairsByKeys (t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, f)
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if a[i] == nil then return nil
		else return a[i], t[a[i]]
		end
	end
	return iter
end

function countTable(t)
	assert(type(t) == 'table', 'bad parameter #1: must be table')
	local count = 0
	for k, v in pairs(t) do
		count = count + 1
	end
	
	return count
end

function SpellToName(spellID)
	return BeStride:GetSpellInfo(spellID).name
end

function ItemToName(itemID)
	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent = C_Item.GetItemInfo(itemID)
	
	return itemName
end

function mapPos(map)
end

function areaInfo()
	--vector = Create2DVector(x, y)
	--DevTools_Dump(vector)

	local ui_map_id = C_Map.GetBestMapForUnit("player")
	local unit_x, unit_y = C_Map.GetPlayerMapPosition(ui_map_id, "player"):GetXY()
	local unit_vector = CreateVector2D(unit_x, unit_y)
	local area = C_MapExplorationInfo.GetExploredAreaIDsAtPosition(ui_map_id, unit_vector)
	print(area)

	return area
end

function GetAreaIDsForPlayer()
	local mapID = C_Map.GetBestMapForUnit("player")
	local pos = C_Map.GetPlayerMapPosition(mapID, "player")
	local areaIDs = C_MapExplorationInfo.GetExploredAreaIDsAtPosition(mapID, pos)
	local areaString = areaIDs and table.concat(areaIDs, ", ") or "none"
	print(format("MapID=%d, Position=%.3f:%.3f, AreaIDs=%s", mapID, pos.x, pos.y, areaString))
end