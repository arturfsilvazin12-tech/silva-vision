-- SILVA VISION V0.5 MEGA BLOCK 26
-- Emergency Contrast Director — CLIENT ONLY / STATE ONLY.
-- Aumenta a prontidão visual para cenas de emergência sem criar sirene,
-- emissive, entidades ou mudanças de gameplay.

local E={enabled=true,interval=250,state={active=0.0,night=0.0,wet=0.0,signal=0.0,contrast=1.0,reflection=0.0,priority=0.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not E.enabled then return end
 local e=call('GetVisualEmergencySceneState') or {};local c=call('GetVisualComposerState') or {};local s=call('GetVisualSceneState') or {};local w=call('GetVisualWeatherBlendState') or {}
 local active=clamp(tonumber(e.active) or tonumber(c.emergency) or 0,0,1);local night=clamp(tonumber(e.night) or tonumber(c.night) or 0,0,1);local wet=clamp(tonumber(e.wet) or tonumber(w.wet) or 0,0,1);local signal=clamp(tonumber(e.signal) or active*(0.45+night*0.35+wet*0.20),0,1);local refl=clamp(tonumber(e.reflection) or signal*(0.55+wet*0.35),0,1)
 E.state.active=smooth(E.state.active,active,0.18);E.state.night=smooth(E.state.night,night,0.12);E.state.wet=smooth(E.state.wet,wet,0.12);E.state.signal=smooth(E.state.signal,signal,0.18);E.state.reflection=smooth(E.state.reflection,refl,0.16);E.state.contrast=smooth(E.state.contrast,clamp(1+E.state.signal*0.10+E.state.night*0.03,1,1.13),0.14);E.state.priority=clamp(E.state.signal*0.70+E.state.reflection*0.30+(tonumber(s.emergency) or 0)*0.10,0,1)
end
CreateThread(function()Wait(8000);while true do tick();Wait(E.interval)end end)
RegisterCommand('svecontrast',function(_,a)if a[1]=='on'then E.enabled=true elseif a[1]=='off'then E.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=E.state;print(('[SilvaVision] emergency contrast active=%.2f signal=%.2f contrast=%.2f reflection=%.2f priority=%.2f'):format(s.active,s.signal,s.contrast,s.reflection,s.priority));return else print('[SilvaVision] svecontrast on | off | reapply | show');return end;print('[SilvaVision] Emergency Contrast '..(E.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualEmergencyContrastState',function()return E.state end)
