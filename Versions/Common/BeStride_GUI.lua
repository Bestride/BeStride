local AceGUI = LibStub("AceGUI-3.0")
	
local BeStride_Frame = nil
local BeStride_Debug_Frame = nil

BeStride_GUI = {
	close = nil,
	closebutton = nil,
	debugclose = nil,
	
	buttons = {},
	elements = {},
	mounts = {},
	mountsGroup = nil
}

function BeStride_GUI:Frame(tab)
	collectgarbage()
	if not BeStride_Frame then
		BeStride_GUI:Open(tab)
	else
		BeStride_GUI:Close()
	end
end

function BeStride_GUI:Open(defaultTab)
	local frameTabs = {
		{text = BeStride_Locale.GUI.TAB.Mounts .. " (" .. #mountTable["ground"] + #mountTable["flying"] + #mountTable["swimming"]   .. ")", value="mounts"},
		{text = BeStride_Locale.GUI.TAB.MountOptions, value="mountoptions"},
		{text = BeStride_Locale.GUI.TAB.ClassOptions, value="classoptions"},
		{text = BeStride_Locale.GUI.TAB.Keybinds, value="keybinds"},
		{text = BeStride_Locale.GUI.TAB.Profile, value="profile"},
		{text = BeStride_Locale.GUI.TAB.About, value="about"}
	}

	BeStride_Frame = AceGUI:Create("Frame")
	BeStride_Frame:SetCallback("OnClose",function (widget) BeStride_GUI:Close() end)
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
	
	closebutton = "BeStride_GUIClose"
	self.close = CreateFrame("Button", closebutton, UIParent, "SecureActionButtonTemplate,ActionButtonTemplate")
	self.close:SetAttribute("type","macro")
	self.close:SetAttribute("macrotext","/script BeStride_GUI:Close()")
	SetOverrideBindingClick(self.close,true,"ESCAPE",closebutton)
end

function BeStride_GUI:Close()
	ClearOverrideBindings(self.close)
	self.close = nil
	
	AceGUI:Release(BeStride_Frame)
	BeStride_Frame = nil
end

function BeStride_GUI:GetStatusText()
	return "Version " .. version .. ", by Anaximander <IRONFIST> - BL US.  https://discord.gg/6bZf5PF"
end

function BeStride_GUI:SelectTab(container, event, group)
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
		BeStride_GUI:DrawProfileTab(container)
	elseif group == "about" then
		BeStride_GUI:DrawAboutTab(container)
	end
	
	currentTab = group
end

function BeStride_GUI:DrawMountsTab(container)
	container:SetLayout("Fill")
	
	local tab  = AceGUI:Create("TabGroup")
	tab:SetLayout("Flow")
	tab:SetTabs({
		{text=BeStride_Locale.GUI.TAB.Ground .. " (".. #mountTable["ground"] ..")", value="ground"},
		{text=BeStride_Locale.GUI.TAB.Flying .. " (".. #mountTable["flying"] ..")", value="flying"},
		{text=BeStride_Locale.GUI.TAB.Swimming .. " (".. #mountTable["swimming"] ..")", value="swimming"},
		{text=BeStride_Locale.GUI.TAB.Repair .. " (".. #mountTable["repair"] ..")", value="repair"},
		{text=BeStride_Locale.GUI.TAB.Passenger .. " (".. #mountTable["passenger"] ..")", value="passenger"}}
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
	selectallbutton:SetText(BeStride_Locale.GUI.BUTTON.SelectAll)
	selectallbutton:SetCallback("OnClick", function() BeStride_GUI:SelectAllMounts(group) end)
	container:AddChild(selectallbutton)

	local clearallbutton = AceGUI:Create("Button")
	clearallbutton:SetText(BeStride_Locale.GUI.BUTTON.ClearAll)
	clearallbutton:SetCallback("OnClick", function() BeStride_GUI:ClearAllMounts(group) end)
	container:AddChild(clearallbutton)

	local filterButton = AceGUI:Create("EditBox")
	filterButton:SetText("")
	filterButton:SetLabel(BeStride_Locale.GUI.BUTTON.Filter)
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
	
	self.mountsGroup = AceGUI:Create("InlineGroup")
	self.mountsGroup:SetFullWidth(true)
	self.mountsGroup:SetLayout("Flow")
	
	filterButton:SetCallback("OnTextChanged",function(self) BeStride_GUI:FilterMounts(group,self:GetText())  end)
	
	
	self.mounts[group] = {}
	self:CreateMountCheckBoxes(group)
	
	for _,mountCheck in pairsByKeys(self.mounts[group]) do self.mountsGroup:AddChild(mountCheck) end
	
	scrollframe:AddChild(self.mountsGroup)
end

function BeStride_GUI:SelectAllMounts(group)
	for key,mount in pairs(self.mounts[group]) do
		mount:SetValue(true)
		BeStride:DBSetMount(group,mount.mountID,mount:GetValue())
	end
end

function BeStride_GUI:ClearAllMounts(group)
	for key,mount in pairs(self.mounts[group]) do
		mount:SetValue(false)
		BeStride:DBSetMount(group,mount.mountID,mount:GetValue())
	end
end

function BeStride_GUI:FilterMounts(group,text)
	self.mountsGroup:ReleaseChildren()
	self.mounts[group] = nil
	self.mounts[group] = {}
	self:CreateMountCheckBoxes(group,text)
	for _,mountCheck in pairsByKeys(self.mounts[group]) do self.mountsGroup:AddChild(mountCheck) end
end

function BeStride_GUI:CreateMountCheckBoxes(group,filter)
	for key,mount in pairs(mountTable[group]) do
		if filter == nil or (filter ~= nil and (string.len(filter) == 0 or string.find(string.lower(mountTable.master[mount].name), string.lower(filter)))) then
			local mountCheck = BeStride_GUI:CreateMountCheckBox(group,mount)
			if mountCheck ~= nil then
				--print("Creating mount: " .. mount)
				local name = mountTable.master[mount].name
				self.mounts[group][name] = mountCheck
			end
		end
	end
end

function BeStride_GUI:CreateMountCheckBox(group,mountID)
	local mount = mountTable.master[mountID]
	if BeStride_Game == "Wrath" or (BeStride_Game == "Mainline" and mount.isCollected and (mount.faction== nil or mount.faction == playerTable["faction"]["id"])) then
		mountButton = AceGUI:Create("CheckBox")
		mountButton:SetImage(mount["icon"])
		mountButton:SetLabel(mount["name"])
		mountButton:SetValue(BeStride:DBGetMount(group,mountID))
		mountButton:SetCallback("OnValueChanged", function(container) BeStride:DBSetMount(group,mount.mountID,container:GetValue()) end)
		mountButton.mountID = mountID
		return mountButton
	else
		return nil
	end
end

function BeStride_GUI:DrawMountOptionTab(container, parent)
	container:SetLayout("Fill")
	
	local scrollcontainer = AceGUI:Create("SimpleGroup")
	scrollcontainer:SetFullWidth(true)
	scrollcontainer:SetFullHeight(true)
	scrollcontainer:SetLayout("Fill")
	container:AddChild(scrollcontainer)

	local scroll = AceGUI:Create("ScrollFrame")
	scroll:SetLayout("Flow") 
	scrollcontainer:AddChild(scroll)
	
	for name,setting in pairs(BeStride_Variables.Settings.Mount) do
		local element = nil
		if setting.element == "CheckBox" then
			element = self:CreateSettingCheckBox(setting.name,setting.label,setting.depends, setting.dependants)
		elseif setting.element == "Slider" then
			element = self:CreateSettingSlider(setting.name,setting.label,setting.minDurability,setting.maxDurability,setting.increment,setting.depends, setting.dependants)
		elseif setting.element == "Group" and setting.children then
			element = AceGUI:Create("SimpleGroup")
			element:SetFullWidth(true)
			for subName,subSetting in pairs(setting.children) do
				local subElement = nil
				if subSetting.element == "CheckBox" then
					subElement = self:CreateSettingCheckBox(subSetting.name,subSetting.label,subSetting.depends, subSetting.dependants)
				elseif subSetting.element == "Slider" then
					subElement = self:CreateSettingSlider(subSetting.name,subSetting.label,subSetting.minDurability,subSetting.maxDurability,subSetting.increment,subSetting.depends, subSetting.dependants)
				end
				element:AddChild(subElement)
			end
		end
		
		if element ~= nil then
			scroll:AddChild(element)
		end
	end
end

function BeStride_GUI:CreateSettingCheckBox(name,label,depends,dependants)
	local element = AceGUI:Create("CheckBox")
	element:SetLabel(label)
	element:SetValue(BeStride:DBGetSetting(name))
	element:SetFullWidth(true)
	
	
	if  depends ~= nil then
		local disabled = nil
		for key,value in pairs(depends) do
			if disabled == nil then
				disabled = BeStride:DBGetSetting(value)
			else
				disabled = bit.band(disabled,BeStride:DBGetSetting(value))
			end
		end
		
		element:SetDisabled(not disabled)
	end
	
	if dependants ~= nil then
		element:SetCallback("OnValueChanged",function (container)
			BeStride:DBSetSetting(name,container:GetValue())
			for key,value in pairs(dependants) do
				self.elements[value]:SetDisabled(not BeStride:DBGetSetting(name))
			end
		end)
	else
		element:SetCallback("OnValueChanged",function (container) BeStride:DBSetSetting(name,container:GetValue()) end)
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
				disabled = BeStride:DBGetSetting(value)
			else
				disabled = bit.band(disabled,BeStride:DBGetSetting(value))
			end
		end
		
		element:SetDisabled(not disabled)
	end
	
	if dependants ~= nil then
		element:SetCallback("OnValueChanged",function (container)
			BeStride:DBSetSetting(name,container:GetValue())
			for key,value in pairs(dependants) do
				self.elements[value]:SetDisabled(not BeStride:DBGetSetting(name))
			end
		end)
	else
		element:SetCallback("OnValueChanged",function (container) BeStride:DBSetSetting(name,container:GetValue()) end)
	end
	
	self.elements[name] = element
	return element
end

function BeStride_GUI:DrawClassOptionTab(container)
	container:SetLayout("Fill")
	
	local scrollcontainer = AceGUI:Create("SimpleGroup")
	scrollcontainer:SetFullWidth(true)
	scrollcontainer:SetFullHeight(true)
	scrollcontainer:SetLayout("Fill")
	container:AddChild(scrollcontainer)

	local scroll = AceGUI:Create("ScrollFrame")
	scroll:SetLayout("Flow") 
	scrollcontainer:AddChild(scroll)
	
	table.foreach(BeStride_Variables.Settings.Classes,function (key,classSetting)
		--if tolower(class) == tolower(playerTable["class"]["name"])
			for name,setting in pairs(classSetting) do
				
				if setting.element == "CheckBox" then
					element = self:CreateSettingCheckBox(setting.name,setting.label,setting.depends, setting.dependants)
				elseif setting.element == "Slider" then
					element = self:CreateSettingSlider(setting.name,setting.label,setting.minDurability,setting.maxDurability,setting.increment,setting.depends, setting.dependants)
				end
				
				if element ~= nil then
					scroll:AddChild(element)
				end
			end
		--end
	end)
end

function BeStride_GUI:DrawKeybindsTab(container)
	container:SetLayout("Flow")
	
	self.buttons[BeStride_ABRegularMount:GetName()] = AceGUI:Create("Keybinding")
	self.buttons[BeStride_ABGroundMount:GetName()] = AceGUI:Create("Keybinding")
	self.buttons[BeStride_ABPassengerMount:GetName()] = AceGUI:Create("Keybinding")
	self.buttons[BeStride_ABRepairMount:GetName()] = AceGUI:Create("Keybinding")
	
	self.buttons[BeStride_ABRegularMount:GetName()]:SetLabel(BeStride_Locale.Bindings.Regular)
	self.buttons[BeStride_ABRegularMount:GetName()]:SetKey(GetBindingKey("CLICK BeStride_ABRegularMount:LeftButton"))
	self.buttons[BeStride_ABRegularMount:GetName()]:SetCallback("OnKeyChanged",function() BeStride_GUI:UpdateBinding(BeStride_ABRegularMount,self.buttons[BeStride_ABRegularMount:GetName()]:GetKey()) end)
	container:AddChild(self.buttons[BeStride_ABRegularMount:GetName()])
	
	self.buttons[BeStride_ABGroundMount:GetName()]:SetLabel(BeStride_Locale.Bindings.Ground)
	self.buttons[BeStride_ABGroundMount:GetName()]:SetKey(GetBindingKey("CLICK BeStride_ABGroundMount:LeftButton"))
	self.buttons[BeStride_ABGroundMount:GetName()]:SetCallback("OnKeyChanged",function() BeStride_GUI:UpdateBinding(BeStride_ABGroundMount,self.buttons[BeStride_ABGroundMount:GetName()]:GetKey()) end)
	container:AddChild(self.buttons[BeStride_ABGroundMount:GetName()])
	
	self.buttons[BeStride_ABRepairMount:GetName()]:SetLabel(BeStride_Locale.Bindings.Repair)
	self.buttons[BeStride_ABRepairMount:GetName()]:SetKey(GetBindingKey("CLICK BeStride_ABRepairMount:LeftButton"))
	self.buttons[BeStride_ABRepairMount:GetName()]:SetCallback("OnKeyChanged",function() BeStride_GUI:UpdateBinding(BeStride_ABRepairMount,self.buttons[BeStride_ABRepairMount:GetName()]:GetKey()) end)
	container:AddChild(self.buttons[BeStride_ABRepairMount:GetName()])
	
	self.buttons[BeStride_ABPassengerMount:GetName()]:SetLabel(BeStride_Locale.Bindings.Passenger)
	self.buttons[BeStride_ABPassengerMount:GetName()]:SetKey(GetBindingKey("CLICK BeStride_ABPassengerMount:LeftButton"))
	self.buttons[BeStride_ABPassengerMount:GetName()]:SetCallback("OnKeyChanged",function() BeStride_GUI:UpdateBinding(BeStride_ABPassengerMount,self.buttons[BeStride_ABPassengerMount:GetName()]:GetKey()) end)
	container:AddChild(self.buttons[BeStride_ABPassengerMount:GetName()])
end

function BeStride_GUI:DrawProfileTab(container) --PROFILE OPTIONS
	container:SetLayout("List")
	
	local profiles = BeStride:GetProfiles()
	local currentProfile = BeStride.db:GetCurrentProfile()
	local profileID = 1
	
	table.foreach(profiles,function (k,v) if v == currentProfile then profileID = k end end)
	
	self.elements["profile.create"] = AceGUI:Create("EditBox")
	self.elements["profile.create"]:SetLabel(BeStride_Locale.Settings.Profiles.CreateNew)
	self.elements["profile.create"]:SetMaxLetters(15) 

	self.elements["profile.current"] = AceGUI:Create("Dropdown")
	self.elements["profile.current"]:SetList(profiles)
	self.elements["profile.current"]:SetLabel(BeStride_Locale.Settings.Profiles.Current)
	self.elements["profile.current"]:SetValue(profileID)
	
	self.elements["profile.copy"] = AceGUI:Create("Dropdown")
	self.elements["profile.copy"]:SetList(profiles)
	self.elements["profile.copy"]:SetItemDisabled(profileID, true)
	self.elements["profile.copy"]:SetLabel(BeStride_Locale.Settings.Profiles.CopyFrom)
	
	self.elements["profile.copybutton"] = AceGUI:Create("Button")
	self.elements["profile.copybutton"]:SetWidth(100)
	self.elements["profile.copybutton"]:SetText(BeStride_Locale.GUI.BUTTON.Copy)
	self.elements["profile.copybutton"]:SetDisabled(true)
	
	self.elements["profile.delete"] = AceGUI:Create("Dropdown")
	self.elements["profile.delete"]:SetList(profiles)
	self.elements["profile.delete"]:SetItemDisabled(profileID, true)
	self.elements["profile.delete"]:SetLabel(BeStride_Locale.Settings.Profiles.Delete)
	
	self.elements["profile.deletebutton"] = AceGUI:Create("Button")
	self.elements["profile.deletebutton"]:SetWidth(100)
	self.elements["profile.deletebutton"]:SetText(BeStride_Locale.GUI.BUTTON.Delete)
	self.elements["profile.deletebutton"]:SetDisabled(true)
	
	self.elements["profile.create"]:SetCallback("OnEnterPressed", function() BeStride_GUI:ProfileCreate(self.elements["profile.create"]:GetText()) end)
	self.elements["profile.current"]:SetCallback("OnValueChanged", function() BeStride_GUI:ProfileSwitch(self.elements["profile.current"]:GetValue()) end)
	self.elements["profile.copy"]:SetCallback("OnValueChanged", function() self.elements["profile.copybutton"]:SetDisabled(false) end)
	self.elements["profile.delete"]:SetCallback("OnValueChanged", function() self.elements["profile.deletebutton"]:SetDisabled(false) end)
	self.elements["profile.copybutton"]:SetCallback("OnClick",function() BeStride_GUI:ProfileCopy(self.elements["profile.copy"]:GetValue()) end)
	self.elements["profile.deletebutton"]:SetCallback("OnClick",function() BeStride_GUI:ProfileDelete(self.elements["profile.delete"]:GetValue()) end)
	
	container:AddChild(self.elements["profile.create"])
	container:AddChild(self.elements["profile.current"])
	container:AddChild(self.elements["profile.copy"])
	container:AddChild(self.elements["profile.copybutton"])
	container:AddChild(self.elements["profile.delete"])
	container:AddChild(self.elements["profile.deletebutton"])
end

function BeStride_GUI:ProfileCreate(name)
	if searchTableForValue(BeStride:GetProfiles(),name) ~= nil then
		return
	end
	
	if name ~= "" then
		BeStride.db:SetProfile(name)
		self:ProfileResetLists()
	end
	
	self.elements["profile.create"]:SetText("")
end

function BeStride_GUI:ProfileSwitch(id)
	local profiles = BeStride:GetProfiles()
	key = profiles[self.elements["profile.current"]:GetValue()]
	BeStride.db:SetProfile(key)
	self:ProfileResetLists()
end

function BeStride_GUI:ProfileResetLists()
	local profiles,currentProfile = BeStride:GetProfiles(),BeStride.db:GetCurrentProfile()
	
	self.elements["profile.current"]:SetList(profiles)
	self.elements["profile.copy"]:SetList(profiles)
	self.elements["profile.delete"]:SetList(profiles)
	
	table.foreach(profiles,function(k,v)
		self.elements["profile.copy"]:SetItemDisabled(k, false)
		self.elements["profile.delete"]:SetItemDisabled(k, false)
	end)
	
	local currentProfileID = searchTableForValue(profiles,currentProfile)
	
	self.elements["profile.current"]:SetValue(currentProfileID)
	self.elements["profile.copy"]:SetItemDisabled(currentProfileID, true)
	self.elements["profile.delete"]:SetItemDisabled(currentProfileID, true)
end

function BeStride_GUI:ProfileCopy(profileID)
	local profiles = BeStride:GetProfiles()
	profile = profiles[profileID]
	BeStride.db:CopyProfile(profile,true)
	self.elements["profile.copy"]:SetValue("")
	self.elements["profile.copybutton"]:SetDisabled(true)
end

function BeStride_GUI:ProfileDelete(profileID)
	local profiles = BeStride:GetProfiles()
	profile = profiles[profileID]
	BeStride.db:DeleteProfile(profile,true)
	self.elements["profile.delete"]:SetValue("")
	self.elements["profile.deletebutton"]:SetDisabled(true)
	self:ProfileResetLists()
end

function BeStride_GUI:UpdateBinding(button,key)
	SetBinding(key)
	SetBindingClick(key,button:GetName())
	
	SaveBindings(GetCurrentBindingSet())
end

function BeStride_GUI:DrawAboutTab(container)
	container:SetLayout("Flow")
	local about = AceGUI:Create("Label")
	about:SetText(BeStride_Locale.About)
	about:SetWidth(700)
	container:AddChild(about)
end

function BeStride_GUI:BugReport()
	BeStride_Debug_Frame = AceGUI:Create("Frame")
	BeStride_Debug_Frame:SetCallback("OnClose",function (widget) BeStride_GUI:BugReportClear() end)
	BeStride_Debug_Frame:SetTitle("BeStride Bug Report")
	BeStride_Debug_Frame:SetStatusText("Press Escape or Close to Exit")
	BeStride_Debug_Frame:SetLayout("Fill")
	BeStride_Debug_Frame:SetWidth(720)
	BeStride_Debug_Frame:SetHeight(490)
	
	local BeStride_Debug_EditBox = AceGUI:Create("MultiLineEditBox")
	BeStride_Debug_EditBox:SetLabel("Debug")
	BeStride_Debug_EditBox:SetFullWidth(true)
	BeStride_Debug_EditBox:SetFullHeight(true)
	BeStride_Debug_EditBox:DisableButton(true)
	BeStride_Debug_EditBox:SetText("Version = " .. version .. "\n"
		.. "maps = { " .. "\n" .. BeStride_GUI:DebugTable(BeStride_GUI:DebugMap(),0) .. "}" .. "\n"
		.. "mountTable = { " .. "\n" .. BeStride_GUI:DebugTable(mountTable,0) .. "}" .. "\n"
		.. "BeStride.db.profile = { " .. "\n" .. BeStride_GUI:DebugTable(BeStride.db.profile,0) .. "}" .. "\n"
		.. "BeStride_Variables = { " .. "\n" .. BeStride_GUI:DebugTable(BeStride_Variables,0) .. "}" .. "\n"
		.. "BeStride_Constants = { " .. "\n" .. BeStride_GUI:DebugTable(BeStride_Constants,0) .. "}" .. "\n"
		)
	
	BeStride_Debug_EditBox:HighlightText()
	
	BeStride_Debug_Frame:AddChild(BeStride_Debug_EditBox)
	
	local closebutton = "BeStride_DebugFrameClose"
	BeStride_GUI.debugclose = CreateFrame("Button", closebutton, UIParent, "SecureActionButtonTemplate,ActionButtonTemplate")
	BeStride_GUI.debugclose:SetAttribute("type","macro")
	BeStride_GUI.debugclose:SetAttribute("macrotext","/script BeStride_GUI:BugReportClear()")
	SetOverrideBindingClick(BeStride_GUI.debugclose,true,"ESCAPE",closebutton)
end

function BeStride_GUI:BugReportClear()
	--ClearOverrideBindings(BeStride_GUI.debugclose)
	BeStride_GUI.debugclose = nil
	AceGUI:Release(BeStride_Debug_Frame)
	BeStride_Debug_Frame = nil
	collectgarbage()
end

function BeStride_GUI:DebugTable(table,depth)
	-- depth shouldn't be > 20 and shouldn't be nil
	if depth == nil or depth > 20 then
		return ""
	end
	
	local tab = ""
	local data = ""
	local lf = "\n"
	
	for i=0,depth do
		tab = tab .. "    "
	end
	
	for k,v in pairs(table) do
		local line = tab .. k
		if k == "source" then
			line = ""
		elseif type(v) == "table" then
			line = line .. " = { " .. lf .. self:DebugTable(v,depth+1) .. tab .. "}," .. lf
		else
			line = line .. " = " .. tostring(v) .. "," .. lf
		end
		
		data = data .. line
	end
	
	return data
end

function BeStride_GUI:DebugMap(mapID)
	if mapID == nil then
		mapID = C_Map.GetBestMapForUnit("player")
	end
	
	local map = C_Map.GetMapInfo(mapID)
	local data = {}
	
	if (map.parentMapID == 0 or map.parentMapID == nil) then
		table.insert(data,map)
		return data
	else
		local parent = BeStride_GUI:DebugMap(map.parentMapID)
		
		table.insert(data,map)
		
		for k,v in pairs(parent) do table.insert(data,v); print(v.name) end
		
		return data
	end
end
