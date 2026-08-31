// 🇧🇷 SILVA VISION — SV Local Contrast V0.1
// 🧪 Experimental próprio.
// Contraste local extremamente conservador para recuperar percepção sem
// transformar sombras em preto absoluto ou highlights em branco estourado.

#include "ReShade.fxh"

uniform float Strength <
    ui_type="slider";
    ui_min=0.0; ui_max=1.0; ui_step=0.01;
> = 0.12;

uniform float Radius <
    ui_type="slider";
    ui_min=0.5; ui_max=3.0; ui_step=0.1;
> = 1.2;

float Luma(float3 c)
{
    return dot(c, float3(0.2126, 0.7152, 0.0722));
}

float4 PS_LocalContrast(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target
{
    float2 px = ReShade::PixelSize * Radius;
    float3 c = tex2D(ReShade::BackBuffer, uv).rgb;
    float3 n = tex2D(ReShade::BackBuffer, uv + float2(0, -px.y)).rgb;
    float3 s = tex2D(ReShade::BackBuffer, uv + float2(0, px.y)).rgb;
    float3 e = tex2D(ReShade::BackBuffer, uv + float2(px.x, 0)).rgb;
    float3 w = tex2D(ReShade::BackBuffer, uv + float2(-px.x, 0)).rgb;

    float local = (Luma(n) + Luma(s) + Luma(e) + Luma(w)) * 0.25;
    float delta = Luma(c) - local;
    float factor = 1.0 + delta * Strength * 2.0;

    return float4(saturate(c * factor), 1.0);
}

technique SV_LocalContrast
{
    pass
    {
        VertexShader = PostProcessVS;
        PixelShader = PS_LocalContrast;
    }
}
