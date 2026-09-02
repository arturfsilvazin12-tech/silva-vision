-- SILVA VISION V0.5 MEGA BLOCK 25
-- CENTRAL VISUAL APPLY - única camada que escreve VisualSettings validados.
-- Integra Night Core, Vehicle Material e Tunnel Atmosphere.
-- Nenhuma chave streetlight/corona/emissive especulativa é liberada.

local Apply={enabled=true,interval=1000,lastStateKey='',lastProfile='',lastMultiplier=1.0,writes=0}
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function num(v,d)return type(v)=='number' and v or (tonumber(v) or d)end
local function flag(v,d)return v==true or (type(v)=='number' and v>0.5) or (type(v)=='string' and v=='true') or d==true end
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
 local budget=call('GetVisualBudget') or {multiplier=1.0,tier='NATIVE'};local adapter=call('GetVisualBudgetAdapter') or {};local gov=call('GetVisualLightGovernorState') or {};local mult=clamp(num(adapter.multiplier,num(budget.multiplier,1.0)),0.72,1.0)
 local finish=call('GetVisualFinishState') or {};local wf=call('GetWeatherFinishState') or {};local ctx=call('GetVisualContextBridge') or {};local sun=call('GetVisualSunCycleState') or {};local e=call('GetVisualEmergencySceneState') or {};local ex=call('GetVisualExposureGuardState') or {};local lb=call('GetVisualLightingBalanceState') or {};local fx=call('GetVisualWeatherFXState') or {}
 local nightCore=call('GetVisualNightCoreState') or {};local veh=call('GetVisualVehicleMaterialState') or {};local tunnel=call('GetVisualTunnelAtmosphereState') or {}
 local nightF=clamp(num(comp.night,num(finish.night,num(scene.night,num(ctx.night,0)))),0,1);local wetF=clamp(num(comp.wet,num(finish.wet,num(scene.wet,num(wf.wet,0)))),0,1);local stormF=clamp(num(comp.storm,num(finish.storm,num(scene.storm,num(wf.storm,0)))),0,1);local reflectionF=clamp(num(comp.reflection,num(wf.reflection,num(scene.reflectionDemand,0))),0,1);local sceneLight=clamp(num(comp.street,num(scene.streetDemand,num(lb.street,0))),0,1);local emergencyF=clamp(num(comp.emergency,num(e.active,num(finish.emergency,0))),0,1)
 local interior=flag(s.interior,num(scene.interior,0)>0.5);local solar=clamp(num(comp.solar,num(sun.solar,1)),0.5,1.08);local exposure=clamp(num(comp.exposure,num(ex.factor,1)),0.88,1.04);local balance=clamp(num(comp.balance,num(lb.balance,1)),0.90,1.04);local governor=clamp(num(gov.boost,1),0.72,1.18)
 local nightUrban=clamp(num(comp.nightUrban,num(nightCore.urban,0)),0,1);local vehicleWet=clamp(num(comp.vehicleWet,num(veh.wetMaterial,0)),0,1);local tunnelF=clamp(num(comp.tunnel,num(tunnel.interior,0)),0,1)
 local lightWeight=clamp(num(comp.lightWeight,mult)*balance*exposure*clamp(governor,0.78,1.08),0.72,1.0);local rainWeight=clamp(num(comp.rainWeight,mult),0.72,1.0)
 local distant=clamp(num(p.distantSize,1.05)*lightWeight+nightF*0.10+reflectionF*0.03+sceneLight*0.06+nightUrban*0.04+emergencyF*0.02,0.90,1.20);local reflection=clamp(num(p.distantReflection,0.85)*lightWeight+wetF*0.10+stormF*0.02+reflectionF*0.06+vehicleWet*0.02,0.70,1.00);local upscale=clamp(num(p.distantUpscale,1.50)*lightWeight+nightF*0.10+reflectionF*0.04,1.10,1.80)
 valid('distantlights.size',distant);valid('distantlights.sizeReflections',reflection);valid('distantlights.sizeUpscale',upscale);valid('distantlights.sizeUpscaleReflections',clamp(upscale+wetF*0.05+reflectionF*0.03,1.10,1.80))
 local rain=num(p.rain,3500)+stormF*650+clamp(num(fx.rain,0),0,1)*250;valid('rain.NumberParticles',clamp(rain*rainWeight,2800,5500));valid('rain.UseLitShader',1.0);valid('rain.diffuse',clamp(0.90+wetF*0.10+stormF*0.02,0.90,1));valid('rain.ambient',clamp(0.35+wetF*(0.08+stormF*0.03),0.35,0.46));valid('rain.wrapScale',0.60);valid('rain.wrapBias',0.40);valid('rain.defaultlight.red',1.0);valid('rain.defaultlight.green',1.0);valid('rain.defaultlight.blue',1.0)
 local cabin=interior and 0.90 or clamp(1.02+nightF*0.05+(1-solar)*0.02+emergencyF*0.01+tunnelF*0.01,1.02,1.08);cabin=cabin*clamp(num(tunnel.exposure,1),0.92,1.02)*clamp(num(tunnel.ambient,1),0.90,1.04);valid('car.interiorlight.intensity',clamp(cabin,0.86,1.08));valid('car.fatinteriorlight.intensity',clamp(cabin,0.86,1.08))
 local head=1.45+nightF*0.16+emergencyF*0.08+sceneLight*0.05+num(nightCore.headlight,0)*0.04;head=head*(0.96+0.04*lightWeight);valid('car.headlight.HDRIntensity',clamp(head,1.35,1.74));valid('car.headlight.fullbeam.HDRIntensity',clamp(1.15+nightF*0.06+wetF*0.02+num(nightCore.headlight,0)*0.02,1.15,1.22))
 Apply.lastProfile=name;Apply.lastMultiplier=mult;Apply.lastStateKey=table.concat({scene.phase or s.phase or '?',scene.weather or s.weather or '?',string.format('night%.2f',nightF),string.format('urban%.2f',nightUrban),string.format('wet%.2f',wetF),string.format('solar%.2f',solar),string.format('em%.2f',emergencyF),string.format('tunnel%.2f',tunnelF),string.format('vehwet%.2f',vehicleWet),name,budget.tier or '?'},'|');return true
end
CreateThread(function()Wait(11500);while true do apply();Wait(Apply.interval)end end)
RegisterCommand('svapply',function(_,a)local c=a[1];if c=='on'then Apply.enabled=true;apply()elseif c=='off'then Apply.enabled=false elseif c=='reapply'then apply()elseif c=='show'or not c then print(('[SilvaVision] apply=%s profile=%s budget=%.2f tier=%s writes=%d'):format(tostring(Apply.enabled),Apply.lastProfile,Apply.lastMultiplier,(call('GetVisualBudget') or {}).tier or '?',Apply.writes));return else print('[SilvaVision] svapply on | off | reapply | show');return end end,false)
exports('ApplyVisualSettings',apply);exports('GetVisualApplyState',function()return Apply end)
