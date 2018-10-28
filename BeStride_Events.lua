function BeStride:EventNewMount(arg1, arg2)
	BeStride:AddNewMount(arg2)
end

function BeStride:EventUpdateKeyBinding()
end

function BeStride:EventCombatEnter()
	local combatButton = BeStride_Logic:Combat()
	if combatButton ~= nil then
		BeStride_ABRegularMount:SetAttribute("macrotext",combatButton)
		BeStride_ABGroundMount:SetAttribute("macrotext",combatButton)
		BeStride_ABPassengerMount:SetAttribute("macrotext",combatButton)
		BeStride_ABRepairMount:SetAttribute("macrotext",combatButton)
	end
end

function BeStride:EventCombatExit()
	BeStride_ABRegularMount:SetAttribute("macrotext",nil)
	BeStride_ABGroundMount:SetAttribute("macrotext",nil)
	BeStride_ABPassengerMount:SetAttribute("macrotext",nil)
	BeStride_ABRepairMount:SetAttribute("macrotext",nil)
end