-- SILVA VISION V0.5 MEGA BLOCK 03
-- Budget Adapter — CLIENT ONLY
-- Produces safe multipliers for Central Apply; never writes VisualSettings.

local State={enabled=true,multiplier=1.0,frameMs=0.0,lastChange=0}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function readBudget()
 local ok,b=pcall(function() return exports['silva-vision-core']:GetVisualBudget() end)
 if ok and type(b)=='table' and type(b.multiplier)=='number' then return clamp(b.multiplier,0.70,1.00) end
 return 1.0
end
CreateThread(function()
 Wait(3500)
 while true do
  if State.enabled then
   local ft=GetFrameTime()
   if type(ft)=='number' and ft>0 then State.frameMs=ft*1000 end
   local m=readBudget()
   if math.abs(m-State.multiplier)>=0.02 then State.lastChange=GetGameTimer() end
   State.multiplier=m
  end
  Wait(500)
 end
end)
RegisterCommand('svbudgetadapter',function(_,a)
 if a[1]=='on' then State.enabled=true elseif a[1]=='off' then State.enabled=false elseif a[1]=='show' then print(('[SilvaVision] BudgetAdapter enabled=%s multiplier=%.2f frame=%.2fms'):format(tostring(State.enabled),State.multiplier,State.frameMs)) else print('[SilvaVision] svbudgetadapter on | off | show') end
end,false)
exports('GetVisualBudgetAdapter',function()return State end)
