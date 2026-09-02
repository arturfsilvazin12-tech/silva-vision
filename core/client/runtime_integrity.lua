-- SILVA VISION V0.5 MEGA BLOCK 18
-- Runtime Integrity — CLIENT ONLY / DIAGNOSTIC ONLY.
-- Verifica o grafo de exports depois que todos os client_scripts carregaram.
-- Não escreve VisualSettings, não força clima e não altera estado do servidor.

local Integrity={
 enabled=true,
 ready=false,
 checkedAt=0,
 total=0,
 ok=0,
 missing=0,
 state='WAITING',
 missingExports={}
}

local required={
 'GetVisualPolicy',
 'GetProfiles',
 'GetVisualBudget',
 'GetVisualBudgetAdapter',
 'GetVisualContextBridge',
 'GetVisualFinishState',
 'GetVisualTransitionState',
 'GetVisualQualityContext',
 'GetWeatherFinishState',
 'GetAtmosphereState',
 'GetWaterReflectionState',
 'GetTunnelState',
 'GetEmergencyLightingState',
 'GetVehicleLightingConfig',
 'GetMasterDirectorState',
 'GetVisualApplyState',
 'ApplyVisualSettings'
}

local function check()
 if not Integrity.enabled then return end
 Integrity.total=#required
 Integrity.ok=0
 Integrity.missing=0
 Integrity.missingExports={}
 for _,name in ipairs(required) do
  local success,result=pcall(function()
   return exports['silva-vision-core'][name]
  end)
  if success and result~=nil then
   Integrity.ok=Integrity.ok+1
  else
   Integrity.missing=Integrity.missing+1
   Integrity.missingExports[#Integrity.missingExports+1]=name
  end
 end
 Integrity.checkedAt=GetGameTimer()
 Integrity.ready=true
 Integrity.state=(Integrity.missing==0) and 'OK' or 'DEGRADED'
end

CreateThread(function()
 Wait(9000)
 check()
end)

RegisterCommand('svintegrity',function(_,args)
 local mode=args[1]
 if mode=='on' then Integrity.enabled=true;check()
 elseif mode=='off' then Integrity.enabled=false;Integrity.state='DISABLED'
 elseif mode=='recheck' then check()
 elseif mode=='show' or not mode then
  print(('[SilvaVision] integrity=%s ready=%s exports=%d/%d missing=%d'):format(Integrity.state,tostring(Integrity.ready),Integrity.ok,Integrity.total,Integrity.missing))
  if Integrity.missing>0 then print('[SilvaVision] missing='..table.concat(Integrity.missingExports,', ')) end
  return
 else
  print('[SilvaVision] svintegrity on | off | recheck | show')
  return
 end
 print(('[SilvaVision] Runtime Integrity %s'):format(Integrity.state))
end,false)

exports('GetRuntimeIntegrity',function() return Integrity end)
