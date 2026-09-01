-- SILVA VISION V0.5
-- Weather Director — CLIENT ONLY
-- Observa o clima do jogo. Não força clima do servidor por padrão.

local Weather = {
    enabled = true,
    force = false,
    interval = 2000,
    state = 'CLEAR',
}

local known = {
    [GetHashKey('RAIN')] = 'RAIN',
    [GetHashKey('THUNDER')] = 'THUNDER',
    [GetHashKey('CLEARING')] = 'CLEARING',
    [GetHashKey('FOGGY')] = 'FOGGY',
    [GetHashKey('OVERCAST')] = 'OVERCAST',
    [GetHashKey('SMOG')] = 'SMOG',
    [GetHashKey('SNOW')] = 'SNOW',
    [GetHashKey('XMAS')] = 'XMAS',
}

local function readWeather()
    local hash = GetPrevWeatherTypeHashName()
    return known[hash] or 'CLEAR'
end

local function tick()
    if not Weather.enabled then return end
    Weather.state = readWeather()
    -- Intencionalmente sem SetWeatherTypeNow/Persist por padrão:
    -- o clima do servidor continua tendo prioridade.
end

CreateThread(function()
    Wait(2500)
    while true do
        tick()
        Wait(Weather.interval)
    end
end)

RegisterCommand('svweather', function(_, args)
    local mode = args[1]
    if mode == 'on' then Weather.enabled = true
    elseif mode == 'off' then Weather.enabled = false
    elseif mode == 'force' then Weather.force = not Weather.force
    else print('[SilvaVision] svweather on | off | force'); return end
    print(('[SilvaVision] Weather Director: %s | force=%s | state=%s'):format(
        Weather.enabled and 'ON' or 'OFF', tostring(Weather.force), Weather.state))
end, false)

exports('GetWeatherState', function() return Weather.state end)
