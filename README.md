# 🇧🇷✨ SILVA VISION

> 🎮 **Projeto gráfico para FiveM / GTA V** focado em iluminação realista, atmosfera cinematográfica, clima, reflexos, cores e desempenho.
>
> 💡 **Realismo sem exagero • Qualidade sem desperdício • Compatibilidade antes de tudo**

<p align="center">
  <strong>🌅 DIA</strong>　<strong>🌇 SUNSET</strong>　<strong>🌙 NOITE</strong>　<strong>🌧️ CHUVA</strong>　<strong>⚡ TEMPESTADE</strong>
</p>

---

## 🚀 O QUE É O SILVA VISION?

O **Silva Vision** não foi pensado como um simples preset de ReShade.

A proposta é construir um **ecossistema gráfico modular**, estudando cada camada do visual do GTA V/FiveM e evitando empilhar efeitos que fazem a mesma coisa.

```text
                 🇧🇷 SILVA VISION
                        │
       ┌────────────────┼────────────────┐
       ↓                ↓                ↓
   🌎 MUNDO         💡 LUZ            🌦️ CLIMA
       │                │                │
   ☁️ Céu          🚗 Veículos        🌧️ Chuva
   🌫️ Atmosfera   🏙️ Cidade          ⛈️ Tempestade
   🌿 Vegetação    🚓 Emergência      🌫️ Neblina
   🛣️ Estradas     🌈 Neon            🌅 Transições
       │                │                │
       └────────────────┼────────────────┘
                        ↓
                  🌊 ÁGUA / REFLEXOS
                        ↓
                  🎨 COR / EXPOSIÇÃO
                        ↓
                  🧠 DEPTH / SHADERS
                        ↓
                    ⚡ PERFORMANCE
                        ↓
                  🛡️ COMPATIBILIDADE
                        ↓
                    📦 RELEASE
```

---

## 🎯 NOSSO OBJETIVO

### ☀️ Dia
Detalhes preservados, sombras naturais e highlights controlados.

### 🌇 Golden Hour
Transição quente e cinematográfica sem transformar toda a cena em laranja.

### 🌙 Noite
Noite realmente escura, mas com iluminação urbana convincente e fontes locais fortes.

### 🌧️ Chuva
Partículas + atmosfera + superfície molhada + iluminação + reflexos trabalhando juntos.

### 🌊 Água
Reflexos, transparência e ondas tratados como um sistema próprio.

### 🚘 Veículos
Faróis, lanternas, pintura, vidro e emissivos integrados à iluminação do mundo.

### ⚡ Performance
Qualidade escalável em vez de simplesmente ligar todos os shaders.

---

## 🧩 ARQUITETURA

| Módulo | Função | Estado |
|---|---|---|
| 🌎 Mundo | céu, atmosfera, LOD, materiais | 🟡 Em desenvolvimento |
| 💡 Iluminação | cidade, veículos, interiores | 🟡 Em desenvolvimento |
| 🌦️ Clima | chuva, tempestade, neblina | 🟡 Em desenvolvimento |
| 🌊 Água | ondas, transparência, reflexos | 🟠 Pesquisa |
| 🎨 Cor | exposição, tonemapping, LUT | 🟡 Em desenvolvimento |
| 🧠 Depth | AO, SSR, efeitos seletivos | 🟠 Pesquisa |
| 🎨 ReShade | pós-processamento modular | 🟡 Em desenvolvimento |
| ⚡ Performance | perfis e orçamento de GPU | 🟢 Planejado/estruturado |
| 🛡️ Compatibilidade | Citizen/timecycle/arquivos | 🟢 Estruturado |

---

## 🎮 PERFIS

### 🟢 SAFE
Mínima interferência e máxima compatibilidade.

### ⚡ PERFORMANCE
Prioridade para fluidez.

### ⭐ BALANCED
**Perfil principal:** equilíbrio entre qualidade e desempenho.

### 🔥 HIGH
Mais efeitos visuais, mantendo controle de custo.

