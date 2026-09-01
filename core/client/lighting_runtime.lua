-- SILVA VISION V0.5
-- Lighting runtime policy — CLIENT ONLY
-- Mantém iluminação branca/neutra e evita extremos.

local Lighting = {
    enabled = true,
    groups = {
        street = { enabled = true, intensity = 3.0, r = 1.0, g = 1.0, b = 1.0 },
        distant = { enabled = true, size = 1.05, reflection = 0.85, upscale = 1.50 },
        corona = { enabled = true, size = 0.50, intensity = 0.35 },
        headlights = { enabled = true, intensity = 1.50, fullbeam = 1.15 },
        interior = { enabled = true, intensity = 1.60 },
        emergency = { enabled = true, intensity = 1.20 },
    }
}

local function clamp(v, lo, hi)
    return math.max(lo, math.min(hi, v))
end

local function set(name, value)
    if not Lighting.enabled or type(SetVisualSettingFloat) ~= 'function' then return false end
    local ok = pcall(SetVisualSettingFloat, name, value)
    return ok
end

local function apply()
    local s = Lighting.groups.street
    if s.enabled then
        -- RGB neutro: branco. Intensidade limitada para não estourar a imagem.
        set('streetlight.color.red', s.r)
        set('streetlight.color.green', s.g)
        set('streetlight.color.blue', s.b)
        set('distantlights.streetlight.HDRIntensity', clamp(s.intensity, 1.0, 6.0))
    end

    local d = Lighting.groups.distant
    if d.enabled then
        set('distantlights.size', clamp(d.size, 0.80, 1.25))
        set('distantlights.sizeReflections', clamp(d.reflection, 0.65, 1.00))
        set('distantlights.sizeUpscale', clamp(d.upscale, 1.00, 1.80))
        set('distantlights.sizeUpscaleReflections', clamp(d.upscale, 1.00, 1.80))
    end

    local c = Lighting.groups.corona
    if c.enabled then
        set('coronastar.size', clamp(c.size, 0.30, 0.75))
        set('coronastar.intensity', clamp(c.intensity, 0.20, 0.55))
    end

    local h = Lighting.groups.headlights
    if h.enabled then
        set('car.headlight.HDRIntensity', clamp(h.intensity, 0.80, 2.50))
        set('car.headlight.fullbeam.HDRIntensity', clamp(h.fullbeam, 0.80, 1.80))
    end

    local i = Lighting.groups.interior
    if i.enabled then
        set('vehicleinteriorlight.color.red', 1.0)
        set('vehicleinteriorlight.color.green', 1.0)
        set('vehicleinteriorlight.color.blue', 1.0)
        set('vehicleinteriorlight.intensity', clamp(i.intensity, 1.0, 2.25))
    end

    local e = Lighting.groups.emergency
    if e.enabled then
        set('emissive.multiplier', clamp(e.intensity, 0.80, 1.80))
    end
end

CreateThread(function()
    Wait(2200)
    apply()
end)

RegisterCommand('svlighting', function(_, args)
    local mode = args[1]
    if mode == 'on' then Lighting.enabled = true; apply() end
    if mode == 'off' then Lighting.enabled = false end
    if mode == 'reapply' then apply() end
    print(('[SilvaVision] lighting=%s'):format(Lighting.enabled and 'ON' or 'OFF'))
end, false)

exports('ApplyLighting', apply)
exports('GetLightingConfig', function() return Lighting end)
