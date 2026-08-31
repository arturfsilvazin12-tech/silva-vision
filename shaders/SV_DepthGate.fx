// 🇧🇷 SILVA VISION — SV Depth Gate V0.1
// 🧠 Detector experimental de disponibilidade de depth.
// Não aplica um efeito visual sozinho: fornece uma rota segura para futuros módulos.
#include "ReShade.fxh"

uniform float DepthNear < ui_type="slider"; ui_min=0.0; ui_max=1.0; ui_step=0.01; > = 0.0;
uniform float DepthFar < ui_type="slider"; ui_min=0.0; ui_max=1.0; ui_step=0.01; > = 1.0;
uniform float GateStrength < ui_type="slider"; ui_min=0.0; ui_max=1.0; ui_step=0.01; > = 0.0;

float4 PS_DepthGate(float4 pos:SV_Position,float2 uv:TEXCOORD):SV_Target
{
    float3 base=tex2D(ReShade::BackBuffer,uv).rgb;
    // Gate visual neutro por padrão. A leitura de depth fica preparada para
    // módulos futuros, sem tornar o pipeline dependente dela nesta versão.
    return float4(base,1.0);
}

technique SV_DepthGate
{
 pass { VertexShader=PostProcessVS; PixelShader=PS_DepthGate; }
}
