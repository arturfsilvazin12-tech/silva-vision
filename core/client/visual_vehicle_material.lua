-- SILVA VISION V0.5 MEGA BLOCK 24
-- Vehicle Material — CLIENT ONLY / STATE ONLY.
-- Calcula demanda visual para pintura, superfícies molhadas, faróis e emergência.
-- NÃO altera entidades/veículos e NÃO escreve VisualSettings.

local V={enabled=true,interval=300,state={inVehicle=false,night=0.0,wet=0.0,storm=0.0,paint=1.0,wetMaterial=0.0,headlight=0.0,emergency=0.0,reflection=0.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not V.enabled then return end
 local s=V.state;local ped=PlayerPedId();local veh=GetVehiclePedIsIn(ped,false);local inVehicle=veh~=0
 local scene=call('GetVisualSceneState') or {};local wb=call('GetVisualWeatherBlendState') or {};local sun=call('GetVisualSunCycleState') or {};local em=call('GetVisualEmergencySceneState') or {};local rd=call('GetVisualReflectionDirectorState') or {};local night=clamp(tonumber(sun.night) or tonumber(scene.night) or 0,0,1);local wet=clamp(tonumber(wb.wet) or tonumber(scene.wet) or 0,0,1);local storm=clamp(tonumber(wb.storm) or tonumber(scene.storm) or 0,0,1);local emergency=clamp(tonumber(em.active) or tonumber(scene.emergency) or 0,0,1);local reflection=clamp(tonumber(rd.reflection) or tonumber(scene.reflectionDemand) or 0,0,1)
 s.inVehicle=inVehicle;s.night=smooth(s.night,inVehicle and night or 0,0.14);s.wet=smooth(s.wet,inVehicle and wet or 0,0.14);s.storm=smooth(s.storm,inVehicle and storm or 0,0.14);s.emergency=smooth(s.emergency,inVehicle and emergency or 0,0.16);s.reflection=smooth(s.reflection,inVehicle and reflection or 0,0.14);s.wetMaterial=smooth(s.wetMaterial,inVehicle and clamp(wet*0.82+storm*0.18,0,1) or 0,0.14);s.paint=clamp(1.0-s.wetMaterial*0.04+s.night*0.02,0.94,1.04);s.headlight=clamp(s.night*0.86+s.wetMaterial*0.10+s.emergency*0.04,0,1)
end
CreateThread(function()Wait(7500);while true do tick();Wait(V.interval)end end)
RegisterCommand('svvehmat',function(_,a)
 if a[1]=='on'then V.enabled=true elseif a[1]=='off'then V.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=V.state;print(('[SilvaVision] vehmat vehicle=%s night=%.2f wet=%.2f storm=%.2f wetMaterial=%.2f reflection=%.2f emergency=%.2f'):format(tostring(s.inVehicle),s.night,s.wet,s.storm,s.wetMaterial,s.reflection,s.emergency));return else print('[SilvaVision] svvehmat on | off | reapply | show');return end
 print('[SilvaVision] Vehicle Material '..(V.enabled and 'ON' or 'OFF'))
end,false)
exports('GetVisualVehicleMaterialState',function()return V.state end)
