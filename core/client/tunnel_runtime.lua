-- SILVA VISION V0.5 MEGA ULTRA
-- Tunnel/interior state layer — CLIENT ONLY.
-- Interior VisualSettings são responsabilidade do Central Apply.

local Tunnel={enabled=true,interval=1000,state={interior=false,id=0}}

local function tick()
 if not Tunnel.enabled then return end
 local id=GetInteriorFromEntity(PlayerPedId())
 Tunnel.state.id=id; Tunnel.state.interior=id~=0
end

CreateThread(function() Wait(3000); while true do tick(); Wait(Tunnel.interval) end end)
RegisterCommand('svtunnel',function(_,args)
 local m=args[1]
 if m=='on' then Tunnel.enabled=true elseif m=='off' then Tunnel.enabled=false elseif m=='reapply' then pcall(function() exports['silva-vision-core']:ApplyVisualSettings() end) elseif m=='show' or not m then print(('[SilvaVision] tunnel/interior=%s | writer=CentralApply'):format(tostring(Tunnel.state.interior))); return else print('[SilvaVision] svtunnel on | off | reapply | show'); return end
 print(('[SilvaVision] Tunnel state %s'):format(Tunnel.enabled and 'ON' or 'OFF'))
end,false)
exports('GetTunnelState',function() return Tunnel.state end)
