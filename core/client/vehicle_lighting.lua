-- SILVA VISION V0.5 MEGA ULTRA
-- Vehicle state layer — CLIENT ONLY.
-- Faróis são aplicados exclusivamente pelo Central Apply.

local VehicleLighting={enabled=true,interval=750,headlights={low=1.50,fullbeam=1.15},emergency={emissive=1.20},state={inVehicle=false}}

local function tick()
 if not VehicleLighting.enabled then return end
 local ped=PlayerPedId()
 VehicleLighting.state.inVehicle=IsPedInAnyVehicle(ped,false)
end

CreateThread(function() Wait(3000); while true do tick(); Wait(VehicleLighting.interval) end end)
RegisterCommand('svvehiclelights',function(_,args)
 local m=args[1]
 if m=='on' then VehicleLighting.enabled=true elseif m=='off' then VehicleLighting.enabled=false elseif m=='reapply' then pcall(function() exports['silva-vision-core']:ApplyVisualSettings() end) elseif m=='show' or not m then print(('[SilvaVision] vehicle=%s | writer=CentralApply'):format(tostring(VehicleLighting.state.inVehicle))); return else print('[SilvaVision] svvehiclelights on | off | reapply | show'); return end
 print(('[SilvaVision] Vehicle state %s'):format(VehicleLighting.enabled and 'ON' or 'OFF'))
end,false)
exports('GetVehicleLightingConfig',function() return VehicleLighting end)
