local AceGUI = LibStub("AceGUI-3.0")
	
local BeStride_Frame = nil

BeStride_GUI = {
	buttons = {},
	elements = {}
}

function BeStride_GUI:Frame(tab)
	if not BeStride_Frame then
		BeStride_GUI:Open(tab)
	else
		BeStride_GUI:Close()
	end
end

function BeStride_GUI:Open(defaultTab)
	local frameTabs = {
		{text = "Mounts (" .. getn(mountTable) .. ")", value="mounts"},
		{text = "Mount Options", value="mountoptions"},
		{text = "Class Options", value="classoptions"},
		{text = "Keybinds", value="keybinds"},
		{text = "Profile", value="profile"},
		{text = "About", value="about"}
	}

	BeStride_Frame = AceGUI:Create("Frame")
	BeStride_Frame:SetCallback("OnClose",function (widget) AceGUI:Release(widget); BeStride_Frame = nil end)
	BeStride_Frame:SetTitle("BeStride")
	BeStride_Frame:SetStatusText(BeStride_GUI:GetStatusText())
	BeStride_Frame:SetLayout("Fill")
	BeStride_Frame:SetWidth(720)
	BeStride_Frame:SetHeight(490)
	
	local tabs = AceGUI:Create("TabGroup")
	tabs:SetLayout("Flow")
	tabs:SetTabs(frameTabs)
	tabs:SetCallback("OnGroupSelected", function (container, event, group ) BeStride_GUI:SelectTab(container, event, group) end )
	
	if defaultTab ~= nil and ( defaultTab == "mounts" or defaultTab == "mountoptions" or defaultTab == "classoptions" or defaultTab == "keybinds" or defaultTab == "profile" or defaultTab == "about" ) then
		tabs:SelectTab(defaultTab)
	else
		tabs:SelectTab("mounts")
	end
	
    BeStride_Frame:AddChild(tabs)
end

function BeStride_GUI:Close()
	AceGUI:Release(BeStride_Frame)
	BeStride_Frame = nil
end

function BeStride_GUI:GetStatusText()
	return "Version " .. version .. ", by Anaximander <IRONFIST> - Burning Legion US, Original Yay Mounts by Cyrae - Windrunner US & Anzu - Kirin Tor US"
end

function BeStride_GUI:SelectTab(container, event, group)-- Callback function for OnGroupSelected
	--BeStride_Debug:Debug("Group: " .. group)
	container:ReleaseChildren()
	if group == "mounts" then
		BeStride_GUI:DrawMountsTab(container)
	elseif group == "mountoptions" then
		BeStride_GUI:DrawMountOptionTab(container)
	elseif group == "classoptions" then
		BeStride_GUI:DrawClassOptionTab(container)
	elseif group == "keybinds" then
		BeStride_GUI:DrawKeybindsTab(container)
	elseif group == "profile" then
		--BeStride_GUI:DrawProfileTab(container)
	elseif group == "about" then
		--BeStride_Debug:Debug("Drawing About")
		BeStride_GUI:DrawAboutTab(container)
	end
	
	--BeStride_Debug:Debug("Group: " .. group)
	
	currentTab = group
end

