-- SILVA VISION V0.5 MEGA BLOCK 27
-- Runtime Integrity — CLIENT ONLY / DIAGNOSTIC ONLY.

local Integrity={enabled=true,ready=false,checkedAt=0,total=0,ok=0,missing=0,state='WAITING',missingExports={}}
local required={'GetVisualPolicy','GetProfiles','GetVisualBudget','GetVisualBudgetAdapter','GetVisualContextBridge','GetVisualFinishState','GetVisualTransitionState','GetVisualQualityContext','GetWeatherFinishState','GetAtmosphereState','GetWaterReflectionState','GetTunnelState','GetEmergencyLightingState','GetVehicleLightingConfig','GetMasterDirectorState','GetVisualApplyState','ApplyVisualSettings','GetVisualSceneState','GetVisualSunCycleState','GetVisualWeatherBlendState','GetVisualEmergencySceneState','GetVisualExposureGuardState','GetVisualReflectionDirectorState','GetVisualLightingBalanceState','GetVisualLightGovernorState','GetVisualWeatherFXState','GetVisualSurfaceResponseState','GetVisualAtmosphereDirectorState','GetVisualEmergencyContrastState','GetVisualNightCoreState','GetVisualVehicleMaterialState','GetVisualTunnelAtmosphereState','GetVisualComposerState','GetVisualFinalFusionState','GetVisualProfileDirectorState'}
local function check()
 if not Integrity.enabled then return end
 Integrity.total=#required;Integrity.ok=0;Integrity.missing=0;Integrity.missingExports={}
 for _,name in ipairs(required) do local success,result=pcall(function()return exports['silva-vision-core'][name]end);if success and result~=nil then Integrity.ok=Integrity.ok+1 else Integrity.missing=Integrity.missing+1;Integrity.missingExports[#Integrity.missingExports+1]=name end end
 Integrity.checkedAt=GetGameTimer();Integrity.ready=true;Integrity.state=(Integrity.missing==0) and 'OK' or 'DEGRADED'
end
CreateThread(function()Wait(16000);check()end)
RegisterCommand('svintegrity',function(_,a)local m=a[1];if m=='on'then Integrity.enabled=true;check()elseif m=='off'then Integrity.enabled=false;Integrity.state='DISABLED'elseif m=='recheck'then check()elseif m=='show'or not m then print(('[SilvaVision] integrity=%s ready=%s exports=%d/%d missing=%d'):format(Integrity.state,tostring(Integrity.ready),Integrity.ok,Integrity.total,Integrity.missing));if Integrity.missing>0 then print('[SilvaVision] missing='..table.concat(Integrity.missingExports,', '))end;return else print('[SilvaVision] svintegrity on | off | recheck | show');return end;print('[SilvaVision] Runtime Integrity '..Integrity.state)end,false)
exports('GetRuntimeIntegrity',function()return Integrity end)
