-- SILVA VISION V0.5 MEGA ULTRA
-- CENTRAL VISUAL APPLY — única camada que escreve VisualSettings validados.

local Apply = { enabled=true, interval=1200, lastStateKey='', lastProfile='', lastMultiplier=1.0, writes=0 }

local function call(name,...)
    local ok,r=pcall(function() return exports['silva-vision-core'][name](...) end)
    return ok and r or nil
end
local function clamp(v,a,b) return math.max(a,math.min(b,v)) end
local function valid(name,value)
    if type(SetVisualSettingFloat)~='function' then return false end
    local ok,allowed=pcall(function() return exports['silva-vision-core']:IsVisualSettingValidated(name) end)
    if not ok or allowed~=true then return false end
    local wrote=pcall(SetVisualSettingFloat,name,value)
    if wrote then Apply.writes=Apply.writes+1 end
    return wrote
end

local function apply()
    if not Apply.enabled then return false end
    local s=call('GetVisualPolicy') or {}
    local profiles=call('GetProfiles') or {}
    local name=s.profile or 'Balanced'
    local p=profiles[name] or profiles.Balanced
    if not p then return false end

    local budget=call('GetVisualBudget') or {multiplier=1.0,tier='NATIVE'}
    local mult=clamp(tonumber(budget.multiplier) or 1.0,0.72,1.0)
    local night=s.phase=='night'
    local wet=s.wet==true
    local storm=s.weather=='THUNDER'
    local interior=s.interior==true
    local emergency=s.emergency==true

    local distant=clamp((p.distantSize or 1.05) * mult + (night and 0.04 or 0),0.90,1.20)
    local reflection=clamp((p.distantReflection or 0.85) * mult + (wet and 0.07 or 0),0.70,1.00)
    local upscale=clamp((p.distantUpscale or 1.50) * mult + (night and 0.05 or 0),1.10,1.80)
    valid('distantlights.size',distant)
    valid('distantlights.sizeReflections',reflection)
    valid('distantlights.sizeUpscale',upscale)
    valid('distantlights.sizeUpscaleReflections',clamp(upscale+(wet and 0.03 or 0),1.10,1.80))

    local rain=(p.rain or 3500.0)
    if storm then rain=rain+500.0 end
    valid('rain.NumberParticles',clamp(rain*mult,2800.0,5500.0))
    valid('rain.UseLitShader',1.0)
    valid('rain.diffuse',wet and 1.0 or 0.90)
    valid('rain.ambient',wet and (storm and 0.45 or 0.42) or 0.35)
    valid('rain.wrapScale',0.60)
    valid('rain.wrapBias',0.40)
    valid('rain.defaultlight.red',1.0); valid('rain.defaultlight.green',1.0); valid('rain.defaultlight.blue',1.0)

    local cabin=interior and 0.90 or 1.08
    valid('car.interiorlight.intensity',cabin)
    valid('car.fatinteriorlight.intensity',cabin)

    local head=(night and 1.55 or 1.45) * (0.96 + 0.04*mult)
    if emergency then head=head+0.05 end
    valid('car.headlight.HDRIntensity',clamp(head,1.35,1.65))
    valid('car.headlight.fullbeam.HDRIntensity',night and 1.18 or 1.15)

    Apply.lastProfile=name
    Apply.lastMultiplier=mult
    Apply.lastStateKey=table.concat({s.phase or '?',s.weather or '?',tostring(wet),tostring(interior),tostring(emergency),name,budget.tier or '?'},'|')
    return true
end

CreateThread(function() Wait(4500); while true do apply(); Wait(Apply.interval) end end)

RegisterCommand('svapply',function(_,args)
    local c=args[1]
    if c=='on' then Apply.enabled=true; apply()
    elseif c=='off' then Apply.enabled=false
    elseif c=='reapply' then apply()
    elseif c=='show' or not c then print(('[SilvaVision] apply=%s profile=%s budget=%.2f tier=%s writes=%d'):format(tostring(Apply.enabled),Apply.lastProfile,Apply.lastMultiplier,(call('GetVisualBudget') or {}).tier or '?',Apply.writes)); return
    else print('[SilvaVision] svapply on | off | reapply | show'); return end
end,false)

exports('ApplyVisualSettings',apply)
exports('GetVisualApplyState',function() return Apply end)
