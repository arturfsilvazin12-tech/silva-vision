-- SILVA VISION V0.5
-- Lighting Director — CLIENT ONLY
-- Ajusta apenas grupos explicitamente suportados; não força exposição/bloom global.

local State = {
    enabled = true,
    interval = 1500,
    phase = 'day',
    wet = false,
    nightFactor = 0.0,
}

local function clamp(v, a, b) return math.max(a, math.min(b, v)) end

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

local function setVisual(name, value)
    if type(SetVisualSettingFloat) ~= 'function' then return end
    pcall(SetVisualSettingFloat, name, value)
end

local function apply()
    if not State.enabled then return end

    local h = GetClockHours()
    State.phase = phase(h)
    State.wet = weatherWet()

    local target = State.phase == 'night' and 1.0 or 0.0
    State.nightFactor = State.nightFactor + (target - State.nightFactor) * 0.12

    -- Aumenta presença das luzes distantes à noite, sem tocar em exposure/bloom.
    local distant = 1.05 + (0.10 * State.nightFactor)
    local reflection = 0.85 + (0.08 * State.nightFactor)
    setVisual('distantlights.size', clamp(distant, 1.05, 1.15))
    setVisual('distantlights.sizeReflections', clamp(reflection, 0.85, 0.93))

    -- Chuva recebe apenas um pequeno ganho de leitura nas luzes; ReShade cuida do brilho.
    if State.wet then
        setVisual('distantlights.sizeReflections', 0.93)
    end
end

CreateThread(function()
    Wait(3000)
    while true do
        apply()
        Wait(State.interval)
    end
end)

RegisterCommand('svlightdirector', function(_, args)
    local mode = args[1]
    if mode == 'on' then State.enabled = true
    elseif mode == 'off' then State.enabled = false
    elseif mode == 'reapply' then apply()
    else print('[SilvaVision] svlightdirector on | off | reapply'); return end
    print(('[SilvaVision] Light Director %s'):format(State.enabled and 'ON' or 'OFF'))
end, false)

exports('GetLightingDirectorState', function() return State end)
