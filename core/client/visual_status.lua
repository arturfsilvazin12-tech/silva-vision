-- SILVA VISION V0.5 MEGA ULTRA
-- Unified diagnostics — CLIENT ONLY.

local Status={enabled=true,interval=2000,last=nil}
local function call(name,...)
 local ok,r=pcall(function() return exports['silva-vision-core'][name](...) end)
 return ok and r or nil
end
local function build()
 local p=call('GetVisualPolicy') or {}; local c=call('GetCompatibility') or {}; local f=call('GetFallbackState') or {}; local a=call('GetVisualApplyState') or {}; local b=call('GetVisualBudget') or {}; local prof=call('GetActiveProfile')
 return {
  phase=p.phase or '?',weather=p.weather or '?',wet=p.wet==true,interior=p.interior==true,emergency=p.emergency==true,
  profile=p.profile or '?',requestedProfile=prof or '?',manualProfile=call('IsProfileManual')==true,
  visualSettings=c.visualSettings==true,timecycle=c.timecycle==true,fallback=f.mode or '?',fallbackReason=f.reason or '?',
  applyEnabled=a.enabled==true,budgetTier=b.tier or '?',budgetMultiplier=b.multiplier or 1.0,frameMs=b.frameMs or 0,lastState=a.lastStateKey or ''
 }
end
local function printStatus()
 local s=build(); Status.last=s
 print('[SilvaVision] ===== MEGA ULTRA STATUS =====')
 print(('[SilvaVision] phase=%s weather=%s wet=%s interior=%s emergency=%s'):format(s.phase,s.weather,tostring(s.wet),tostring(s.interior),tostring(s.emergency)))
 print(('[SilvaVision] profile=%s requested=%s manual=%s'):format(s.profile,s.requestedProfile,tostring(s.manualProfile)))
 print(('[SilvaVision] visualSettings=%s timecycle=%s fallback=%s'):format(tostring(s.visualSettings),tostring(s.timecycle),s.fallback))
 print(('[SilvaVision] apply=%s budget=%s x%.2f frame=%.2fms'):format(tostring(s.applyEnabled),s.budgetTier,s.budgetMultiplier,s.frameMs))
 print(('[SilvaVision] reason=%s'):format(s.fallbackReason)); print('[SilvaVision] ============================')
end
CreateThread(function() Wait(7000); if Status.enabled then printStatus() end end)
RegisterCommand('svstatus',function(_,args)
 if args[1]=='off' then Status.enabled=false; print('[SilvaVision] Status auto OFF'); return end
 if args[1]=='on' then Status.enabled=true end
 printStatus()
end,false)
exports('GetVisualStatus',function() return Status.last or build() end)
