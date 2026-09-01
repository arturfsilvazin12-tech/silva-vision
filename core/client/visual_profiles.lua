-- SILVA VISION V0.5
-- Profile system — CLIENT ONLY
-- Perfis separados para evitar duplicação de pós-processamento.

local Profiles = {
    Performance = {
        rain = 3000.0,
        distantSize = 0.95,
        distantReflection = 0.75,
        distantUpscale = 1.25,
        lightBoost = 1.00,
        transition = 0.20,
    },
    Balanced = {
        rain = 3500.0,
        distantSize = 1.05,
        distantReflection = 0.85,
        distantUpscale = 1.50,
        lightBoost = 1.08,
        transition = 0.15,
    },
    Quality = {
        rain = 4500.0,
        distantSize = 1.10,
        distantReflection = 0.90,
        distantUpscale = 1.60,
        lightBoost = 1.12,
        transition = 0.12,
    },
    Cinematic = {
        rain = 5000.0,
        distantSize = 1.15,
        distantReflection = 0.95,
        distantUpscale = 1.70,
        lightBoost = 1.16,
        transition = 0.10,
    }
}

local activeProfile = 'Balanced'

local function clamp(v, lo, hi)
    return math.max(lo, math.min(hi, v))
end

local function getProfile(name)
    return Profiles[name] or Profiles.Balanced
end

local function applyProfile(name)
    local p = getProfile(name)
    activeProfile = Profiles[name] and name or 'Balanced'

    -- Só aplica natives quando disponíveis; falhas não interrompem o resource.
    local function set(name_, value)
        if type(SetVisualSettingFloat) == 'function' then
            pcall(SetVisualSettingFloat, name_, value)
        end
    end

    set('rain.NumberParticles', clamp(p.rain, 2500.0, 6000.0))
    set('distantlights.size', clamp(p.distantSize, 0.80, 1.25))
    set('distantlights.sizeReflections', clamp(p.distantReflection, 0.65, 1.00))
    set('distantlights.sizeUpscale', clamp(p.distantUpscale, 1.00, 1.80))
    set('distantlights.sizeUpscaleReflections', clamp(p.distantUpscale, 1.00, 1.80))
end

RegisterCommand('svprofile', function(_, args)
    if args[1] then
        applyProfile(args[1])
        print(('[SilvaVision] perfil: %s'):format(activeProfile))
    else
        print('[SilvaVision] Perfis: Performance | Balanced | Quality | Cinematic')
    end
end, false)

CreateThread(function()
    Wait(1800)
    applyProfile(activeProfile)
end)

exports('ApplyProfile', applyProfile)
exports('GetActiveProfile', function() return activeProfile end)
exports('GetProfiles', function() return Profiles end)
