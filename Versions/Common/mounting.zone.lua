function BeStride:SpecialZone()
	local mapID = C_Map.GetBestMapForUnit("player")
	local micro = BeStride:GetMapUntil(mapID,5)
	local dungeon = BeStride:GetMapUntil(mapID,4)
	local zone = BeStride:GetMapUntil(mapID,3)
	local continent = BeStride:GetMapUntil(mapID,2)
	
	if continent ~= nil and continent.name == LibStub("AceLocale-3.0"):GetLocale("BeStride")["Continent.Draenor"] and micro.name == LibStub("AceLocale-3.0"):GetLocale("BeStride")["Zone.Nagrand"] and self:DBGet("settings.mount.telaari") == true then
		return BeStride_Mount:Nagrand()
	end
	
	return nil
end

function BeStride:KnownSpecialCombatEncounter()
	local encounter = self:IsKnownSpecialCombatEncounter()
	local _, _, br_mount_fn_name = unpack(encounter or {});
	if br_mount_fn_name == nil then return nil end

	return BeStride_Mount[br_mount_fn_name]()
end