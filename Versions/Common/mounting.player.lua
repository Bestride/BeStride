
function BeStride:NeedsChauffeur()
	local skill,spells = self:GetRidingSkill()
	if skill == 0 then
		if BeStride:IsSpellUsable(179245) or BeStride:IsSpellUsable(179244)  then
			return true
		else
			return false
		end
	else
		return false
	end
end