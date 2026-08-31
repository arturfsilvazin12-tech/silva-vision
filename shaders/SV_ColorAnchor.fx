// 🇧🇷 SILVA VISION — SV Color Anchor V0.1
// 🎨 Componente experimental próprio.
// Objetivo: controlar a intensidade cromática de forma conservadora,
// evitando a aparência de saturação global exagerada.

#include "ReShade.fxh"

uniform float Saturation <
    ui_type="slider";
    ui_min=0.80; ui_max=1.20; ui_step=0.01;
> = 1.00;

uniform float Vibrance <
    ui_type="slider";
    ui_min=-0.20; ui_max=0.20; ui_step=0.01;
> = 0.00;

float3 ApplyColorAnchor(float3 color)
{
    float luminance = dot(color, float3(0.2126, 0.7152, 0.0722));
    float3 chroma = color - luminance;
    float maxc = max(color.r, max(color.g, color.b));
    float minc = min(color.r, min(color.g, color.b));
    float spread = maxc - minc;

    // Vibrance afeta mais pixels pouco saturados e preserva cores já fortes.
    float adaptive = 1.0 - saturate(spread * 2.0);
    float amount = Saturation + Vibrance * adaptive;
    return saturate(luminance + chroma * amount);
}

float4 PS_ColorAnchor(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
    float4 src = tex2D(ReShade::BackBuffer, texcoord);
    src.rgb = ApplyColorAnchor(src.rgb);
    return src;
}

technique SV_ColorAnchor
{
    pass
    {
        VertexShader = PostProcessVS;
        PixelShader = PS_ColorAnchor;
    }
}
