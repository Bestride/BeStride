BeStride_ActionButtonRegularMount = {}
BeStride_ActionButtonGroundMount = {}
BeStride_ActionButtonPassengerMount = {}
BeStride_ActionButtonRepairMount = {}

-- Creates Action Buttons
function BeStride:CreateActionButton(buttontype)
	local name = "BeStride_AB" .. buttontype .. "Mount"

	local br = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate,ActionButtonTemplate")
	br:SetAttribute("type","macro")
	br:SetAttribute("macrotext",nil)
	
    if buttontype == "Regular" then
		Mixin(br, BeStride_ActionButtonRegularMount)
	elseif buttontype == "Ground" then
		Mixin(br, BeStride_ActionButtonGroundMount)
	elseif buttontype == "Repair" then
		Mixin(br, BeStride_ActionButtonRepairMount)
	elseif buttontype == "Passenger" then
		Mixin(br, BeStride_ActionButtonPassengerMount)
	end
	
	br.id = buttontype
	br:SetScript("PreClick",function (self) self:PreClick() end )
	br:SetScript("PostClick",self.PostClick)
	--SaveBindings(GetCurrentBindingSet())
	if br then
	    --print("Returning: " .. br:GetName())
		return br
	else
	  BeStride_Debug:Critical("Critical: " .. buttontype)
	end
end

-- +-------+ --
-- Any Mount --
-- +-------+ --

-- Action Button Wrapper
function BeStride_ActionButtonRegularMount:PreClick()
	if BeStride_Logic:IsCombat() then
		return
	end
	
	local passenger = nil
	
	if IsInGroup() == true and BeStride_Logic:IsFlyable() and BeStride:DBGet("settings.mount.prioritizepassenger") then
		passenger = BeStride_Mount:Passenger("flying")
	elseif IsInGroup() == true and BeStride:DBGet("settings.mount.prioritizepassenger") then
		passenger = BeStride_Mount:Passenger()
	end
	
	if passenger ~= nil then
		--BeStride_Debug:Verbose("Mount:" .. tostring(passenger))
		self:SetAttribute("macrotext",passenger)
	else
		local mount = BeStride_Logic:Regular()
		if mount ~= nil then
			self:SetAttribute("macrotext",mount)
			--BeStride_Debug:Verbose(self:GetAttribute("macrotext"))
		end
	end
end

-- Action Button Cleanup
function BeStride_ActionButtonRegularMount:PostClick()
	if BeStride_Logic:IsCombat() then
		return
	end
	
	BeStride_ABRegularMount:SetAttribute("macrotext", nil)
end


-- +----------+ --
-- Ground Mount --
-- +----------+ --

-- Action Button Wrapper
function BeStride_ActionButtonGroundMount:PreClick()
	if BeStride_Logic:IsCombat() then
		return
	end
	
	local passenger = nil
	
	if IsInGroup() == true and BeStride:DBGet("settings.mount.prioritizepassenger") then
		passenger = BeStride_Mount:Passenger("ground")
	end
	
	if passenger ~= nil then
		--BeStride_Debug:Verbose("Mount:" .. tostring(passenger))
		self:SetAttribute("macrotext",passenger)
	else
		local mount = BeStride_Logic:GroundMountButton()
		if mount ~= nil then
			self:SetAttribute("macrotext",mount)
		end
	end
end

-- Action Button Cleanup
function BeStride_ActionButtonGroundMount:PostClick()
	if BeStride_Logic:IsCombat() then
		return
	end
	
	BeStride_ABRegularMount:SetAttribute("macrotext", nil)
end


-- +-------------+ --
-- Passenger Mount --
-- +-------------+ --

-- Action Button Wrapper
function BeStride_ActionButtonPassengerMount:PreClick()
	if BeStride_Logic:IsCombat() then
		return
	end
	
	local mount = BeStride_Logic:PassengerMountButton()
	if mount ~= nil then
		self:SetAttribute("macrotext",mount)
	end
end

-- Action Button Cleanup
function BeStride_ActionButtonPassengerMount:PostClick()
	if BeStride_Logic:IsCombat() then
		return
	end
	
	BeStride_ABRegularMount:SetAttribute("macrotext", nil)
end


-- +----------+ --
-- Repair Mount --
-- +----------+ --

-- Action Button Wrapper
function BeStride_ActionButtonRepairMount:PreClick()
	if BeStride_Logic:IsCombat() then
		return
	end
	
	local mount = BeStride_Logic:RepairMountButton()
	if mount ~= nil then
		self:SetAttribute("macrotext",mount)
	end
end

-- Action Button Cleanup
function BeStride_ActionButtonRepairMount:PostClick()
	if BeStride_Logic:IsCombat() then
		return
	end
	
	BeStride_ABRegularMount:SetAttribute("macrotext", nil)
end