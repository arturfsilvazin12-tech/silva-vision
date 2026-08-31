// 🇧🇷 SILVA VISION — SV Filmic V0.1
// 🎞️ Curva filmic experimental simples para highlights e contraste.
#include "ReShade.fxh"

uniform float Exposure < ui_type="slider"; ui_min=-1.0; ui_max=1.0; ui_step=0.01; > = 0.0;
uniform float Contrast < ui_type="slider"; ui_min=0.0; ui_max=1.0; ui_step=0.01; > = 0.15;

float3 Filmic(float3 x)
{
    x *= exp2(Exposure);
    const float a=2.51; const float b=0.03; const float c=2.43; const float d=0.59; const float e=0.14;
    return saturate((x*(a*x+b))/(x*(c*x+d)+e));
}

float4 PS_Filmic(float4 pos:SV_Position,float2 uv:TEXCOORD):SV_Target
{
    float3 c=tex2D(ReShade::BackBuffer,uv).rgb;
    c=Filmic(c);
    c=(c-0.5)*(1.0+Contrast)+0.5;
    return float4(saturate(c),1.0);
}

technique SV_Filmic
{
 pass { VertexShader=PostProcessVS; PixelShader=PS_Filmic; }
}
