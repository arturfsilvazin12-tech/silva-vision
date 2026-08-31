# 🔬🇧🇷 RELATÓRIO — MEGA PESQUISA SILVA VISION

**Data:** 30/08/2026  
**Objetivo:** pesquisar técnicas relevantes para construir o Silva Vision, separar inspiração de tecnologia realmente aplicável e transformar os melhores achados em decisões próprias.

## 🧠 Resumo executivo

A pesquisa mostrou que o maior ganho não vem de empilhar dezenas de shaders. Os projetos mais úteis trabalham em camadas: correção de cor, exposição, bloom, LUT, profundidade e efeitos específicos. O repositório prod80, por exemplo, possui efeitos separados para bloom, sharpening, LUT, adaptação filmic e correção de cor; vários podem trabalhar seletivamente com depth/shadows/midtones/highlights. citeturn0search0turn0search5turn0search6turn0search8turn0search9

### 🎯 Decisão Silva Vision

O projeto vai priorizar **poucos efeitos bem calibrados**, com perfis diferentes e uma cadeia de processamento previsível. Não vamos copiar presets inteiros nem redistribuir shaders de terceiros sem verificar licença.

---

# 1. 🎨 PIPELINE DE COR

### O que encontramos

O ecossistema ReShade possui ferramentas avançadas de correção de cor, LUT, adaptação e separação de sombras/meios-tons/highlights. O repositório prod80 é MIT e organiza os efeitos em uma ordem sugerida. citeturn0search0turn0search4

### 🧠 O que vamos criar

Um **Silva Color Pipeline** conceitual:

```text
BACKBUFFER
   ↓
EXPOSIÇÃO / BALANÇO
   ↓
CORREÇÃO DE CONTRASTE
   ↓
TONEMAPPING
   ↓
COR DOS MEIOS-TONS
   ↓
HIGHLIGHTS CONTROLADOS
   ↓
LUT OPCIONAL
   ↓
DEBANDING / DITHER
   ↓
SHARPEN FINAL
```

### 🚫 Decisão

Não colocar LUT + correção pesada + saturação global simultaneamente por padrão.

---

# 2. ✨ BLOOM INTELIGENTE

O shader de bloom do prod80 demonstra uma abordagem com limiar de luminância e diferentes níveis de qualidade; o próprio código documenta uma opção de qualidade alta que reduz bastante o custo em relação ao modo de maior qualidade. citeturn0search5

### 🧠 Ideia própria

Criar futuramente o conceito **SV Bloom Budget**:

- fontes muito brilhantes → bloom;
- fontes médias → pouco/no bloom;
- superfícies normais → nenhum bloom;
- perfil Performance → bloom mínimo;
- Balanced → bloom moderado;
- Ultra → bloom de maior qualidade.

Isso evita o visual de “cidade inteira brilhando”.

---

# 3. 🧪 LUT COMO OTIMIZAÇÃO

O `PD80_02_LUT_Creator.fx` descreve um fluxo para criar uma LUT a partir de uma cadeia de efeitos e depois substituir várias operações de cor por uma textura LUT, reduzindo o custo de aplicar múltiplas transformações. citeturn0search7

### 🚀 Upgrade Silva Vision

Criar futuramente **SV LUT Factory**:

```text
CRIAR LOOK
   ↓
CALIBRAR
   ↓
GERAR LUT
   ↓
VALIDAR
   ↓
USAR LUT NO RELEASE
```

A ideia é reservar shaders complexos para desenvolvimento e produzir uma versão mais barata para o preset final quando o resultado puder ser representado por LUT.

---

# 4. 🌗 SOMBRAS / MEIOS-TONS / HIGHLIGHTS

O shader `PD80_03_Shadows_Midtones_Highlights.fx` existe especificamente para manipular regiões tonais separadas. citeturn0search9

### 🧠 Decisão própria

Em vez de “aumentar contraste” globalmente:

