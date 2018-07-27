local version = "0.0.5"
local bestrideFrame = nil

function Bestride:HandleNewCompanion()
	if bestrideFrame then
      local ct, cst = currentTab, currentSubTab
      Bestride:Frames()
      currentSubTab = cst
      Bestride:Frames(ct)
    end
end
--------------------------------------------------------------
--GUI functions for drawing frames
--------------------------------------------------------------
local function DrawMountTab(container, mountType)
  container:SetLayout("Flow")
    
  local selectallbutton = AceGUI:Create("Button")
  selectallbutton:SetText("Select All")
  selectallbutton:SetCallback("OnClick", function() Bestride:SelectAllMounts(mountType) end)
  container:AddChild(selectallbutton)
    
  local clearallbutton = AceGUI:Create("Button")
  clearallbutton:SetText("Clear All")
  clearallbutton:SetCallback("OnClick", function() Bestride:ClearMounts(mountType) end)
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
  
  BestrideState.tabContent = AceGUI:Create("InlineGroup")
  BestrideState.tabContent:SetFullWidth(true)
  BestrideState.tabContent:SetLayout("Flow")
  
  filterButton:SetCallback("OnTextChanged", function(_,_,text)
	Bestride:FilterMounts(text) 
	scrollframe:SetScroll(0)
	scrollframe:DoLayout()
  end)
  
  Bestride:BuildList(mountType)
  scrollframe:AddChild(BestrideState.tabContent)
end

local function SelectGroupMounts(container, event, group)
	container:ReleaseChildren()
	if group == "tab1" then
		DrawMountTab(container, BestrideMountType.ground)
	elseif group == "tab2" then
		DrawMountTab(container, BestrideMountType.flying)
	elseif group == "tab4" then
		DrawMountTab(container, BestrideMountType.special)
	end
	currentSubTab = group
end

local function DrawGroup1(container)--MOUNTS
  container:SetLayout("Fill")

  local tab  = AceGUI:Create("TabGroup")
  tab:SetLayout("Flow")
  tab:SetTabs({
	{text="Ground ("..Bestride.db.profile.misc.NumMounts["Ground"]..")", value="tab1"}, 
	{text="Flying ("..Bestride.db.profile.misc.NumMounts["Flying"]..")", value="tab2"}, 
	{text="Special ("..Bestride.db.profile.misc.NumMounts["Special"]..")", value="tab4"}})
  tab:SetCallback("OnGroupSelected", SelectGroupMounts)
  
  if currentSubTab ~= nil then
    tab:SelectTab(currentSubTab)
  else
    tab:SelectTab("tab1")
  end
  container:AddChild(tab)
end

