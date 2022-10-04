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
	local name, rank, icon, castTime, minRange, maxRange, spellID = GetSpellInfo(spellID)
	
	return name
end

function ItemToName(itemID)
	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent = GetItemInfo(itemID)
	
	return itemName
end