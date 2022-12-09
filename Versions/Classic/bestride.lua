
function BeStride:Version_OnEnable()
    BeStride_Constants.spells.druid.travelform = 783
    BeStride_Constants.spells.druid.flightform = 33943
    if IsPlayerSpell(40120) then
        BeStride_Constants.spells.druid.flightform = 40120
    else
        BeStride_Constants.spells.druid.flightform = 33943
    end
    BeStride_Constants.spells.druid.aquaticform = 1066
end

function BeSTride:IsClassicEra()
    print("Classic Era")
    return true
end

function BeStride:IsWrath()
    return false
end

function BeStride:IsMainline()
    return false
end

function BeStride:GetMountInfoBySpellID()
    return nil
end

function BeStride:GetMountInfoByMountID()
    return nil
end

function BeStride:GetMountInfoByIndex()
    return nil
end

function BeStride:GetKnownMountFromTarget()
    return nil
end
