-- SILVA VISION V0.5
-- Runtime atmosphere/timecycle director — CLIENT ONLY

local SVTC = {
    enabled = true,
    modifier = 'silva_vision_runtime',
    strength = 0.0,
    targetStrength = 0.0,
    transitionSpeed = 0.08,
}

local function clamp(v, lo, hi)
    return math.max(lo, math.min(hi, v))
end

local function safeNative(fn, ...)
    if type(fn) ~= 'function' then return false end
    local ok = pcall(fn, ...)
    return ok
end

local function updateTarget()
    local hour = GetClockHours()
    local weather = GetPrevWeatherTypeHashName()
    local isNight = (hour >= 20 or hour < 6)
    local isStorm = weather == GetHashKey('THUNDER')
    local isRain = isStorm or weather == GetHashKey('RAIN') or weather == GetHashKey('CLEARING')

    if isStorm then
        SVTC.targetStrength = 0.85
    elseif isRain then
        SVTC.targetStrength = 0.55
    elseif isNight then
        SVTC.targetStrength = 0.35
    else
        SVTC.targetStrength = 0.0
    end
end

local function apply()
    if not SVTC.enabled then return end
    updateTarget()
    SVTC.strength = SVTC.strength + (SVTC.targetStrength - SVTC.strength) * SVTC.transitionSpeed

    -- O modifier só é criado quando as natives estiverem disponíveis.
    safeNative(CreateTimecycleModifier, SVTC.modifier)
    safeNative(SetTimecycleModifier, SVTC.modifier)
    safeNative(SetTimecycleModifierStrength, clamp(SVTC.strength, 0.0, 1.0))
end

CreateThread(function()
    while true do
        apply()
        Wait(1000)
    end
end)

exports('GetTimecycleState', function()
    return {
        strength = SVTC.strength,
        target = SVTC.targetStrength,
        modifier = SVTC.modifier,
    }
end)
