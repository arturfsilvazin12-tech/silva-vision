-- SILVA VISION V0.5 MEGA BLOCK 22
-- Exposure Guard — CLIENT ONLY / STATE ONLY.
-- Evita extremos de exposição sem escrever VisualSettings.

local G={enabled=true,interval=350,state={factor=1.0,night=0.0,wet=0.0,fog=0.0,interior=0.0,limit=1.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not G.enabled then return end
 local s=call('GetVisualSceneState') or {};local sun=call('GetVisualSunCycleState') or {};local wb=call('GetVisualWeatherBlendState') or {}
 local night=clamp(tonumber(sun.night) or tonumber(s.night) or 0,0,1);local wet=clamp(tonumber(wb.wet) or 0,0,1);local fog=clamp(tonumber(wb.fog) or 0,0,1);local inside=clamp(tonumber(s.interior) or 0,0,1)
 local target=1.0-night*0.06-wet*0.02-fog*0.04+inside*0.04
 G.state.factor=smooth(G.state.factor,clamp(target,0.88,1.04),0.14);G.state.night=night;G.state.wet=wet;G.state.fog=fog;G.state.interior=inside;G.state.limit=clamp(1.0-fog*0.08+inside*0.03,0.88,1.03)
end
CreateThread(function()Wait(9000);while true do tick();Wait(G.interval)end end)
RegisterCommand('svexposure',function(_,a)if a[1]=='on'then G.enabled=true elseif a[1]=='off'then G.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=G.state;print(('[SilvaVision] exposure factor=%.2f limit=%.2f night=%.2f wet=%.2f fog=%.2f interior=%.2f'):format(s.factor,s.limit,s.night,s.wet,s.fog,s.interior));return else print('[SilvaVision] svexposure on | off | reapply | show');return end;print('[SilvaVision] Exposure Guard '..(G.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualExposureGuardState',function()return G.state end)
