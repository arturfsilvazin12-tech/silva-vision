-- SILVA VISION V0.5 MEGA BLOCK 10
-- Unified diagnostics - CLIENT ONLY.

local Status={enabled=true,interval=2000,last=nil}
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function build()
 local p=call('GetVisualPolicy') or {};local c=call('GetCompatibility') or {};local f=call('GetFallbackState') or {};local a=call('GetVisualApplyState') or {};local b=call('GetVisualBudget') or {};local ba=call('GetVisualBudgetAdapter') or {};local ctx=call('GetVisualContextBridge') or {};local fin=call('GetVisualFinishState') or {};local tr=call('GetVisualTransitionState') or {};local prof=call('GetActiveProfile')
 return {phase=p.phase or '?',weather=p.weather or '?',wet=p.wet==true,interior=p.interior==true,emergency=p.emergency==true,profile=p.profile or '?',requestedProfile=prof or '?',manualProfile=call('IsProfileManual')==true,visualSettings=c.visualSettings==true,timecycle=c.timecycle==true,fallback=f.mode or '?',fallbackReason=f.reason or '?',applyEnabled=a.enabled==true,budgetTier=b.tier or '?',budgetMultiplier=b.multiplier or 1.0,adapterMultiplier=ba.multiplier or 1.0,finish=fin.finish or 0.0,night=fin.night or 0.0,wetFactor=fin.wet or 0.0,stormFactor=fin.storm or 0.0,contextIntensity=ctx.intensity or 0.0,transitionProgress=tr.progress or 0.0,transitionFrom=tr.from or '?',transitionTo=tr.to or '?',frameMs=b.frameMs or 0,lastState=a.lastStateKey or ''}
end
local function printStatus()
 local s=build();Status.last=s
 print('[SilvaVision] ===== MEGA ULTRA STATUS =====')
 print(('[SilvaVision] phase=%s weather=%s wet=%s interior=%s emergency=%s'):format(s.phase,s.weather,tostring(s.wet),tostring(s.interior),tostring(s.emergency)))
 print(('[SilvaVision] profile=%s requested=%s manual=%s'):format(s.profile,s.requestedProfile,tostring(s.manualProfile)))
 print(('[SilvaVision] visualSettings=%s timecycle=%s fallback=%s'):format(tostring(s.visualSettings),tostring(s.timecycle),s.fallback))
 print(('[SilvaVision] apply=%s budget=%s x%.2f adapter=x%.2f frame=%.2fms'):format(tostring(s.applyEnabled),s.budgetTier,s.budgetMultiplier,s.adapterMultiplier,s.frameMs))
 print(('[SilvaVision] finish=%.2f night=%.2f wet=%.2f storm=%.2f context=%.2f'):format(s.finish,s.night,s.wetFactor,s.stormFactor,s.contextIntensity))
 print(('[SilvaVision] transition=%s -> %s progress=%.2f'):format(s.transitionFrom,s.transitionTo,s.transitionProgress))
 print(('[SilvaVision] reason=%s'):format(s.fallbackReason));print('[SilvaVision] ============================')
end
CreateThread(function()Wait(7000);if Status.enabled then printStatus()end end)
RegisterCommand('svstatus',function(_,args)if args[1]=='off'then Status.enabled=false;print('[SilvaVision] Status auto OFF');return end;if args[1]=='on'then Status.enabled=true end;printStatus()end,false)
exports('GetVisualStatus',function()return Status.last or build()end)
