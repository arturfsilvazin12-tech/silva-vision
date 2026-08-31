// 🇧🇷 SILVA VISION — SV Bloom V0.1
// ✨ Bloom experimental próprio. Multi-sample leve, com threshold.
#include "ReShade.fxh"

uniform float Threshold < ui_type="slider"; ui_min=0.5; ui_max=2.0; ui_step=0.01; > = 1.0;
uniform float Intensity < ui_type="slider"; ui_min=0.0; ui_max=1.0; ui_step=0.01; > = 0.10;
uniform float Radius < ui_type="slider"; ui_min=0.5; ui_max=3.0; ui_step=0.1; > = 1.2;

float Luma(float3 c){ return dot(c,float3(0.2126,0.7152,0.0722)); }

float3 SampleBright(float2 uv)
{
    float3 c=tex2D(ReShade::BackBuffer,uv).rgb;
    return max(Luma(c)-Threshold,0.0)*c;
}

float4 PS_Bloom(float4 pos:SV_Position,float2 uv:TEXCOORD):SV_Target
{
    float2 p=ReShade::PixelSize*Radius;
    float3 b=SampleBright(uv);
    b+=SampleBright(uv+float2(p.x,0));
    b+=SampleBright(uv-float2(p.x,0));
    b+=SampleBright(uv+float2(0,p.y));
    b+=SampleBright(uv-float2(0,p.y));
    b*=0.2;
    float3 base=tex2D(ReShade::BackBuffer,uv).rgb;
    return float4(saturate(base+b*Intensity),1.0);
}

technique SV_Bloom
{
 pass { VertexShader=PostProcessVS; PixelShader=PS_Bloom; }
}
