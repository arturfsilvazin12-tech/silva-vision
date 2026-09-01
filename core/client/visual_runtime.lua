-- SILVA VISION V0.5
-- Runtime visual layer — CLIENT ONLY
-- Não substitui visualsettings.dat automaticamente.
-- Aplicar somente overrides explicitamente habilitados.

local SV = {
    enabled = true,
    visual = {
        -- Valores conservadores; validar no FiveM antes de elevar.
        rain = {
            NumberParticles = 3500.0,
            UseLitShader = 1.0,
            diffuse = 1.0,
            ambient = 0.40,
            wrapScale = 0.60,
            wrapBias = 0.40,
            defaultlight_red = 1.0,
            defaultlight_green = 1.0,
            defaultlight_blue = 1.0,
        },
        distant = {
            size = 1.05,
            sizeReflections = 0.85,
            sizeUpscale = 1.50,
            sizeUpscaleReflections = 1.50,
        },
    },
    debug = false,
}

local function log(msg)
    if SV.debug then
        print(('[SilvaVision] %s'):format(msg))
    end
end

local function setVisual(name, value)
    if type(SetVisualSettingFloat) ~= 'function' then
        return false
    end

    local ok, err = pcall(SetVisualSettingFloat, name, value)
    if not ok then
        log(('visual setting falhou: %s (%s)'):format(name, tostring(err)))
        return false
    end

    return true
end

local function applyVisualLayer()
    if not SV.enabled then return end

    local r = SV.visual.rain
    setVisual('rain.NumberParticles', r.NumberParticles)
    setVisual('rain.UseLitShader', r.UseLitShader)
    setVisual('rain.diffuse', r.diffuse)
    setVisual('rain.ambient', r.ambient)
    setVisual('rain.wrapScale', r.wrapScale)
    setVisual('rain.wrapBias', r.wrapBias)
    setVisual('rain.defaultlight.red', r.defaultlight_red)
    setVisual('rain.defaultlight.green', r.defaultlight_green)
    setVisual('rain.defaultlight.blue', r.defaultlight_blue)

    local d = SV.visual.distant
    setVisual('distantlights.size', d.size)
    setVisual('distantlights.sizeReflections', d.sizeReflections)
    setVisual('distantlights.sizeUpscale', d.sizeUpscale)
    setVisual('distantlights.sizeUpscaleReflections', d.sizeUpscaleReflections)

    log('camada visual runtime aplicada')
end

CreateThread(function()
    Wait(1500)
    applyVisualLayer()
end)

exports('ApplyVisualLayer', applyVisualLayer)
exports('GetVisualConfig', function()
    return SV
end)
