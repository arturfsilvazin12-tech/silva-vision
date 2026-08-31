// 🇧🇷 SILVA VISION — SV Bloom V0.2
// ✨ Bloom experimental, com threshold e amostragem leve.
#include "ReShade.fxh"
uniform float Threshold < ui_type="slider"; ui_min=0.2; ui_max=2.0; ui_step=0.01; > = 1.0;
uniform float Intensity < ui_type="slider"; ui_min=0.0; ui_max=1.0; ui_step=0.01; > = 0.12;
uniform float Radius < ui_type="slider"; ui_min=1.0; ui_max=3.0; ui_step=0.1; > = 1.4;
float3 Bright(float3 c){return max(c-Threshold,0.0);}
float4 PS_Bloom(float4 pos:SV_Position,float2 uv:TEXCOORD):SV_Target{float2 p=ReShade::PixelSize*Radius;float3 c=tex2D(ReShade::BackBuffer,uv).rgb;float3 b=Bright(c)*0.40;b+=Bright(tex2D(ReShade::BackBuffer,uv+float2(p.x,0)).rgb)*0.15;b+=Bright(tex2D(ReShade::BackBuffer,uv-float2(p.x,0)).rgb)*0.15;b+=Bright(tex2D(ReShade::BackBuffer,uv+float2(0,p.y)).rgb)*0.15;b+=Bright(tex2D(ReShade::BackBuffer,uv-float2(0,p.y)).rgb)*0.15;return float4(saturate(c+b*Intensity),1.0);}
technique SV_Bloom_V02{pass{VertexShader=PostProcessVS;PixelShader=PS_Bloom;}}
