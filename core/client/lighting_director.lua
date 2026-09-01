-- SILVA VISION V0.5 MEGA BLOCK
-- Lighting Director — STATE ONLY / CLIENT ONLY
-- Central Apply é o único writer de VisualSettings.

local State = {
    enabled = true,
    interval = 1500,
    phase = 'day',
    wet = false,
    nightFactor = 0.0,
}

local function phase(hour)
    if hour >= 5 and hour < 7 then return 'sunrise' end
    if hour >= 7 and hour < 17 then return 'day' end
    if hour >= 17 and hour < 20 then return 'sunset' end
    return 'night'
end

local function weatherWet()
    local h = GetPrevWeatherTypeHashName()
    return h == GetHashKey('RAIN') or h == GetHashKey('THUNDER') or h == GetHashKey('CLEARING')
end

local function update()
    if not State.enabled then return end
    State.phase = phase(GetClockHours())
    State.wet = weatherWet()
    local target = State.phase == 'night' and 1.0 or 0.0
    State.nightFactor = State.nightFactor + (target - State.nightFactor) * 0.12
end

CreateThread(function()
    Wait(3000)
    while true do
        update()
        Wait(State.interval)
    end
end)

RegisterCommand('svlightdirector', function(_, args)
    local mode = args[1]
    if mode == 'on' then State.enabled = true
    elseif mode == 'off' then State.enabled = false
    elseif mode == 'reapply' then update()
    else print('[SilvaVision] svlightdirector on | off | reapply'); return end
    print(('[SilvaVision] Light Director %s'):format(State.enabled and 'ON' or 'OFF'))
end, false)

exports('GetLightingDirectorState', function() return State end)
