-- SILVA VISION V0.5
-- Surface Weather Runtime — CLIENT ONLY
-- Coordena leitura de chuva/superfície sem substituir o ReShade.

local Surface = {
    enabled = true,
    interval = 1200,
    state = { wet = false, storm = false, rain = false, intensity = 0.0 },
}

local function weatherName()
    local h = GetPrevWeatherTypeHashName()
    if h == GetHashKey('THUNDER') then return 'THUNDER' end
    if h == GetHashKey('RAIN') then return 'RAIN' end
    if h == GetHashKey('CLEARING') then return 'CLEARING' end
    return 'OTHER'
end

local function update()
    if not Surface.enabled then return end
    local w = weatherName()
    Surface.state.storm = w == 'THUNDER'
    Surface.state.rain = Surface.state.storm or w == 'RAIN'
    Surface.state.wet = Surface.state.rain or w == 'CLEARING'

    local target = Surface.state.storm and 1.0 or (Surface.state.rain and 0.75 or (Surface.state.wet and 0.35 or 0.0))
    Surface.state.intensity = Surface.state.intensity + (target - Surface.state.intensity) * 0.20
end

CreateThread(function()
    Wait(3000)
    while true do
        update()
        Wait(Surface.interval)
    end
end)

RegisterCommand('svsurface', function(_, args)
    local mode = args[1]
    if mode == 'on' then Surface.enabled = true
    elseif mode == 'off' then Surface.enabled = false
    elseif mode == 'reapply' then update()
    else print('[SilvaVision] svsurface on | off | reapply'); return end
    print(('[SilvaVision] Surface Runtime %s'):format(Surface.enabled and 'ON' or 'OFF'))
end, false)

exports('GetSurfaceWeatherState', function() return Surface.state end)
