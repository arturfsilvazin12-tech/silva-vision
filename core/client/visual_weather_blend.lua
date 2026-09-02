-- SILVA VISION V0.5 MEGA BLOCK 21
-- Weather Blend — CLIENT ONLY / STATE ONLY.
-- Normaliza clima observado em pesos estáveis para Composer/Apply.
-- Nunca força o clima do servidor.

local W={enabled=true,interval=300,state={weather='CLEAR',rain=0.0,storm=0.0,fog=0.0,overcast=0.0,wet=0.0,visibility=1.0,transition=0.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function name()
 local h=GetPrevWeatherTypeHashName();local map={[GetHashKey('RAIN')]='RAIN',[GetHashKey('THUNDER')]='THUNDER',[GetHashKey('CLEARING')]='CLEARING',[GetHashKey('FOGGY')]='FOGGY',[GetHashKey('OVERCAST')]='OVERCAST',[GetHashKey('SMOG')]='SMOG',[GetHashKey('SNOW')]='SNOW',[GetHashKey('XMAS')]='XMAS'};return map[h] or 'CLEAR'
end
local function tick()
 if not W.enabled then return end
 local s=W.state;local x=name();local rain=(x=='RAIN' or x=='THUNDER' or x=='CLEARING' or x=='SNOW' or x=='XMAS') and 1 or 0;local storm=x=='THUNDER' and 1 or 0;local fog=x=='FOGGY' and 1 or 0;local over=x=='OVERCAST' and 1 or 0
 local wet=(rain>0 and x~='SNOW' and x~='XMAS') and 1 or 0
 s.transition=smooth(s.transition,s.weather~=x and 1 or 0,0.10);s.weather=x;s.rain=smooth(s.rain,rain,0.13);s.storm=smooth(s.storm,storm,0.16);s.fog=smooth(s.fog,fog,0.12);s.overcast=smooth(s.overcast,over,0.12);s.wet=smooth(s.wet,wet,0.14);s.visibility=clamp(1.0-s.fog*0.34-s.storm*0.08-s.overcast*0.04,0.58,1.0)
end
CreateThread(function()Wait(6500);while true do tick();Wait(W.interval)end end)
RegisterCommand('svweatherblend',function(_,a)if a[1]=='on'then W.enabled=true elseif a[1]=='off'then W.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=W.state;print(('[SilvaVision] weatherblend=%s rain=%.2f storm=%.2f fog=%.2f overcast=%.2f wet=%.2f visibility=%.2f'):format(s.weather,s.rain,s.storm,s.fog,s.overcast,s.wet,s.visibility));return else print('[SilvaVision] svweatherblend on | off | reapply | show');return end;print('[SilvaVision] Weather Blend '..(W.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualWeatherBlendState',function()return W.state end)
