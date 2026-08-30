# 🧠 Silva Vision — Arquitetura V2

## 🎯 Objetivo

Construir um pacote gráfico modular para FiveM/GTA V em que cada camada tenha uma responsabilidade clara e possa ser desligada sem desmontar o restante.

```text
🇧🇷 SILVA VISION
│
├── 🌎 WORLD
│   ├── Atmosfera
│   ├── Céu/Nuvens
│   ├── Água
│   ├── Vegetação
│   └── LOD/Streaming
│
├── 💡 LIGHTING
│   ├── Sol
│   ├── Cidade
│   ├── Veículos
│   ├── Interiores
│   ├── Neon
│   └── Emergência
│
├── 🌦️ WEATHER
│   ├── Timecycle
│   ├── Chuva
│   ├── Tempestade
│   ├── Neblina
│   └── Transições
│
├── 🎨 POST
│   ├── Exposure
│   ├── Tonemapping
│   ├── Cor
│   ├── AA
│   ├── Deband
│   └── Sharpen
│
├── 🧠 DEPTH
│   ├── Depth validation
│   ├── AO
│   ├── SSR
│   └── Depth-aware effects
│
└── ⚡ PERFORMANCE
    ├── Perfis
    ├── Budget
    ├── Fallbacks
    └── Diagnóstico
```

## 🔐 Regra de isolamento

Um módulo não deve assumir que outro está instalado. O comportamento padrão deve ser seguro quando um componente opcional estiver ausente.

## 🔄 Ordem conceitual

**Dados do mundo → iluminação/clima → renderização do jogo → pós-processamento → diagnóstico.**

A ordem exata de shaders só será congelada após testes reais, porque diferentes versões e configurações podem alterar o comportamento do depth buffer e do pipeline.

## 🧪 Experimentalidade

Qualquer alteração sem benchmark ou teste no jogo permanece 🟡 experimental.
