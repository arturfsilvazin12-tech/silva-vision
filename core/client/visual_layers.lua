-- SILVA VISION V0.5 ULTRA
-- Visual Layer Registry — CLIENT ONLY
-- Define prioridade entre camadas sem forçar parâmetros desconhecidos.

local Layers = {
    { name='V04_TIMEcycle', priority=10, owner='world/timecycle' },
    { name='VISUAL_POLICY', priority=20, owner='core/client/visual_policy.lua' },
    { name='CENTRAL_APPLY', priority=30, owner='core/client/visual_apply.lua' },
    { name='RUNTIME_STATE', priority=40, owner='core/client/*runtime.lua' },
    { name='RESHADE', priority=50, owner='ReShade' },
}

local function sorted()
    local out = {}
    for i, layer in ipairs(Layers) do out[i] = layer end
    table.sort(out, function(a,b) return a.priority < b.priority end)
    return out
end

RegisterCommand('svlayers', function()
    print('[SilvaVision] ===== VISUAL LAYERS =====')
    for _, layer in ipairs(sorted()) do
        print(('[SilvaVision] %02d | %s | %s'):format(layer.priority, layer.name, layer.owner))
    end
    print('[SilvaVision] Pending settings remain blocked until validation.')
end, false)

exports('GetVisualLayers', sorted)
