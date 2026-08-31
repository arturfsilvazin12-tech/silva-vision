# 🇧🇷✨ SILVA VISION

<div align="center">

## 🎮 Realismo • Atmosfera • Iluminação • Performance

### Projeto gráfico modular para FiveM / GTA V

**Construído em PT-BR com foco em qualidade visual, desempenho e compatibilidade.**

`0.1.0-dev` · 🟡 Experimental

</div>

---

## 👋 Bem-vindo

O **Silva Vision** busca criar uma identidade visual própria para FiveM/GTA V sem depender de uma pilha de filtros exagerados.

A arquitetura separa **Post FX, World, Performance, Validation e Release**, permitindo desenvolver e testar cada parte isoladamente.

> 🎯 **Regra principal:** um efeito só entra no preset padrão se melhorar a imagem, justificar seu custo e continuar reversível.

---

## ✨ O projeto

| Sistema | Foco |
|:--|:--|
| 🎨 **Post FX** | cor, exposição, tonemap, contraste, bloom e nitidez |
| 💡 **Lighting** | iluminação urbana e fontes artificiais |
| 🌫️ **Atmosphere** | profundidade, haze e neblina |
| 🌧️ **Weather** | identidade visual por clima |
| 🌊 **Water** | água, reflexos e wetness |
| 🚘 **Vehicles** | iluminação e presença dos veículos |
| ⚡ **Performance** | perfis e orçamento gráfico |
| 🛡️ **Validation** | testes, benchmark e rollback |

---

## 🏗️ Arquitetura

```text
                         🇧🇷 SILVA VISION
                                │
             ┌──────────────────┼──────────────────┐
             ▼                  ▼                  ▼
         🌎 WORLD           🎨 POST FX        ⚡ PERFORMANCE
             │                  │                  │
      ┌──────┼──────┐      ┌────┼────┐        Profiles
      ▼      ▼      ▼      ▼    ▼    ▼        GPU Budget
     💡     🌧️     🌫️    🎨   ✨   🔍
    Luz   Clima  Atmos   Cor Bloom Sharp
      │      │      │
      └──────┼──────┘
             ▼
          🌊 Water
             ▼
        🚘 Vehicles
             │
             ▼
        🧪 Validation
             │
             ▼
          📦 Release
```

### 📊 Estado

| Componente | Estado |
|:--|:--:|
| 🎨 ReShade Core | 🟡 Desenvolvimento |
| 🎛️ Presets | 🟡 Desenvolvimento |
| 💡 Lighting | 🟡 Especificação |
| 🌫️ Atmosphere | 🟡 Especificação |
| 🌧️ Weather | 🟡 Planejamento |
| 🌊 Water | 🟡 Especificação |
| 🚘 Vehicles | 🟡 Planejamento |
| ⚡ Performance | 🟢 Estruturado |
| 🛡️ Validation | 🟢 Ferramentas iniciais |
| 📦 Installer | 🟡 Preparação |
| 🧪 Teste real | 🔴 Pendente |
| 🏁 Release estável | 🔴 Não lançado |

---

## 🎛️ Perfis

🟢 **Performance** — FPS e estabilidade  
⚖️ **Balanced** ⭐ — equilíbrio recomendado  
🔵 **Quality** — qualidade visual  
🟣 **Ultra** — avaliação máxima  
🎬 **Cinematic** — vídeos e screenshots

> ⚠️ Ultra não significa ligar tudo. Os efeitos precisam ser validados.

---

## 🧪 Metodologia

```text
🔎 Pesquisa
   ↓
🛠️ Implementação
   ↓
🎛️ A/B
   ↓
📈 Benchmark
   ↓
👁️ Análise
   ↓
🐛 Correção
   ↓
🔁 Repetição
   ↓
📦 Release
```

Testes previstos: ☀️ Dia · 🌅 Sunset · 🌙 Noite · 🌧️ Chuva · 🌧️🌙 Chuva noturna · 🌆 Cidade · 🚘 Faróis · 🌊 Água · 🌫️ Neblina.

---

## 🛡️ Compatibilidade primeiro

- ❌ Não inventar formatos nativos.
- ❌ Não renomear arquivos nativos sem validação.
- ❌ Não prometer FPS sem benchmark.
- ❌ Não incluir assets de terceiros sem licença.
- ✅ Backup e rollback.
- ✅ Experimental separado de estável.
- ✅ Testes isolados.
- ✅ Dependências documentadas.

**Citizen, VisualSettings, Timecycle, ReShade e ENB são camadas diferentes.**

---

## 📦 Instalação

A instalação final depende da validação no PC.

**💾 Backup → 🎨 ReShade → 🧠 Core → 🎛️ Preset → 🌎 World → 🧪 Teste → 🚀 Release**

Ferramentas:

```text
SV_VALIDATE.ps1
└─ 🔍 verifica a estrutura

SV_INSTALL_PLAN.ps1
└─ 📄 prepara relatório sem alterar GTA/FiveM
```

---

## 📚 Documentação

- 🧠 `docs/ARCHITECTURE_V02.md`
- 🛡️ `docs/QUALITY_RULES_PTBR.md`
- ⚡ `performance/SV_PROFILES.md`
- 🧪 `tools/TEST_CHECKLIST_PTBR.md`
- 📦 `tools/INSTALL_ORDER_PTBR.md`
- 💡 `world/lighting/SV_LIGHTING_SPEC_V01.md`
- 🌫️ `world/atmosphere/SV_ATMOSPHERE_SPEC_V01.md`
- 🌊 `world/water/SV_WATER_SPEC_V01.md`
- 🌅 `world/timecycle/SV_TIMECYCLE_PLAN_V01.md`
- 🌧️ `world/weather/SV_WEATHER_MATRIX_V01.md`

### 📋 Histórico

Os arquivos `MEGA_UPDATE_V*` registram as principais rodadas de evolução.

---

## 🗺️ Roadmap

### 🟢 Base

- [x] 🧠 Arquitetura modular
- [x] 🇧🇷 Documentação PT-BR
- [x] ⚡ Perfis de performance
- [x] 🛡️ Validador
- [x] 📦 Preparador de instalação
- [x] 🌎 Especificações World
- [x] 📊 Manifesto
- [x] 🎨 README profissional

### 🟡 Desenvolvimento

- [ ] 🎨 Pipeline ReShade final
- [ ] 🎛️ Presets finais
- [ ] 💡 Lighting real
- [ ] 🌫️ Atmosphere real
- [ ] 🌊 Water real
- [ ] 🌧️ Weather real
- [ ] 🚘 Vehicle Lights
- [ ] 🛡️ Rollback completo
- [ ] 📦 Installer completo

### 🔴 Validação

- [ ] 🧪 Primeiro teste FiveM
- [ ] 📈 Benchmark
- [ ] 👁️ Antes/depois
- [ ] 🐛 Correção de artefatos
- [ ] 🧪 Estabilidade
- [ ] 🏁 Release estável

---

## 📦 Tamanho

Ainda não há tamanho final. A meta é **não adicionar gigabytes sem necessidade**. A estimativa será atualizada quando os assets finais forem definidos.

---

<div align="center">

## 🔥 SILVA VISION

### Realismo sem exagero.
### Qualidade sem desperdício.
### Compatibilidade antes de tudo.

🇧🇷 **Feito para evoluir.**

</div>