- 🌑 sombras → preservar detalhe;
- 🌓 meios-tons → definir aparência principal;
- ☀️ highlights → proteger clipping.

Esse será o princípio do perfil **SV Neutral**.

---

# 5. 🔍 DEPTH

A pesquisa reforça que depth pode tornar efeitos seletivos muito mais interessantes, mas também aumenta a complexidade de compatibilidade.

### 🧠 Nova regra

Nenhum efeito dependente de depth entra no preset base sem um **Depth Gate**:

```text
DEPTH DISPONÍVEL?
      ├── SIM → efeito permitido
      └── NÃO → fallback seguro
```

---

# 6. 🪄 SHARPENING

O repositório prod80 mantém sharpening dedicado e licenciado em MIT. citeturn0search6

### 🧠 Decisão

Sharpen será sempre **último ou quase último** estágio do pipeline e terá intensidade baixa no Neutral.

Objetivo:

> recuperar percepção de detalhe sem transformar bordas em halos.

---

# 7. 🚫 ABERRAÇÃO CROMÁTICA

Existe um shader dedicado de chromatic aberration, mas a pesquisa não encontrou justificativa para colocá-lo como efeito padrão realista. citeturn0search11

### 🔴 Decisão

**Não usar no SV Neutral/Balanced.**

Poderá existir futuramente em um perfil Cinematic experimental, com intensidade extremamente baixa.

---

# 8. 🌐 COMUNIDADE FIVE M

Relatos comunitários indicam que ReShade costuma ser a opção simples para melhoria visual, enquanto pacotes que alteram mais profundamente o jogo podem entregar ganhos maiores com custo e complexidade maiores. Isso é evidência comunitária, não benchmark universal. citeturn0reddit128

### 🧠 Decisão

O Silva Vision será modular para que o usuário possa escolher o nível de intervenção.

---

# 9. 🏗️ NOVA ARQUITETURA DE RELEASE

```text
🇧🇷 SILVA VISION
│
├── 🟢 SV NEUTRAL
│   └── base visual leve
│
├── ⭐ SV BALANCED
│   └── pipeline principal
│
├── 🌙 SV NIGHT
│   └── iluminação urbana
│
├── 🌧️ SV RAIN
│   └── clima/superfícies
│
├── 🎬 SV CINEMATIC
│   └── efeitos artísticos opcionais
│
└── 💎 SV ULTRA
    └── efeitos de maior custo
```

---

# 10. 🧠 O QUE FOI REJEITADO

Não vamos colocar no projeto apenas porque apareceu em um tutorial:

- ❌ chromatic aberration padrão;
- ❌ bloom máximo;
- ❌ sharpen extremo;
- ❌ saturação global exagerada;
- ❌ depth effects sem fallback;
- ❌ dezenas de shaders duplicando funções;
- ❌ assets de terceiros sem licença compatível;
- ❌ promessa de FPS baseada em outra máquina.

---

# 11. 🚀 UPGRADES CRIADOS A PARTIR DA PESQUISA

### 🆕 SV Bloom Budget
Controle de bloom por perfil.

### 🆕 SV LUT Factory
Fluxo de criação de LUT para reduzir custo do look final.

### 🆕 SV Depth Gate
Fallback para efeitos que precisam de profundidade.

### 🆕 SV Color Pipeline
Ordem oficial de processamento de cor.

### 🆕 SV Quality Budget
Todo efeito precisa declarar custo/benefício.

### 🆕 SV Neutral como referência
Preset base para A/B contra o jogo original.

---

# 📌 Conclusão

A pesquisa não será usada para copiar outros mods. Ela serve para descobrir **princípios técnicos, problemas recorrentes e soluções verificáveis**.

O Silva Vision vai transformar essas ideias em implementação própria, documentação em PT-BR e componentes modulares.

**Status:** 🟡 Pesquisa avançada → implementação progressiva.
