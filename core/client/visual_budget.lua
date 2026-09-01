-- SILVA VISION V0.5 MEGA ULTRA
-- Adaptive visual budget — CLIENT ONLY
-- Não troca perfil nem altera resolução. Entrega apenas um multiplicador ao Central Apply.

local Budget = {
    enabled = true,
    interval = 750,
    targetMs = 16.7,
    smoothedMs = 16.7,
    multiplier = 1.0,
    tier = 'NATIVE',
    state = { frameMs=0, fps=0, smoothedMs=16.7, multiplier=1.0, tier='NATIVE' }
}

local function clamp(v,a,b) return math.max(a, math.min(b,v)) end

local function sample()
    if not Budget.enabled or type(GetFrameTime) ~= 'function' then return end
    local ms = GetFrameTime() * 1000.0
    if ms <= 0 then return end
    Budget.smoothedMs = Budget.smoothedMs * 0.88 + ms * 0.12

    local m, tier
    if Budget.smoothedMs <= 14.5 then m, tier = 1.00, 'NATIVE'
    elseif Budget.smoothedMs <= 17.5 then m, tier = 0.94, 'LIGHT'
    elseif Budget.smoothedMs <= 21.0 then m, tier = 0.84, 'MEDIUM'
    else m, tier = 0.74, 'HEAVY' end

    Budget.multiplier = m
    Budget.tier = tier
    Budget.state.frameMs = ms
    Budget.state.fps = 1000.0 / ms
    Budget.state.smoothedMs = Budget.smoothedMs
    Budget.state.multiplier = m
    Budget.state.tier = tier
end

CreateThread(function()
    Wait(6000)
    while true do sample(); Wait(Budget.interval) end
end)

RegisterCommand('svbudget', function(_, args)
    local mode = args[1]
    if mode == 'on' then Budget.enabled = true
    elseif mode == 'off' then Budget.enabled = false; Budget.multiplier = 1.0; Budget.tier = 'DISABLED'
    elseif mode == 'reapply' then sample()
    elseif mode == 'show' or not mode then
        print(('[SilvaVision] budget=%s tier=%s frame=%.2fms smooth=%.2fms multiplier=%.2f'):format(
            Budget.enabled and 'ON' or 'OFF', Budget.tier, Budget.state.frameMs, Budget.state.smoothedMs, Budget.multiplier))
        return
    else print('[SilvaVision] svbudget on | off | reapply | show'); return end
    print(('[SilvaVision] Budget %s'):format(Budget.enabled and 'ON' or 'OFF'))
end, false)

exports('GetVisualBudget', function() return Budget.state end)
exports('GetVisualBudgetMultiplier', function() return Budget.multiplier end)
