local name, addon = ...
local f = CreateFrame("Frame");
local L = LibStub("AceLocale-3.0"):GetLocale("BeStride")

-- Basedd off of Opie Rings\Default.lua file
local function addBeStrideRingToOpie() 
    local ringname = L["Bindings.Header"]
    if not (OPie and OPie.CustomRings) then return end
    local _, major = OPie.GetVersion()
    if not (major and major == 4) then return end

    OPie.CustomRings:AddDefaultRing(ringname, {
        {"macrotext", "/click BeStride_ABRegularMount", icon="Interface/Icons/inv_misc_summerfest_brazierorange", fastClick=true},
        {"macrotext", "/click BeStride_ABPassengerMount", icon="Interface/Icons/inv_misc_stonedragonorange"},
        {"macrotext", "/click BeStride_ABGroundMount", icon="Interface/Icons/misc_arrowdown"},
        {"macrotext", "/click BeStride_ABRepairMount", icon="Interface/Icons/trade_blacksmithing"},
        name=ringname, hotkey="SHIFT-SPACE", _u="OPCBR"
    })
end

local function awaitAddonThen(addonName, andThen)
    if (IsAddOnLoaded(addonName)) then
        andThen()
    else
        f:RegisterEvent("ADDON_LOADED");
        f:SetScript("OnEvent", function(self, event, arg1)
            if (event ~= "ADDON_LOADED") then return end
            if (arg1 ~= addonName) then return end
            andThen()
            f:UnregisterEvent("ADDON_LOADED")
        end
        )
    end
end

awaitAddonThen("OPie", addBeStrideRingToOpie)
