-- SILVA VISION V0.5 MEGA BLOCK 07
-- Atmosphere Runtime — CLIENT ONLY / STATE ONLY
-- Mantém leitura atmosférica leve e evita alterar clima do servidor.

local Atmosphere={enabled=true,interval=900,state={fog=false,overcast=false,smog=false,rain=false,density=0.0}}
local function smooth(old,target,k)return old+(target-old)*k end
local function read()
 if not Atmosphere.enabled then return end
 local ok,c=pcall(function()return exports['silva-vision-core']:GetVisualContextBridge()end)
 if not ok or type(c)~='table' then return end
 local w=c.weather or 'CLEAR'
 Atmosphere.state.fog=w=='FOGGY'
 Atmosphere.state.overcast=w=='OVERCAST'
 Atmosphere.state.smog=w=='SMOG'
 Atmosphere.state.rain=w=='RAIN' or w=='THUNDER'
 local target=Atmosphere.state.fog and 1.0 or (Atmosphere.state.smog and 0.65 or (Atmosphere.state.overcast and 0.35 or (Atmosphere.state.rain and 0.20 or 0.0)))
 if c.storm then target=math.min(1.0,target+0.08) end
 Atmosphere.state.density=smooth(Atmosphere.state.density,target,0.15)
end
CreateThread(function()Wait(4000);while true do read();Wait(Atmosphere.interval)end end)
RegisterCommand('svatmosphere',function(_,a)
 if a[1]=='on' then Atmosphere.enabled=true elseif a[1]=='off' then Atmosphere.enabled=false elseif a[1]=='reapply' then read() elseif a[1]=='show' or not a[1] then print(('[SilvaVision] atmosphere fog=%s overcast=%s smog=%s rain=%s density=%.2f'):format(tostring(Atmosphere.state.fog),tostring(Atmosphere.state.overcast),tostring(Atmosphere.state.smog),tostring(Atmosphere.state.rain),Atmosphere.state.density));return else print('[SilvaVision] svatmosphere on | off | reapply | show');return end
 print('[SilvaVision] Atmosphere Runtime '..(Atmosphere.enabled and 'ON' or 'OFF'))
end,false)
exports('GetAtmosphereState',function()return Atmosphere.state end)
