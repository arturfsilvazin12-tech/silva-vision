-- SILVA VISION V0.5
-- VFX State Runtime — CLIENT ONLY
-- Estado leve para chuva/tempestade e futura integração com efeitos.

local VFX = {
    enabled = true,
    interval = 500,
    state = { rain = false, storm = false, lightning = false, intensity = 0.0 },
}

local function update()
    if not VFX.enabled then return end
    local h = GetPrevWeatherTypeHashName()
    local rain = h == GetHashKey('RAIN') or h == GetHashKey('THUNDER')
    local storm = h == GetHashKey('THUNDER')
    VFX.state.rain = rain
    VFX.state.storm = storm
    local target = storm and 1.0 or (rain and 0.65 or 0.0)
    VFX.state.intensity = VFX.state.intensity + (target - VFX.state.intensity) * 0.18
end

CreateThread(function()
    Wait(3000)
    while true do
        update()
        Wait(VFX.interval)
    end
end)

RegisterCommand('svvfx', function(_, args)
    local mode = args[1]
    if mode == 'on' then VFX.enabled = true
    elseif mode == 'off' then VFX.enabled = false
    elseif mode == 'reapply' then update()
    else print('[SilvaVision] svvfx on | off | reapply'); return end
    print(('[SilvaVision] VFX Runtime %s'):format(VFX.enabled and 'ON' or 'OFF'))
end, false)

exports('GetVFXState', function() return VFX.state end)
