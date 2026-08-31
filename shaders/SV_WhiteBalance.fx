// 🇧🇷 SILVA VISION — SV White Balance V0.1
// 🌡️ Correção simples de temperatura/tint.
#include "ReShade.fxh"

uniform float Temperature < ui_type="slider"; ui_min=-0.25; ui_max=0.25; ui_step=0.01; > = 0.0;
uniform float Tint < ui_type="slider"; ui_min=-0.15; ui_max=0.15; ui_step=0.01; > = 0.0;

float4 PS_WhiteBalance(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target
{
    float3 c = tex2D(ReShade::BackBuffer, uv).rgb;
    c.r += Temperature;
    c.b -= Temperature;
    c.g += Tint;
    return float4(saturate(c), 1.0);
}

technique SV_WhiteBalance
{
    pass { VertexShader=PostProcessVS; PixelShader=PS_WhiteBalance; }
}