local function DrawGroup2(container)--MOUNT OPTIONS
	container:SetLayout("Flow")
	
	-- No dismount while flying
	local nDWF = AceGUI:Create("CheckBox")
	nDWF:SetLabel(BestrideLocale.String.NDWF)
	nDWF:SetValue(Bestride:GetDbValue("settings", "NDWF"))
	nDWF:SetCallback("OnValueChanged",  function() Bestride:SetDbValue("settings", "NDWF", nDWF:GetValue()) end)
	nDWF:SetFullWidth(true)
	container:AddChild(nDWF)
	
	-- Use Telaari Talbuk (or horde version) in Nagrand
	local telaari = AceGUI:Create("CheckBox")
	telaari:SetLabel(BestrideLocale.String.TELAARI)
	telaari:SetValue(Bestride:GetDbValue("settings", "TELAARI"))
	telaari:SetCallback("OnValueChanged",  function() Bestride:SetDbValue("settings", "TELAARI", telaari:GetValue()) end)
	telaari:SetFullWidth(true)
	container:AddChild(telaari)
	
	-- enable new mounts upon learning them
	local enableNew = AceGUI:Create("CheckBox")
	enableNew:SetLabel(BestrideLocale.String.ENABLENEW)
	enableNew:SetValue(Bestride:GetDbValue("settings", "ENABLENEW"))
	enableNew:SetCallback("OnValueChanged",  function() Bestride:SetDbValue("settings", "ENABLENEW", enableNew:GetValue()) end)
	enableNew:SetFullWidth(true)
	container:AddChild(enableNew)

	-- Emergency random mount if no mounts useable from selected mounts
	local emptyRandom = AceGUI:Create("CheckBox")
	emptyRandom:SetLabel(BestrideLocale.String.ER)
	emptyRandom:SetValue(Bestride:GetDbValue("settings", "ER"))
	emptyRandom:SetCallback("OnValueChanged",  function() Bestride:SetDbValue("settings", "ER", emptyRandom:GetValue()) end)
	emptyRandom:SetFullWidth(true)
	container:AddChild(emptyRandom)

	local forceFlyingMount = AceGUI:Create("CheckBox")
	forceFlyingMount:SetLabel(BestrideLocale.String.FFM)
	forceFlyingMount:SetValue(Bestride:GetDbValue("settings", "FFM"))
	forceFlyingMount:SetCallback("OnValueChanged", function() Bestride:SetDbValue("settings", "FFM", forceFlyingMount:GetValue()) end)
	forceFlyingMount:SetFullWidth(true)
	container:AddChild(forceFlyingMount)

	local sliderRepairMount = AceGUI:Create("Slider") --repair mount slider in decimal %
	sliderRepairMount:SetLabel("Low Durability %")
	sliderRepairMount:SetValue(Bestride:GetDbValue("misc", "MinDurability")*100)
	sliderRepairMount:SetCallback("OnMouseUp", function() Bestride:SetDbValue("misc", "MinDurability", (sliderRepairMount:GetValue()/100)) end)
	sliderRepairMount:SetSliderValues(0, 100, 5)
	sliderRepairMount:SetDisabled( not Bestride:GetDbValue("settings", "URM"))

	local repairMount = AceGUI:Create("CheckBox")
	repairMount:SetLabel(BestrideLocale.String.URM)
	repairMount:SetValue(Bestride:GetDbValue("settings", "URM"))
	repairMount:SetCallback("OnValueChanged", function() Bestride:SetDbValue("settings", "URM", repairMount:GetValue()) sliderRepairMount:SetDisabled(not repairMount:GetValue()) end)
	repairMount:SetFullWidth(true)
  
	container:AddChild(repairMount)
	container:AddChild(sliderRepairMount)
  
	if GetItemCount(37011, false) > 0 then
		local flyingBroomPriority = AceGUI:Create("CheckBox")
		flyingBroomPriority:SetLabel(BestrideLocale.String.FBP)
		flyingBroomPriority:SetValue(Bestride:GetDbValue("settings", "FBP"))
		flyingBroomPriority:SetCallback("OnValueChanged", function() Bestride:SetDbValue("settings", "FBP", flyingBroomPriority:GetValue()) end)
		flyingBroomPriority:SetFullWidth(true)
		container:AddChild(flyingBroomPriority)
	end
end

