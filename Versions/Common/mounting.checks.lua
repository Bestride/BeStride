function BeStride:MovementCheck()
	-- Checks Player Speed
	-- Returns: integer
	if BeStride:SpeedCheck() ~= 0 then
		return true
	else
		return false
	end
end

function BeStride:SpeedCheck()
	-- Checks Player Speed
	-- Returns: integer
	return GetUnitSpeed("player")
end