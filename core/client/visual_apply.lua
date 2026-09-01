-- SILVA VISION V0.5 ULTRA
-- Central Visual Apply — CLIENT ONLY
-- Fonte única para VisualSettings validados.
-- Nenhum parâmetro pending é escrito aqui.

local Apply = {
    enabled = true,
    interval = 1200,
    lastStateKey = '',
    lastProfile = '',
}

local function safeExport(name, ...)
    local ok, result = pcall(function()
        return exports['silva-vision-core'][name](...)
    end)
    return ok and result or nil
end

local function validated(name, value)
    if type(SetVisualSettingFloat) ~= 'function' then return false end
    local ok, allowed = pcall(function()
        return exports['silva-vision-core']:IsVisualSettingValidated(name)
    end)
    if not ok or allowed ~= true then return false end
    local wrote = pcall(SetVisualSettingFloat, name, value)
    return wrote
end

local function clamp(v, lo, hi)
    return math.max(lo, math.min(hi, v))
end

local function getState()
    return safeExport('GetVisualPolicy') or {}
end

local function getProfiles()
    return safeExport('GetProfiles') or {}
end

local function chooseProfile(state)
    local p = state.profile
    if p == 'Performance' or p == 'Balanced' or p == 'Quality' or p == 'Cinematic' then
        return p
    end
    if state.emergency or state.phase == 'night' then return 'Quality' end
    return 'Balanced'
end

local function apply()
    if not Apply.enabled then return false end
    local s = getState()
    local profiles = getProfiles()
    local profileName = chooseProfile(s)
    local p = profiles[profileName] or profiles.Balanced or {
        rain=3500.0, distantSize=1.05, distantReflection=0.85, distantUpscale=1.50
    }

    local night = s.phase == 'night'
    local wet = s.wet == true
    local storm = s.weather == 'THUNDER'
    local interior = s.interior == true
    local emergency = s.emergency == true

    -- Distant lights: visibilidade noturna sem transformar cada fonte em bloom.
    validated('distantlights.size', clamp((p.distantSize or 1.05) + (night and 0.04 or 0.0), 0.90, 1.20))
    validated('distantlights.sizeReflections', clamp((p.distantReflection or 0.85) + (wet and 0.07 or 0.0), 0.70, 1.00))
    validated('distantlights.sizeUpscale', clamp((p.distantUpscale or 1.50) + (night and 0.05 or 0.0), 1.10, 1.80))
    validated('distantlights.sizeUpscaleReflections', clamp((p.distantUpscale or 1.50) + (wet and 0.05 or 0.0), 1.10, 1.80))

    -- Chuva: mais presença em tempestade, mas sem valores extremos.
    local rain = p.rain or 3500.0
    if storm then rain = rain + 500.0 end
    validated('rain.NumberParticles', clamp(rain, 2800.0, 5500.0))
    validated('rain.UseLitShader', 1.0)
    validated('rain.diffuse', wet and 1.00 or 0.90)
    validated('rain.ambient', wet and (storm and 0.45 or 0.42) or 0.35)
    validated('rain.wrapScale', 0.60)
    validated('rain.wrapBias', 0.40)
    validated('rain.defaultlight.red', 1.0)
    validated('rain.defaultlight.green', 1.0)
    validated('rain.defaultlight.blue', 1.0)

    -- Interior: protege contra cabine estourada sem apagar iluminação.
    local interiorLight = interior and 0.90 or 1.08
    validated('car.interiorlight.intensity', interiorLight)
    validated('car.fatinteriorlight.intensity', interiorLight)

    -- Faróis: ganho moderado à noite; emergência ganha somente um pequeno adicional.
    local headlight = night and 1.55 or 1.45
    if emergency then headlight = headlight + 0.05 end
    validated('car.headlight.HDRIntensity', clamp(headlight, 1.35, 1.65))
    validated('car.headlight.fullbeam.HDRIntensity', night and 1.18 or 1.15)

    Apply.lastProfile = profileName
    Apply.lastStateKey = table.concat({
        s.phase or 'unknown', s.weather or 'unknown', tostring(wet),
        tostring(interior), tostring(emergency), profileName
    }, '|')
    return true
end

CreateThread(function()
    Wait(4500)
    while true do
        apply()
        Wait(Apply.interval)
    end
end)

RegisterCommand('svapply', function(_, args)
    local cmd = args[1]
    if cmd == 'on' then Apply.enabled = true; apply()
    elseif cmd == 'off' then Apply.enabled = false
    elseif cmd == 'reapply' then apply()
    elseif cmd == 'show' then
        print(('[SilvaVision] Apply=%s profile=%s state=%s'):format(
            tostring(Apply.enabled), Apply.lastProfile, Apply.lastStateKey))
    else
        print('[SilvaVision] svapply on | off | reapply | show')
        return
    end
    print(('[SilvaVision] Central Apply %s'):format(Apply.enabled and 'ON' or 'OFF'))
end, false)

exports('ApplyVisualSettings', apply)
exports('GetVisualApplyState', function() return Apply end)
