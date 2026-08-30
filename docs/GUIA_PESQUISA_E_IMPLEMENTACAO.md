# 🔬 Silva Vision — Guia de Pesquisa e Implementação

> 🇧🇷 Documento central do desenvolvimento. O objetivo é transformar pesquisa pública em decisões técnicas reproduzíveis, sem copiar assets de terceiros.

## 🧭 Como uma descoberta entra no projeto

1. 🔎 Encontrar a técnica em documentação, código público ou relatos da comunidade.
2. 🧪 Verificar se a técnica é relevante para GTA V/FiveM e para a arquitetura atual.
3. ⚖️ Verificar licença quando houver código ou asset reutilizável.
4. 🧩 Isolar a função: iluminação, clima, água, cor, profundidade, AA ou desempenho.
5. 🛡️ Definir fallback e rollback.
6. 📊 Definir como medir qualidade e custo.
7. 📝 Registrar a decisão.
8. 🚦 Só promover para release depois de validação.

## 🧠 Regra de ouro

**Uma screenshot bonita não é prova de uma implementação boa.** O Silva Vision deve ser avaliado em gameplay, diferentes horários, climas, movimento e desempenho.

## 🧱 Camadas

### 🌎 Mundo
Atmosfera, céu, nuvens, vegetação, materiais, água, LOD e streaming.

### 💡 Iluminação
Sol, postes, interiores, emissivos, veículos, neon, emergência, chuva e reflexos.

### 🌦️ Clima
Timecycle, exposição, umidade, chuva, trovoada, neblina e transições.

### 🎨 Pós-processamento
Tonemapping, exposição, cor, contraste, deband, AA e nitidez.

### ⚡ Desempenho
Orçamento de GPU, resolução, depth, custo por shader, compatibilidade e fallback.

## 🧪 Estados de implementação

- 🟢 **Estável:** validado e adequado para release.
- 🟡 **Experimental:** tecnicamente promissor, ainda exige teste real.
- 🟠 **Pesquisa:** hipótese ou técnica em investigação.
- 🔴 **Rejeitado:** causa conflito, custo excessivo ou resultado ruim.

## 🚫 O que não fazer

- Não renomear arquivos nativos sem necessidade.
- Não empilhar três sistemas para resolver o mesmo problema.
- Não usar valores arbitrários como se fossem definitivos.
- Não distribuir assets de terceiros sem licença compatível.
- Não declarar FPS garantido sem benchmark.
- Não considerar ENB/ReShade/Citizen universalmente compatíveis.

## 📦 Objetivo final

Uma distribuição modular com presets e componentes independentes, permitindo atualizar iluminação, clima ou pós-processamento sem reconstruir o projeto inteiro.
