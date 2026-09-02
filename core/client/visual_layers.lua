-- SILVA VISION V0.5 MEGA BLOCK 29
-- Visual Layer Registry — CLIENT ONLY.
-- Prioridade explícita; somente Central Apply escreve VisualSettings.

local Layers={
 {name='V04_TIMEcycle',priority=10,owner='world/timecycle'},
 {name='VISUAL_POLICY',priority=20,owner='core/client/visual_policy.lua'},
 {name='SCENE_CONTEXT',priority=24,owner='core/client/visual_scene_director.lua'},
 {name='SOLAR_CYCLE',priority=25,owner='core/client/visual_sun_cycle.lua'},
 {name='WEATHER_BLEND',priority=25,owner='core/client/visual_weather_blend.lua'},
 {name='WEATHER_FX',priority=25,owner='core/client/visual_weather_fx.lua'},
 {name='SURFACE_RESPONSE',priority=25,owner='core/client/visual_surface_response.lua'},
 {name='RAIN_SURFACE',priority=25,owner='core/client/visual_rain_surface_director.lua'},
 {name='ATMOSPHERE_DIRECTOR',priority=25,owner='core/client/visual_atmosphere_director.lua'},
 {name='REFLECTION_DIRECTOR',priority=25,owner='core/client/visual_reflection_director.lua'},
 {name='LIGHT_GOVERNOR',priority=25,owner='core/client/visual_light_governor.lua'},
 {name='NIGHT_CORE',priority=25,owner='core/client/visual_night_core.lua'},
 {name='VEHICLE_MATERIAL',priority=25,owner='core/client/visual_vehicle_material.lua'},
 {name='TUNNEL_ATMOSPHERE',priority=25,owner='core/client/visual_tunnel_atmosphere.lua'},
 {name='EMERGENCY_SCENE',priority=25,owner='core/client/visual_emergency_scene.lua'},
 {name='EMERGENCY_CONTRAST',priority=25,owner='core/client/visual_emergency_contrast.lua'},
 {name='VISUAL_COMPOSER',priority=26,owner='core/client/visual_composer.lua'},
 {name='FINAL_FUSION',priority=27,owner='core/client/visual_final_fusion.lua'},
 {name='PROFILE_DIRECTOR',priority=28,owner='core/client/visual_profile_director.lua'},
 {name='CENTRAL_APPLY',priority=30,owner='core/client/visual_apply.lua'},
 {name='RUNTIME_STATE',priority=40,owner='core/client/*runtime.lua'},
 {name='RESHADE',priority=50,owner='ReShade'},
}
local function sorted()
 local out={};for i,l in ipairs(Layers) do out[i]=l end;table.sort(out,function(a,b)return a.priority<b.priority end);return out
end
RegisterCommand('svlayers',function()print('[SilvaVision] ===== VISUAL LAYERS MEGA 29 =====');for _,l in ipairs(sorted()) do print(('[SilvaVision] %02d | %s | %s'):format(l.priority,l.name,l.owner))end;print('[SilvaVision] Streetlight/corona/emissive seguem bloqueados até validação real.')end,false)
exports('GetVisualLayers',sorted)
