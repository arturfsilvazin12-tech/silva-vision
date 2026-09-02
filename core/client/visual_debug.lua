-- SILVA VISION V0.5 MEGA BLOCK 17
-- Visual Debug / Telemetry — CLIENT ONLY.
-- Diagnóstico local, sem alterações no mundo.

local Debug={enabled=false,interval=2500}
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function snapshot()
 local ped=PlayerPedId();local c=call('GetVisualContextBridge') or {};local a=call('GetAtmosphereState') or {};local w=call('GetWaterReflectionState') or {};local e=call('GetEmergencyLightingState') or {};local t=call('GetVisualTransitionState') or {};local b=call('GetVisualBudget') or {};local m=call('GetMasterDirectorState') or {}
 return {hour=GetClockHours(),minute=GetClockMinutes(),weather=c.weather or 'CLEAR',phase=c.phase or '?',interior=GetInteriorFromEntity(ped),vehicle=IsPedInAnyVehicle(ped,false),wet=c.wet==true,storm=c.storm==true,night=c.night or 0,atmosphere=a.density or 0,visibility=a.visibility or 1,reflection=w.reflection or 0,puddle=w.puddleFactor or 0,emergency=e.active==true,transition=t.progress or 0,budget=b.tier or '?',frameMs=b.frameMs or 0,masterQuality=m.quality or 1}
end
local function printSnapshot()
 local s=snapshot();print(('[SilvaVision] %02d:%02d | %s | weather=%s | wet=%s storm=%s night=%.2f'):format(s.hour,s.minute,s.phase,s.weather,tostring(s.wet),tostring(s.storm),s.night));print(('[SilvaVision] atmosphere=%.2f visibility=%.2f reflection=%.2f puddle=%.2f'):format(s.atmosphere,s.visibility,s.reflection,s.puddle));print(('[SilvaVision] emergency=%s transition=%.2f budget=%s frame=%.2fms quality=%.2f'):format(tostring(s.emergency),s.transition,s.budget,s.frameMs,s.masterQuality))
end
RegisterCommand('svdebug',function(_,a)if a[1]=='on'then Debug.enabled=true elseif a[1]=='off'then Debug.enabled=false elseif a[1]=='show'or not a[1]then printSnapshot();return else print('[SilvaVision] svdebug on | off | show');return end;print('[SilvaVision] Debug '..(Debug.enabled and 'ON' or 'OFF'))end,false)
CreateThread(function()while true do if Debug.enabled then printSnapshot()end;Wait(Debug.interval)end end)
exports('GetDebugSnapshot',snapshot)
