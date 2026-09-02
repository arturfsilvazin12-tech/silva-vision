-- SILVA VISION V0.5 MEGA BLOCK 23
-- Weather FX Director — CLIENT ONLY / STATE ONLY.
-- Produz pesos para chuva, tempestade, neblina e céu sem forçar o weather do servidor.

local W={enabled=true,interval=400,state={rain=0.0,storm=0.0,fog=0.0,overcast=0.0,lightning=0.0,wet=0.0,visibility=1.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not W.enabled then return end
 local b=call('GetVisualWeatherBlendState') or {};local s=call('GetVisualSceneState') or {};local wb=call('GetWeatherFinishState') or {}
 local rain=clamp(tonumber(b.rain) or tonumber(wb.rain) or 0,0,1);local storm=clamp(tonumber(b.storm) or tonumber(wb.storm) or 0,0,1);local fog=clamp(tonumber(b.fog) or tonumber(wb.fog) or 0,0,1);local over=clamp(tonumber(b.overcast) or tonumber(wb.overcast) or 0,0,1);local wet=clamp(tonumber(b.wet) or tonumber(s.wet) or 0,0,1)
 W.state.rain=smooth(W.state.rain,rain,0.14);W.state.storm=smooth(W.state.storm,storm,0.16);W.state.fog=smooth(W.state.fog,fog,0.12);W.state.overcast=smooth(W.state.overcast,over,0.12);W.state.wet=smooth(W.state.wet,wet,0.14);W.state.lightning=smooth(W.state.lightning,storm*0.85,0.20);W.state.visibility=clamp(1-W.state.fog*0.30-W.state.storm*0.07-W.state.overcast*0.04,0.60,1)
end
CreateThread(function()Wait(10500);while true do tick();Wait(W.interval)end end)
RegisterCommand('svweatherfx',function(_,a)if a[1]=='on'then W.enabled=true elseif a[1]=='off'then W.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=W.state;print(('[SilvaVision] weatherfx rain=%.2f storm=%.2f fog=%.2f overcast=%.2f lightning=%.2f visibility=%.2f'):format(s.rain,s.storm,s.fog,s.overcast,s.lightning,s.visibility));return else print('[SilvaVision] svweatherfx on | off | reapply | show');return end;print('[SilvaVision] Weather FX '..(W.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualWeatherFXState',function()return W.state end)
