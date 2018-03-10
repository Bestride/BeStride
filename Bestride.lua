Bestride = LibStub("AceAddon-3.0"):NewAddon("Bestride","AceConsole-3.0", "AceEvent-3.0")
AceGUI = LibStub("AceGUI-3.0")

local function pairsByKeys (t, f)
  local a = {}
    for n in pairs(t) do 
      table.insert(a, n) 
    end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
      i = i + 1
      if a[i] == nil then 
        return nil
      else 
        return a[i], t[a[i]]
      end
    end
  return iter
end

local options = {
  name="Bestride",
  handler = Bestride,
  type = "group",
  args = {
    enable = {
      type = "execute",
      name = BestrideLocale.Misc.optionsGUIButton,
      func = "Frames",
    },
  }
}

BestrideState = {
	playerFaction = nil, 
	usePassengerMount = false, 
	forceRepairMount = false,
	localClass = nil,
	class = nil,
	playerCombat = false,
	tabContent
}

BestrideDB = {
	tProfiles, tProfiles2
}

BestrideSpellIDs = {
	["MONK"] = 109132, -- Roll
	["PALADIN"] = 190784, -- Divine Steed
	["DEATHKNIGHT"]= 212552, -- Wraith Walk
	["SHAMAN"] = 2645, -- Ghost Wolf
	["ROGUE"] = 2983, -- Sprint
	["ZENFLIGHT"] = 125883, -- Zen Flight
}

BestrideMountType = {
	ground = "ground",
	flying = "fly",
	special = "special",
}

local infoTable, tabCheckBoxes = {}, {}
local currentTab, currentSubTab
local f = CreateFrame("frame")
local f2 = CreateFrame("frame")

local defaults = { 
  global = { 
    ["CV"] = "0.0.1", --Current version
  },
  profile = {
    settings = {
      ["ER"] = true, --emptyrandom: use random mount if none selected
      ["FFP"] = false, --Druid: Use flight form with priority
      ["TTT"] = false, --Travel to Travel, no human form. Mostly for pvp.
      ["MTFF"] = false, --Druid: When flying mounted shift directly to flight form
      ["FBP"] = false, --Prioritize flying broom, even over Flight form
      ["HM"] = false, -- Has Mount
      ["NDWF"] = false, -- No Dismount while Flying. Safe!
      ["FFM"] = true, --Force Flying Mount (in ground areas)
      ["DEATHKNIGHT"] = true, --DeathKnight: Wraith Walk
	  ["PALADIN"] = true, --Paladin: Divine Steed
	  ["SHAMAN"] = true, --Shaman: Ghost wolf
	  ["MONK"] = true, --Monk: Roll
	  ["MONKZENUSE"] = true, --Monk: Use Zen Flight at all
      ["ROGUE"] = true, --Rogue: Sprint
      ["PRIEST"] = true, --Priest/Mage: Levitate/Slowfall
	  ["MAGE"] = true, --Priest/Mage: Levitate/Slowfall
      ["URM"] = true, --use a repair mount if one exists
	  ["TELAARI"] = true, --Use the Telaari Talbuk (or horde equivalent) in Nagrand
	  ["ENABLENEW"] = false, -- New mounts are selected upon learning them
    },
    misc = {
      ["DBSize"] = 0, -- Database size
      ["MinDurability"] = 0.2, --summon repair mount if under X durability
      
      RepairMounts = {},
      NumMounts = {
        ["Total"] = 0,
        ["Ground"] = 0,
        ["Flying"] = 0,
		["Profession"] = 0,
        ["Special"] = 0,
        },
    },    
    mounts = {
      ['*'] = {
      },
    },
  }
}

function Bestride:OnInitialize() 
  self.db = LibStub("AceDB-3.0"):New("BestrideDB", defaults, "Default")
  local bestrideOptions = LibStub("AceConfigRegistry-3.0")
  bestrideOptions:RegisterOptionsTable("Bestride",options)
  self.bestrideOpFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Bestride","Bestride")
  self:RegisterChatCommand("br", "ChatCommand")
  self:RegisterChatCommand("bestride", "ChatCommand")
  self:RegisterChatCommand("ym", "ChatCommand")
  self:RegisterChatCommand("bestride", "ChatCommand")
end

function Bestride:ChatCommand(input) --Chat command function
  if input == "reload" or input == "rl" then
    Bestride:ReSort()
    self:Print(BestrideLocale.Misc.mountsReloaded)
  
  else
    Bestride:Frames("tab1")
  end
end

