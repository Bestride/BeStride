
function BeStride:Version_OnEnable()
    BeStride_Constants.spells.druid.flightform = 33943
    if IsPlayerSpell(40120) then
        BeStride_Constants.spells.druid.flightform = 40120
    end
    BeStride_Constants.spells.druid.aquaticform = 1066
end

function BeStride:IsWrath()
    return true
end

function BeStride:IsMainline()
    return false
end
