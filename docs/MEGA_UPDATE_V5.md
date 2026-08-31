# 🚀🇧🇷 MEGA UPDATE V5 — SILVA VISION

## 🆕 Nesta rodada

O projeto ganhou mais quatro módulos próprios de pós-processamento:

### ☀️ SV Exposure
`shaders/SV_Exposure.fx`

Controle de exposição separado do tonemapping. Isso permite testar o nível de luz sem misturar responsabilidades.

### 🌡️ SV White Balance
`shaders/SV_WhiteBalance.fx`

Controle experimental de temperatura e tint.

### 🔍 SV Sharpen
`shaders/SV_Sharpen.fx`

Sharpen próprio e conservador para ser aplicado no final da cadeia.

### 🎨 Pipeline
Os módulos anteriores continuam:

- `SV_Tonemap.fx`
- `SV_ColorAnchor.fx`
- `SV_LocalContrast.fx`

## 🧠 Arquitetura atual

```text
INPUT
 ↓
☀️ EXPOSURE
 ↓
🎞️ TONEMAP
 ↓
🌡️ WHITE BALANCE
 ↓
🎨 COLOR ANCHOR
 ↓
🌗 LOCAL CONTRAST
 ↓
✨ BLOOM (futuro)
 ↓
🧠 DEPTH (opcional)
 ↓
🔍 SHARPEN
 ↓
OUTPUT
```

## ⚠️ Aviso técnico

Os módulos são protótipos experimentais. Eles foram criados para o projeto e ainda precisam ser compilados/testados no ambiente real do ReShade e FiveM.

Não foram declarados como release estável.

## 🧪 Amanhã — protocolo de teste

Quando houver acesso ao PC:

1. testar cada shader isoladamente;
2. verificar compilação;
3. fotografar comparação original/efeito;
4. testar dia/noite/chuva/pôr do sol;
5. verificar artefatos;
6. medir custo de GPU;
7. somente depois combinar os módulos.

## 🎯 Próximo grande bloco

- ✨ `SV_Bloom.fx`
- 🎞️ `SV_Filmic.fx`
- 🧠 `SV_DepthGate.fx`
- 🌅 controle de sunset;
- 🌙 integração do perfil Night;
- 🌧️ pipeline Rain;
- ⚡ sistema de orçamento de efeitos.
