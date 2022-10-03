
function BeStride:NeedsChauffeur()
	local skill,spells = self:GetRidingSkill()
	if skill == 0 then
		if IsUsableSpell(179245) or IsUsableSpell(179244)  then
			return true
		else
			return false
		end
	else
		return false
	end
end