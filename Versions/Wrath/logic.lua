BeStride_Game = "Wrath"


function BeStride:isMountUsable(mountId)
	--print("isMountUsable: " .. mountId)
	spellID = mountTable["master"][mountId].spellID
	
	return spellID,mountID,true
end

function BeStride:isZoneMount(mountId)
	return false
end

function BeStride:IsCombat()
	if InCombatLockdown() then
		return true
	else
		return false
	end
end

function BeStride:GetSkills()
	local skills = {}
	local category = nil

	for skillIndex = 1, GetNumSkillLines() do
		local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType, skillDescription = GetSkillLineInfo(skillIndex)
		
		if isHeader then
			category = skillName
			skills[category] = {}
		else
			skills[category][skillName] = skillRank
		end
	end

	return skills
end

function BeStride:GetProfessions()
	skills = self:GetSkills()
	
	return nil, nil
end

function BeStride:GetRidingSkill()
	local ridingSkillLevel = 0
	local ridingSpells = {}

	for skillIndex = 1, GetNumSkillLines() do
		local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType, skillDescription = GetSkillLineInfo(skillIndex)

		if (skillName == 'Riding') or (skillName=='탈것 타기') then
			ridingSkillLevel = skillRank
		end
	end

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

function BeStride:CanWraithWalk()
	return false
end
