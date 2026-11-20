BeStride_Debug = {
	debugLevel = 1,
}

function BeStride_Debug:Emergency(message)
    -- Debug Level 1
	if BeStride_Debug.debugLevel >= 1 then
		if message == nil then
			ChatFrame1:AddMessage("[BeStride Emerg]" .. "",1.0,0,0);
		else
			ChatFrame1:AddMessage("[BeStride Emerg]" .. message,1.0,0,0);
		end
	end
end

function BeStride_Debug:Critical(message)
	if BeStride_Debug.debugLevel >= 2 then
		if message == nil then
			ChatFrame1:AddMessage("[BeStride Crit]" .. "",1.0,0,0);
		else
			ChatFrame1:AddMessage("[BeStride Crit]" .. message,0,1.0,0);
		end
	end
end

function BeStride_Debug:Error(message)
	if BeStride_Debug.debugLevel >= 3 then
		if message == nil then
			ChatFrame1:AddMessage("[BeStride Error]" .. "",1.0,0,0);
		else
			ChatFrame1:AddMessage("[BeStride Error]" .. message,1.0,0,0);
		end
	end
end


function BeStride_Debug:Info(message)
	if BeStride_Debug.debugLevel >= 4 then
		if message == nil then
			ChatFrame1:AddMessage("[BeStride Info]" .. "",1.0,0,0);
		else
			ChatFrame1:AddMessage("[BeStride Info]" .. message,1.0,1.0,1.0);
		end
		
	end
end


function BeStride_Debug:Informational(message)
	if BeStride_Debug.debugLevel >= 4 then
		if message == nil then
			ChatFrame1:AddMessage("[BeStride Informational]" .. "",1.0,0,0);
		else
			print("[BeStride Informational]" .. message)
			--ChatFrame1:AddMessage("[BeStride Informational]" .. message,1.0,1.0,1.0);
		end
	end
end

function BeStride_Debug:Notice(message)
	if BeStride_Debug.debugLevel >= 5 then
		if message == nil then
			ChatFrame1:AddMessage("[BeStride Notice]" .. "",1.0,0,0);
		else
			ChatFrame1:AddMessage("[BeStride Notice]" .. message,1.0,0.9,0);
		end
	end
end

function BeStride_Debug:Verbose(message)
	if BeStride_Debug.debugLevel >= 6 then
		if message == nil then
			ChatFrame1:AddMessage("[BeStride Verbose]" .. "",1.0,0,0);
		else
			ChatFrame1:AddMessage("[BeStride Verbose]" .. message,0,1.0,1.0);
		end
	end
end

function BeStride_Debug:Debug(message)
	if BeStride_Debug.debugLevel >= 7 then
		if message == nil then
			print("[BeStride Debug]")
		else
			print("[BeStride Debug] " .. tostring(message))
		end
	end
end