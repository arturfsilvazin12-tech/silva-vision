# 🚀 Silva Vision — Relatório de Upgrade V3

## 📅 Rodada

2026-08-30

## 🎯 Objetivo

Transformar a pesquisa anterior em uma primeira linha de presets concretos, mantendo o projeto modular e evitando afirmar que algo está estável sem teste real.

## 🆕 Arquivos criados

### 🎨 `presets/reshade/SV_Neutral.ini`
Base de referência. Poucos efeitos e nitidez conservadora.

### ⭐ `presets/reshade/SV_Balanced.ini`
Perfil intermediário para desenvolvimento. A prioridade é qualidade por custo de GPU.

### 🌙 `presets/reshade/SV_Night.ini`
Primeira base dedicada à noite. Não tenta resolver a iluminação do mundo apenas com exposição.

### 🌧️ `presets/reshade/SV_Rain.ini`
Primeira base dedicada à chuva. Importante: o arquivo não cria chuva; ele é apenas a camada de pós-processamento e precisa trabalhar junto aos sistemas de clima do jogo.

## 🧠 Decisões novas

1. Presets começam pequenos para permitir A/B.
2. Efeitos depth não são obrigatórios.
3. Bloom pesado não entra no perfil base.
4. Sharpen deve ser controlado para evitar halos.
5. Alterações de clima e mundo não devem ser confundidas com ReShade.
6. Cada futuro efeito precisa ter função, custo e fallback definidos.

## 🛠️ Próxima implementação

### Fase A — Core
- pipeline de exposição;
- tonemapping;
- contraste local;
- controle cromático;
- debanding quando necessário.

### Fase B — Mundo
- timecycle experimental;
- iluminação;
- céu;
- atmosfera;
- chuva.

### Fase C — ReShade
- bloom seletivo;
- color grading;
- LUT;
- sharpen;
- efeitos depth opcionais.

### Fase D — Performance
- benchmark por preset;
- GPU ms;
- 1% low;
- VRAM;
- custo por efeito.

## 🚫 O que não foi feito

- Não foi copiado nenhum graphics pack proprietário.
- Não foram incorporados assets de terceiros sem licença.
- Não foi declarado FPS garantido.
- Não foram tratados presets experimentais como versão final.

## 🧪 Estado

🟡 **Experimental / aguardando validação no FiveM.**

O usuário está temporariamente sem possibilidade de testar, portanto a próxima evolução deve priorizar componentes reversíveis e documentação clara de dependências.
