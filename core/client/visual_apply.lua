-- SILVA VISION V0.5 MEGA BLOCK 20
-- CENTRAL VISUAL APPLY - única camada que escreve VisualSettings validados.
-- Composer alimenta apenas chaves já validadas.

local Apply={enabled=true,interval=1000,lastStateKey='',lastProfile='',lastMultiplier=1.0,writes=0}
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function valid(name,value)
 if type(SetVisualSettingFloat)~='function' then return false end
 local ok,allowed=pcall(function()return exports['silva-vision-core']:IsVisualSettingValidated(name)end)
 if not ok or allowed~=true then return false end
 local wrote=pcall(SetVisualSettingFloat,name,value);if wrote then Apply.writes=Apply.writes+1 end;return wrote
end
local function apply()
 if not Apply.enabled then return false end
 local s=call('GetVisualPolicy') or {};local scene=call('GetVisualSceneState') or {};local comp=call('GetVisualComposerState') or {};local profiles=call('GetProfiles') or {}
 local name=s.profile or 'Balanced';local p=profiles[name] or profiles.Balanced;if not p then return false end
 local budget=call('GetVisualBudget') or {multiplier=1.0,tier='NATIVE'};local adapter=call('GetVisualBudgetAdapter') or {};local mult=clamp(tonumber(adapter.multiplier) or tonumber(budget.multiplier) or 1.0,0.72,1.0)
 local finish=call('GetVisualFinishState') or {};local wf=call('GetWeatherFinishState') or {};local ctx=call('GetVisualContextBridge') or {}
 local nightF=clamp(tonumber(comp.night) or tonumber(finish.night) or tonumber(scene.night) or tonumber(ctx.night) or 0,0,1)
 local wetF=clamp(tonumber(comp.wet) or tonumber(finish.wet) or tonumber(scene.wet) or tonumber(wf.wet) or 0,0,1)
 local stormF=clamp(tonumber(comp.storm) or tonumber(finish.storm) or tonumber(scene.storm) or tonumber(wf.storm) or 0,0,1)
 local reflectionF=clamp(tonumber(comp.reflection) or tonumber(wf.reflection) or tonumber(scene.reflectionDemand) or 0,0,1)
 local sceneLight=clamp(tonumber(comp.street) or tonumber(scene.streetDemand) or 0,0,1)
 local emergencyF=clamp(tonumber(finish.emergency) or tonumber(scene.emergency) or 0,0,1);local interior=s.interior==true or scene.interior>0.5
 local lightWeight=clamp(tonumber(comp.lightWeight) or mult,0.72,1.0);local rainWeight=clamp(tonumber(comp.rainWeight) or mult,0.72,1.0)
 local distant=clamp((p.distantSize or 1.05)*lightWeight+nightF*0.08+reflectionF*0.02+sceneLight*0.04,0.90,1.20)
 local reflection=clamp((p.distantReflection or 0.85)*lightWeight+wetF*0.10+stormF*0.02+reflectionF*0.05,0.70,1.00)
 local upscale=clamp((p.distantUpscale or 1.50)*lightWeight+nightF*0.10+reflectionF*0.03,1.10,1.80)
 valid('distantlights.size',distant);valid('distantlights.sizeReflections',reflection);valid('distantlights.sizeUpscale',upscale);valid('distantlights.sizeUpscaleReflections',clamp(upscale+wetF*0.04+reflectionF*0.02,1.10,1.80))
 local rain=(p.rain or 3500.0)+stormF*600.0;valid('rain.NumberParticles',clamp(rain*rainWeight,2800.0,5500.0));valid('rain.UseLitShader',1.0);valid('rain.diffuse',clamp(0.90+wetF*0.10+stormF*0.02,0.90,1.0));valid('rain.ambient',clamp(0.35+wetF*(0.08+stormF*0.03),0.35,0.46));valid('rain.wrapScale',0.60);valid('rain.wrapBias',0.40);valid('rain.defaultlight.red',1.0);valid('rain.defaultlight.green',1.0);valid('rain.defaultlight.blue',1.0)
 local cabin=interior and 0.90 or clamp(1.03+nightF*0.04+sceneLight*0.02,1.03,1.07);valid('car.interiorlight.intensity',cabin);valid('car.fatinteriorlight.intensity',cabin)
 local head=1.45+nightF*0.15+emergencyF*0.06+sceneLight*0.04;head=head*(0.96+0.04*lightWeight);valid('car.headlight.HDRIntensity',clamp(head,1.35,1.70));valid('car.headlight.fullbeam.HDRIntensity',clamp(1.15+nightF*0.05+wetF*0.02,1.15,1.20))
 Apply.lastProfile=name;Apply.lastMultiplier=mult;Apply.lastStateKey=table.concat({scene.phase or s.phase or '?',scene.weather or s.weather or '?',string.format('wet%.2f',wetF),tostring(interior),name,budget.tier or '?',string.format('street%.2f',sceneLight),string.format('refl%.2f',reflectionF)},'|');return true
end
CreateThread(function()Wait(8000);while true do apply();Wait(Apply.interval)end end)
RegisterCommand('svapply',function(_,args)local c=args[1];if c=='on' then Apply.enabled=true;apply()elseif c=='off' then Apply.enabled=false elseif c=='reapply' then apply()elseif c=='show' or not c then print(('[SilvaVision] apply=%s profile=%s budget=%.2f tier=%s writes=%d'):format(tostring(Apply.enabled),Apply.lastProfile,Apply.lastMultiplier,(call('GetVisualBudget') or {}).tier or '?',Apply.writes));return else print('[SilvaVision] svapply on | off | reapply | show');return end end,false)
exports('ApplyVisualSettings',apply);exports('GetVisualApplyState',function()return Apply end)
