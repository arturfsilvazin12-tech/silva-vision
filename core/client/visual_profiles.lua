-- SILVA VISION V0.5 MEGA ULTRA
-- Profiles are data only. Central Apply is the only VisualSettings writer.

local Profiles = {
    Performance = { rain=2800.0, distantSize=0.95, distantReflection=0.75, distantUpscale=1.25, lightBoost=1.00, transition=0.20 },
    Balanced    = { rain=3500.0, distantSize=1.05, distantReflection=0.85, distantUpscale=1.50, lightBoost=1.08, transition=0.15 },
    Quality     = { rain=4300.0, distantSize=1.10, distantReflection=0.90, distantUpscale=1.60, lightBoost=1.12, transition=0.12 },
    Cinematic   = { rain=5000.0, distantSize=1.15, distantReflection=0.95, distantUpscale=1.70, lightBoost=1.16, transition=0.10 },
}

local activeProfile = 'Balanced'
local manual = false

local function valid(name) return Profiles[name] ~= nil end

local function setProfile(name, isManual)
    if not valid(name) then name = 'Balanced' end
    activeProfile = name
    if isManual ~= nil then manual = isManual end
    print(('[SilvaVision] perfil=%s | manual=%s'):format(activeProfile, tostring(manual)))
end

RegisterCommand('svprofile', function(_, args)
    if args[1] then setProfile(args[1], true)
    else print('[SilvaVision] Performance | Balanced | Quality | Cinematic') end
end, false)

RegisterCommand('svprofileauto', function(_, args)
    if args[1] == 'on' then manual = false
    elseif args[1] == 'off' then manual = true
    else print('[SilvaVision] svprofileauto on | off'); return end
    print(('[SilvaVision] profile auto=%s'):format(tostring(not manual)))
end, false)

exports('ApplyProfile', function(name) setProfile(name, true) end)
exports('GetActiveProfile', function() return activeProfile end)
exports('GetProfiles', function() return Profiles end)
exports('IsProfileManual', function() return manual end)
