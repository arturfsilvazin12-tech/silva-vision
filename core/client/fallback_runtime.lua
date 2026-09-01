-- SILVA VISION V0.5
-- Fallback Runtime — CLIENT ONLY
-- Mantém o mod seguro quando uma capacidade local não estiver disponível.

local Fallback = {
    enabled = true,
    state = { mode = 'full', reason = 'initializing' }
}

local function detect()
    local compat = exports['silva-vision-core']
    if type(compat) ~= 'table' then return end

    local ok, caps = pcall(function() return compat:GetCompatibility() end)
    if not ok or type(caps) ~= 'table' then return end

    if not caps.visualSettings then
        Fallback.state.mode = 'reshade_only'
        Fallback.state.reason = 'visual_settings_unavailable'
    elseif not caps.timecycle then
        Fallback.state.mode = 'visual_runtime_limited'
        Fallback.state.reason = 'timecycle_unavailable'
    else
        Fallback.state.mode = 'full'
        Fallback.state.reason = 'all_required_capabilities_detected'
    end
end

CreateThread(function()
    Wait(2200)
    detect()
    print(('[SilvaVision] fallback=%s reason=%s'):format(Fallback.state.mode, Fallback.state.reason))
end)

RegisterCommand('svfallback', function(_, args)
    if args[1] == 'refresh' then detect()
    elseif args[1] == 'show' or not args[1] then
        print(('[SilvaVision] fallback=%s reason=%s'):format(Fallback.state.mode, Fallback.state.reason))
        return
    else
        print('[SilvaVision] svfallback refresh | show')
        return
    end
    print(('[SilvaVision] fallback=%s reason=%s'):format(Fallback.state.mode, Fallback.state.reason))
end, false)

exports('GetFallbackState', function() return Fallback.state end)
