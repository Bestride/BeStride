function BeStride:NoDismountWhileFlying()
	-- Check whether we can dismount while flying
	-- Returns: boolean
	-- Todo: Bitwise Compare
	if BeStride:DBGet("settings.mount.nodismountwhileflying") then
		return true
	else
		return false
	end
end

function BeStride:IsCombat()
	if InCombatLockdown() then
		return true
	else
		return false
	end
end

function BeStride:NeedToRepair()
	-- Check whether we need to repair
	-- Returns: boolean
	if BeStride:ForceRepair() then
		return true
	end
	
	if size(BeStride.db.profile.misc.RepairMounts) > 0 and BeStride:UseRepair() then
		for i = 0, 17 do
			local current, maximum = GetInventoryItemDurability(i)
			if current ~= nil and maximum ~= nil and ( (current/maximum) <= BeStride:GetRepairThreshold() ) then
				return true
			end
		end
	end
	
	return false
end

function BeStride:IsRepairable()
	if not self:IsMountable() or IsFlying() or not IsOutdoors() then
		return false
	end
	mounts = BeStride:DBGet("mounts.repair")
	local mountCount = {}
	
	table.foreach(mounts,function (key,value) table.insert(mountCount,key) end )
	
	if #mountCount ~= 0 then
		local globalDurability,count = 0,0
		for i = 0, 17 do
			local current, maximum = GetInventoryItemDurability(i)
			if current ~= nil and maximum ~= nil then
				local durability = (current / maximum)
				count = count + 1
				globalDurability = globalDurability + durability
				if (durability * 100) <= BeStride:DBGet("settings.mount.repair.durability") then
					return true
				end
			end
		end
		
		if ((globalDurability/count)*100) <= BeStride:DBGet("settings.mount.repair.globaldurability") then
			return true
		end
		
		for i = 0, 4 do
			for j = 0, GetContainerNumSlots(i) do
				local current, maximum = GetContainerItemDurability(i, j)
				if current ~= nil and maximum ~= nil then
					if ((current / maximum)*100) <= BeStride:DBGet("settings.mount.repair.inventorydurability") then
						return true
					end
				end
			end
		end
	else
		return false
	end
end

function BeStride:IsForceRepair()
	-- Check whether we force a repair mount
	-- Returns: boolean
	if BeStride.db.profile.settings["repair"]["force"] then
		return true
	else
		return false
	end
end

function BeStride:IsUseRepair()
	-- Checks whether we check to repair or not
	-- Returns: boolean
	if BeStride.db.profile.settings["repair"]["use"] then
		return true
	else
		return false
	end
end

function BeStride:GetRepairThreshold()
	-- Get repair threshold
	-- Returns: signed integer
	if BeStride.db.profile.settings["repair"]["durability"] then
		return BeStride.db.profile.settings["repair"]["durability"]
	else
		return -1
	end
end

function BeStride:IsHerbalismAndCanRobot()
	if BeStride:IsHerbalism() and not BeStride:IsCombat() and BeStride:CanRobotSetting() then
		if IsUsableSpell(134359) or IsUsableSpell(223814) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function BeStride:IsHerbalism()
	local prof1,prof2 = self:GetProfessions()
	-- 182 = Herbalism
	-- ref: http://wowwiki.wikia.com/wiki/API_GetProfessionInfo
	if (prof1 and select(7,GetProfessionInfo(prof1)) == 182) or (prof2 and select(7,GetProfessionInfo(prof2)) == 182) then
		return true
	else
		return false
	end
end