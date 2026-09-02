-- SILVA VISION V0.5 MEGA BLOCK 15
-- Emergency Lighting Director — CLIENT ONLY / STATE ONLY.
-- Não força sirenes, não altera entidades e não escreve emissive sem validação.

local Emergency={
 enabled=true,interval=250,boost=1.20,
 state={active=false,boost=1.0,vehicleClass=-1,inVehicle=false,night=0.0,wet=0.0,storm=0.0,signal=0.0}
}
local function smooth(old,target,k)return old+(target-old)*k end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not Emergency.enabled then return end
 local ped=PlayerPedId();local inVehicle=IsPedInAnyVehicle(ped,false);local veh=inVehicle and GetVehiclePedIsIn(ped,false) or 0;local class=inVehicle and GetVehicleClass(veh) or -1
 local active=inVehicle and class==18
 local c=call('GetVisualContextBridge') or {};local f=call('GetVisualFinishState') or {}
 Emergency.state.inVehicle=inVehicle;Emergency.state.vehicleClass=class;Emergency.state.active=active;Emergency.state.boost=active and Emergency.boost or 1.0
 Emergency.state.night=tonumber(f.night) or tonumber(c.night) or 0.0;Emergency.state.wet=tonumber(f.wet) or 0.0;Emergency.state.storm=tonumber(f.storm) or 0.0
 local target=active and (0.55+Emergency.state.night*0.30+Emergency.state.wet*0.10+Emergency.state.storm*0.05) or 0.0
 Emergency.state.signal=smooth(Emergency.state.signal,target,0.20)
end
CreateThread(function()Wait(3500);while true do tick();Wait(Emergency.interval)end end)
RegisterCommand('sveemergency',function(_,args)
 local m=args[1]
 if m=='on' then Emergency.enabled=true elseif m=='off' then Emergency.enabled=false elseif m=='reapply' then tick() elseif m=='show' or not m then print(('[SilvaVision] emergency=%s class=%d boost=%.2f signal=%.2f night=%.2f wet=%.2f storm=%.2f | emissive writer=BLOCKED'):format(tostring(Emergency.state.active),Emergency.state.vehicleClass,Emergency.state.boost,Emergency.state.signal,Emergency.state.night,Emergency.state.wet,Emergency.state.storm));return else print('[SilvaVision] sveemergency on | off | reapply | show');return end
 print('[SilvaVision] Emergency Director '..(Emergency.enabled and 'ON' or 'OFF'))
end,false)
exports('GetEmergencyLightingState',function()return Emergency.state end)
