-- SILVA VISION V0.5 MEGA ULTRA
-- Performance Governor — CLIENT ONLY.
-- Não troca o perfil automaticamente: o Adaptive Budget faz ajuste fino sem brigar com svprofile.

local Governor={enabled=false,interval=2000,targetMs=16.7,hysteresis=2.0,state={fps=0,frameMs=0,profile='manual',automatic=false}}

local function tick()
 if not Governor.enabled or type(GetFrameTime)~='function' then return end
 local ms=GetFrameTime()*1000.0
 if ms<=0 then return end
 Governor.state.frameMs=ms; Governor.state.fps=1000.0/ms; Governor.state.profile='manual'; Governor.state.automatic=false
end

CreateThread(function() Wait(6000); while true do tick(); Wait(Governor.interval) end end)
RegisterCommand('svgovernor',function(_,args)
 local m=args[1]
 if m=='on' then Governor.enabled=true elseif m=='off' then Governor.enabled=false elseif m=='reapply' then tick() elseif m=='show' or not m then print(('[SilvaVision] Governor=%s | profile changes=OFF | use svbudget for adaptive scaling'):format(Governor.enabled and 'ON' or 'OFF')); return else print('[SilvaVision] svgovernor on | off | reapply | show'); return end
 print(('[SilvaVision] Governor %s'):format(Governor.enabled and 'ON' or 'OFF'))
end,false)
exports('GetPerformanceState',function() return Governor.state end)
