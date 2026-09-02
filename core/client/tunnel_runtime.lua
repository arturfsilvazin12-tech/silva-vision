-- SILVA VISION V0.5 MEGA BLOCK 16
-- Tunnel / Interior Director — CLIENT ONLY / STATE ONLY.
-- Central Apply é o único writer de VisualSettings.

local Tunnel={enabled=true,interval=350,state={interior=false,id=0,deep=false,night=0.0,wet=0.0,exposure=1.0,ambient=1.0,contrast=1.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(old,target,k)return old+(target-old)*k end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not Tunnel.enabled then return end
 local id=GetInteriorFromEntity(PlayerPedId());local inside=id~=0
 local c=call('GetVisualContextBridge') or {};local f=call('GetVisualFinishState') or {}
 local night=clamp(tonumber(f.night) or tonumber(c.night) or 0,0,1);local wet=clamp(tonumber(f.wet) or 0,0,1)
 Tunnel.state.id=id;Tunnel.state.interior=inside;Tunnel.state.deep=inside and id~=0 and id~=1;Tunnel.state.night=night;Tunnel.state.wet=wet
 local targetExposure=inside and 0.94 or 1.0;local targetAmbient=inside and (0.92+night*0.05) or (1.0+wet*0.03);local targetContrast=inside and 0.98 or 1.0
 Tunnel.state.exposure=smooth(Tunnel.state.exposure,targetExposure,0.18);Tunnel.state.ambient=smooth(Tunnel.state.ambient,targetAmbient,0.18);Tunnel.state.contrast=smooth(Tunnel.state.contrast,targetContrast,0.18)
end
CreateThread(function()Wait(3000);while true do tick();Wait(Tunnel.interval)end end)
RegisterCommand('svtunnel',function(_,args)
 local m=args[1]
 if m=='on' then Tunnel.enabled=true elseif m=='off' then Tunnel.enabled=false elseif m=='reapply' then tick() elseif m=='show' or not m then print(('[SilvaVision] interior=%s id=%d deep=%s exposure=%.2f ambient=%.2f contrast=%.2f night=%.2f wet=%.2f | writer=CentralApply'):format(tostring(Tunnel.state.interior),Tunnel.state.id,tostring(Tunnel.state.deep),Tunnel.state.exposure,Tunnel.state.ambient,Tunnel.state.contrast,Tunnel.state.night,Tunnel.state.wet));return else print('[SilvaVision] svtunnel on | off | reapply | show');return end
 print('[SilvaVision] Tunnel Director '..(Tunnel.enabled and 'ON' or 'OFF'))
end,false)
exports('GetTunnelState',function()return Tunnel.state end)