local function DrawGroup3(container) --CLASS OPTIONS
  container:SetLayout("Flow")
  
  local infoCS = AceGUI:Create("Label")
  infoCS:SetText(BestrideLocale.String.INFOCS)
  infoCS:SetRelativeWidth(0.9)
  container:AddChild(infoCS)
  
	local shamanCS = AceGUI:Create("CheckBox")
    shamanCS:SetLabel(BestrideLocale.String.SHAMCS)
    shamanCS:SetValue(Bestride:GetDbValue("settings", "SHAMAN"))
    shamanCS:SetCallback("OnValueChanged",  function() Bestride:SetDbValue("settings", "SHAMAN", shamanCS:GetValue()) end)
    shamanCS:SetFullWidth(true)
    container:AddChild(shamanCS)
  
    local rogueCS = AceGUI:Create("CheckBox")
    rogueCS:SetLabel(BestrideLocale.String.RS)
    rogueCS:SetValue(Bestride:GetDbValue("settings", "ROGUE"))
    rogueCS:SetCallback("OnValueChanged",  function() Bestride:SetDbValue("settings", "ROGUE", rogueCS:GetValue()) end)
    rogueCS:SetFullWidth(true)
    container:AddChild(rogueCS)
  
    local mageCS = AceGUI:Create("CheckBox")
    mageCS:SetLabel(BestrideLocale.String.MS)
    mageCS:SetValue(Bestride:GetDbValue("settings", "MAGE"))
    mageCS:SetCallback("OnValueChanged",  function() Bestride:SetDbValue("settings", "MAGE", mageCS:GetValue()) end)
    mageCS:SetFullWidth(true)
    container:AddChild(mageCS)
  
    local dkCS = AceGUI:Create("CheckBox")
    dkCS:SetLabel(BestrideLocale.String.DKS)
    dkCS:SetValue(Bestride:GetDbValue("settings", "DEATHKNIGHT"))
    dkCS:SetCallback("OnValueChanged",  function() Bestride:SetDbValue("settings", "DEATHKNIGHT", dkCS:GetValue()) end)
    dkCS:SetFullWidth(true)
    container:AddChild(dkCS)
  
    local palCS = AceGUI:Create("CheckBox")
    palCS:SetLabel(BestrideLocale.String.PS)
    palCS:SetValue(Bestride:GetDbValue("settings", "PALADIN"))
    palCS:SetCallback("OnValueChanged",  function() Bestride:SetDbValue("settings", "PALADIN", palCS:GetValue()) end)
    palCS:SetFullWidth(true)
    container:AddChild(palCS)
  
    local priestCS = AceGUI:Create("CheckBox")
    priestCS:SetLabel(BestrideLocale.String.PL)
    priestCS:SetValue(Bestride:GetDbValue("settings", "PRIEST"))
    priestCS:SetCallback("OnValueChanged",  function() Bestride:SetDbValue("settings", "PRIEST", priestCS:GetValue()) end)
    priestCS:SetFullWidth(true)
    container:AddChild(priestCS)
	
	------Monk stuff-----
	local monkHeading = AceGUI:Create("Heading")
	monkHeading:SetText(BestrideLocale.String.MONKHEADING)
	monkHeading:SetFullWidth(true)
	container:AddChild(monkHeading)
	
	local monkCS = AceGUI:Create("CheckBox")
    monkCS:SetLabel(BestrideLocale.String.MR)
    monkCS:SetValue(Bestride:GetDbValue("settings", "MONK"))
    monkCS:SetCallback("OnValueChanged",  function() Bestride:SetDbValue("settings", "MONK", monkCS:GetValue()) end)
    monkCS:SetFullWidth(true)
    container:AddChild(monkCS)
	
	local monkZen = AceGUI:Create("CheckBox")
    monkZen:SetLabel(BestrideLocale.String.MONKZENUSE)
    monkZen:SetValue(Bestride:GetDbValue("settings", "MONKZENUSE"))
    monkZen:SetCallback("OnValueChanged",  function() Bestride:SetDbValue("settings", "MONKZENUSE", monkZen:GetValue()) end)
    monkZen:SetFullWidth(true)
    container:AddChild(monkZen)
	
	------Druid stuff-----
	local druidHeading = AceGUI:Create("Heading")
	druidHeading:SetText(BestrideLocale.String.DRUIDHEADING)
	druidHeading:SetFullWidth(true)
	container:AddChild(druidHeading)
	
	local flightFormPriority = AceGUI:Create("CheckBox")
    flightFormPriority:SetLabel(BestrideLocale.String.FFP)
    flightFormPriority:SetValue(Bestride:GetDbValue("settings", "FFP"))
    flightFormPriority:SetCallback("OnValueChanged",  function() Bestride:SetDbValue("settings", "FFP", flightFormPriority:GetValue()) end)
    flightFormPriority:SetFullWidth(true)
    container:AddChild(flightFormPriority)
    
    local travelToTravel = AceGUI:Create("CheckBox")
    travelToTravel:SetLabel(BestrideLocale.String.TTT)
    travelToTravel:SetValue(Bestride:GetDbValue("settings", "TTT"))
    travelToTravel:SetCallback("OnValueChanged", function() Bestride:SetDbValue("settings", "TTT", travelToTravel:GetValue()) end)
    travelToTravel:SetFullWidth(true)
    container:AddChild(travelToTravel)
    
    local mountToFlightForm = AceGUI:Create("CheckBox")
    mountToFlightForm:SetLabel(BestrideLocale.String.MTFF)
    mountToFlightForm:SetValue(Bestride:GetDbValue("settings", "MTFF"))
    mountToFlightForm:SetCallback("OnValueChanged", function() Bestride:SetDbValue("settings", "MTFF", mountToFlightForm:GetValue()) end)
    mountToFlightForm:SetFullWidth(true)
    container:AddChild(mountToFlightForm)
