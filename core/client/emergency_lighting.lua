-- SILVA VISION V0.5
-- Emergency Lighting Director — CLIENT ONLY
-- Melhora a leitura das luzes de emergência sem criar novas sirenes/efeitos.

local Emergency = {
    enabled = true,
    interval = 400,
    state = { active = false, boost = 1.0 },
    boost = 1.20,
}

local function setVisual(name, value)
    if type(SetVisualSettingFloat) ~= 'function' then return end
    pcall(SetVisualSettingFloat, name, value)
end

local function tick()
    if not Emergency.enabled then return end
    local ped = PlayerPedId()
    local active = false

    if IsPedInAnyVehicle(ped, false) then
        active = GetVehicleClass(GetVehiclePedIsIn(ped, false)) == 18
    end

    Emergency.state.active = active
    Emergency.state.boost = active and Emergency.boost or 1.0
    setVisual('emissive.multiplier', Emergency.state.boost)
end

CreateThread(function()
    Wait(3500)
    while true do
        tick()
        Wait(Emergency.interval)
    end
end)

RegisterCommand('sveemergency', function(_, args)
    local mode = args[1]
    if mode == 'on' then Emergency.enabled = true
    elseif mode == 'off' then Emergency.enabled = false
    elseif mode == 'reapply' then tick()
    else print('[SilvaVision] sveemergency on | off | reapply'); return end
    print(('[SilvaVision] Emergency Lighting %s'):format(Emergency.enabled and 'ON' or 'OFF'))
end, false)

exports('GetEmergencyLightingState', function() return Emergency.state end)
