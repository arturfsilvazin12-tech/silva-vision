-- SILVA VISION V0.5
-- Central Visual Apply — CLIENT ONLY
-- Aplica somente settings validados e evita extremos.

local Apply = { enabled = true, interval = 1500, lastStateKey = '' }

local function setValidated(name, value)
    if type(SetVisualSettingFloat) ~= 'function' then return false end
    local ok, valid = pcall(function() return exports['silva-vision-core']:IsVisualSettingValidated(name) end)
    if not ok or valid ~= true then return false end
    return pcall(SetVisualSettingFloat, name, value)
end

local function getState()
    local ok, state = pcall(function() return exports['silva-vision-core']:GetVisualPolicy() end)
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
    local emergency = s.emergency and 1.0 or 0.0

    setValidated('distantlights.size', 1.05 + 0.08 * night)
    setValidated('distantlights.sizeReflections', 0.85 + 0.08 * wet + 0.02 * night)
    setValidated('distantlights.sizeUpscale', 1.45 + 0.15 * night)
    setValidated('distantlights.sizeUpscaleReflections', 1.45 + 0.15 * night)

    local rain = s.weather == 'THUNDER' and 4500.0 or (s.wet and 3500.0 or 3000.0)
    setValidated('rain.NumberParticles', rain)
    setValidated('rain.UseLitShader', 1.0)
    setValidated('rain.ambient', s.wet and 0.42 or 0.35)
    setValidated('rain.diffuse', s.wet and 1.0 or 0.90)

    local interiorLight = interior == 1.0 and 0.90 or 1.10
    setValidated('car.interiorlight.intensity', interiorLight)
    setValidated('car.fatinteriorlight.intensity', interiorLight)

    local headlight = night == 1.0 and 1.55 or 1.45
    if emergency == 1.0 then headlight = 1.60 end
    setValidated('car.headlight.HDRIntensity', headlight)
    setValidated('car.headlight.fullbeam.HDRIntensity', 1.15)

    Apply.lastStateKey = table.concat({s.phase, s.weather, tostring(s.wet), tostring(s.interior), tostring(s.emergency), s.profile}, '|')
end

CreateThread(function()
    Wait(5500)
    while true do
        apply()
        Wait(Apply.interval)
    end
end)

RegisterCommand('svapply', function(_, args)
    if args[1] == 'on' then Apply.enabled = true; apply()
    elseif args[1] == 'off' then Apply.enabled = false
    elseif args[1] == 'reapply' then apply()
    elseif args[1] == 'show' then print('[SilvaVision] apply state=' .. Apply.lastStateKey)
    else print('[SilvaVision] svapply on | off | reapply | show'); return end
    print(('[SilvaVision] Central Apply %s'):format(Apply.enabled and 'ON' or 'OFF'))
end, false)

exports('ApplyVisualSettings', apply)
exports('GetVisualApplyState', function() return Apply end)