end

local function DrawGroup4(container)--KEYBINDS
	container:SetLayout("Flow")
  
	local BestrideBindingButtonMount = AceGUI:Create("Keybinding")
	local BestrideBindingButtonGround = AceGUI:Create("Keybinding")
	local BestrideBindingButtonPassenger = AceGUI:Create("Keybinding")
	local BestrideBindingButtonRepair = AceGUI:Create("Keybinding")
	
	BestrideBindingButtonMount:SetLabel(BINDING_NAME_BRMOUNT)
	BestrideBindingButtonMount:SetKey(GetBindingKey("BRMOUNT"))
	BestrideBindingButtonMount:SetCallback("OnKeyChanged", 
		function() 
			Bestride:Keybinding(BestrideBindingButtonMount:GetKey(), 1) 
			Bestride:UpdateBindingButtons(BestrideBindingButtonMount, BestrideBindingButtonGround, BestrideBindingButtonPassenger, BestrideBindingButtonRepair)
		end)
	container:AddChild(BestrideBindingButtonMount)

	
	BestrideBindingButtonGround:SetLabel(BINDING_NAME_BRFORCEGROUND)
	BestrideBindingButtonGround:SetKey(GetBindingKey("BRFORCEGROUND"))
	BestrideBindingButtonGround:SetCallback("OnKeyChanged", 
		function() 
			Bestride:Keybinding(BestrideBindingButtonGround:GetKey(), 2); 
			Bestride:UpdateBindingButtons(BestrideBindingButtonMount, BestrideBindingButtonGround, BestrideBindingButtonPassenger, BestrideBindingButtonRepair)
		end)
	container:AddChild(BestrideBindingButtonGround)
  
	
	BestrideBindingButtonPassenger:SetLabel(BINDING_NAME_BRFORCEPASSENGER)
	BestrideBindingButtonPassenger:SetKey(GetBindingKey("BRFORCEPASSENGER"))
	BestrideBindingButtonPassenger:SetCallback("OnKeyChanged", 
		function() 
			Bestride:Keybinding(BestrideBindingButtonPassenger:GetKey(), 3); 
			Bestride:UpdateBindingButtons(BestrideBindingButtonMount, BestrideBindingButtonGround, BestrideBindingButtonPassenger, BestrideBindingButtonRepair)
		end)
	container:AddChild(BestrideBindingButtonPassenger)
	
	
	BestrideBindingButtonRepair:SetLabel(BINDING_NAME_BRFORCEREPAIR)
	BestrideBindingButtonRepair:SetKey(GetBindingKey("BRFORCEREPAIR"))
	BestrideBindingButtonRepair:SetCallback("OnKeyChanged", 
		function() 
			Bestride:Keybinding(BestrideBindingButtonRepair:GetKey(), 4); 
			Bestride:UpdateBindingButtons(BestrideBindingButtonMount, BestrideBindingButtonGround, BestrideBindingButtonPassenger, BestrideBindingButtonRepair)
		end)
	container:AddChild(BestrideBindingButtonRepair)
