function BeStride:GetRidingSkill()
	local ridingSkillLevel = 0
	local ridingSpells = {}
	
  
	for spellID,skill in pairsByKeys(BeStride_Constants.Riding.Skill) do
		if IsSpellKnown(spellID) and skill.level ~= nil and skill.level > ridingSkillLevel then
			ridingSkillLevel = skill.level
			ridingSpells[spellID] = true
		elseif IsSpellKnown(spellID) and skill.level == nil then
			ridingSpells[spellID] = true
		end
	end
	
	return ridingSkillLevel,ridingSpells
end

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
	elseif zone.name == BeStride_Locale.Zone.Dalaran.Name then
		local subzone = GetSubZoneText()
		if subzone == BeStride_Locale.Zone.Dalaran.SubZone.Underbelly.Name or
				subzone == BeStride_Locale.Zone.Dalaran.SubZone.UnderbellyDescent.Name or
				subzone == BeStride_Locale.Zone.Dalaran.SubZone.CircleofWills.Name or
				subzone == BeStride_Locale.Zone.Dalaran.SubZone.BlackMarket.Name then
			if GetItemCount(139421, false) > 0 then
				return 139421
			end
		end
	elseif zone.name == BeStride_Locale.Zone.Oculus.Name then
		if GetItemCount(37859) == 1 then
			return 37859
		elseif GetItemCount(37860) == 1 then
			return 37860
		elseif GetItemCount(37815) == 1 then
			return 37815
		end
	elseif zone.name == BeStride_Locale.Zone.StormPeaks.Name or zone.name == BeStride_Locale.Zone.Icecrown.Name or zone.name == BeStride_Locale.Zone.SholazarBasin.Name then
		if GetItemCount(44221, false) > 0 then
			return 44221
		elseif GetItemCount(44229, false) > 0 then
			return 44229
		end
	end
	
	return nil
end