function Bestride:OnEnable()-- addon enabled
	BestrideState.localClass, BestrideState.class = UnitClass("player")
	BestrideDB.tProfiles = {}
	BestrideDB.tProfiles2 = {}
	
	Bestride:AlphaSortProfileDB()

	local _, race = UnitRace("player")

    Bestride:ReSort()

	Bestride:MapOverrides()
  
	-- Register events
	self:RegisterEvent("UPDATE_BINDINGS", "MapOverrides")
	self:RegisterEvent("COMPANION_LEARNED", "EventHandler")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "EventHandler")
	Bestride:RegisterEvent("PLAYER_REGEN_DISABLED", "EventHandler")
	Bestride:RegisterEvent("PLAYER_REGEN_ENABLED", "EventHandler")

	--if race == "Worgen" and UnitLevel("player") < 21 then
		--self:RegisterEvent("PLAYER_LEVEL_UP", "EventHandler")
	--end
end

function Bestride:EventHandler(arg1, arg2)
  if arg1 == "PLAYER_REGEN_DISABLED" then
    BestrideState.playerCombat = true
		
    if BestrideState.class == "DRUID" then
		if not self.db.profile.settings["TTT"] then
			Bestride:SetMacroButtonCombat("[swimming] "..Bestride:SpellToName(783).."; [outdoors] "..Bestride:SpellToName(783).."; "..Bestride:SpellToName(768))
		else
			Bestride:SetMacroButtonCombat("[swimming] !"..Bestride:SpellToName(783).."; [outdoors] !"..Bestride:SpellToName(783).."; !"..Bestride:SpellToName(768))
		end
      
    elseif BestrideState.class == "PRIEST" then
		if IsUsableSpell(1706) and self.db.profile.settings["PRIEST"] then --IsUsableSpell checks for reagents/glyphs
			Bestride:SetMacroButtonCombat("[@player] "..Bestride:SpellToName(1706).."\n/cancelaura "..Bestride:SpellToName(1706)) --Levitate
		end
      
    elseif BestrideState.class == "MAGE" then
		if IsUsableSpell(130) and self.db.profile.settings["MAGE"] then
			Bestride:SetMacroButtonCombat("[@player] "..Bestride:SpellToName(130).."\n/cancelaura "..Bestride:SpellToName(130)) --Slow fall
		end
    
    elseif self.db.profile.settings[BestrideState.class] then
		Bestride:SetMacroButtonCombat(Bestride:SpellToName(BestrideSpellIDs[BestrideState.class]))
    end
    
  elseif arg1 == "PLAYER_REGEN_ENABLED" then
    BestrideState.playerCombat = false
    Bestride:SetMacroButton()
    
  elseif arg1 == "PLAYER_LEVEL_UP" then
    if arg2 == 20 then
      Bestride:ReSort()
      self:UnregisterEvent("PLAYER_LEVEL_UP")
    end
    
  elseif arg1 == "COMPANION_LEARNED" then
    Bestride:ReSort()
	Bestride:HandleNewCompanion()
    
  elseif arg1 == "PLAYER_ENTERING_WORLD" then
    local faction, _ = UnitFactionGroup("player")
    if(faction == "Alliance") then
      BestrideState.playerFaction = 1
    elseif(faction == "Horde") then
      BestrideState.playerFaction = 0
    else
      self:Print("Unrecognized faction: ", faction)
      BestrideState.playerFaction = -1
    end
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
  end
end

--------------------------------------------------------------
--database handling and creation functions
--------------------------------------------------------------

function Bestride:IsUsableMount(id)
	local n,spellID,_,_,isUsable,_,_,_,_,isHidden,isCollected = C_MountJournal.GetMountInfoByID(id)
	-- DEFAULT_CHAT_FRAME:AddMessage("Usable: " .. tostring(id) .. "," .. tostring(isUsable) )
	return isUsable
end

function Bestride:AlphaSortProfileDB()
  table.wipe(BestrideDB.tProfiles)
  table.wipe(BestrideDB.tProfiles2)
  
  self.db:GetProfiles(BestrideDB.tProfiles)

  for k, v in pairs(BestrideDB.tProfiles) do
    BestrideDB.tProfiles2[v] = k     --put names as key, order #'s as value
  end
  
  table.wipe(BestrideDB.tProfiles)
  
  for k, v in pairsByKeys(BestrideDB.tProfiles2) do
    tinsert(BestrideDB.tProfiles, k)   --sort alphabetically, name as value
  end
  
end

function Bestride:ReSort()
  local tempTable = {}
  
  for k,v in pairs(self.db.profile.mounts) do
    tempTable[k] = self.db.profile.mounts[k][1]
  end
  table.wipe(self.db.profile.mounts)
  
  Bestride:ReloadMounts(tempTable)
end

