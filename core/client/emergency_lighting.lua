-- SILVA VISION V0.5 MEGA ULTRA
-- Emergency state detector — CLIENT ONLY.
-- emissive.multiplier permanece PENDING e não é escrito.

local Emergency={enabled=true,interval=400,state={active=false,boost=1.0},boost=1.20}

local function tick()
 if not Emergency.enabled then return end
 local ped=PlayerPedId(); local active=false
 if IsPedInAnyVehicle(ped,false) then active=GetVehicleClass(GetVehiclePedIsIn(ped,false))==18 end
 Emergency.state.active=active
 Emergency.state.boost=active and Emergency.boost or 1.0
end

CreateThread(function() Wait(3500); while true do tick(); Wait(Emergency.interval) end end)
RegisterCommand('sveemergency',function(_,args)
 local m=args[1]
 if m=='on' then Emergency.enabled=true elseif m=='off' then Emergency.enabled=false elseif m=='reapply' then tick() elseif m=='show' or not m then print(('[SilvaVision] emergency=%s boost=%.2f | emissive writer=BLOCKED'):format(tostring(Emergency.state.active),Emergency.state.boost)); return else print('[SilvaVision] sveemergency on | off | reapply | show'); return end
 print(('[SilvaVision] Emergency detector %s'):format(Emergency.enabled and 'ON' or 'OFF'))
end,false)
exports('GetEmergencyLightingState',function() return Emergency.state end)
