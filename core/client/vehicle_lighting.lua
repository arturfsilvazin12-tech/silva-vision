-- SILVA VISION V0.5
-- Vehicle Lighting Layer — CLIENT ONLY
-- Não altera handling, sirenes ou assets de veículos.

local VehicleLighting = {
    enabled = true,
    interval = 500,
    headlights = { low = 1.50, fullbeam = 1.15 },
    emergency = { emissive = 1.20 },
}

local function clamp(v, lo, hi) return math.max(lo, math.min(hi, v)) end

local function setVisual(name, value)
    if type(SetVisualSettingFloat) ~= 'function' then return false end
    local ok = pcall(SetVisualSettingFloat, name, value)
    return ok
end

local function applyGlobal()
    setVisual('car.headlight.HDRIntensity', clamp(VehicleLighting.headlights.low, 0.80, 2.50))
    setVisual('car.headlight.fullbeam.HDRIntensity', clamp(VehicleLighting.headlights.fullbeam, 0.80, 1.80))
end

local function tick()
    if not VehicleLighting.enabled then return end
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        -- Mantém a iluminação do veículo consistente sem criar um boost por veículo.
        applyGlobal()
    end
end

CreateThread(function()
    Wait(3000)
    applyGlobal()
    while true do
        tick()
        Wait(VehicleLighting.interval)
    end
end)

RegisterCommand('svvehiclelights', function(_, args)
    local mode = args[1]
    if mode == 'on' then VehicleLighting.enabled = true; applyGlobal()
    elseif mode == 'off' then VehicleLighting.enabled = false
    elseif mode == 'reapply' then applyGlobal()
    else print('[SilvaVision] svvehiclelights on | off | reapply'); return end
    print(('[SilvaVision] Vehicle Lights %s'):format(VehicleLighting.enabled and 'ON' or 'OFF'))
end, false)

exports('GetVehicleLightingConfig', function() return VehicleLighting end)
