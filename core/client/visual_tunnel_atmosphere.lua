-- SILVA VISION V0.5 MEGA BLOCK 24
-- Tunnel Atmosphere — CLIENT ONLY / STATE ONLY.
-- Suaviza demanda de exposição, ambiente e contraste em interiores/túneis.
-- NÃO força timecycle e NÃO escreve VisualSettings.

local T={enabled=true,interval=300,state={interior=0.0,deep=0.0,night=0.0,wet=0.0,exposure=1.0,ambient=1.0,contrast=0.0,atmosphere=0.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not T.enabled then return end
 local s=T.state;local scene=call('GetVisualSceneState') or {};local tun=call('GetTunnelState') or {};local ex=call('GetVisualExposureGuardState') or {};local at=call('GetAtmosphereState') or {};local night=clamp(tonumber(scene.night) or 0,0,1);local wet=clamp(tonumber(scene.wet) or 0,0,1);local interior=clamp(tonumber(scene.interior) or 0,0,1);local deep=clamp(tonumber(tun.deep) or interior*0.55,0,1);local fog=clamp(tonumber(at.fog) or tonumber(scene.fog) or 0,0,1)
 s.interior=smooth(s.interior,interior,0.16);s.deep=smooth(s.deep,deep,0.14);s.night=smooth(s.night,night,0.12);s.wet=smooth(s.wet,wet,0.12);s.exposure=clamp(smooth(s.exposure,tonumber(ex.factor) or 1.0,0.14),0.88,1.04);s.ambient=clamp(1.0-s.interior*0.06-s.deep*0.04+wet*0.02,0.88,1.04);s.contrast=clamp(s.deep*0.06+s.night*0.03+fog*0.02,0,0.10);s.atmosphere=clamp(fog*0.65+s.interior*0.18+wet*0.10,0,1)
end
CreateThread(function()Wait(7500);while true do tick();Wait(T.interval)end end)
RegisterCommand('svtunnelatm',function(_,a)
 if a[1]=='on'then T.enabled=true elseif a[1]=='off'then T.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=T.state;print(('[SilvaVision] tunnelatm interior=%.2f deep=%.2f night=%.2f wet=%.2f exposure=%.2f ambient=%.2f contrast=%.2f atmosphere=%.2f'):format(s.interior,s.deep,s.night,s.wet,s.exposure,s.ambient,s.contrast,s.atmosphere));return else print('[SilvaVision] svtunnelatm on | off | reapply | show');return end
 print('[SilvaVision] Tunnel Atmosphere '..(T.enabled and 'ON' or 'OFF'))
end,false)
exports('GetVisualTunnelAtmosphereState',function()return T.state end)
