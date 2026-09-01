-- SILVA VISION V0.5 MEGA ULTRA
-- Context decision layer — CLIENT ONLY.
-- Não escreve VisualSettings.

local Policy = {
    enabled = true,
    state = { phase='day', weather='CLEAR', wet=false, interior=false, emergency=false, profile='Balanced' }
}

local function phase(h)
    if h >= 5 and h < 7 then return 'sunrise' end
    if h >= 7 and h < 17 then return 'day' end
    if h >= 17 and h < 20 then return 'sunset' end
    return 'night'
end

local function weather()
    local h = GetPrevWeatherTypeHashName()
    local map = {
        [GetHashKey('RAIN')] = 'RAIN', [GetHashKey('THUNDER')] = 'THUNDER',
        [GetHashKey('CLEARING')] = 'CLEARING', [GetHashKey('FOGGY')] = 'FOGGY',
        [GetHashKey('OVERCAST')] = 'OVERCAST', [GetHashKey('SMOG')] = 'SMOG',
        [GetHashKey('SNOW')] = 'SNOW', [GetHashKey('XMAS')] = 'XMAS'
    }
    return map[h] or 'CLEAR'
end

local function update()
    if not Policy.enabled then return end
    local ped = PlayerPedId()
    local w = weather()
    local emergency = false
    if IsPedInAnyVehicle(ped, false) then
        emergency = GetVehicleClass(GetVehiclePedIsIn(ped, false)) == 18
    end
    Policy.state.phase = phase(GetClockHours())
    Policy.state.weather = w
    Policy.state.wet = w == 'RAIN' or w == 'THUNDER' or w == 'CLEARING'
    Policy.state.interior = GetInteriorFromEntity(ped) ~= 0
    Policy.state.emergency = emergency

    local manual = false
    local ok, result = pcall(function() return exports['silva-vision-core']:IsProfileManual() end)
    manual = ok and result == true
    if not manual then
        if Policy.state.interior then Policy.state.profile='Balanced'
        elseif emergency or Policy.state.phase=='night' then Policy.state.profile='Quality'
        else Policy.state.profile='Balanced' end
    else
        local ok2, p = pcall(function() return exports['silva-vision-core']:GetActiveProfile() end)
        if ok2 and type(p)=='string' then Policy.state.profile=p end
    end
end

CreateThread(function()
    Wait(4000)
    while true do update(); Wait(1000) end
end)

RegisterCommand('svpolicy', function(_, args)
    if args[1]=='on' then Policy.enabled=true
    elseif args[1]=='off' then Policy.enabled=false
    elseif args[1]=='show' then
        print(('[SilvaVision] phase=%s weather=%s wet=%s interior=%s emergency=%s profile=%s'):format(
            Policy.state.phase, Policy.state.weather, tostring(Policy.state.wet), tostring(Policy.state.interior), tostring(Policy.state.emergency), Policy.state.profile))
        return
    else print('[SilvaVision] svpolicy on | off | show'); return end
    print(('[SilvaVision] Visual Policy %s'):format(Policy.enabled and 'ON' or 'OFF'))
end, false)

exports('GetVisualPolicy', function() return Policy.state end)
