-- SILVA VISION V0.5 ULTRA
-- Profile system — CLIENT ONLY
-- Perfis usados pelo Central Apply.

local Profiles = {
    Performance = {
        rain=2800.0, distantSize=0.95, distantReflection=0.75,
        distantUpscale=1.25, lightBoost=1.00, transition=0.20,
    },
    Balanced = {
        rain=3500.0, distantSize=1.05, distantReflection=0.85,
        distantUpscale=1.50, lightBoost=1.08, transition=0.15,
    },
    Quality = {
        rain=4300.0, distantSize=1.10, distantReflection=0.90,
        distantUpscale=1.60, lightBoost=1.12, transition=0.12,
    },
    Cinematic = {
        rain=5000.0, distantSize=1.15, distantReflection=0.95,
        distantUpscale=1.70, lightBoost=1.16, transition=0.10,
    }
}

local activeProfile='Balanced'

local function valid(name)
    return Profiles[name] ~= nil
end

local function applyProfile(name)
    if not valid(name) then name='Balanced' end
    activeProfile=name
    print(('[SilvaVision] perfil selecionado: %s'):format(activeProfile))
end

RegisterCommand('svprofile', function(_, args)
    if args[1] then applyProfile(args[1])
    else print('[SilvaVision] Perfis: Performance | Balanced | Quality | Cinematic') end
end, false)

CreateThread(function()
    Wait(1800)
    applyProfile(activeProfile)
end)

exports('ApplyProfile', applyProfile)
exports('GetActiveProfile', function() return activeProfile end)
exports('GetProfiles', function() return Profiles end)
