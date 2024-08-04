function BeStride:Upgrade()
	local db = LibStub("AceDB-3.0"):New("BestrideDB")
	
	local mountButtons = {
		BRMOUNT = BeStride_ABRegularMount,
		BRFORCEGROUND = BeStride_ABGroundMount,
		BRFORCEPASSENGER = BeStride_ABPassengerMount,
		BRFORCEREPAIR = BeStride_ABRepairMount
	}
	
	if self.db.profile.settings.ymBindingsMigrated == false then
		table.foreach(mountButtons,function (binding,button)
			local primaryKey,secondaryKey = GetBindingKey(binding)
			if primaryKey then
				SetBindingClick(primaryKey,button:GetName())
			end
		
			if secondaryKey then
				SetBindingClick(secondaryKey,button:GetName())
			end
		end)
	end
	if self.db.profile.settings.bindingsMigrated == false then
		table.foreach({BeStride_ABRegularMount,BeStride_ABGroundMount,BeStride_ABPassengerMount,BeStride_ABRepairMount},function (key,button)
			local primaryKey,secondaryKey = GetBindingKey(button:GetName())
			if primaryKey then
				SetBindingClick(primaryKey,button:GetName())
			end
		
			if secondaryKey then
				SetBindingClick(secondaryKey,button:GetName())
			end
		end)
	end
	self.db.profile.settings.bindingsMigrated = true
	self.db.profile.settings.ymBindingsMigrated = true
	
	if db.profile.settings and self.db.profile.settings.migrated == false then
		table.foreach(db.profile.settings,function (key,value)
			if key == "HM" then
				self.db.profile.settings.mount.hasmount = value
			elseif key == "ER" then
				self.db.profile.settings.mount.emptyrandom = value
			elseif key == "FBP" then
				self.db.profile.settings.mount.flyingbroom = value
			elseif key == "TTT" then
				self.db.profile.settings.classes.druid.traveltotravel = value
			elseif key == "MTFF" then
				self.db.profile.settings.classes.druid.mountedtoflightform = value
			elseif key == "NDWF" then
				self.db.profile.settings.mount.nodismountwhileflying = value
			elseif key == "FFM" then
				self.db.profile.settings.mount.useflyingmount = value
			elseif key == "URM" then
				self.db.profile.settings.mount.repair.use = value
			elseif key == "ENABLENEW" then
				self.db.profile.settings.mount.enablenew = value
			elseif key == "TELAARI" then
				self.db.profile.settings.mount.telaari = value
			elseif key == "DEATHKNIGHT" then
				self.db.profile.settings.classes.deathknight.wraithwalk = value
			elseif key == "PALADIN" then
				self.db.profile.settings.classes.paladin.steed = value
			elseif key == "SHAMAN" then
				self.db.profile.settings.classes.shaman.ghostwolf = value
			elseif key == "MONK" then
				self.db.profile.settings.classes.monk.roll = value
			elseif key == "MONKZENUSE" then
				self.db.profile.settings.classes.monk.zenflight = value
			elseif key == "ROGUE" then
				self.db.profile.settings.classes.rogue.sprint = value
			elseif key == "PRIEST" then
				self.db.profile.settings.classes.levitate = value
			elseif key == "MAGE" then
				self.db.profile.settings.classes.mage.slowfall = value
				self.db.profile.settings.classes.mage.blink = value
			elseif key == "EVOKER" then
				self.db.profile.settings.classes.evoker.hover = value
				self.db.profile.settings.classes.evoker.soar = value
			elseif key == "Warlock" then
				self.db.profile.settings.classes.warlock.rush = value
			end
		end)
		
		table.foreach(db.profile.mounts,function (key,value)
			if mountTable.master[value[3]] and mountTable.master[value[3]].spellID == key then
				local mountID,spellID,status,savedType = value[3],key,value[1],value[2]
				local mountType = mountTable.master[mountID].type
				
				if mountType == "ground" or mountType == "flying" or mountType == "swimming" then
					self.db.profile.mounts[mountType][mountID] = status
				end
				
				if savedType == "special" then
					if BeStride_Constants.Mount.Mounts[mountTable.master[mountID].spellID] and BeStride_Constants.Mount.Mounts[mountTable.master[mountID].spellID].type == "zone" then
						self.db.profile.mounts[mountType][mountID] = status
					end
				end
			end
		end)
	end
	
	self.db.profile.settings.migrated = true
end