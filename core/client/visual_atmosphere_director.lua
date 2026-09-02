-- SILVA VISION V0.5 MEGA BLOCK 26
-- Atmosphere Director — CLIENT ONLY / STATE ONLY.
-- Coordena visibilidade, neblina, chuva, tempestade e pressão atmosférica.
-- Observa o clima existente; nunca força weather do servidor.

local A={enabled=true,interval=350,state={fog=0.0,overcast=0.0,rain=0.0,storm=0.0,visibility=1.0,sky=1.0,atmosphere=0.0,lightning=0.0,quality=1.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not A.enabled then return end
 local fx=call('GetVisualWeatherFXState') or {};local wb=call('GetVisualWeatherBlendState') or {};local at=call('GetAtmosphereState') or {};local b=call('GetVisualBudget') or {}
 local fog=clamp(math.max(tonumber(fx.fog) or 0,tonumber(wb.fog) or 0,tonumber(at.fog) or 0),0,1);local over=clamp(math.max(tonumber(fx.overcast) or 0,tonumber(wb.overcast) or 0,tonumber(at.overcast) or 0),0,1);local rain=clamp(math.max(tonumber(fx.rain) or 0,tonumber(wb.rain) or 0,tonumber(at.rain) or 0),0,1);local storm=clamp(math.max(tonumber(fx.storm) or 0,tonumber(wb.storm) or 0,tonumber(at.storm) or 0),0,1);local vis=clamp(tonumber(fx.visibility) or tonumber(at.visibility) or 1,0.55,1);local lightning=clamp(math.max(tonumber(fx.lightning) or 0,storm*0.82),0,1);local q=clamp(tonumber(b.multiplier) or 1,0.72,1)
 A.state.fog=smooth(A.state.fog,fog,0.12);A.state.overcast=smooth(A.state.overcast,over,0.12);A.state.rain=smooth(A.state.rain,rain,0.14);A.state.storm=smooth(A.state.storm,storm,0.15);A.state.visibility=smooth(A.state.visibility,vis,0.12);A.state.lightning=smooth(A.state.lightning,lightning,0.18);A.state.sky=smooth(A.state.sky,clamp(1-A.state.overcast*0.20-A.state.fog*0.08,0.70,1),0.12);A.state.atmosphere=smooth(A.state.atmosphere,clamp(A.state.fog*0.48+A.state.overcast*0.22+A.state.rain*0.16+A.state.storm*0.14,0,1),0.12);A.state.quality=q
end
CreateThread(function()Wait(9800);while true do tick();Wait(A.interval)end end)
RegisterCommand('svatmosphere',function(_,a)if a[1]=='on'then A.enabled=true elseif a[1]=='off'then A.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=A.state;print(('[SilvaVision] atmosphere=%.2f fog=%.2f rain=%.2f storm=%.2f vis=%.2f lightning=%.2f'):format(s.atmosphere,s.fog,s.rain,s.storm,s.visibility,s.lightning));return else print('[SilvaVision] svatmosphere on | off | reapply | show');return end;print('[SilvaVision] Atmosphere Director '..(A.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualAtmosphereDirectorState',function()return A.state end)
