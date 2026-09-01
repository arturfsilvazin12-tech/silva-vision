-- SILVA VISION V0.5
-- Debug/telemetry local — CLIENT ONLY

local Debug = { enabled = false }

local function snapshot()
    local ped = PlayerPedId()
    return {
        hour = GetClockHours(),
        minute = GetClockMinutes(),
        weather = GetPrevWeatherTypeHashName(),
        interior = GetInteriorFromEntity(ped),
        vehicle = IsPedInAnyVehicle(ped, false),
    }
end

RegisterCommand('svdebug', function()
    Debug.enabled = not Debug.enabled
    print(('[SilvaVision] debug=%s'):format(Debug.enabled and 'ON' or 'OFF'))
end, false)

CreateThread(function()
    while true do
        if Debug.enabled then
            local s = snapshot()
            print(('[SilvaVision] %02d:%02d | weather=%s | interior=%s | vehicle=%s'):format(
                s.hour, s.minute, tostring(s.weather), tostring(s.interior), tostring(s.vehicle)
            ))
        end
        Wait(3000)
    end
end)

exports('GetDebugSnapshot', snapshot)
