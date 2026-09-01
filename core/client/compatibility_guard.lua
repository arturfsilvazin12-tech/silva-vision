-- SILVA VISION V0.5
-- Compatibility Guard — CLIENT ONLY
-- Detecta capacidades locais e fornece fallback seguro.

local Compat = {
    enabled = true,
    capabilities = {
        visualSettings = false,
        timecycle = false,
        interior = false,
        vehicle = false,
        frameTime = false,
    }
}

local function detect()
    Compat.capabilities.visualSettings = type(SetVisualSettingFloat) == 'function'
    Compat.capabilities.timecycle = type(SetTimecycleModifier) == 'function' and type(SetTimecycleModifierStrength) == 'function'
    Compat.capabilities.interior = type(GetInteriorFromEntity) == 'function'
    Compat.capabilities.vehicle = type(IsPedInAnyVehicle) == 'function' and type(GetVehicleClass) == 'function'
    Compat.capabilities.frameTime = type(GetFrameTime) == 'function'
end

local function report()
    print(('[SilvaVision] compatibility | visualSettings=%s timecycle=%s interior=%s vehicle=%s frameTime=%s'):format(
        tostring(Compat.capabilities.visualSettings),
        tostring(Compat.capabilities.timecycle),
        tostring(Compat.capabilities.interior),
        tostring(Compat.capabilities.vehicle),
        tostring(Compat.capabilities.frameTime)
    ))
end

CreateThread(function()
    Wait(1200)
    detect()
    report()
end)

RegisterCommand('svcompat', function(_, args)
    if args[1] == 'refresh' then detect() end
    report()
end, false)

exports('GetCompatibility', function() return Compat.capabilities end)
exports('HasCapability', function(name) return Compat.capabilities[name] == true end)