function Bestride:ReputationCheck(spellID)
  if BestrideType["Reputation"][spellID] then    
	-- Nothing gated behind reputation right now
    return false
  end
  
  return true -- Not a known reputation restricted spell
end

function Bestride:SpellToName(spell) --converts spell ID to Name
  local name = GetSpellInfo(spell)
  return name
end

function Bestride:ItemToName(itemID) --converts spell ID to Name
  local name = GetItemInfo(itemID)
  return name
end

function Bestride:GetDbValue(info, key)
  if info == "mounts" then
    return self.db.profile.mounts[key][1]
  
  elseif info == "settings" then
    return self.db.profile.settings[key]
    
  elseif info == "misc" then
    return self.db.profile.misc[key]
  end
end

function Bestride:SetDbValue(info, key, state)
  -- DEFAULT_CHAT_FRAME:AddMessage("Setting: " .. tostring(key) .. "," .. tostring(state))

  if info == "mounts" then
    self.db.profile.mounts[key][1] = state
  elseif info == "misc" then
    self.db.profile.misc[key] = state  
  elseif info == "settings" then
    self.db.profile.settings[key] = state
  end
end

function Bestride:ClearMounts(mountType)-- clear all mounts
	for spellID,v in pairs(self.db.profile.mounts) do
		if self.db.profile.mounts[spellID][2] == mountType and tabCheckBoxes[spellID] ~= nil then
			self.db.profile.mounts[spellID][1] = false
			tabCheckBoxes[spellID]:SetValue(false)
		end
	end
end

function Bestride:SelectAllMounts(mountType)-- select all mounts
	for spellID,v in pairs(self.db.profile.mounts) do
		if self.db.profile.mounts[spellID][2] == mountType and tabCheckBoxes[spellID] ~= nil then
			self.db.profile.mounts[spellID][1] = true
			tabCheckBoxes[spellID]:SetValue(true)
		end
	end
end

local function BuildListSortFunc(a, b)
    return a.name < b.name
end

function Bestride:BuildList(mountType)--Builds and draws the checkboxes for the opened tab
	infoTable = {}
	for index,id in pairs(C_MountJournal.GetMountIDs()) do
		local name,spellID,icon,_,_,_,_,_,faction,_,_ = C_MountJournal.GetMountInfoByID(id)
		infoTable[index] = {}
		infoTable[index].id = id
		infoTable[index].name = name
		infoTable[index].spellID = spellID
		infoTable[index].icon = icon
		infoTable[index].faction = faction
		infoTable[index].mountType = mountType
	end
	
	table.sort(infoTable, BuildListSortFunc)

	for index,_ in pairs(infoTable) do	
		local info = infoTable[index]
		Bestride:CreateMountCheckBox(info, mountType)
	end
	
	collectgarbage()
end

function Bestride:ReloadMounts(tempTable)--Rebuilds the database. Activates on load
	self.db.profile.misc.NumMounts["Ground"] = 0
	self.db.profile.misc.NumMounts["Flying"] = 0
	self.db.profile.misc.NumMounts["Profession"] = 0
	self.db.profile.misc.NumMounts["Special"] = 0
	self.db.profile.misc.NumMounts["Total"] = 0
  
	for index,id in pairs(C_MountJournal.GetMountIDs()) do
		local n,spellID,_,_,_,isUsable,_,_,_,isHidden,isCollected = C_MountJournal.GetMountInfoByID(id)
		local _, _, _, _, mountTypeID = C_MountJournal.GetMountInfoExtraByID(id)
		
		-- Deal with class mounts not showing up as collected on other classes.
		if(BestrideType["Class"][spellID] ~= nil) then
			if(tempTable[spellID] ~= nil) then
				isCollected = true
			end
		end
		
		if(isCollected and mountTypeID ~= 242 and mountTypeID ~= 284) then
			local mountType = BestrideType["Mounts"][mountTypeID]		  
		  
			if(mountType ~= nil) then
				--Check if we have a repair mount
				if spellID == 61425 or spellID == 61447 or spellID == 122708 then
					self.db.profile.misc.RepairMounts[spellID] = true
				end

				if mountType == nil and spellID ~= 75207 then --Found a 'new' mount, ie unknown type
					self.db.profile.misc.NumMounts["Total"] = self.db.profile.misc.NumMounts["Total"] - 1
				else
					-- Keep old selection setting
					if tempTable[spellID] == nil then
						self.db.profile.mounts[spellID] = {self.db.profile.settings["ENABLENEW"], mountType, id}
					else
						self.db.profile.mounts[spellID] = {tempTable[spellID], mountType, id}
					end
				end

				--Increment the counters
				if mountType == BestrideMountType.ground then
					self.db.profile.misc.NumMounts["Ground"] = self.db.profile.misc.NumMounts["Ground"] + 1
				elseif mountType == BestrideMountType.flying then
					self.db.profile.misc.NumMounts["Flying"] = self.db.profile.misc.NumMounts["Flying"] + 1
				elseif mountType == BestrideMountType.special then
					self.db.profile.misc.NumMounts["Special"] = self.db.profile.misc.NumMounts["Special"] + 1
				end

				self.db.profile.misc.NumMounts["Total"] = self.db.profile.misc.NumMounts["Total"] + 1
				
			else
				self:Print("Unknown mount type id found (", mountTypeID, ") ", n)
			end
		end
	end
  
	if self.db.profile.misc.NumMounts["Total"] > 0 then
		self.db.profile.settings["HM"] = true
	end