end

local function DrawGroup5(container) --PROFILE OPTIONS
  container:SetLayout("List")
  local cPV, tempStr = 1, Bestride.db:GetCurrentProfile()
  
  for k,v in pairs(BestrideDB.tProfiles) do
    if v == tempStr then
      cPV = k
    end
  end
  
  local createProfile = AceGUI:Create("EditBox")
  createProfile:SetLabel("Create new Profile")
  createProfile:SetMaxLetters(15) 
  
  local currentProfile = AceGUI:Create("Dropdown")
  currentProfile:SetList(BestrideDB.tProfiles)
  currentProfile:SetLabel("Current Profile:")
  currentProfile:SetValue(cPV)
  
  local copyFrom = AceGUI:Create("Dropdown")
  copyFrom:SetList(BestrideDB.tProfiles)
  copyFrom:SetItemDisabled(cPV, true)
  copyFrom:SetLabel("Copy settings from:")

  
  local copyButton = AceGUI:Create("Button")
  copyButton:SetWidth(75)
  copyButton:SetText("Copy")
  copyButton:SetDisabled(true)
  
  local deleteSelect = AceGUI:Create("Dropdown")
  deleteSelect:SetList(BestrideDB.tProfiles)
  deleteSelect:SetItemDisabled(cPV, true)
  deleteSelect:SetLabel("Delete profile:")
  
  local deleteButton = AceGUI:Create("Button")
  deleteButton:SetWidth(100)
  deleteButton:SetText("Delete")
  deleteButton:SetDisabled(true)
  
  --Callbacks
  createProfile:SetCallback("OnEnterPressed", 
	function()
		local newProfileName = createProfile:GetText()
	
		--Check if there already is a profile with this name
		for k,v in pairs(BestrideDB.tProfiles) do
			if(newProfileName == v) then
				return
			end
		end
	
		local tempKey = cPV
		if newProfileName ~= "" then
			Bestride.db:SetProfile(newProfileName) 

			-- Update the dropdown lists
			Bestride:AlphaSortProfileDB()
			currentProfile:SetList(BestrideDB.tProfiles)
			copyFrom:SetList(BestrideDB.tProfiles)
			deleteSelect:SetList(BestrideDB.tProfiles)
	  
			-- Select the new profile
			if currentProfile:GetValue() ~= newProfileName then
				for k,v in pairs(BestrideDB.tProfiles) do
				  if v == newProfileName then
					tempKey = k
				  end
				end
				currentProfile:SetValue(tempKey)
				copyFrom:SetItemDisabled(tempKey, true)
				copyFrom:SetItemDisabled(cPV, false)
				deleteSelect:SetItemDisabled(tempKey, true)
				deleteSelect:SetItemDisabled(cPV, false)
				cPV = currentProfile:GetValue()
				createProfile:SetText("")
				Bestride:ReSort()
			end
		end
	end)
  
	currentProfile:SetCallback("OnValueChanged", 
		function() 
			if currentProfile:GetValue() ~= cPV then 
				Bestride.db:SetProfile(BestrideDB.tProfiles[currentProfile:GetValue()])
				copyFrom:SetItemDisabled(currentProfile:GetValue(), true)
				copyFrom:SetItemDisabled(cPV, false)
				deleteSelect:SetItemDisabled(currentProfile:GetValue(), true)
				deleteSelect:SetItemDisabled(cPV, false)
				deleteSelect:SetValue(nil)
				cPV = currentProfile:GetValue() 
			end 
		end)
  
	copyFrom:SetCallback("OnValueChanged", 
		function() 
			copyButton:SetDisabled(false) 
		end)
  
	copyButton:SetCallback("OnClick", 
		function() 
			Bestride.db:CopyProfile(BestrideDB.tProfiles[copyFrom:GetValue()], true) 
			copyFrom:SetValue(nil) 
			copyButton:SetDisabled(true)
			Bestride:ReSort()
		end)
  
  deleteSelect:SetCallback("OnValueChanged", 
	function()
		if deleteSelect:GetValue() ~= nil then
		  deleteButton:SetDisabled(false) 
		else
		  deleteButton:SetDisabled(true)
		end
	end)
  
  deleteButton:SetCallback("OnClick", 
	function()
		if(copyFrom:GetValue() == deleteSelect:GetValue()) then
			copyFrom:SetValue(nil)
		end
		
		Bestride.db:DeleteProfile(BestrideDB.tProfiles[deleteSelect:GetValue()], true)
		deleteSelect:SetValue(nil) 
		deleteButton:SetDisabled(true)
		Bestride:AlphaSortProfileDB()
		currentProfile:SetList(BestrideDB.tProfiles)
		copyFrom:SetList(BestrideDB.tProfiles)
		deleteSelect:SetList(BestrideDB.tProfiles)
		deleteSelect:SetItemDisabled(1, true)
		deleteSelect:SetItemDisabled(cPV, true)
	end)
  
  container:AddChild(createProfile)
  container:AddChild(currentProfile)
  container:AddChild(copyFrom)
  container:AddChild(copyButton)
  container:AddChild(deleteSelect)
  container:AddChild(deleteButton)
