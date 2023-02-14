function BeStride:CanBroom()
	if GetItemCount(37011, false) > 0 and not BeStride:IsCombat() and BeStride:GetBroomSetting() == true then
		return true
	end
end

function BeStride:IsLoanedMount()
	local loanedMount = BeStride:CheckLoanedMount()
	if loanedMount ~= nil then
		return true
	else
		return false
	end
end

function BeStride:CheckLoanedMount()
	local mapID = C_Map.GetBestMapForUnit("player")
	local zone = BeStride:GetMapUntil(mapID,3)
	if zone == nil then
		return nil
	elseif IsSwimming() and (
		zone.mapID == BeStride_Constants.Zone.Vashjir.KelptharForest.id or
		zone.mapID == BeStride_Constants.Zone.Vashjir.ShimmeringExpanse.id or
		zone.mapID == BeStride_Constants.Zone.Vashjir.AbyssalDepths.id or
		zone.mapID == BeStride_Constants.Zone.Vashjir.id
	) then
		return BeStride_Mount:VashjirSeahorse()
	elseif zone.name == LibStub("AceLocale-3.0"):GetLocale("BeStride")["Zone.Dalaran"] then
		local subzone = GetSubZoneText()
		if subzone == LibStub("AceLocale-3.0"):GetLocale("BeStride")["Zone.Dalaran.SubZone.Underbelly"] or
				subzone == LibStub("AceLocale-3.0"):GetLocale("BeStride")["Zone.Dalaran.SubZone.UnderbellyDescent"] or
				subzone == LibStub("AceLocale-3.0"):GetLocale("BeStride")["Zone.Dalaran.SubZone.CircleofWills"] or
				subzone == LibStub("AceLocale-3.0"):GetLocale("BeStride")["Zone.Dalaran.SubZone.BlackMarket"] then
			if GetItemCount(139421, false) > 0 then
				return 139421
			end
		end
	elseif zone.name == LibStub("AceLocale-3.0"):GetLocale("BeStride")["Zone.Oculus"] then
		if GetItemCount(37859) == 1 then
			return 37859
		elseif GetItemCount(37860) == 1 then
			return 37860
		elseif GetItemCount(37815) == 1 then
			return 37815
		end
	elseif zone.name == LibStub("AceLocale-3.0"):GetLocale("BeStride")["Zone.StormPeaks"] or zone.name == LibStub("AceLocale-3.0"):GetLocale("BeStride")["Zone.Icecrown"] or zone.name == LibStub("AceLocale-3.0"):GetLocale("BeStride")["Zone.SholazarBasin"] then
		if GetItemCount(44221, false) > 0 then
			return 44221
		elseif GetItemCount(44229, false) > 0 then
			return 44229
		end
	end
	
	return nil
end

function BeStride:CanUseTargetsMount()
	if (not self:DBGet("settings.mount.copytargetmount")) then return false end
	if (self:MovementCheck() or not UnitExists("target")) then return false end

	local spellId, mountId, isUsable = self:GetKnownMountFromTarget()
	return isUsable
end