-- SILVA VISION V0.5 MEGA BLOCK 17
-- Water / Reflection Finish Director — CLIENT ONLY / STATE ONLY.
-- Preserva o comportamento do servidor. Não escreve VisualSettings.

local Water={enabled=true,interval=450,state={wet=false,rain=false,storm=false,reflection=0.0,waterFactor=0.0,puddleFactor=0.0,visibility=1.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(old,target,k)return old+(target-old)*k end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function update()
 if not Water.enabled then return end
 local c=call('GetVisualContextBridge') or {};local a=call('GetAtmosphereState') or {};local w=c.weather or a.weather or 'CLEAR';local storm=c.storm==true or a.storm==true
 local rain=w=='RAIN' or w=='THUNDER' or w=='CLEARING';local wet=c.wet==true or rain
 local targetReflection=wet and (storm and 1.0 or 0.84) or 0.0
 local targetWater=wet and (storm and 1.0 or 0.78) or 0.0
 local targetPuddle=wet and (storm and 0.95 or 0.68) or 0.0
 local visibility=clamp(tonumber(a.visibility) or 1.0,0.55,1.0)
 Water.state.wet=wet;Water.state.rain=rain;Water.state.storm=storm
 Water.state.reflection=smooth(Water.state.reflection,targetReflection,0.14);Water.state.waterFactor=smooth(Water.state.waterFactor,targetWater,0.12);Water.state.puddleFactor=smooth(Water.state.puddleFactor,targetPuddle,0.14);Water.state.visibility=smooth(Water.state.visibility,visibility,0.12)
end
CreateThread(function()Wait(4000);while true do update();Wait(Water.interval)end end)
RegisterCommand('svwater',function(_,a)
 if a[1]=='on' then Water.enabled=true elseif a[1]=='off' then Water.enabled=false elseif a[1]=='reapply' then update() elseif a[1]=='show' or not a[1] then print(('[SilvaVision] water wet=%s rain=%s storm=%s reflection=%.2f water=%.2f puddle=%.2f visibility=%.2f'):format(tostring(Water.state.wet),tostring(Water.state.rain),tostring(Water.state.storm),Water.state.reflection,Water.state.waterFactor,Water.state.puddleFactor,Water.state.visibility));return else print('[SilvaVision] svwater on | off | reapply | show');return end
 print('[SilvaVision] Water Finish '..(Water.enabled and 'ON' or 'OFF'))
end,false)
exports('GetWaterReflectionState',function()return Water.state end)