end

local function SelectGroup(container, event, group)-- Callback function for OnGroupSelected
  container:ReleaseChildren()
  if group == "tab1" then
    DrawGroup1(container)
  elseif group == "tab2" then
    DrawGroup2(container)
  elseif group == "tab3" then
    DrawGroup3(container)
  elseif group == "tab4" then
    DrawGroup4(container)
	elseif group == "tab5" then
    DrawGroup5(container)
  end
  currentTab = group
end

function Bestride:Frames(selectedTab)-- Basic frame
  if not bestrideFrame then 
    bestrideFrame = AceGUI:Create("BestrideFrame")
	tinsert(UISpecialFrames, "BestrideFrame")
	
    bestrideFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget); bestrideFrame = nil end)
    bestrideFrame:SetTitle("Bestride")
    bestrideFrame:SetStatusText("Version "..version..", by Anaximander <IRONFIST> - Burning Legion US, Original Yay Mounts by Cyrae - Windrunner US & Anzu - Kirin Tor US")
    bestrideFrame:SetLayout("Fill")
    bestrideFrame:SetWidth(720)
    bestrideFrame:SetHeight(490)
    
    local tTabs = {
		{text="Mounts ("..self.db.profile.misc.NumMounts["Total"]..")", value="tab1"}, 
		{text="Mount Options", value="tab2"}, 
		{text="Class Options", value="tab3"}, 
		{text="Keybinds", value="tab4"},
		{text="Profile Options", value="tab5"},
    }
  
    --if BestrideState.class == "MAGE" or BestrideState.class == "PRIEST" or BestrideState.class == "DRUID" or BestrideState.class == "MONK" or BestrideState.class == "ROGUE" then
		--tinsert(tTabs, 3, {text=""..BestrideState.localClass.." Options", value = "tab3"})
    --end
  
    local tab = AceGUI:Create("TabGroup")
    tab:SetLayout("Flow")
    tab:SetTabs(tTabs)
    tab:SetCallback("OnGroupSelected", SelectGroup)
    tab:SelectTab(selectedTab)
    bestrideFrame:AddChild(tab)
    
  else
    AceGUI:Release(bestrideFrame)
    bestrideFrame, currentTab, currentSubTab = nil
  end
end
