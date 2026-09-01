-- SILVA VISION V0.5
-- Tunnel / Interior runtime — CLIENT ONLY
-- Separa interiores/túneis da iluminação externa.

local Tunnel = {
    enabled = true,
    interval = 1000,
    state = { interior = false, id = 0 },
}

local function setVisual(name, value)
    if type(SetVisualSettingFloat) ~= 'function' then return false end
    return pcall(SetVisualSettingFloat, name, value)
end

local function apply()
    if not Tunnel.enabled then return end
    local ped = PlayerPedId()
    local id = GetInteriorFromEntity(ped)
    Tunnel.state.id = id
    Tunnel.state.interior = id ~= 0

    if Tunnel.state.interior then
        -- Valores conservadores para não lavar o interior.
        setVisual('car.interiorlight.intensity', 0.90)
        setVisual('car.fatinteriorlight.intensity', 0.90)
    else
        -- Ao sair, não força um valor agressivo; a configuração base assume o controle.
    end
end

CreateThread(function()
    Wait(3000)
    while true do
        apply()
        Wait(Tunnel.interval)
    end
end)

RegisterCommand('svtunnel', function(_, args)
    local mode = args[1]
    if mode == 'on' then Tunnel.enabled = true
    elseif mode == 'off' then Tunnel.enabled = false
    elseif mode == 'reapply' then apply()
    else print('[SilvaVision] svtunnel on | off | reapply'); return end
    print(('[SilvaVision] Tunnel Runtime %s'):format(Tunnel.enabled and 'ON' or 'OFF'))
end, false)

exports('GetTunnelState', function() return Tunnel.state end)
