# 🖥️ Silva Vision — Perfil 1080p / RTX 3050

> Este documento é uma estratégia de desenvolvimento, não uma promessa de FPS.

## 🎯 Objetivo

Construir um preset equilibrado para uma GPU da classe RTX 3050 em 1080p, mantendo a identidade visual do Silva Vision sem transformar pós-processamento em um “imposto” de FPS.

## 🟢 Prioridade alta / baixo custo

- correção de exposição;
- balanço de branco;
- tonemapping;
- curvas/cor seletiva;
- debanding quando necessário;
- sharpen moderado e único;
- bloom muito controlado.

## 🟡 Prioridade condicional

- AO;
- SSR;
- efeitos de atmosfera dependentes de depth;
- efeitos de clareza local.

Devem passar pelo budget de GPU.

## 🔴 Candidatos a Ultra/Optional

- GI pesado;
- SSR de alta qualidade;
- DOF cinematográfico;
- múltiplos passes complexos;
- efeitos que apresentem comportamento instável.

## 📊 Metodologia

Não vamos escolher configurações só pela especificação da GPU. O teste real deve registrar:

`preset + resolução + horário + clima + local + FPS médio + 1% low + GPU ms + VRAM + observações`

## 🧪 Cenas de teste

1. 🌆 centro da cidade à noite;
2. 🛣️ avenida rápida;
3. 🌧️ chuva à noite;
4. 🌅 pôr do sol;
5. 🌫️ neblina;
6. 🌳 área com vegetação;
7. 🚗 trânsito intenso;
8. 💡 área com muitas luzes/emissivos.

## Regra

A RTX 3050 é referência para o perfil, não desculpa para limitar o projeto inteiro. O mesmo sistema deve permitir presets High/Ultra para hardware mais forte.
