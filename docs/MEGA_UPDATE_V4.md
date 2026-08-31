# 🚀🇧🇷 SILVA VISION — MEGA UPDATE V4

## 📅 30/08/2026

Esta rodada representa a primeira passagem da arquitetura para **shaders próprios**.

## 🆕 1. SV Color Anchor

Arquivo: `shaders/SV_ColorAnchor.fx`

### O que faz

Controla saturação e vibrance de maneira adaptativa. Pixels que já possuem muita separação cromática recebem menos impulso de vibrance.

### Por que existe

Evitar o visual artificial de saturação global usado por muitos presets.

### Estado

🟡 Experimental — precisa de teste visual em várias condições.

---

## 🆕 2. SV Local Contrast

Arquivo: `shaders/SV_LocalContrast.fx`

### O que faz

Compara luminância do pixel com vizinhos próximos e aplica uma pequena correção de contraste local.

### Objetivo

Aumentar percepção de detalhe sem depender de sharpen extremo.

### Riscos a verificar

- halos;
- ruído em superfícies;
- flicker em movimento;
- custo adicional.

### Estado

🟡 Experimental.

---

## 🆕 3. SV Tonemap

Arquivo: `shaders/SV_Tonemap.fx`

### O que faz

Aplica exposição e uma compressão simples de highlights.

### Objetivo

Construir a primeira peça do pipeline de exposição/tonemapping próprio.

### Estado

🟡 Experimental.

---

## 🧠 4. Nova arquitetura

O projeto passa a ter três classes claras:

```text
CORE
├── Tonemap
├── Color Anchor
└── Local Contrast

OPTIONAL
├── Bloom
├── LUT
└── Depth FX

WORLD
├── Timecycle
├── VisualSettings
├── Weather
└── Citizen
```

---

## ⚠️ 5. Limitações honestas

Os shaders foram escritos como protótipos e ainda não foram testados no FiveM nesta rodada.

Eles **não devem ser apresentados como release estável**.

A sintaxe e o comportamento precisam ser validados no ReShade instalado no ambiente real.

---

## 🧪 6. Plano de validação

Para cada shader:

1. carregar sozinho;
2. verificar compilação;
3. testar dia;
4. testar noite;
5. testar chuva;
6. testar pôr do sol;
7. verificar movimento;
8. comparar FPS/GPU;
9. procurar artefatos;
10. só então integrar ao preset.

---

## 🔥 7. Próximos componentes próprios

- `SV_Bloom.fx`
- `SV_Vibrance.fx` refinado
- `SV_Sharpen.fx`
- `SV_Exposure.fx`
- `SV_WhiteBalance.fx`
- `SV_DepthGate.fx`
- `SV_Filmic.fx`
- sistema de presets que combine os módulos sem duplicação.

## 🏆 Direção

O objetivo continua sendo **criar uma identidade visual própria**, inspirada por técnicas descobertas na comunidade, sem copiar assets ou código proprietário.
