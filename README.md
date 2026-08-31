# 🇧🇷✨ SILVA VISION

<div align="center">

### 🎮 Uma nova identidade visual para FiveM / GTA V

**Realismo • Atmosfera • Iluminação • Performance • Compatibilidade**

[🚀 Roadmap](#-roadmap) · [🧩 Arquitetura](#-arquitetura) · [🧪 Testes](#-testes) · [📦 Instalação](#-instalação) · [📚 Documentação](#-documentação)

</div>

---

## 🌎 Sobre o projeto

O **Silva Vision** é um projeto gráfico modular para FiveM/GTA V. A ideia é construir uma apresentação visual própria, com foco em iluminação, atmosfera, clima, água, cores e desempenho — sem simplesmente empilhar filtros.

> 🎯 **Nossa regra:** cada efeito precisa melhorar a imagem, justificar seu custo e continuar reversível.

---

## ✨ Visão visual

| ☀️ Dia | 🌅 Sunset | 🌙 Noite | 🌧️ Chuva |
|---|---|---|---|
| sombras preservadas | luz quente controlada | fontes artificiais fortes | atmosfera + wetness |
| highlights naturais | sem laranja global | pretos realmente escuros | reflexos coerentes |

---

## 🧩 Arquitetura

```text
                    🇧🇷 SILVA VISION
                           │
          ┌────────────────┼────────────────┐
          ↓                ↓                ↓
       🌎 WORLD          🎨 POST FX       ⚡ PERF
          │                │                │
   ┌──────┼──────┐    ┌────┼────┐       Profiles
   ↓      ↓      ↓    ↓    ↓    ↓       GPU Budget
 💡 Luz  🌦️ Clima 🌫️ Atmos  🎨 Cor ✨ Bloom 🔍 Sharpen
   │      │      │
   └──────┴──────┘
          ↓
       🌊 Água
          ↓
       🚘 Veículos
          ↓
       🛡️ Validação
          ↓
       📦 Release
```

### Estado dos módulos

| Módulo | Estado |
|---|---|
| 🎨 ReShade | 🟡 Desenvolvimento |
| 💡 Lighting | 🟡 Especificação |
| 🌫️ Atmosphere | 🟡 Especificação |
| 🌧️ Weather | 🟡 Planejamento |
| 🌊 Water | 🟡 Especificação |
| 🚘 Vehicles | 🟡 Planejamento |
| ⚡ Performance | 🟢 Estruturado |
| 🛡️ Validation | 🟢 Ferramentas criadas |
| 📦 Installer | 🟡 Preparação |

---

## 🎛️ Perfis

**🟢 Performance** — máximo foco em fluidez  
**⚖️ Balanced** — ponto de partida recomendado  
**🔵 Quality** — qualidade visual elevada  
**🟣 Ultra** — avaliação máxima  
**🎬 Cinematic** — cenas e screenshots

> ⚠️ **Ultra não significa ligar tudo.**

---

## 🧪 Testes

O projeto usa uma sequência simples:

`Pesquisa → Implementação → A/B → Benchmark → Artefatos → Correção → Release`

Cenários previstos:

- ☀️ Dia
- 🌅 Amanhecer/Sunset
- 🌙 Noite
- 🌧️ Chuva
- 🌧️🌙 Chuva noturna
- 🌆 Cidade iluminada
- 🚘 Estrada com faróis
- 🌊 Água

---

## 🛡️ Compatibilidade primeiro

Não consideramos arquivo nativo pronto apenas porque ele existe no repositório.

- ❌ Não inventar formatos nativos.
- ❌ Não renomear arquivos sem validar compatibilidade.
- ❌ Não redistribuir assets de terceiros sem licença.
- ✅ Manter rollback.
- ✅ Separar experimental de estável.
- ✅ Medir antes de prometer desempenho.

Citizen, VisualSettings, Timecycle, ReShade e ENB são tratados como camadas distintas.

---

## 📦 Instalação

A instalação final ainda depende da validação no PC. A ordem prevista é:

**💾 Backup → 🎨 ReShade → 🧠 Core → 🎛️ Preset → 🌎 World → 🧪 Teste → 🚀 Release**

Ferramentas preparadas:

- `tools/SV_VALIDATE.ps1`
- `tools/SV_INSTALL_PLAN.ps1`

---

## 📚 Documentação

A pasta `docs/` contém os relatórios e especificações de cada fase.

⭐ Comece por:

- `docs/MEGA_UPDATE_V15.md`
- `docs/RELEASE_SIZE_ESTIMATE.md`
- `docs/QUALITY_RULES_PTBR.md`
- `docs/MEGA_UPDATE_V14.md`

---

## 🗺️ Roadmap

- [x] 🧠 Arquitetura modular
- [x] 🇧🇷 Documentação PT-BR
- [x] ⚡ Sistema de performance
- [x] 🛡️ Validador de estrutura
- [x] 📦 Preparador de instalação
- [x] 🌎 Especificações World
- [x] ✨ Bloom experimental
- [ ] 🎨 Pipeline ReShade integrado
- [ ] 💡 Implementação Lighting
- [ ] 🌫️ Implementação Atmosphere
- [ ] 🌊 Implementação Water
- [ ] 🌧️ Implementação Weather
- [ ] 🚘 Implementação Vehicle Lights
- [ ] 🧪 Testes reais FiveM
- [ ] 📦 Release instalável
- [ ] 🏁 Release estável

---

## 📊 Status

**Versão:** `0.1.0-dev`  
**Idioma:** 🇧🇷 PT-BR  
**Estado:** 🟡 Experimental  
**Release estável:** 🔴 Ainda não

---

<div align="center">

### 🔥 Silva Vision

**Realismo sem exagero. Qualidade sem desperdício. Compatibilidade antes de tudo.**

</div>
