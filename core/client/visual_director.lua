-- SILVA VISION V0.5
-- Visual Director — CLIENT ONLY
-- Coordena horário, clima, luzes, chuva e túneis sem substituir o ReShade.

local Director = {
    enabled = true,
    debug = false,
    interval = 1000,
    nightStart = 20,
    dayStart = 6,
    rainStates = {
        RAIN = true,
        THUNDER = true,
        CLEARING = true,
    },
    state = {
        phase = 'day',
        weather = 'CLEAR',
        profile = 'Balanced',
        tunnel = false,
        wet = false,
        emergency = false,
    }
}

local function log(msg)
    if Director.debug then
        print(('[SilvaVision Director] %s'):format(msg))
    end
end

local function getPhase(hour)
    if hour >= 5 and hour < 7 then return 'sunrise' end
    if hour >= 7 and hour < 17 then return 'day' end
    if hour >= 17 and hour < 20 then return 'sunset' end
    return 'night'
end

local function getWeather()
    local hash = GetPrevWeatherTypeHashName()
    local names = {
        [GetHashKey('RAIN')] = 'RAIN',
        [GetHashKey('THUNDER')] = 'THUNDER',
        [GetHashKey('CLEARING')] = 'CLEARING',
        [GetHashKey('FOGGY')] = 'FOGGY',
        [GetHashKey('OVERCAST')] = 'OVERCAST',
        [GetHashKey('SMOG')] = 'SMOG',
        [GetHashKey('XMAS')] = 'XMAS',
        [GetHashKey('SNOW')] = 'SNOW',
    }
    return names[hash] or 'CLEAR'
end

local function isNight(phase)
    return phase == 'night'
end

local function updateState()
    local hour = GetClockHours()
    local phase = getPhase(hour)
    local weather = getWeather()
    local wet = Director.rainStates[weather] == true or weather == 'THUNDER'

    Director.state.phase = phase
    Director.state.weather = weather
    Director.state.wet = wet
    Director.state.tunnel = GetInteriorFromEntity(PlayerPedId()) ~= 0

    if isNight(phase) then
        Director.state.profile = 'Quality'
    elseif wet then
        Director.state.profile = 'Balanced'
    else
        Director.state.profile = 'Balanced'
    end
end

local function tick()
    if not Director.enabled then return end
    updateState()
    log(('phase=%s weather=%s tunnel=%s wet=%s'):format(
        Director.state.phase,
        Director.state.weather,
        tostring(Director.state.tunnel),
        tostring(Director.state.wet)
    ))
end

CreateThread(function()
    Wait(2500)
    while true do
        tick()
        Wait(Director.interval)
    end
end)

RegisterCommand('svdirector', function(_, args)
    local mode = args[1]
    if mode == 'on' then
        Director.enabled = true
    elseif mode == 'off' then
        Director.enabled = false
    elseif mode == 'debug' then
        Director.debug = not Director.debug
    else
        print('[SilvaVision] svdirector on | off | debug')
        return
    end
    print(('[SilvaVision] Director %s'):format(Director.enabled and 'ON' or 'OFF'))
end, false)

exports('GetDirectorState', function()
    return Director.state
end)