end

function Bestride:FilterMounts(str)
	str = string.lower(str)
	BestrideState.tabContent:ReleaseChildren()
	tabCheckBoxes = {}
	
	for spellID, info in pairs(infoTable) do
		if string.len(str) == 0 or string.find(string.lower(info.name), str) then
			Bestride:CreateMountCheckBox(info)
		end
	end
end

function Bestride:CreateMountCheckBox(info)
	if info.faction == nil or info.faction == BestrideState.playerFaction then
		if self.db.profile.mounts[info.spellID][2] == info.mountType then			
			tabCheckBoxes[info.spellID] = AceGUI:Create("CheckBox")
			
			local widget = tabCheckBoxes[info.spellID]
			widget:SetUserData("spellID", info.spellID)
			widget:SetImage(info.icon)
			widget:SetLabel(info.name)
			widget:SetValue(Bestride:GetDbValue("mounts", info.spellID))
			widget:SetCallback("OnValueChanged",  
				function(arg1) 
					Bestride:SetDbValue("mounts", arg1:GetUserData("spellID"), arg1:GetValue()) 
				end)
			BestrideState.tabContent:AddChild(widget)
		end
	end
end

--------------------------------------------------------------
--Keybinding stuff
--------------------------------------------------------------
function Bestride:UpdateBindingButtons(btn1, btn2, btn3, btn4)
	btn1:SetKey(GetBindingKey("BRMOUNT"))
	btn2:SetKey(GetBindingKey("BRFORCEGROUND"))
	btn3:SetKey(GetBindingKey("BRFORCEPASSENGER"))
	btn4:SetKey(GetBindingKey("BRFORCEREPAIR"))
end

function Bestride:MapOverrides()
  if not InCombatLockdown() then
    ClearOverrideBindings(BestrideButtonMount)
    local key1 = GetBindingKey("BRMOUNT")
    if key1 then
      SetOverrideBindingClick(BestrideButtonMount, true, key1, BestrideButtonMount:GetName())
    end

    ClearOverrideBindings(BestrideButtonGround)
    key1 = GetBindingKey("BRFORCEGROUND")
    if key1 then
      SetOverrideBindingClick(BestrideButtonGround, true, key1, BestrideButtonGround:GetName())
    end
    
    ClearOverrideBindings(BestrideButtonPassenger)
    key1 = GetBindingKey("BRFORCEPASSENGER")
    if key1 then
      SetOverrideBindingClick(BestrideButtonPassenger, true, key1, BestrideButtonPassenger:GetName())
    end
	
	ClearOverrideBindings(BestrideButtonRepair)
    key1 = GetBindingKey("BRFORCEREPAIR")
    if key1 then
      SetOverrideBindingClick(BestrideButtonRepair, true, key1, BestrideButtonRepair:GetName())
    end
  end
end

function Bestride:Keybinding(key, buttonID)
	if not key then
		key = ""
	end

	--if not InCombatLockdown() then
		if buttonID == 1 then
			local key1 = GetBindingKey("BRMOUNT")
			if key1 then
				SetBinding(key1)
			end
			SetBinding(key, "BRMOUNT")
		  
		elseif buttonID == 2 then
			local key1 = GetBindingKey("BRFORCEGROUND")
			if key1 then
				SetBinding(key1)
			end
			SetBinding(key, "BRFORCEGROUND")
		
		elseif buttonID == 3 then
			local key1 = GetBindingKey("BRFORCEPASSENGER")
			if key1 then
				SetBinding(key1)
			end
			SetBinding(key, "BRFORCEPASSENGER")
		
		elseif buttonID == 4 then
			local key1 = GetBindingKey("BRFORCEREPAIR")
			if key1 then
				SetBinding(key1)
			end
			SetBinding(key, "BRFORCEREPAIR")
		end
	--end
  
	SaveBindings(GetCurrentBindingSet())
end