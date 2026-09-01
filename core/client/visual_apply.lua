-- SILVA VISION V0.5
-- Central Visual Apply — CLIENT ONLY
-- Aplica somente settings validados e evita extremos.

local Apply = { enabled = true, interval = 2500 }

local function setValidated(name, value)
    if type(SetVisualSettingFloat) ~= 'function' then return false end
    local catalog = exports['silva-vision-core']
    if type(catalog) ~= 'table' then return false end
    local ok, valid = pcall(function() return catalog:IsVisualSettingValidated(name) end)
    if not ok or not valid then return false end
    local success = pcall(SetVisualSettingFloat, name, value)
    return success
end

local function getState()
    local master = exports['silva-vision-core']
    if type(master) ~= 'table' then return nil end
    local ok, state = pcall(function() return master:GetVisualPolicy() end)
    if ok and type(state) == 'table' then return state end
    return nil
end

local function apply()
    if not Apply.enabled then return end
    local s = getState()
    if not s then return end

    local night = s.phase == 'night' and 1.0 or 0.0
    local wet = s.wet and 1.0 or 0.0
    local interior = s.interior and 1.0 or 0.0

    setValidated('distantlights.size', 1.05 + 0.08 * night)
    setValidated('distantlights.sizeReflections', 0.85 + 0.08 * wet + 0.02 * night)
    setValidated('distantlights.sizeUpscale', 1.45 + 0.15 * night)
    setValidated('distantlights.sizeUpscaleReflections', 1.45 + 0.15 * night)

    setValidated('rain.NumberParticles', s.weather == 'THUNDER' and 4500.0 or (s.wet and 3500.0 or 3000.0))
    setValidated('rain.ambient', s.wet and 0.42 or 0.35)

    if interior then
        setValidated('car.interiorlight.intensity', 0.90)
        setValidated('car.fatinteriorlight.intensity', 0.90)
    else
        setValidated('car.interiorlight.intensity', 1.10)
        setValidated('car.fatinteriorlight.intensity', 1.10)
    end
end

CreateThread(function()
    Wait(5500)
    while true do
        apply()
        Wait(Apply.interval)
    end
end)

RegisterCommand('svapply', function(_, args)
    if args[1] == 'on' then Apply.enabled = true
    elseif args[1] == 'off' then Apply.enabled = false
    elseif args[1] == 'reapply' then apply()
    else print('[SilvaVision] svapply on | off | reapply'); return end
    print(('[SilvaVision] Central Apply %s'):format(Apply.enabled and 'ON' or 'OFF'))
end, false)

exports('ApplyVisualSettings', apply)
