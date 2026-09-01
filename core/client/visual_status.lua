-- SILVA VISION V0.5
-- Visual Status — CLIENT ONLY
-- Diagnóstico centralizado para testes no FiveM.

local Status = {
    enabled = true,
    interval = 2000,
    last = nil,
}

local function callExport(name, ...)
    local ok, result = pcall(function()
        return exports['silva-vision-core'][name](...)
    end)
    if ok then return result end
    return nil
end

local function build()
    local policy = callExport('GetVisualPolicy') or {}
    local compat = callExport('GetCompatibility') or {}
    local fallback = callExport('GetFallbackState') or {}
    local apply = callExport('GetVisualApplyState') or {}

    return {
        phase = policy.phase or 'unknown',
        weather = policy.weather or 'unknown',
        wet = policy.wet == true,
        interior = policy.interior == true,
        emergency = policy.emergency == true,
        profile = policy.profile or 'unknown',
        visualSettings = compat.visualSettings == true,
        timecycle = compat.timecycle == true,
        fallback = fallback.mode or 'unknown',
        fallbackReason = fallback.reason or 'unknown',
        applyEnabled = apply.enabled == true,
        lastState = apply.lastStateKey or '',
    }
end

local function printStatus()
    local s = build()
    Status.last = s
    print('[SilvaVision] ===== STATUS =====')
    print(('[SilvaVision] phase=%s weather=%s wet=%s interior=%s emergency=%s profile=%s'):format(
        s.phase, s.weather, tostring(s.wet), tostring(s.interior), tostring(s.emergency), s.profile))
    print(('[SilvaVision] visualSettings=%s timecycle=%s fallback=%s'):format(
        tostring(s.visualSettings), tostring(s.timecycle), s.fallback))
    print(('[SilvaVision] fallbackReason=%s apply=%s'):format(s.fallbackReason, tostring(s.applyEnabled)))
    print('[SilvaVision] ==================')
end

CreateThread(function()
    Wait(7000)
    if Status.enabled then printStatus() end
end)

RegisterCommand('svstatus', function(_, args)
    if args[1] == 'off' then Status.enabled = false; print('[SilvaVision] Status auto OFF'); return end
    if args[1] == 'on' then Status.enabled = true; print('[SilvaVision] Status auto ON') end
    printStatus()
end, false)

exports('GetVisualStatus', function()
    return Status.last or build()
end)
