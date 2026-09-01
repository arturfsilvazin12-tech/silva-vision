-- SILVA VISION V0.5
-- Client-only guard
-- O projeto deve funcionar instalado apenas no cliente.

local Guard = {
    clientOnly = true,
    serverDependency = false,
}

CreateThread(function()
    Wait(1000)
    if Guard.clientOnly then
        print('[SilvaVision] CLIENT-ONLY mode active | server dependency: NO')
    end
end)

exports('IsClientOnly', function() return Guard.clientOnly end)
exports('HasServerDependency', function() return Guard.serverDependency end)
