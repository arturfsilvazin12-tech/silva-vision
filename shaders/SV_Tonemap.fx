// 🇧🇷 SILVA VISION — SV Tonemap V0.1
// 🎞️ Tone mapping experimental próprio.
// Objetivo: comprimir highlights de forma suave e preservar informação visual.

#include "ReShade.fxh"

uniform float Exposure <
    ui_type="slider";
    ui_min=-2.0; ui_max=2.0; ui_step=0.01;
> = 0.0;

uniform float Shoulder <
    ui_type="slider";
    ui_min=0.0; ui_max=1.0; ui_step=0.01;
> = 0.35;

float3 SVTonemap(float3 x)
{
    x *= exp2(Exposure);
    // Compressão simples e estável de highlights; não pretende substituir
    // um pipeline HDR completo.
    float3 compressed = x / (1.0 + x * Shoulder);
    return saturate(compressed);
}

float4 PS_Tonemap(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target
{
    float3 color = tex2D(ReShade::BackBuffer, uv).rgb;
    return float4(SVTonemap(color), 1.0);
}

technique SV_Tonemap
{
    pass
    {
        VertexShader = PostProcessVS;
        PixelShader = PS_Tonemap;
    }
}
