-- SILVA VISION V0.5 MEGA BLOCK 27
-- Final Visual Fusion — CLIENT ONLY / STATE ONLY.
-- Consolida superfície, atmosfera, emergência e Composer em um único estado final.
-- Não escreve VisualSettings, não força clima e não altera entidades.

local F={enabled=true,interval=250,state={quality=1.0,wet=0.0,rain=0.0,storm=0.0,puddle=0.0,reflection=0.0,atmosphere=0.0,fog=0.0,visibility=1.0,lightning=0.0,night=0.0,street=0.0,emergency=0.0,signal=0.0,contrast=1.0,priority=0.0,surface=0.0,nightUrban=0.0,tunnel=0.0,lightWeight=1.0,rainWeight=1.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function n(v,d)return type(v)=='number' and v or (tonumber(v) or d)end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not F.enabled then return end
 local s=call('GetVisualSurfaceResponseState') or {};local a=call('GetVisualAtmosphereDirectorState') or {};local e=call('GetVisualEmergencyContrastState') or {};local c=call('GetVisualComposerState') or {}
 local wet=clamp(math.max(n(s.wet,0),n(c.wet,0)),0,1);local rain=clamp(math.max(n(s.rain,0),n(a.rain,0),n(c.rain,0)),0,1);local storm=clamp(math.max(n(s.storm,0),n(a.storm,0),n(c.storm,0)),0,1);local puddle=clamp(n(s.puddle,0),0,1);local refl=clamp(math.max(n(s.reflection,0),n(c.reflection,0),n(e.reflection,0)),0,1);local atmos=clamp(math.max(n(a.atmosphere,0),n(c.atmosphere,0)),0,1);local fog=clamp(math.max(n(a.fog,0),n(c.fog,0)),0,1);local vis=clamp(math.min(n(s.visibility,1),n(a.visibility,1)),0.55,1);local lightning=clamp(n(a.lightning,0),0,1);local night=clamp(n(c.night,0),0,1);local street=clamp(n(c.street,0),0,1);local em=clamp(math.max(n(e.active,0),n(c.emergency,0)),0,1);local signal=clamp(n(e.signal,0),0,1);local contrast=clamp(n(e.contrast,1),1,1.13);local priority=clamp(n(e.priority,0),0,1);local quality=clamp(n(c.quality,1),0.72,1)
 F.state.wet=smooth(F.state.wet,wet,0.16);F.state.rain=smooth(F.state.rain,rain,0.14);F.state.storm=smooth(F.state.storm,storm,0.15);F.state.puddle=smooth(F.state.puddle,puddle,0.13);F.state.reflection=smooth(F.state.reflection,refl,0.14);F.state.atmosphere=smooth(F.state.atmosphere,atmos,0.12);F.state.fog=smooth(F.state.fog,fog,0.12);F.state.visibility=smooth(F.state.visibility,vis,0.12);F.state.lightning=smooth(F.state.lightning,lightning,0.18);F.state.night=smooth(F.state.night,night,0.14);F.state.street=smooth(F.state.street,street,0.14);F.state.emergency=smooth(F.state.emergency,em,0.18);F.state.signal=smooth(F.state.signal,signal,0.18);F.state.contrast=smooth(F.state.contrast,contrast,0.14);F.state.priority=smooth(F.state.priority,priority,0.16);F.state.surface=smooth(F.state.surface,clamp(wet*0.52+puddle*0.30+refl*0.18,0,1),0.14);F.state.quality=quality;F.state.nightUrban=clamp(n(c.nightUrban,0),0,1);F.state.tunnel=clamp(n(c.tunnel,0),0,1);F.state.lightWeight=clamp(n(c.lightWeight,1),0.72,1);F.state.rainWeight=clamp(n(c.rainWeight,1),0.72,1)
end
CreateThread(function()Wait(12000);while true do tick();Wait(F.interval)end end)
RegisterCommand('svfusion',function(_,a)if a[1]=='on'then F.enabled=true elseif a[1]=='off'then F.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=F.state;print(('[SilvaVision] fusion q=%.2f wet=%.2f rain=%.2f storm=%.2f surface=%.2f atmos=%.2f fog=%.2f vis=%.2f night=%.2f street=%.2f em=%.2f signal=%.2f refl=%.2f'):format(s.quality,s.wet,s.rain,s.storm,s.surface,s.atmosphere,s.fog,s.visibility,s.night,s.street,s.emergency,s.signal,s.reflection));return else print('[SilvaVision] svfusion on | off | reapply | show');return end;print('[SilvaVision] Final Fusion '..(F.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualFinalFusionState',function()return F.state end)
