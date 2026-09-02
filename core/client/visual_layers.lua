-- SILVA VISION V0.5 MEGA BLOCK 20
-- Visual Layer Registry — CLIENT ONLY.
-- Prioridade explícita; somente Central Apply escreve VisualSettings.

local Layers={
 {name='V04_TIMEcycle',priority=10,owner='world/timecycle'},
 {name='VISUAL_POLICY',priority=20,owner='core/client/visual_policy.lua'},
 {name='SCENE_CONTEXT',priority=24,owner='core/client/visual_scene_director.lua'},
 {name='VISUAL_COMPOSER',priority=26,owner='core/client/visual_composer.lua'},
 {name='PROFILE_DIRECTOR',priority=27,owner='core/client/visual_profile_director.lua'},
 {name='CENTRAL_APPLY',priority=30,owner='core/client/visual_apply.lua'},
 {name='RUNTIME_STATE',priority=40,owner='core/client/*runtime.lua'},
 {name='RESHADE',priority=50,owner='ReShade'},
}
local function sorted()
 local out={};for i,l in ipairs(Layers) do out[i]=l end;table.sort(out,function(a,b)return a.priority<b.priority end);return out
end
RegisterCommand('svlayers',function()print('[SilvaVision] ===== VISUAL LAYERS =====');for _,l in ipairs(sorted()) do print(('[SilvaVision] %02d | %s | %s'):format(l.priority,l.name,l.owner))end;print('[SilvaVision] Pending settings remain blocked until validation.')end,false)
exports('GetVisualLayers',sorted)
