-- SILVA VISION V0.5 MEGA ULTRA
-- Lighting state/config registry — CLIENT ONLY.
-- Streetlight/corona/emissive continuam PENDING até validação real.

local Lighting={
 enabled=true,
 groups={
  street={enabled=true,intensity=3.0,r=1.0,g=1.0,b=1.0},
  distant={enabled=true,size=1.05,reflection=0.85,upscale=1.50},
  corona={enabled=true,size=0.50,intensity=0.35},
  headlights={enabled=true,intensity=1.50,fullbeam=1.15},
  interior={enabled=true,intensity=1.60},
  emergency={enabled=true,intensity=1.20},
 },
 state={writer='CentralApply',pendingBlocked=true}
}

RegisterCommand('svlighting',function(_,args)
 local m=args[1]
 if m=='on' then Lighting.enabled=true
 elseif m=='off' then Lighting.enabled=false
 elseif m=='show' or not m then print(('[SilvaVision] lighting=%s | central-writer=ON | pending-blocked=YES'):format(Lighting.enabled and 'ON' or 'OFF')); return
 elseif m=='reapply' then pcall(function() exports['silva-vision-core']:ApplyVisualSettings() end)
 else print('[SilvaVision] svlighting on | off | reapply | show'); return end
 print(('[SilvaVision] lighting=%s'):format(Lighting.enabled and 'ON' or 'OFF'))
end,false)

exports('ApplyLighting',function() return pcall(function() return exports['silva-vision-core']:ApplyVisualSettings() end) end)
exports('GetLightingConfig',function() return Lighting end)
