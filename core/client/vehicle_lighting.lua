-- SILVA VISION V0.5 MEGA BLOCK 15
-- Vehicle Lighting Director — CLIENT ONLY / STATE ONLY.
-- Faróis aplicados exclusivamente pelo Central Apply.

local VehicleLighting={enabled=true,interval=500,headlights={low=1.50,fullbeam=1.15},emergency={emissive=1.20},state={inVehicle=false,vehicleClass=-1,night=0.0,wet=0.0,emergency=false,headlightFactor=1.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not VehicleLighting.enabled then return end
 local ped=PlayerPedId();local inVehicle=IsPedInAnyVehicle(ped,false);local veh=inVehicle and GetVehiclePedIsIn(ped,false) or 0
 local c=call('GetVisualContextBridge') or {};local f=call('GetVisualFinishState') or {};local e=call('GetEmergencyLightingState') or {}
 local night=clamp(tonumber(f.night) or tonumber(c.night) or 0,0,1);local wet=clamp(tonumber(f.wet) or 0,0,1);local emergency=e.active==true
 VehicleLighting.state.inVehicle=inVehicle;VehicleLighting.state.vehicleClass=inVehicle and GetVehicleClass(veh) or -1;VehicleLighting.state.night=night;VehicleLighting.state.wet=wet;VehicleLighting.state.emergency=emergency
 VehicleLighting.state.headlightFactor=clamp(1.0+night*0.10+wet*0.04+(emergency and 0.03 or 0),1.0,1.17)
end
CreateThread(function()Wait(3000);while true do tick();Wait(VehicleLighting.interval)end end)
RegisterCommand('svvehiclelights',function(_,args)
 local m=args[1]
 if m=='on' then VehicleLighting.enabled=true elseif m=='off' then VehicleLighting.enabled=false elseif m=='reapply' then pcall(function()exports['silva-vision-core']:ApplyVisualSettings()end) elseif m=='show' or not m then print(('[SilvaVision] vehicle=%s class=%d night=%.2f wet=%.2f emergency=%s headlightFactor=%.2f | writer=CentralApply'):format(tostring(VehicleLighting.state.inVehicle),VehicleLighting.state.vehicleClass,VehicleLighting.state.night,VehicleLighting.state.wet,tostring(VehicleLighting.state.emergency),VehicleLighting.state.headlightFactor));return else print('[SilvaVision] svvehiclelights on | off | reapply | show');return end
 print('[SilvaVision] Vehicle Lighting '..(VehicleLighting.enabled and 'ON' or 'OFF'))
end,false)
exports('GetVehicleLightingConfig',function()return VehicleLighting end)
