local AceGUI = LibStub("AceGUI-3.0")
	
local BeStride_Frame = nil


BeStride_GUI = {}

function BeStride_GUI:Frame()
	if not BeStride_Frame then
		BeStride_GUI:Open()
	else
		BeStride_GUI:Close()
	end
end

function BeStride_GUI:Open()
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
	
	local tab = AceGUI:Create("TabGroup")
	tab:SetLayout("Flow")
	tab:SetTabs(frameTabs)
	tab:SetCallback("OnGroupSelected", function (container, event, group ) BeStride_GUI:SelectTab(container, event, group) end )
    tab:SelectTab("mounts")
	
    BeStride_Frame:AddChild(tab)
end

function BeStride_GUI:Close()
	AceGUI:Release(widget)
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
		--BeStride_GUI:DrawMountOptionTab(container)
	elseif group == "classoptions" then
		--BeStride_GUI:DrawClassOptionTab(container)
	elseif group == "keybinds" then
		--BeStride_GUI:DrawKeybindsTab(container)
	elseif group == "profile" then
		--BeStride_GUI:DrawProfileTab(container)
	elseif group == "about" then
		--BeStride_Debug:Debug("Drawing About")
		BeStride_GUI:DrawAboutTab(container)
	end
	
	BeStride_Debug:Debug("Group: " .. group)
	
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
	
	local mounts = AceGUI:Create("InlineGroup")
	mounts:SetFullWidth(true)
	mounts:SetLayout("Flow")
	
	for key,mount in pairs(mountTable[group]) do
		--BeStride_Debug:Debug(mount["type"] .. ":" .. group)
		BeStride_Debug:Debug("Mount: " .. mountTable["master"][mount]["name"])
		local mountCheck = BeStride_GUI:CreateMountButton(mount)
		if mountCheck ~= nil then
			mounts:AddChild( mountCheck )
		end
	end
	
	scrollframe:AddChild(mounts)
end

function BeStride_GUI:CreateMountButton(mountID)
	local mount = mountTable.master[mountID]
	if mount["isCollected"] and (mount["faction"]== nil or mount["faction"] == playerTable["faction"]["id"]) then
		mountButton = AceGUI:Create("CheckBox")
		mountButton:SetImage(mount["icon"])
		mountButton:SetLabel(mount["name"])
		mountButton:SetValue(BeStride:DBGetMount(mountID))
		mountButton:SetCallback("OnValueChanged", function(container) Bestride:DBSetMount(mount["mountID"],not container:GetValue()) end)
		return mountButton
	else
		return nil
	end
end

function BeStride_GUI:DrawAboutTab(container)
	container:SetLayout("Flow")
	local about = AceGUI:Create("Label")
	about:SetText( "Version: " .. version .. "\n" .. "Author: " .. author .. "\n" .. "Description: " .. "\n" .. "\t\t" .. "BeStride originally started out as YayMounts by Cyrae on Windrunner US and Anzu on Kirin Tor US"  .. "\n" .. "\t\t" .. "Later, Anaximander from Burning Legion US found the project was neglected and had several bugs which needed to be resolved"  .. "\n" .. "\t\t" .. "as part of the bug resolution process, the addon was modernized to make the code cleaner to follow as well as more modular."  .. "\n" )
	about:SetWidth(700)
	container:AddChild(about)
end