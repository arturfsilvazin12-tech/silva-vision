-- SILVA VISION V0.5 MEGA BLOCK 06
-- Visual Finish Director — CLIENT ONLY / STATE ONLY
-- Prepara fatores para acabamento sem escrever VisualSettings.

local Finish={enabled=true,interval=700,state={night=0.0,wet=0.0,storm=0.0,emergency=0.0,interior=0.0,finish=0.0}}
local function smooth(old,target,k)return old+(target-old)*k end
local function update()
 if not Finish.enabled then return end
 local ok,c=pcall(function()return exports['silva-vision-core']:GetVisualContextBridge()end)
 if not ok or type(c)~='table' then return end
 Finish.state.night=smooth(Finish.state.night,tonumber(c.night) or 0,0.12)
 Finish.state.wet=smooth(Finish.state.wet,c.wet and 1 or 0,0.16)
 Finish.state.storm=smooth(Finish.state.storm,c.storm and 1 or 0,0.18)
 Finish.state.emergency=smooth(Finish.state.emergency,c.emergency and 1 or 0,0.18)
 Finish.state.interior=smooth(Finish.state.interior,c.interior and 1 or 0,0.18)
 local target=Finish.state.night*0.50+Finish.state.wet*0.22+Finish.state.storm*0.10+Finish.state.emergency*0.18
 if Finish.state.interior>0.5 then target=target*0.55 end
 Finish.state.finish=smooth(Finish.state.finish,target,0.12)
end
CreateThread(function()Wait(4500);while true do update();Wait(Finish.interval)end end)
RegisterCommand('svfinish',function(_,a)
 if a[1]=='on' then Finish.enabled=true elseif a[1]=='off' then Finish.enabled=false elseif a[1]=='show' or not a[1] then print(('[SilvaVision] finish=%.2f night=%.2f wet=%.2f storm=%.2f emergency=%.2f interior=%.2f'):format(Finish.state.finish,Finish.state.night,Finish.state.wet,Finish.state.storm,Finish.state.emergency,Finish.state.interior));return else print('[SilvaVision] svfinish on | off | show');return end
 print('[SilvaVision] Finish Director '..(Finish.enabled and 'ON' or 'OFF'))
end,false)
exports('GetVisualFinishState',function()return Finish.state end)
