// 🇧🇷 SILVA VISION — SV Sharpen V0.1
// 🔍 Sharpen conservador. Deve ser usado como último estágio.
#include "ReShade.fxh"

uniform float Strength < ui_type="slider"; ui_min=0.0; ui_max=1.0; ui_step=0.01; > = 0.12;

float4 PS_Sharpen(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target
{
    float2 p = ReShade::PixelSize;
    float3 c = tex2D(ReShade::BackBuffer, uv).rgb;
    float3 n = tex2D(ReShade::BackBuffer, uv + float2(0,-p.y)).rgb;
    float3 s = tex2D(ReShade::BackBuffer, uv + float2(0,p.y)).rgb;
    float3 e = tex2D(ReShade::BackBuffer, uv + float2(p.x,0)).rgb;
    float3 w = tex2D(ReShade::BackBuffer, uv + float2(-p.x,0)).rgb;
    float3 blur = (n+s+e+w) * 0.25;
    float3 result = c + (c-blur) * Strength;
    return float4(saturate(result),1.0);
}

technique SV_Sharpen
{
    pass { VertexShader=PostProcessVS; PixelShader=PS_Sharpen; }
}
