-- SILVA VISION V0.5 MEGA BLOCK 16
-- Atmosphere Director — CLIENT ONLY / STATE ONLY.
-- Leitura contextual; não altera clima do servidor nem VisualSettings.

local Atmosphere={enabled=true,interval=600,state={weather='CLEAR',fog=false,overcast=false,smog=false,rain=false,storm=false,density=0.0,sky=0.0,visibility=1.0,wetness=0.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(old,target,k)return old+(target-old)*k end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function read()
 if not Atmosphere.enabled then return end
 local c=call('GetVisualContextBridge') or {};local w=c.weather or 'CLEAR';local storm=c.storm==true
 local fog=w=='FOGGY';local overcast=w=='OVERCAST';local smog=w=='SMOG';local rain=w=='RAIN' or w=='THUNDER' or w=='CLEARING'
 local densityTarget=fog and 1.0 or (smog and 0.72 or (overcast and 0.38 or (rain and 0.18 or 0.0)))
 if storm then densityTarget=clamp(densityTarget+0.10,0,1) end
 local skyTarget=overcast and 0.72 or (fog and 0.55 or (smog and 0.48 or (storm and 0.60 or 1.0)))
 local visibilityTarget=fog and 0.62 or (smog and 0.72 or (overcast and 0.86 or (storm and 0.80 or 1.0)))
 local wetTarget=rain and (storm and 1.0 or 0.75) or 0.0
 Atmosphere.state.weather=w;Atmosphere.state.fog=fog;Atmosphere.state.overcast=overcast;Atmosphere.state.smog=smog;Atmosphere.state.rain=rain;Atmosphere.state.storm=storm
 Atmosphere.state.density=smooth(Atmosphere.state.density,densityTarget,0.14);Atmosphere.state.sky=smooth(Atmosphere.state.sky,skyTarget,0.12);Atmosphere.state.visibility=smooth(Atmosphere.state.visibility,visibilityTarget,0.14);Atmosphere.state.wetness=smooth(Atmosphere.state.wetness,wetTarget,0.16)
end
CreateThread(function()Wait(4000);while true do read();Wait(Atmosphere.interval)end end)
RegisterCommand('svatmosphere',function(_,a)
 if a[1]=='on' then Atmosphere.enabled=true elseif a[1]=='off' then Atmosphere.enabled=false elseif a[1]=='reapply' then read() elseif a[1]=='show' or not a[1] then print(('[SilvaVision] atmosphere weather=%s fog=%s overcast=%s smog=%s rain=%s storm=%s density=%.2f sky=%.2f visibility=%.2f wet=%.2f'):format(Atmosphere.state.weather,tostring(Atmosphere.state.fog),tostring(Atmosphere.state.overcast),tostring(Atmosphere.state.smog),tostring(Atmosphere.state.rain),tostring(Atmosphere.state.storm),Atmosphere.state.density,Atmosphere.state.sky,Atmosphere.state.visibility,Atmosphere.state.wetness));return else print('[SilvaVision] svatmosphere on | off | reapply | show');return end
 print('[SilvaVision] Atmosphere Director '..(Atmosphere.enabled and 'ON' or 'OFF'))
end,false)
exports('GetAtmosphereState',function()return Atmosphere.state end)
