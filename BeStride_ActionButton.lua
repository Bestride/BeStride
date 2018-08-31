function BeStride:CreateActionButton(name)
	local name = "BeStride_AB" .. name

    local b = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate")
    Mixin(b, BeStride_ActionButtonTemplate)
end

function BeStride_ActionButtonTemplate:PreClick()
	if BeStride:CheckCombat() then
		return
	end
	
	BeStride_Logic:MountButton()
end

function BeStride_ActionButtonTemplate:PostClick()

end

