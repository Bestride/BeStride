function BeStride:CreateActionButton(name)
	local name = "BeStride_AB" .. name

    local b = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate")
    Mixin(b, BeStride_ActionButtonTemplate)
end

function BeStride_ActionButtonTemplate:PreClick()
	if BeStride:CheckCombat() then
		return
	end
	
	local loanedMount = Bestride:CheckLoanerMount()
	local isFlyable = BeStride:IsFlyableArea()
	
	-- Dismount Logic
	if IsMounted() and IsFlying() then
	end
	
	
end

function BeStride_ActionButtonTemplate:PostClick()

end

