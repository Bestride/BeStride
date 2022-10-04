function BeStride:CanRobotSetting()
	return BeStride:DBGet("settings.mount.forcerobot")
end

function BeStride:GetBroomSetting()
	return BeStride:DBGet("settings.mount.flyingbroom")
end