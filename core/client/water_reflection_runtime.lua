-- SILVA VISION V0.5 MEGA BLOCK 07
-- Water / Reflection Runtime — CLIENT ONLY / STATE ONLY
-- Preserva reflexos e usa o contexto compartilhado. Não escreve VisualSettings.

local Water={enabled=true,interval=700,state={wet=false,rain=false,reflection=0.0}}
local function smooth(old,target,k)return old+(target-old)*k end
local function update()
 if not Water.enabled then return end
 local ok,c=pcall(function()return exports['silva-vision-core']:GetVisualContextBridge()end)
 if not ok or type(c)~='table' then return end
 Water.state.rain=c.weather=='RAIN' or c.weather=='THUNDER'
 Water.state.wet=c.wet==true
 local target=Water.state.wet and (c.storm and 1.0 or 0.82) or 0.0
 Water.state.reflection=smooth(Water.state.reflection,target,0.10)
end
CreateThread(function()Wait(4000);while true do update();Wait(Water.interval)end end)
RegisterCommand('svwater',function(_,a)
 if a[1]=='on' then Water.enabled=true elseif a[1]=='off' then Water.enabled=false elseif a[1]=='reapply' then update() elseif a[1]=='show' or not a[1] then print(('[SilvaVision] water wet=%s rain=%s reflection=%.2f'):format(tostring(Water.state.wet),tostring(Water.state.rain),Water.state.reflection));return else print('[SilvaVision] svwater on | off | reapply | show');return end
 print('[SilvaVision] Water Runtime '..(Water.enabled and 'ON' or 'OFF'))
end,false)
exports('GetWaterReflectionState',function()return Water.state end)