### 💎 ULTRA
Máxima qualidade disponível, sem obrigação de ativar tudo.

> ⚠️ **Ultra ≠ todos os shaders ligados.** Cada efeito precisa justificar o custo visual/GPU.

---

## 🔬 COMO DESENVOLVEMOS

```text
🔎 PESQUISA
   ↓
🧠 ANÁLISE
   ↓
⚖️ COMPATIBILIDADE / LICENÇA
   ↓
🧩 IMPLEMENTAÇÃO
   ↓
🧪 A/B TESTE
   ↓
📊 BENCHMARK
   ↓
🐛 CAÇA A ARTEFATOS
   ↓
🔄 ROLLBACK SE NECESSÁRIO
   ↓
🟢 RELEASE
```

**Uma screenshot bonita não é considerada prova suficiente.** O projeto precisa sobreviver a gameplay, movimento, clima, horários diferentes e medições de desempenho.

---

## 🛡️ REGRA DOS ARQUIVOS

🚫 Não renomeamos arquivos nativos sem verificar compatibilidade.

🚫 Não distribuímos assets de terceiros sem licença compatível.

🚫 Não tratamos valores experimentais como definitivos.

✅ Toda alteração importante deve ter caminho de rollback.

✅ Citizen, visualsettings, timecycle, ReShade e ENB são tratados como camadas diferentes.

---

## 📂 ESTRUTURA

```text
silva-vision/
├── 📚 docs/
├── 🎨 presets/
│   ├── reshade/
│   └── profiles/
├── 💡 visualsettings/
├── 👤 citizen/
├── 🔥 enb/
├── 🧠 shaders/
├── 🛠️ tools/
├── 🛡️ compatibility/
├── 📊 benchmarks/
└── 📦 releases/
```

---

## 📚 DOCUMENTAÇÃO

- 💡 `docs/SISTEMA_ILUMINACAO.md`
- 🌊 `docs/SISTEMA_AGUA_E_REFLEXOS.md`
- ☁️ `docs/SISTEMA_CEU_ATMOSFERA.md`
- 🚘 `docs/SISTEMA_VEICULOS.md`
- ⚡ `docs/SISTEMA_PERFORMANCE.md`
- 🧪 `docs/PLANO_DE_TESTES.md`
- 🎨 `docs/MATRIZ_VISUAL.md`
- 🔬 `docs/GUIA_PESQUISA_E_IMPLEMENTACAO.md`
- 🗂️ `docs/REGRAS_ARQUIVOS.md`
- 🚀 `docs/MODULOS_FUTUROS.md`

---

## 🧪 STATUS ATUAL

**Pesquisa:** 🟢 avançando  
**Arquitetura:** 🟢 consolidada  
**Documentação:** 🟢 ativa  
**Componentes concretos:** 🟡 em desenvolvimento  
**Valores finais:** 🟡 dependem de testes reais  
**Release pública:** 🔴 ainda não

---

## 🗺️ ROADMAP

- [x] 🧠 Arquitetura inicial
- [x] 🇧🇷 Documentação PT-BR
- [x] 💡 Sistema de iluminação
- [x] 🌊 Sistema de água/reflexos
- [x] ☁️ Sistema de céu/atmosfera
- [x] 🚘 Sistema de veículos
- [x] ⚡ Estratégia de performance
- [x] 🛡️ Regras de compatibilidade
- [ ] 🎨 Primeiro pipeline ReShade próprio
- [ ] 🌦️ Primeiro pacote de clima
- [ ] 💡 Primeiro pacote de iluminação experimental
- [ ] 🧪 Testes reais no FiveM
- [ ] 📦 Primeiro release instalável

---

## ❤️ FILOSOFIA

> **“Não queremos o gráfico mais exagerado. Queremos o gráfico que você olha durante horas e continua parecendo bonito.”**

🇧🇷 Feito para o projeto **Silva Vision**.

⭐ Se você acompanhar o projeto, acompanhe também as mudanças e a documentação: cada upgrade deve explicar **o que mudou, por que mudou e como validar**.
