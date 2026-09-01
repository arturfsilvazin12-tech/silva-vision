-- SILVA VISION V0.5 MEGA ULTRA
-- Runtime compatibility/config shim — CLIENT ONLY.
-- IMPORTANTE: este arquivo não escreve VisualSettings; Central Apply é o único writer.

local SV = {
    enabled = true,
    visual = {
        rain = { NumberParticles=3500.0, UseLitShader=1.0, diffuse=1.0, ambient=0.40, wrapScale=0.60, wrapBias=0.40, defaultlight_red=1.0, defaultlight_green=1.0, defaultlight_blue=1.0 },
        distant = { size=1.05, sizeReflections=0.85, sizeUpscale=1.50, sizeUpscaleReflections=1.50 },
    },
    debug = false,
}

RegisterCommand('svruntime', function(_,args)
    if args[1]=='on' then SV.enabled=true
    elseif args[1]=='off' then SV.enabled=false
    elseif args[1]=='show' or not args[1] then
        print(('[SilvaVision] Runtime shim=%s | writer=CentralApply'):format(SV.enabled and 'ON' or 'OFF'))
        return
    else print('[SilvaVision] svruntime on | off | show'); return end
    print(('[SilvaVision] Runtime shim %s'):format(SV.enabled and 'ON' or 'OFF'))
end,false)

exports('ApplyVisualLayer', function()
    local ok=pcall(function() return exports['silva-vision-core']:ApplyVisualSettings() end)
    return ok
end)
exports('GetVisualConfig',function() return SV end)
