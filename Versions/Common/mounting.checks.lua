function BeStride:MovementCheck()
	-- Checks Player Speed
	-- Returns: integer
	local speed = BeStride:SpeedCheck()
	BeStride_Debug:Debug("Mage movement speed= " .. tostring(speed))
	if speed ~= 0 then
		return true
	else
		return false
	end
end

function BeStride:SpeedCheck()
	-- Checks Player Speed
	-- Returns: integer
	if GetUnitSpeed then
		local speed = GetUnitSpeed("player")
		if speed ~= 0 then
			return speed
		end
	end

	if IsPlayerMoving and IsPlayerMoving() then
		return 1
	end

	return 0
end

function BeStride:IsSpellUsable(spell)
	if C_Spell and C_Spell.IsSpellUsable then
		local isUsable = C_Spell.IsSpellUsable(spell)
		if isUsable ~= nil then
			return isUsable
		end
	end
	if C_Spell and C_Spell.IsUsableSpell then
		local isUsable = C_Spell.IsUsableSpell(spell)
		if isUsable ~= nil then
			return isUsable
		end
	end
	if IsUsableSpell then
		local isUsable = IsUsableSpell(spell)
		if isUsable ~= nil then
			return isUsable
		end
		local name
		if C_Spell and C_Spell.GetSpellInfo then
			local info = C_Spell.GetSpellInfo(spell)
			name = info and info.name
		elseif GetSpellInfo then
			name = GetSpellInfo(spell)
		end
		if name then
			isUsable = IsUsableSpell(name)
			if isUsable ~= nil then
				return isUsable
			end
		end
	end
	return false
end

function BeStride:GetSpellInfo(spell)
	if C_Spell and C_Spell.GetSpellInfo then
		local info = C_Spell.GetSpellInfo(spell)
		if info and type(info) == "table" then
			return { name = info.name, spellID = info.spellID }
		end
	end
	if GetSpellInfo then
		local name,_,_,_,_,_,spellID = GetSpellInfo(spell)
		if name then
			return { name = name, spellID = spellID }
		end
	end
	return nil
end

function BeStride:GetSpellOnCooldown(spell)
	if C_Spell and C_Spell.GetSpellCooldown then
		local info = C_Spell.GetSpellCooldown(spell)
		if info and type(info) == "table" then
			return info.duration ~= 0
		end
	end
	if GetSpellCooldown then
		local start,duration = GetSpellCooldown(spell)
		return start ~= nil and start ~= 0 and duration ~= nil and duration ~= 0
	end
	return false
end