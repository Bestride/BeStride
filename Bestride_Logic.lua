local function size(t)
	local i = 0
	for k,v in pairs(t) do
		i = i + 1
	end
	return i
end

--------------------------------------------------------------
--Mounting and button click functions
--------------------------------------------------------------
function Bestride:ShouldRepair()
	if(BestrideState.forceRepairMount) then
		return true
	end
	
	local shouldRepair = false

	--Repair mount code
    if size(self.db.profile.misc.RepairMounts) > 0 and self.db.profile.settings["URM"] then
		--Check for low durability equipped gear
		for i = 0, 17 do
			local current, maximum = GetInventoryItemDurability(i)
			if current ~= nil and maximum ~= nil then
				if (current / maximum) <= self.db.profile.misc["MinDurability"] then
				shouldRepair = true
				end
			end
		end
      
		--Check inventory for low durability items
		if(not shouldRepair) then
			for i = 0, 4 do
				for j = 0, GetContainerNumSlots(i) do
					local current, maximum = GetContainerItemDurability(i, j);
					if current ~= nil and maximum ~= nil then
						if (current / maximum) <= self.db.profile.misc["MinDurability"] then
						shouldRepair = true
						end
					end
				end
			end
		end
    end
    
    return shouldRepair
end

function Bestride:GetRepairMount()
	local i, e = 1, {}
  -- Try and use selected repair mounts first
	for k in pairs(self.db.profile.misc.RepairMounts) do
		if k then
			e[i] = k
			i = i + 1
		end
	end

	-- Use any repair mount if none selected
	if #e == 0 then 
		for k in pairs(self.db.profile.misc.RepairMounts) do
			e[i] = k
			i = i + 1
		end
	end
	
	return e
end

local function GetRidingSkill()
	local spellIDs = {33388, 33391, 34090, 34091, 90265}
	local ridingSkill = 0
	
	for i = #spellIDs, 1, -1 do
		if IsSpellKnown(spellIDs[i]) then
			ridingSkill = i
			break
		end
	end
	
	return ridingSkill
end

---- Helper method to get the passenger mounts
function Bestride:BuildPassengerTable(mountType)
	local i, e = 1, {}
  
	for k,v in pairs(BestrideType["Passenger"]) do
		local mountIndex = self.db.profile.mounts[k][3]
		if Bestride:IsUsableMount(mountIndex) and v == mountType then
			e[i] = k
			i = i + 1
		end
	end
  
  -- If we wanted flying mounts, but have none, use any passenger mount
	if #e == 0 then
		for k,v in pairs(BestrideType["Passenger"]) do
			local mountIndex = self.db.profile.mounts[k][3]
			if Bestride:IsUsableMount(mountIndex) then
				e[i] = k
				i = i + 1
			end
		end
	end

	return e
end

function Bestride:BuildStandardMountTable(mountType)
	local i, e = 1, {}
	local forceFlyingMounts = self.db.profile.settings["FFM"] and mountType == BestrideMountType.ground and IsUsableSpell(59976)
  
	for k,v in pairs(self.db.profile.mounts) do  
		local isCorrectType = forceFlyingMounts or v[2] == mountType
		
		if v[1] and Bestride:IsUsableMount(v[3]) and isCorrectType then
			e[i] = k
			i = i + 1
		end
	end
  
	return e
end

