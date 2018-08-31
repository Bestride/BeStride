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
	BeStride_Frame = AceGUI:Create("Frame")
	BeStride_Frame:SetCallback("OnClose",function (widget) AceGUI:Release(widget); BeStride_Frame = nil end)
	BeStride_Frame:SetTitle("BeStride")
	BeStride_Frame:SetStatusText(BeStride_GUI:GetStatusText())
	BeStride_Frame:SetLayout("Fill")
	BeStride_Frame:SetWidth(720)
	BeStride_Frame:SetHeight(490)
	
	local frameTabs = {
		{text = "Mounts (" .. getn(mountTable) .. ")"}
	}
end

function BeStride_GUI:Close()
	AceGUI:Release(widget)
	BeStride_Frame = nil
end

function BeStride_GUI:GetStatusText()
	return "Version " .. version .. ", by Anaximander <IRONFIST> - Burning Legion US, Original Yay Mounts by Cyrae - Windrunner US & Anzu - Kirin Tor US"
end