BeStride_ActionButtonMount = {}
BeStride_ActionButtonGroundMount = {}
BeStride_ActionButtonPassengerMount = {}
BeStride_ActionButtonRepairMount = {}

-- Creates Action Buttons
function BeStride:CreateActionButton(buttontype)
	local name = "BeStride_AB" .. buttontype .. "Mount"

	local br = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate")
	br:SetAttribute("type","macro")
	br:SetAttribute("macrotext","/script print('Test')")
	
    if buttontype == "Mount" then
		Mixin(br, BeStride_ActionButtonMount)
		BeStride_Debug:Debug("Setting Binding")
		SetBindingClick("Middle Mouse", br:GetName() )
		SetBindingClick("F12", br:GetName() )
	elseif buttontype == "GroundMount" then
		Mixin(br, BeStride_ActionButtonGroundMount)
	elseif buttontype == "RepairMount" then
		Mixin(br, BeStride_ActionButtonRepairMount)
	elseif buttontype == "PassengerMount" then
		Mixin(br, BeStride_ActionButtonPassengerMount)
	end
	
	br.id = buttontype
	br:SetScript("PreClick",function(self)
	  self:PreClick()
	end)
	br:SetScript("PostClick",function(self)
	  self:PostClick()
	end)
	SaveBindings(GetCurrentBindingSet())
	if br then
	    print("Returning: " .. br:GetName())
		return br
	else
	  print("Fatal: " .. buttontype)
	end
end

-- +-------+ --
-- Any Mount --
-- +-------+ --

-- Action Button Wrapper
function BeStride_ActionButtonMount:PreClick()
	if BeStride_Logic:IsCombat() then
		return
	end
	
	BeStride_Logic:MountButton()
end

-- Action Button Cleanup
function BeStride_ActionButtonMount:PostClick()

end


-- +----------+ --
-- Ground Mount --
-- +----------+ --

-- Action Button Wrapper
function BeStride_ActionButtonGroundMount:PreClick()
	if BeStride_Logic:IsCombat() then
		return
	end
	
	BeStride_Logic:GroundMountButton()
end

-- Action Button Cleanup
function BeStride_ActionButtonGroundMount:PostClick()

end


-- +-------------+ --
-- Passenger Mount --
-- +-------------+ --

-- Action Button Wrapper
function BeStride_ActionButtonPassengerMount:PreClick()
	if BeStride_Logic:IsCombat() then
		return
	end
	
	BeStride_Logic:PassengerMountButton()
end

-- Action Button Cleanup
function BeStride_ActionButtonPassengerMount:PostClick()

end


-- +----------+ --
-- Repair Mount --
-- +----------+ --

-- Action Button Wrapper
function BeStride_ActionButtonRepairMount:PreClick()
	if BeStride_Logic:IsCombat() then
		return
	end
	
	BeStride_Logic:RepairMountButton()
end

-- Action Button Cleanup
function BeStride_ActionButtonRepairMount:PostClick()

end