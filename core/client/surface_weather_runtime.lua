-- SILVA VISION V0.5 MEGA BLOCK 07
-- Surface Weather Runtime — CLIENT ONLY / STATE ONLY
-- Usa o Context Bridge como fonte principal para evitar leituras duplicadas.

local Surface={enabled=true,interval=600,state={wet=false,storm=false,rain=false,intensity=0.0}}
local function smooth(old,target,k)return old+(target-old)*k end
local function update()
 if not Surface.enabled then return end
 local ok,c=pcall(function()return exports['silva-vision-core']:GetVisualContextBridge()end)
 if not ok or type(c)~='table' then return end
 Surface.state.storm=c.storm==true
 Surface.state.rain=c.weather=='RAIN' or c.weather=='THUNDER'
 Surface.state.wet=c.wet==true
 local target=Surface.state.storm and 1.0 or (Surface.state.rain and 0.75 or (Surface.state.wet and 0.35 or 0.0))
 Surface.state.intensity=smooth(Surface.state.intensity,target,0.20)
end
CreateThread(function()Wait(4000);while true do update();Wait(Surface.interval)end end)
RegisterCommand('svsurface',function(_,a)
 if a[1]=='on' then Surface.enabled=true elseif a[1]=='off' then Surface.enabled=false elseif a[1]=='reapply' then update() elseif a[1]=='show' or not a[1] then print(('[SilvaVision] surface wet=%s rain=%s storm=%s intensity=%.2f'):format(tostring(Surface.state.wet),tostring(Surface.state.rain),tostring(Surface.state.storm),Surface.state.intensity));return else print('[SilvaVision] svsurface on | off | reapply | show');return end
 print('[SilvaVision] Surface Runtime '..(Surface.enabled and 'ON' or 'OFF'))
end,false)
exports('GetSurfaceWeatherState',function()return Surface.state end)
