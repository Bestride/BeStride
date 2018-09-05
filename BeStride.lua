BeStride = LibStub("AceAddon-3.0"):NewAddon("Bestride","AceConsole-3.0", "AceEvent-3.0")

mountTable = {
	["master"] = {},
	["ground"] = {},
	["flying"] = {},
	["swimming"] = {},
	["repair"] = {},
	["passenger"] = {},
}

local defaults = {
	["version"] = version,
	
	profile = {
		settings = {
			["emptyrandom"] = true,
			["hasmount"] = false,
			["enablenew"] = false,
			["traveltotravel"] = false,
			["forceflyingmount"] = false,
			["nodismountwhileflying"] = false,
			
			["repair"] = {
				["use"] = false
				["force"] = false,
				["durability"] = 0.2,
			},
			["priorities"] = {
				["flyingbroom"] = false,
				["repairmount"] = true,
				["telaari"] = true
			},
			["classes"] = {
				["deathknight"] = {
					["wraithwalk"] = true,
				},
				["druid"] = {
					["flightform"] = true,
					["flightformpriority"] = false,
					["mountedtoflightform"] = false,
				},
				["paladin"] = {
					["steed"] = true,
				},
				["shaman"] = {
					["ghostwolf"] = true,
				},
				["monk"] = {
					["roll"] = true,
					["zenflight"] = true,
				},
				["priest"] = {
					["levitate"] = true,
				},
				["mage"] = {
					["slowfall"] = true,
				},
			},
		}
	}
}

function BeStride:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("BeStride", defaults, "Default")
	self:RegisterChatCommand("bestride","ChatCommand")
	self:RegisterChatCommand("br","ChatCommand")
end

function BeStride:OnEnable()
	
end

function BeStride:ChatCommand(input)
	if input == "reload" then
		BeStride:buildMountTables()
	elseif input == "enum" then
		local types = {}
		for key,value in pairs(C_MountJournal.GetMountIDs()) do
			local name,spellID,_,isActive,isUsable,sourceType,isFavorite,isFactionSpecific,_,isCollected,mountId = C_MountJournal.GetMountInfoByID(value)
			local creatureDisplayInfoId,description,source,isSelfMount,mountTypeID,uiModelSceneID = C_MountJournal.GetMountInfoExtraByID(value)
			
			if mountTypes[mountTypeID] then
				types[mountTypeID] = mountTypes[mountTypeID]
			else
				types[mountTypeID] = mountTypeID
			end
			
			if isCollected == true then
				if mountTypes[mountTypeID] then
					self:Print("|" .. name .. "|" .. mountTypes[mountTypeID] .. "|")
				end
			end
		end
		
		for k,v in pairs(types) do
			self:Print("|" .. k .. "|" .. v .. "|")
		end
	elseif input == "map" then
		BeStride:GetMaps()
	else
		BeStride_GUI:Frame()
	end
end



function BeStride:GetMaps()
	local locID = C_Map.GetBestMapForUnit("player")
	BeStride:GetMap(locID)
end

function BeStride:GetMap(locID)
	local map = C_Map.GetMapInfo(locID)
	
	print(locID .. ":" .. map["name"] .. ":" .. map["mapType"])
	
	if map["mapType"] ~= 0 then
		BeStride:GetMap(map["parentMapID"])
	end
end