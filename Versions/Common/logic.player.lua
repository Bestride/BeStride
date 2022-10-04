function BeStride:IsFalling()
	return IsFalling()
end

function BeStride:IsUnderwater()
	if IsSwimming() and BeStride:DBGet("settings.mount.noswimming") == false then
		local timer, initial, maxvalue, scale, paused, label = GetMirrorTimerInfo(2)
		if timer ~= nil and timer == "BREATH" and scale < 0 then
			return true
		else
			return false
		end
	else
		return false
	end
end
