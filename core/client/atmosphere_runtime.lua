-- SILVA VISION V0.5
-- Atmosphere Runtime — CLIENT ONLY
-- Estado atmosférico para integração futura com ReShade/timecycle.

local Atmosphere = {
    enabled = true,
    interval = 1800,
    state = { fog = false, overcast = false, smog = false, rain = false, density = 0.0 },
}

local function read()
    local h = GetPrevWeatherTypeHashName()
    local fog = h == GetHashKey('FOGGY')
    local overcast = h == GetHashKey('OVERCAST')
    local smog = h == GetHashKey('SMOG')
    local rain = h == GetHashKey('RAIN') or h == GetHashKey('THUNDER')

    Atmosphere.state.fog = fog
    Atmosphere.state.overcast = overcast
    Atmosphere.state.smog = smog
    Atmosphere.state.rain = rain

    local target = fog and 1.0 or (smog and 0.65 or (overcast and 0.35 or (rain and 0.20 or 0.0)))
    Atmosphere.state.density = Atmosphere.state.density + (target - Atmosphere.state.density) * 0.15
end

CreateThread(function()
    Wait(3200)
    while true do
        if Atmosphere.enabled then read() end
        Wait(Atmosphere.interval)
    end
end)

RegisterCommand('svatmosphere', function(_, args)
    local mode = args[1]
    if mode == 'on' then Atmosphere.enabled = true
    elseif mode == 'off' then Atmosphere.enabled = false
    elseif mode == 'reapply' then read()
    else print('[SilvaVision] svatmosphere on | off | reapply'); return end
    print(('[SilvaVision] Atmosphere Runtime %s'):format(Atmosphere.enabled and 'ON' or 'OFF'))
end, false)

exports('GetAtmosphereState', function() return Atmosphere.state end)
