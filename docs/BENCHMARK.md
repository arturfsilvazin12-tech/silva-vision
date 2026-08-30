# 📊 Silva Vision — Benchmark e Testes

## Regra principal

Uma mudança gráfica só é considerada boa quando melhora a imagem **sem introduzir artefatos ou custo desproporcional**.

## 🧪 Protocolo

Para cada alteração registrar:

- versão do Silva Vision;
- preset;
- resolução;
- escala/upscaler;
- clima;
- horário;
- local;
- FPS médio;
- 1% low, quando disponível;
- GPU ms do ReShade;
- VRAM aproximada;
- artefatos observados.

## 🗺️ Cenas padrão

| ID | Cena | O que observar |
|---|---|---|
| A | 🌆 Centro/noite | postes, bloom, sombras |
| B | 🌧️ Chuva/noite | reflexos, gotas, exposição |
| C | 🌅 Pôr do sol | highlights, céu, cor |
| D | ☀️ Meio-dia | clipping, sombras, saturação |
| E | 🌫️ Neblina | profundidade atmosférica |
| F | 🌳 Vegetação | LOD, flicker, AA |
| G | 🚗 Trânsito | emissivos e faróis |
| H | 🛣️ Rodovia | streaming e distância |

## 🔬 Teste A/B

Mudar uma variável importante por vez. Se três shaders forem alterados simultaneamente e o resultado melhorar, não sabemos qual mudança realmente funcionou.

## 🛑 Critérios de rejeição

- flicker novo;
- ghosting evidente;
- halos fortes;
- clipping de luz;
- céu com banding excessivo;
- água parecendo espelho em toda superfície;
- queda de desempenho sem ganho visual proporcional;
- conflito com outra camada.

## Status

🟡 Metodologia pronta.  
🔴 Números finais dependem de testes reais no PC/FiveM.