function BeStride_GUI:DrawMountsTab(container)
	container:SetLayout("Fill")
	
	local tab  = AceGUI:Create("TabGroup")
	tab:SetLayout("Flow")
	tab:SetTabs({
		{text="Ground (".. #mountTable["ground"] ..")", value="ground"},
		{text="Flying (".. #mountTable["flying"] ..")", value="flying"},
		{text="Swimming (".. #mountTable["swimming"] ..")", value="swimming"},
		{text="Repair (".. #mountTable["repair"] ..")", value="repair"},
		{text="Passenger (".. #mountTable["passenger"] ..")", value="passenger"}}
	)
	tab:SetCallback("OnGroupSelected", function (container,event,group) BeStride_GUI:DrawMountsSubTab(container,group) end )
  
	if currentSubTab ~= nil then
		tab:SelectTab(currentSubTab)
	else
		tab:SelectTab("ground")
	end
	container:AddChild(tab)
end

function BeStride_GUI:DrawMountsSubTab(container,group)
	container:ReleaseChildren()
	container:SetLayout("Flow")
    
	local selectallbutton = AceGUI:Create("Button")
	selectallbutton:SetText("Select All")
	--selectallbutton:SetCallback("OnClick", function() Bestride:SelectAllMounts(mountType) end)
	container:AddChild(selectallbutton)

	local clearallbutton = AceGUI:Create("Button")
	clearallbutton:SetText("Clear All")
	--clearallbutton:SetCallback("OnClick", function() Bestride:ClearMounts(mountType) end)
	container:AddChild(clearallbutton)

	local filterButton = AceGUI:Create("EditBox")
	filterButton:SetText("")
	filterButton:SetLabel("Filter")
	filterButton:DisableButton(true)
	filterButton:SetMaxLetters(25)
	container:AddChild(filterButton)
	
	local scrollcontainerframe = AceGUI:Create("SimpleGroup")
	scrollcontainerframe:SetLayout("Fill")
	scrollcontainerframe:SetFullWidth(true)
	scrollcontainerframe:SetFullHeight(true)
	container:AddChild(scrollcontainerframe)  

	local scrollframe = AceGUI:Create("ScrollFrame")
	scrollcontainerframe:AddChild(scrollframe)
	
	local mountsGroup = AceGUI:Create("InlineGroup")
	mountsGroup:SetFullWidth(true)
	mountsGroup:SetLayout("Flow")
	
	local mounts = {}
	
	for key,mount in pairs(mountTable[group]) do
		--BeStride_Debug:Debug(mount["type"] .. ":" .. group)
		--BeStride_Debug:Debug("Mount: " .. mountTable["master"][mount]["name"])
		local mountCheck = BeStride_GUI:CreateMountCheckBox(group,mount)
		if mountCheck ~= nil then
			mounts[mountTable["master"][mount]["name"]] = mountCheck
		end
	end
	
	
	mountsTable = sortTable(mounts)
	
	for _,mountCheck in pairsByKeys(mounts) do mountsGroup:AddChild(mountCheck) end
	
	scrollframe:AddChild(mountsGroup)
end

function BeStride_GUI:CreateMountCheckBox(group,mountID)
	local mount = mountTable.master[mountID]
	if mount["isCollected"] and (mount["faction"]== nil or mount["faction"] == playerTable["faction"]["id"]) then
		mountButton = AceGUI:Create("CheckBox")
		mountButton:SetImage(mount["icon"])
		mountButton:SetLabel(mount["name"])
		mountButton:SetValue(BeStride:DBGetMount(group,mountID))
		mountButton:SetCallback("OnValueChanged", function(container) BeStride:DBSetMount(group,mount["mountID"],container:GetValue()) end)
		return mountButton
	else
		return nil
	end
end

function BeStride_GUI:DrawMountOptionTab(container, parent)
	container:SetLayout("Flow")
	
	for name,setting in pairs(BeStride_Constants.Settings.Mount) do
		local element = nil
		if setting.element == "CheckBox" then
			element = self:CreateSettingCheckBox(setting.name,setting.label,setting.depends)
		elseif setting.element == "Slider" then
			element = self:CreateSettingSlider(setting.name,setting.label,setting.minDurability,setting.maxDurability,setting.increment,setting.disabled,setting.depends)
		elseif setting.element == "Group" and setting.children then
			element = AceGUI:Create("SimpleGroup")
			element:SetFullWidth(true)
			for subName,subSetting in pairs(setting.children) do
				--print("    SubName: " .. subName)
				local subElement = nil
				if subSetting.element == "CheckBox" then
					subElement = self:CreateSettingCheckBox(subSetting.name,subSetting.label,subSetting.depends)
				elseif subSetting.element == "Slider" then
					subElement = self:CreateSettingSlider(subSetting.name,subSetting.label,subSetting.minDurability,subSetting.maxDurability,subSetting.increment,subSetting.depends)
				end
				element:AddChild(subElement)
			end
		end
		
		if element ~= nil then
			container:AddChild(element)
		end
	end
end

function BeStride_GUI:CreateSettingCheckBox(name,label,depends)
	local element = AceGUI:Create("CheckBox")
	element:SetLabel(label)
	element:SetValue(BeStride:DBGetSetting(name))
	element:SetFullWidth(true)
	element:SetCallback("OnValueChanged",function (container) BeStride:DBSetSetting(name,container:GetValue()) end)
	
	if  depends ~= nil then
		local disabled = nil
		for key,value in pairs(depends) do
			if disabled == nil then
				print("Depends Value: " .. tostring(BeStride:DBGetSetting(value)))
				disabled = BeStride:DBGetSetting(value)
				
			else
				print("Depends Value: " .. tostring(BeStride:DBGetSetting(value)))
				disabled = bit.band(disabled,BeStride:DBGetSetting(value))
			end
			print("DisabledCheck: " .. name .. ":" .. tostring(disabled))
		end
		
		element:SetDisabled(not disabled)
	end
	self.elements[name] = element
	return element
end

function BeStride_GUI:CreateSettingSlider(name,label,minValue,maxValue,increment,depends)
	local element = AceGUI:Create("Slider")
	element:SetLabel(label)
	element:SetValue(BeStride:DBGetSetting(name))
	element:SetFullWidth(true)
	element:SetSliderValues(minValue,maxValue,increment)
	element:SetCallback("OnMouseUp",function (container) BeStride:DBSetSetting(name,container:GetValue()) end)
	
	if  depends ~= nil then
		local disabled = nil
		for key,value in pairs(depends) do
			if disabled == nil then
				print("Depends Value: " .. tostring(BeStride:DBGetSetting(value)))
				disabled = BeStride:DBGetSetting(value)
				
			else
				print("Depends Value: " .. tostring(BeStride:DBGetSetting(value)))
				disabled = bit.band(disabled,BeStride:DBGetSetting(value))
			end
			print("DisabledCheck: " .. name .. ":" .. tostring(disabled))
		end
		
		element:SetDisabled(not disabled)
	end
	self.elements[name] = element
	return element
end

function BeStride_GUI:DrawClassOptionTab(container)
	container:SetLayout("Flow")
	
	table.foreach(BeStride_Constants.Settings.Classes,function (key,classSetting)
		--if tolower(class) == tolower(playerTable["class"]["name"])
			for name,setting in pairs(classSetting) do
				
				if setting.element == "CheckBox" then
					element = self:CreateClassSettingCheckBox(setting.name,setting.label)
				elseif setting.element == "Slider" then
					element = self:CreateClassSettingSlider(setting.name,setting.label,setting.minDurability,setting.maxDurability,setting.increment)
				end
				
				if element ~= nil then
					container:AddChild(element)
				end
			end
		--end
	end)
end

function BeStride_GUI:CreateClassSettingCheckBox(name,label)
	local element = AceGUI:Create("CheckBox")
	element:SetLabel(label)
	element:SetValue(BeStride:DBGetSetting(name))
	element:SetFullWidth(true)
	element:SetCallback("OnValueChanged",function (container) BeStride:DBSetSetting(name,container:GetValue()) end)
	
	return element
end

function BeStride_GUI:CreateClassSettingSlider(label,parent,setting,minValue,maxValue,increment,disabled)
	local element = AceGUI:Create("Slider")
	element:SetLabel(label)
	element:SetValue(BeStride:DBGetSetting(name))
	element:SetFullWidth(true)
	element:SetSliderValues(minValue,maxValue,increment)
	element:SetCallback("OnMouseUp",function (container) BeStride:DBSetSetting(name,container:GetValue()) end)
	
	return element
end

function BeStride_GUI:DrawKeybindsTab(container)
	container:SetLayout("Flow")
	
	self.buttons[BeStride_ABRegularMount:GetName()] = AceGUI:Create("Keybinding")
	self.buttons[BeStride_ABGroundMount:GetName()] = AceGUI:Create("Keybinding")
	self.buttons[BeStride_ABPassengerMount:GetName()] = AceGUI:Create("Keybinding")
	self.buttons[BeStride_ABRepairMount:GetName()] = AceGUI:Create("Keybinding")
	
	self.buttons[BeStride_ABRegularMount:GetName()]:SetLabel(BINDING_NAME_BeStride_ABRegularMount)
	self.buttons[BeStride_ABRegularMount:GetName()]:SetKey(GetBindingKey("CLICK BeStride_ABRegularMount"))
	self.buttons[BeStride_ABRegularMount:GetName()]:SetCallback("OnKeyChanged",function() BeStride_GUI:UpdateBinding(BeStride_ABRegularMount,self.buttons[BeStride_ABRegularMount:GetName()]:GetKey()) end)
	container:AddChild(self.buttons[BeStride_ABRegularMount:GetName()])
	
	self.buttons[BeStride_ABGroundMount:GetName()]:SetLabel(BINDING_NAME_BeStride_ABGroundMount)
	self.buttons[BeStride_ABGroundMount:GetName()]:SetKey(GetBindingKey("CLICK BeStride_ABGroundMount"))
	self.buttons[BeStride_ABGroundMount:GetName()]:SetCallback("OnKeyChanged",function() BeStride_GUI:UpdateBinding(BeStride_ABGroundMount,self.buttons[BeStride_ABGroundMount:GetName()]:GetKey()) end)
	container:AddChild(self.buttons[BeStride_ABGroundMount:GetName()])
	
	self.buttons[BeStride_ABPassengerMount:GetName()]:SetLabel(BINDING_NAME_BeStride_ABPassengerMount)
	self.buttons[BeStride_ABPassengerMount:GetName()]:SetKey(GetBindingKey("CLICK BeStride_ABPassengerMount"))
	self.buttons[BeStride_ABPassengerMount:GetName()]:SetCallback("OnKeyChanged",function() BeStride_GUI:UpdateBinding(BeStride_ABPassengerMount,self.buttons[BeStride_ABPassengerMount:GetName()]:GetKey()) end)
	container:AddChild(self.buttons[BeStride_ABPassengerMount:GetName()])
	
	self.buttons[BeStride_ABRepairMount:GetName()]:SetLabel(BINDING_NAME_BeStride_ABRepairMount)
	self.buttons[BeStride_ABRepairMount:GetName()]:SetKey(GetBindingKey("CLICK BeStride_ABRepairMount"))
	self.buttons[BeStride_ABRepairMount:GetName()]:SetCallback("OnKeyChanged",function() BeStride_GUI:UpdateBinding(BeStride_ABRepairMount,self.buttons[BeStride_ABRepairMount:GetName()]:GetKey()) end)
	container:AddChild(self.buttons[BeStride_ABRepairMount:GetName()])
end

function BeStride_GUI:UpdateBinding(button,key)
end

function BeStride_GUI:DrawAboutTab(container)
	container:SetLayout("Flow")
	local about = AceGUI:Create("Label")
	about:SetText( "Version: " .. version .. "\n" .. "Author: " .. author .. "\n" .. "Description: " .. "\n" .. "\t\t" .. "BeStride originally started out as YayMounts by Cyrae on Windrunner US and Anzu on Kirin Tor US"  .. "\n" .. "\t\t" .. "Later, Anaximander from Burning Legion US found the project was neglected and had several bugs which needed to be resolved"  .. "\n" .. "\t\t" .. "as part of the bug resolution process, the addon was modernized to make the code cleaner to follow as well as more modular."  .. "\n" )
	about:SetWidth(700)
	container:AddChild(about)
end