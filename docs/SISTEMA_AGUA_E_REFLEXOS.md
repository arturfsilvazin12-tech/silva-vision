# 🌊 Silva Vision — Água e Reflexos

## 🎯 Princípio

Água, asfalto molhado, vidro e metal não devem receber o mesmo comportamento de reflexão.

## 🌊 Água

Avaliar separadamente:

- transparência;
- ondas;
- reflexão do céu;
- reflexão de luzes;
- resposta à chuva;
- distância de visão.

## 🛣️ Asfalto molhado

O resultado deve depender da umidade. A superfície pode apresentar reflexos fortes à noite sem parecer um espelho durante qualquer chuva.

## 🪟 Vidro

Reflexos e transparência devem permanecer distintos. Evitar brilho uniforme sobre todos os veículos.

## 🚘 Metal / pintura

Highlights devem responder à iluminação e ao material. Sharpen ou bloom não devem criar falsa sensação de especularidade.

## 🪞 SSR / efeitos de profundidade

Efeitos screen-space podem criar falhas fora da tela. Por isso devem possuir fallback e nunca ser tratados como fonte única de reflexão física.

## ⚡ Desempenho

Reflexos depth-aware entram preferencialmente nos perfis High/Ultra. Balanced prioriza correções baratas e estáveis.

## 🧪 Validação futura

Comparar seco, chuva leve, chuva forte, noite e iluminação urbana. Procurar ghosting, bordas quebradas, reflexos duplicados e flicker.
