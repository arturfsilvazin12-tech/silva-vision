-- SILVA VISION V0.5
-- Master Director — CLIENT ONLY
-- Orquestra estado visual sem duplicar aplicação de efeitos.

local Master = {
    enabled = true,
    interval = 1000,
    state = {
        phase = 'day',
        weather = 'CLEAR',
        wet = false,
        interior = false,
        emergency = false,
        profile = 'Balanced',
    }
}

local function getPhase(h)
    if h >= 5 and h < 7 then return 'sunrise' end
    if h >= 7 and h < 17 then return 'day' end
    if h >= 17 and h < 20 then return 'sunset' end
    return 'night'
end

local function getWeather()
    local h = GetPrevWeatherTypeHashName()
    local map = {
        [GetHashKey('RAIN')] = 'RAIN',
        [GetHashKey('THUNDER')] = 'THUNDER',
        [GetHashKey('CLEARING')] = 'CLEARING',
        [GetHashKey('FOGGY')] = 'FOGGY',
        [GetHashKey('OVERCAST')] = 'OVERCAST',
        [GetHashKey('SMOG')] = 'SMOG',
        [GetHashKey('SNOW')] = 'SNOW',
        [GetHashKey('XMAS')] = 'XMAS',
    }
    return map[h] or 'CLEAR'
end

local function update()
    if not Master.enabled then return end
    local ped = PlayerPedId()
    local weather = getWeather()
    local emergency = false
    if IsPedInAnyVehicle(ped, false) then
        emergency = GetVehicleClass(GetVehiclePedIsIn(ped, false)) == 18
    end

    Master.state.phase = getPhase(GetClockHours())
    Master.state.weather = weather
    Master.state.wet = weather == 'RAIN' or weather == 'THUNDER' or weather == 'CLEARING'
    Master.state.interior = GetInteriorFromEntity(ped) ~= 0
    Master.state.emergency = emergency

    if Master.state.interior then
        Master.state.profile = 'Balanced'
    elseif Master.state.phase == 'night' and not emergency then
        Master.state.profile = 'Quality'
    elseif emergency then
        Master.state.profile = 'Quality'
    else
        Master.state.profile = 'Balanced'
    end
end

CreateThread(function()
    Wait(4500)
    while true do
        update()
        Wait(Master.interval)
    end
end)

RegisterCommand('svmaster', function(_, args)
    local mode = args[1]
    if mode == 'on' then Master.enabled = true
    elseif mode == 'off' then Master.enabled = false
    elseif mode == 'reapply' then update()
    else print('[SilvaVision] svmaster on | off | reapply'); return end
    print(('[SilvaVision] Master Director %s'):format(Master.enabled and 'ON' or 'OFF'))
end, false)

exports('GetMasterDirectorState', function() return Master.state end)
