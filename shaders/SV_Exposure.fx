// 🇧🇷 SILVA VISION — SV Exposure V0.1
// ☀️ Exposição independente para o pipeline.
#include "ReShade.fxh"

uniform float Exposure < ui_type="slider"; ui_min=-2.0; ui_max=2.0; ui_step=0.01; > = 0.0;

float4 PS_Exposure(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target
{
    float3 c = tex2D(ReShade::BackBuffer, uv).rgb;
    c *= exp2(Exposure);
    return float4(saturate(c), 1.0);
}

technique SV_Exposure
{
    pass { VertexShader=PostProcessVS; PixelShader=PS_Exposure; }
}
