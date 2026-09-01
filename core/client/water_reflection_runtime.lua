-- SILVA VISION V0.5
-- Water / Reflection Runtime — CLIENT ONLY
-- Preserva reflexos existentes e prepara o estado para a camada ReShade.

local Water = {
    enabled = true,
    interval = 1500,
    state = { wet = false, rain = false, reflection = 1.0 },
}

local function readWeather()
    local h = GetPrevWeatherTypeHashName()
    return h == GetHashKey('RAIN') or h == GetHashKey('THUNDER') or h == GetHashKey('CLEARING')
end

local function update()
    if not Water.enabled then return end
    Water.state.rain = readWeather()
    Water.state.wet = Water.state.rain
    local target = Water.state.rain and 1.0 or 0.0
    Water.state.reflection = Water.state.reflection + (target - Water.state.reflection) * 0.08
end

CreateThread(function()
    Wait(3500)
    while true do
        update()
        Wait(Water.interval)
    end
end)

RegisterCommand('svwater', function(_, args)
    local mode = args[1]
    if mode == 'on' then Water.enabled = true
    elseif mode == 'off' then Water.enabled = false
    elseif mode == 'reapply' then update()
    else print('[SilvaVision] svwater on | off | reapply'); return end
    print(('[SilvaVision] Water Runtime %s'):format(Water.enabled and 'ON' or 'OFF'))
end, false)

exports('GetWaterReflectionState', function() return Water.state end)
