-- SILVA VISION V0.5
-- Visual Settings Catalog — CLIENT ONLY
-- Lista conservadora de nomes conhecidos/permitidos.

local Catalog = {
    validated = {
        ['rain.NumberParticles'] = true,
        ['rain.UseLitShader'] = true,
        ['rain.diffuse'] = true,
        ['rain.ambient'] = true,
        ['rain.wrapScale'] = true,
        ['rain.wrapBias'] = true,
        ['rain.defaultlight.red'] = true,
        ['rain.defaultlight.green'] = true,
        ['rain.defaultlight.blue'] = true,
        ['distantlights.size'] = true,
        ['distantlights.sizeReflections'] = true,
        ['distantlights.sizeUpscale'] = true,
        ['distantlights.sizeUpscaleReflections'] = true,
        ['car.headlight.HDRIntensity'] = true,
        ['car.headlight.fullbeam.HDRIntensity'] = true,
        ['car.interiorlight.intensity'] = true,
        ['car.fatinteriorlight.intensity'] = true,
    },
    pending = {
        ['streetlight.color.red'] = true,
        ['streetlight.color.green'] = true,
        ['streetlight.color.blue'] = true,
        ['distantlights.streetlight.HDRIntensity'] = true,
        ['coronastar.size'] = true,
        ['coronastar.intensity'] = true,
        ['vehicleinteriorlight.color.red'] = true,
        ['vehicleinteriorlight.color.green'] = true,
        ['vehicleinteriorlight.color.blue'] = true,
        ['vehicleinteriorlight.intensity'] = true,
        ['emissive.multiplier'] = true,
    }
}

function IsSilvaVisualSettingValidated(name)
    return Catalog.validated[name] == true
end

function IsSilvaVisualSettingPending(name)
    return Catalog.pending[name] == true
end

exports('IsVisualSettingValidated', IsSilvaVisualSettingValidated)
exports('IsVisualSettingPending', IsSilvaVisualSettingPending)
exports('GetVisualSettingCatalog', function() return Catalog end)