function Bestride:Mounting(flyable, zone)
	--Chauffeured check
	if GetRidingSkill() == 0 then
		if IsUsableSpell(179245) then
			return Bestride:SpellToName(179245)
		elseif IsUsableSpell(179244) then
			return Bestride:SpellToName(179244)
		end
	end
	
	if not self.db.profile.settings["HM"] then
		return nil
	end	
		
	local e = {}
	local useRepairMount = 1, false
	local mountType
	
	if flyable then
		mountType = BestrideMountType.flying
	else
		mountType = BestrideMountType.ground
	end
	
	--Repair mount
	if Bestride:ShouldRepair() then
		e = Bestride:GetRepairMount()
	elseif BestrideState.usePassengerMount then
		e = Bestride:BuildPassengerTable(mountType)
	else
		e = Bestride:BuildStandardMountTable(mountType)
	end
	
	-- Filter out mounts for certain zones (AQ, etc)
	e = Bestride:Filter(e, zone)
	
	-- Load emergency mounts if we have no usable mounts yet
	if #e == 0 and self.db.profile.settings["ER"] then

		if(mountType == BestrideMountType.flying and self.db.profile.misc.NumMounts.Flying == 0) then
			mountType = BestrideMountType.ground
		end
		
		local i = 1
		-- DEFAULT_CHAT_FRAME:AddMessage("Spell,Enabled,Type,id")
		-- DEFAULT_CHAT_FRAME:AddMessage("Mount Type:" .. mountType )
		for spellID,v in pairs(self.db.profile.mounts) do
			if v[3] and Bestride:IsUsableMount(v[3]) and v[2] == mountType then
			    -- DEFAULT_CHAT_FRAME:AddMessage(tostring(spellID) .. "," .. tostring(v[1]) .. "," .. tostring(v[2]) .. "," .. tostring(v[3]))
				e[i] = spellID
				i = i + 1
			end
		end
	end
	
	-- Final check to remove any currently unusable mounts
	for k,spellId in pairs(e) do
		if not Bestride:IsUsableMount(self.db.profile.mounts[spellId][3]) then
			tremove(e, k)
		end
	end
	
	if #e == 0 then
		--self:Print(BestrideLocale.String.NoMounts)
		return nil
	end
	
	return Bestride:SpellToName(e[math.random(#e)])
end

function Bestride:PreClick()
	if BestrideState.playerCombat then
		return
	end

	local _,_,WGActive,_,_,_ = GetWorldPVPAreaInfo(1)
	local isFlyable
	local broom = false
	local zone = GetRealZoneText()
	local loanedMount = Bestride:CheckLoanerMount()

	-- Check if we can fly
	isFlyable = IsFlyableArea()
	
	--Check if we're in Draenor for flying
	if((GetCurrentMapContinent() == 7 or zone == "Tanaan Jungle") and not IsSpellKnown(191645)) then
		isFlyable = false
		if(zone == "Nagrand" and self.db.profile.settings["TELAARI"] == true) then
			if(Bestride:CheckNagrandSpecialMount()) then --Telaari Talbuk/Horde wolf
				return
			end
		end
	end
	
	--Check if we're in Broken Isles for flying
	if ( GetCurrentMapContinent() == 8 and not IsSpellKnown(233368) ) then
		isFlyable = false
	end

	--Check if in Wintergrasp
	if zone == BestrideLocale.Zone.Wintergrasp then 
		isFlyable = not WGActive
	end
     
	-- check if we can use flying broom
	if GetItemCount(37011, false) > 0 and not BestrideState.playerCombat and self.db.profile.settings["FBP"] == true then
		broom = true
	end
	
  ------------Dismounting logic-------------
	if IsMounted() and IsFlying() then
		if BestrideState.class == "DRUID" and self.db.profile.settings["MTFF"] and GetUnitSpeed("player") ~= 0 then 
			Bestride:Druids(isFlyable, zone) -- Druid: Flying mount to flight form   
		elseif self.db.profile.settings["NDWF"] then
			Bestride:SetMacroButton()
		else
			Dismount()
			Bestride:SetMacroButton()
		end
  
	elseif IsMounted() then
		if IsSwimming() and BestrideState.class == "DRUID" and IsUsableSpell(783) and GetUnitSpeed("player") ~= 0  then
			Bestride:SetMacroButton(Bestride:SpellToName(783)) -- Aquatic Form  
		else
			Dismount()
			Bestride:SetMacroButton()
		end
    
	elseif CanExitVehicle() then
		Bestride:SetMacroButton()
		VehicleExit()
    
	------------Not currently mounted-------------
	elseif BestrideState.class == "MONK" and isFlyable and Bestride:MonkSpecial() then
		return
	
	elseif Bestride:ClassCheck() or Bestride:PriestOrMageSpecial() then
		return
    
	elseif isFlyable and IsOutdoors() then
		if broom then --flying broom
			Bestride:SetMacroButton(Bestride:ItemToName(37011))
		elseif IsSwimming() then
			Bestride:Swimming(isFlyable, zone, broom)
		elseif BestrideState.class == "DRUID" then
			Bestride:Druids(isFlyable, zone)
		else
			Bestride:SetMacroButton(Bestride:Mounting(isFlyable, zone))
		end
    
	elseif not isFlyable and IsOutdoors() and zone ~= BestrideLocale.Zone.VortexPinnacle then
		if zone == BestrideLocale.Zone.Oculus and Bestride:Filter(nil, zone) then
			return
		elseif broom then --flying broom
			Bestride:SetMacroButton(Bestride:ItemToName(37011))     
		elseif IsSwimming() then
			Bestride:Swimming(isFlyable, zone, broom)
		elseif loanedMount ~= nil and not BestrideState.playerCombat then
			Bestride:SetMacroButton(Bestride:ItemToName(loanedMount))
		elseif BestrideState.class == "DRUID" then
			Bestride:Druids(isFlyable, zone)
		else
			Bestride:SetMacroButton(Bestride:Mounting(isFlyable, zone))
		end
    
	elseif not IsOutdoors() or zone == BestrideLocale.Zone.VortexPinnacle then
		if IsSwimming() then
			Bestride:Swimming(isFlyable, zone, broom)
		elseif BestrideState.class == "DRUID" and IsUsableSpell(768) then
			Bestride:SetMacroButton(Bestride:SpellToName(768)) -- Cat form
		end
    
	else
		--No logic left, just try to use a mount
		Bestride:SetMacroButton(Bestride:Mounting(isFlyable, zone)) 
	end
end

function Bestride:ForcePassengerMount()
	BestrideState.usePassengerMount = true
	Bestride:PreClick()
	BestrideState.usePassengerMount = false
end

function Bestride:ForceRepairMount()
	BestrideState.forceRepairMount = true
	Bestride:PreClick()
	BestrideState.forceRepairMount = false
end

-- Tries to use the Nagrand outpost special ability
function Bestride:CheckNagrandSpecialMount()
	local garrisonAbilityName = GetSpellInfo(161691)
	local _,_,_,_,_,_,spellID = GetSpellInfo(garrisonAbilityName)
	if(spellID == 165803 or spellID == 164222) then -- Have the proper outpost
		if(BestrideState.playerCombat) then
			Bestride:SetMacroButtonCombat(garrisonAbilityName)
		else
			Bestride:SetMacroButton(garrisonAbilityName)
		end
		return true
	else
		return false
	end
end

-- Checks if slowfall or levitate should be used
function Bestride:PriestOrMageSpecial()
	if not BestrideState.playerCombat then
		if (IsFalling() or GetUnitSpeed("player") ~= 0) and BestrideState.class == "PRIEST" and IsUsableSpell(1706) and self.db.profile.settings["PRIEST"] then --IsUsableSpell checks for reagents/glyphs
			Bestride:SetMacroButton("[@player] "..Bestride:SpellToName(1706).."\n/cancelaura "..Bestride:SpellToName(1706)) --Levitate
			return true
		  
		elseif (IsFalling() or GetUnitSpeed("player") ~= 0) and BestrideState.class == "MAGE" and IsUsableSpell(130) and self.db.profile.settings["MAGE"] then
			Bestride:SetMacroButton("[@player] "..Bestride:SpellToName(130).."\n/cancelaura "..Bestride:SpellToName(130)) --Slow fall
			return true
		  
		else
			return false
		end
	end
end

function Bestride:MonkSpecial()
	local usable,_ = IsUsableSpell(BestrideSpellIDs.ZENFLIGHT)
	
	if not self.db.profile.settings["MONKZENUSE"] or not usable then
		return false
	end
	
	if GetUnitSpeed("player") ~= 0 or IsFalling() then
		Bestride:SetMacroButton(Bestride:SpellToName(BestrideSpellIDs.ZENFLIGHT))
		return true
	end
	
	return false
end

function Bestride:ClassCheck()
	if not IsUsableSpell(BestrideSpellIDs[BestrideState.class]) then
		return false
	end

	if GetUnitSpeed("player") ~= 0 and self.db.profile.settings[BestrideState.class] then
		Bestride:SetMacroButton(Bestride:SpellToName(BestrideSpellIDs[BestrideState.class]))
		return true
	end
	
	return false
end

function Bestride:Druids(flyable, zone)
	local travelForm, flightForm = 783, 783 -- 3 in 1 travel form

	if GetUnitSpeed("player") ~= 0 then
		if flyable then
			Bestride:SetMacroButton(Bestride:SpellToName(flightForm))
		else
			Bestride:SetMacroButton(Bestride:SpellToName(travelForm))
		end
		
	elseif(flyable and not BestrideState.playerCombat) then
		if self.db.profile.settings["FFP"] or IsFalling() or IsFlying() or GetShapeshiftForm() == 3 then
			Bestride:SetMacroButton(Bestride:SpellToName(flightForm))
		else
			Bestride:SetMacroButton(Bestride:Mounting(flyable, zone), 1)
		end
    
	else
		Bestride:SetMacroButton(Bestride:Mounting(false, zone), 1)  
	end
end

function Bestride:Swimming(flyable, zone, broom)
	local aquaticForm = 783

	local timer, _,_,scale,_,_ = GetMirrorTimerInfo(2)
	local name, _, _, _, _, _, _, _, _, _, _ = UnitBuff("player", BestrideLocale.Misc.WaterBreathing)
	if timer == "UNKNOWN" or scale >= 0 then
		scale = 1
	end
  
	if flyable and not BestrideState.playerCombat then			
		if BestrideState.class == "DRUID" and IsUsableSpell(aquaticForm) and GetUnitSpeed("player") ~= 0 then
			Bestride:SetMacroButton(Bestride:SpellToName(aquaticForm)) --Aquatic Form
		elseif BestrideState.class == "DRUID" then
			Bestride:Druids(flyable, zone)
		else
			Bestride:SetMacroButton(Bestride:Mounting(true, zone))
		end
    
	elseif IsOutdoors() and not BestrideState.playerCombat then
		if BestrideState.class == "DRUID" and IsUsableSpell(aquaticForm) and GetUnitSpeed("player") ~= 0 then
			Bestride:SetMacroButton(Bestride:SpellToName(aquaticForm)) --Aquatic Form
		else 
			if zone == BestrideLocale.Zone.Vashjir1 or zone == BestrideLocale.Zone.Vashjir2 or zone == BestrideLocale.Zone.Vashjir3 or zone == BestrideLocale.Zone.Vashjir4 or zone == BestrideLocale.Zone.Vashjir5 and self.db.profile.mounts[75207][1] == true then --Abyssal Seahorse
				Bestride:SetMacroButton(Bestride:SpellToName(75207)) --Abyssal Seahorse
			elseif Bestride:UseStrider() then
				return
			elseif IsUsableSpell(98718) and self.db.profile.mounts[98718][1] == true then
				Bestride:SetMacroButton(Bestride:SpellToName(98718)) --Subdued Seahorse
			elseif IsUsableSpell(64731) and self.db.profile.mounts[64731][1] then
				Bestride:SetMacroButton(Bestride:SpellToName(64731)) --Sea Turtle
			else
				Bestride:SetMacroButton(Bestride:Mounting(false, zone))
			end
		end
    
	elseif not BestrideState.playerCombat then
		if BestrideState.class == "DRUID" and IsUsableSpell(aquaticForm) then
			Bestride:SetMacroButton(Bestride:SpellToName(aquaticForm)) -- Aquatic Form
		elseif BestrideState.class == "SHAMAN" and IsUsableSpell(2645) then
			Bestride:SetMacroButton(Bestride:SpellToName(2645)) --Ghost wolf
		end
	end
end

function Bestride:UseStrider()
	if GetUnitSpeed("player") ~= 0 then
		return false
	end

	local i, e = 1, {}
  
	for index,id in pairs(C_MountJournal.GetMountIDs()) do
		local n,spellID,_,_,_,isUsable,_,_,_,isHidden,isCollected = C_MountJournal.GetMountInfoByID(id)
		local _, _, _, _, mountTypeID = C_MountJournal.GetMountInfoExtraByID(id)
		
		if mountTypeID == 269 and isUsable and isCollected then
			e[i] = spellID
			i = i + 1
		end
	end
	
	if #e == 0 then	
		return false
	end
	
	Bestride:SetMacroButton(Bestride:SpellToName(e[math.random(#e)]))
		
	return true
end

--check if we have cold weather flying, a loaned mount, and/or flight master's license
function Bestride:CheckLoanerMount()
  local zone = GetRealZoneText()
  if zone == BestrideLocale.Zone.Dalaran then
	  local subzone = GetSubZoneText()
	  if subzone == BestrideLocale.Zone.DalaranSubZone.Underbelly or
			  subzone == BestrideLocale.Zone.DalaranSubZone.UnderbellyDescent or
			  subzone == BestrideLocale.Zone.DalaranSubZone.CircleofWills or
			  subzone == BestrideLocale.Zone.DalaranSubZone.BlackMarket then
		  if GetItemCount(139421, false) > 0 then
			  return 139421
		  else
			  return nil
		  end
	  else
		  return nil
	  end
  elseif zone == BestrideLocale.Zone.StormPeaks or zone == BestrideLocale.Zone.Icecrown then
    if GetItemCount(44221, false) > 0 then
      return 44221
    elseif GetItemCount(44229, false) > 0 then
      return 44229
    else
      return nil
    end
  end
  return nil
end

function Bestride:SetMacroButton(mount, button)
	if not BestrideState.playerCombat then
		if mount and button == 2 then
			BestrideButtonGround:SetAttribute("macrotext", "/use "..Bestride:Mounting(false, GetRealZoneText()))
		elseif mount and BestrideState.usePassengerMount then
			BestrideButtonPassenger:SetAttribute("macrotext", "/use "..mount)
		elseif mount and BestrideState.forceRepairMount then
			BestrideButtonRepair:SetAttribute("macrotext", "/use "..mount)
		elseif mount then
			BestrideButtonMount:SetAttribute("macrotext", "/use "..mount)
			--YayMountsButton:SetAttribute("macrotext", "/use "..mount)
		else
			BestrideButtonMount:SetAttribute("macrotext", nil)
			--YayMountsButton:SetAttribute("macrotext", nil)
		end
	end
end

function Bestride:SetMacroButtonCombat(mount, button)
	if mount and button == 2 then
		BestrideButtonGround:SetAttribute("macrotext", "/use "..Bestride:Mounting(false, GetRealZoneText()))
	elseif mount and button == 3 then
		BestrideButtonPassenger:SetAttribute("macrotext", "/use "..mount)
	elseif mount then
		BestrideButtonMount:SetAttribute("macrotext", "/use "..mount)
	else
		BestrideButtonMount:SetAttribute("macrotext", nil)
    end
end

function Bestride:Filter(e, zone)
  if zone ~= BestrideLocale.Zone.AQ40 and e ~= nil then
    for k,v in pairs(e) do
      if v == BestrideType["Ahn'Qiraj"][v] then
        tremove(e, k)
      end
    end
    return e
    
  elseif zone == BestrideLocale.Zone.AQ40 and e ~= nil then
    local aq40 = false
    local aq40Table = {}
    local i = 1
    
    for k,v in pairs(e) do
      if v == BestrideType["Ahn'Qiraj"][v] then
        aq40 = true
        
        break
      end
    end
    
    if aq40 then
      for k,v in pairs(e) do
        if v == BestrideType["Ahn'Qiraj"][v] then
          aq40Table[i] = v
          i = i + 1
        end
      end
      return aq40Table
    
    else
      return e
    end
    
  
  elseif zone == BestrideLocale.Zone.Oculus and e == nil then
    if GetItemCount(37859) == 1 then
      Bestride:SetMacroButton(Bestride:ItemToName(37859))
      return true
    elseif GetItemCount(37860) == 1 then
      Bestride:SetMacroButton(Bestride:ItemToName(37860))
      return true
    elseif GetItemCount(37815) == 1 then
      Bestride:SetMacroButton(Bestride:ItemToName(37815))
      return true
    end
    return false
    
  else
    return e
  end
end
