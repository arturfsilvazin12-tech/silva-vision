-- SILVA VISION V0.5
-- Performance Governor — CLIENT ONLY
-- Seleciona um perfil conservador conforme frame time; não reduz resolução.

local Governor = {
    enabled = true,
    interval = 3000,
    targetMs = 16.7,
    hysteresis = 2.0,
    profile = 'Balanced',
    state = { fps = 0, frameMs = 0, profile = 'Balanced' },
}

local function choose(frameMs)
    if frameMs <= Governor.targetMs - Governor.hysteresis then return 'Quality' end
    if frameMs >= Governor.targetMs + Governor.hysteresis then return 'Performance' end
    return 'Balanced'
end

local function applyProfile(name)
    if type(ExecuteCommand) ~= 'function' then return end
    ExecuteCommand(('svprofile %s'):format(name))
    Governor.profile = name
end

local function tick()
    if not Governor.enabled then return end
    local frameMs = GetFrameTime() * 1000.0
    if frameMs <= 0 then return end
    local fps = 1000.0 / frameMs
    local nextProfile = choose(frameMs)

    Governor.state.frameMs = frameMs
    Governor.state.fps = fps
    Governor.state.profile = nextProfile

    if nextProfile ~= Governor.profile then
        applyProfile(nextProfile)
    end
end

CreateThread(function()
    Wait(5000)
    while true do
        tick()
        Wait(Governor.interval)
    end
end)

RegisterCommand('svgovernor', function(_, args)
    local mode = args[1]
    if mode == 'on' then Governor.enabled = true
    elseif mode == 'off' then Governor.enabled = false
    elseif mode == 'reapply' then tick()
    else print('[SilvaVision] svgovernor on | off | reapply'); return end
    print(('[SilvaVision] Governor %s | profile=%s'):format(Governor.enabled and 'ON' or 'OFF', Governor.profile))
end, false)

exports('GetPerformanceState', function() return Governor.state end)
