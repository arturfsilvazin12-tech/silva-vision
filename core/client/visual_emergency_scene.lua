-- SILVA VISION V0.5 MEGA BLOCK 21
-- Emergency Scene — CLIENT ONLY / STATE ONLY.
-- Detecta contexto de emergência sem forçar sirene, veículo ou emissive.

local E={enabled=true,interval=250,state={active=0.0,night=0.0,wet=0.0,signal=0.0,reflection=0.0,quality=1.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function tick()
 if not E.enabled then return end
 local s=E.state;local ped=PlayerPedId();local inVeh=IsPedInAnyVehicle(ped,false);local active=inVeh and GetVehicleClass(GetVehiclePedIsIn(ped,false))==18
 local h=GetClockHours();local night=(h<7 or h>=20) and 1 or 0;local wet=0;local ok,r=pcall(function()return exports['silva-vision-core']:GetVisualWeatherBlendState()end);if ok and type(r)=='table' then wet=tonumber(r.wet) or 0 end
 s.active=smooth(s.active,active and 1 or 0,0.18);s.night=smooth(s.night,night,0.12);s.wet=smooth(s.wet,wet,0.12);s.signal=clamp(s.active*(0.45+s.night*0.35+s.wet*0.20),0,1);s.reflection=clamp(s.signal*(0.55+s.wet*0.35),0,1);s.quality=clamp(1.0+s.active*0.04,1.0,1.05)
end
CreateThread(function()Wait(7000);while true do tick();Wait(E.interval)end end)
RegisterCommand('svevent',function(_,a)if a[1]=='on'then E.enabled=true elseif a[1]=='off'then E.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=E.state;print(('[SilvaVision] emergency active=%.2f signal=%.2f reflection=%.2f'):format(s.active,s.signal,s.reflection));return else print('[SilvaVision] svevent on | off | reapply | show');return end;print('[SilvaVision] Emergency Scene '..(E.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualEmergencySceneState',function()return E.state end)
