-- SILVA VISION V0.5 MEGA BLOCK 22
-- Unified diagnostics - CLIENT ONLY.
-- Observabilidade apenas; não altera clima nem VisualSettings.

local Status={enabled=true,interval=2000,last=nil}
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function build()
 local p=call('GetVisualPolicy') or {};local c=call('GetCompatibility') or {};local f=call('GetFallbackState') or {};local a=call('GetVisualApplyState') or {};local b=call('GetVisualBudget') or {};local ba=call('GetVisualBudgetAdapter') or {};local ctx=call('GetVisualContextBridge') or {};local fin=call('GetVisualFinishState') or {};local tr=call('GetVisualTransitionState') or {};local wf=call('GetWeatherFinishState') or {};local md=call('GetMasterDirectorState') or {};local sc=call('GetVisualSceneState') or {};local sun=call('GetVisualSunCycleState') or {};local wb=call('GetVisualWeatherBlendState') or {};local em=call('GetVisualEmergencySceneState') or {};local ex=call('GetVisualExposureGuardState') or {};local rd=call('GetVisualReflectionDirectorState') or {};local lb=call('GetVisualLightingBalanceState') or {};local co=call('GetVisualComposerState') or {};local pr=call('GetVisualProfileDirectorState') or {};local integ=call('GetRuntimeIntegrity') or {};local prof=call('GetActiveProfile')
 return {phase=p.phase or md.phase or sc.phase or sun.phase or '?',weather=p.weather or wb.weather or wf.weather or md.weather or sc.weather or '?',wet=p.wet==true or (tonumber(wb.wet) or 0)>0.5 or (tonumber(wf.wet) or 0)>0.5,interior=p.interior==true,emergency=p.emergency==true or (tonumber(em.active) or 0)>0.5,profile=p.profile or md.profile or '?',requestedProfile=prof or '?',recommendedProfile=pr.recommended or '?',recommendationReason=pr.reason or '?',manualProfile=call('IsProfileManual')==true,visualSettings=c.visualSettings==true,timecycle=c.timecycle==true,fallback=f.mode or '?',fallbackReason=f.reason or '?',applyEnabled=a.enabled==true,budgetTier=b.tier or '?',budgetMultiplier=b.multiplier or 1.0,adapterMultiplier=ba.multiplier or 1.0,finish=fin.finish or wf.finish or 0.0,night=co.night or sun.night or wb.night or fin.night or md.night or sc.night or 0.0,wetFactor=co.wet or wb.wet or wf.wet or md.wetFactor or sc.wet or 0.0,stormFactor=co.storm or wb.storm or wf.storm or md.storm or sc.storm or 0.0,fog=co.fog or wb.fog or wf.fog or sc.fog or 0.0,overcast=wb.overcast or wf.overcast or sc.overcast or 0.0,reflection=rd.reflection or wf.reflection or co.reflection or 0.0,solar=sun.solar or co.solar or 1.0,golden=sun.golden or co.golden or 0.0,emergencySignal=em.signal or co.emergency or 0.0,exposure=ex.factor or co.exposure or 1.0,lightingBalance=lb.balance or co.balance or 1.0,waterReflection=rd.water or 0.0,puddleFactor=rd.puddle or 0.0,contextIntensity=ctx.intensity or 0.0,transitionProgress=tr.progress or 0.0,transitionFrom=tr.from or '?',transitionTo=tr.to or '?',masterQuality=md.quality or 1.0,composerQuality=co.quality or 1.0,sceneStreet=sc.streetDemand or 0.0,sceneAtmosphere=sc.atmosphereDemand or 0.0,sceneCinematic=sc.cinematic or 0.0,integrity=integ.state or '?',integrityOk=integ.ok or 0,integrityTotal=integ.total or 0,frameMs=b.frameMs or 0,lastState=a.lastStateKey or ''}
end
local function printStatus()
 local s=build();Status.last=s
 print('[SilvaVision] ===== MEGA BLOCK 22 STATUS =====')
 print(('[SilvaVision] scene=%s %02d:00 weather=%s wet=%s interior=%s emergency=%s'):format(s.phase,GetClockHours(),s.weather,tostring(s.wet),tostring(s.interior),tostring(s.emergency)))
 print(('[SilvaVision] solar=%.2f golden=%.2f exposure=%.2f balance=%.2f'):format(s.solar,s.golden,s.exposure,s.lightingBalance))
 print(('[SilvaVision] profile=%s requested=%s recommended=%s (%s) manual=%s'):format(s.profile,s.requestedProfile,s.recommendedProfile,s.recommendationReason,tostring(s.manualProfile)))
 print(('[SilvaVision] integrity=%s %d/%d | visualSettings=%s timecycle=%s fallback=%s'):format(s.integrity,s.integrityOk,s.integrityTotal,tostring(s.visualSettings),tostring(s.timecycle),s.fallback))
 print(('[SilvaVision] apply=%s budget=%s x%.2f adapter=x%.2f frame=%.2fms'):format(tostring(s.applyEnabled),s.budgetTier,s.budgetMultiplier,s.adapterMultiplier,s.frameMs))
 print(('[SilvaVision] composer q=%.2f night=%.2f wet=%.2f storm=%.2f refl=%.2f water=%.2f puddle=%.2f'):format(s.composerQuality,s.night,s.wetFactor,s.stormFactor,s.reflection,s.waterReflection,s.puddleFactor))
 print(('[SilvaVision] scene street=%.2f atmosphere=%.2f cinematic=%.2f emergencySignal=%.2f'):format(s.sceneStreet,s.sceneAtmosphere,s.sceneCinematic,s.emergencySignal))
 print(('[SilvaVision] finish=%.2f transition=%s -> %s %.2f masterQuality=%.2f'):format(s.finish,s.transitionFrom,s.transitionTo,s.transitionProgress,s.masterQuality))
 print(('[SilvaVision] reason=%s'):format(s.fallbackReason));print('[SilvaVision] =================================')
end
CreateThread(function()Wait(11000);if Status.enabled then printStatus()end end)
RegisterCommand('svstatus',function(_,args)if args[1]=='off'then Status.enabled=false;print('[SilvaVision] Status auto OFF');return end;if args[1]=='on'then Status.enabled=true end;printStatus()end,false)
exports('GetVisualStatus',function()return Status.last or build()end)
