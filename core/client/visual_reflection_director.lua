-- SILVA VISION V0.5 MEGA BLOCK 22
-- Reflection Director — CLIENT ONLY / STATE ONLY.
-- Coordena reflexo distante, chuva e água sem criar writes especulativos.

local R={enabled=true,interval=300,state={wet=0.0,storm=0.0,reflection=0.0,water=0.0,puddle=0.0,quality=1.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not R.enabled then return end
 local wb=call('GetVisualWeatherBlendState') or {};local water=call('GetWaterReflectionState') or {};local b=call('GetVisualBudget') or {}
 local wet=clamp(tonumber(wb.wet) or 0,0,1);local storm=clamp(tonumber(wb.storm) or 0,0,1);local wr=clamp(tonumber(water.reflection) or 0,0,1);local wp=clamp(tonumber(water.puddleFactor) or 0,0,1);local q=clamp(tonumber(b.multiplier) or 1,0.72,1)
 R.state.wet=smooth(R.state.wet,wet,0.16);R.state.storm=smooth(R.state.storm,storm,0.16);R.state.reflection=smooth(R.state.reflection,math.max(wr,wet*0.72+storm*0.12),0.14);R.state.water=smooth(R.state.water,clamp(wr+wet*0.12,0,1),0.14);R.state.puddle=smooth(R.state.puddle,clamp(wp+wet*0.18,0,1),0.14);R.state.quality=q
end
CreateThread(function()Wait(9000);while true do tick();Wait(R.interval)end end)
RegisterCommand('svreflection',function(_,a)if a[1]=='on'then R.enabled=true elseif a[1]=='off'then R.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=R.state;print(('[SilvaVision] reflection=%.2f water=%.2f puddle=%.2f wet=%.2f storm=%.2f'):format(s.reflection,s.water,s.puddle,s.wet,s.storm));return else print('[SilvaVision] svreflection on | off | reapply | show');return end;print('[SilvaVision] Reflection Director '..(R.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualReflectionDirectorState',function()return R.state end)
