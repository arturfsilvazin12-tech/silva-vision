-- SILVA VISION V0.5 MEGA BLOCK
-- White Lights Validator — CLIENT ONLY
-- Nunca aplica parâmetros pendentes. Apenas diagnostica suporte em runtime.

local State={enabled=true,last=nil,validated=0,pending=0}

local targets={
 'streetlight.color.red','streetlight.color.green','streetlight.color.blue',
 'distantlights.streetlight.HDRIntensity',
 'coronastar.size','coronastar.intensity',
 'vehicleinteriorlight.color.red','vehicleinteriorlight.color.green','vehicleinteriorlight.color.blue',
 'vehicleinteriorlight.intensity','emissive.multiplier'
}

local function test(name)
 if type(SetVisualSettingFloat)~='function' then return false end
 -- Não existe API confiável de descoberta de chave; não escrever valores especulativos.
 return false
end

local function scan()
 State.validated=0; State.pending=#targets
 State.last={}
 for _,name in ipairs(targets) do
  local ok=test(name)
  State.last[name]=ok
  if ok then State.validated=State.validated+1 end
 end
end

RegisterCommand('svwhitelights',function(_,args)
 if args[1]=='scan' then
  scan()
  print(('[SilvaVision] White Lights scan: validated=%d pending=%d'):format(State.validated,State.pending))
  print('[SilvaVision] Streetlight/corona/emissive permanecem bloqueados até validação real do visualsettings.dat.')
 elseif args[1]=='show' then
  print(('[SilvaVision] White Lights enabled=%s validated=%d pending=%d'):format(tostring(State.enabled),State.validated,State.pending))
 else
  print('[SilvaVision] svwhitelights scan | show')
 end
end,false)

CreateThread(function() Wait(2500); scan() end)
exports('GetWhiteLightsValidation',function() return State end)
