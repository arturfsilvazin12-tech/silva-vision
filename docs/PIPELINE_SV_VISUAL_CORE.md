# 🧠 Silva Vision — Pipeline Visual Core

## 🎯 Arquitetura própria

O Silva Vision passa a separar o pós-processamento em estágios. A ordem abaixo é uma arquitetura de desenvolvimento; ela ainda precisa ser validada no jogo.

```text
FRAME
  ↓
📷 INPUT
  ↓
☀️ EXPOSURE
  ↓
🎞️ TONEMAP
  ↓
🌡️ WHITE BALANCE
  ↓
🎨 COLOR ANCHOR
  ↓
🌗 LOCAL CONTRAST
  ↓
✨ SELECTIVE BLOOM
  ↓
🧠 OPTIONAL DEPTH FX
  ↓
🔍 SHARPEN
  ↓
🖥️ OUTPUT
```

## 🧠 SV Color Anchor

O look não deve depender de saturação global. O Color Anchor será usado como referência para manter pele, vegetação, céu, luzes e superfícies dentro de uma faixa visual coerente.

## ✨ Selective Bloom

Bloom deve responder a fontes luminosas fortes, não a qualquer pixel claro. A implementação final deve usar threshold e controle de intensidade.

## 🔍 Sharpen

Sharpen é o último estágio visual. Deve ser suficiente para recuperar percepção de detalhe sem criar halos em fios, prédios ou bordas de veículos.

## 🧠 Depth

Depth é opcional. Se a entrada estiver inválida, o pipeline deve continuar com uma rota sem efeitos depth.

## ⚡ Performance

Cada estágio deverá receber uma classificação de custo antes de ser ativado nos perfis públicos.

## 🧪 Validação

O pipeline precisa ser comparado em:

- dia;
- noite;
- pôr do sol;
- chuva;
- cidade iluminada;
- estrada escura;
- veículos próximos;
- câmera em movimento.

## 📌 Estado

🟡 **Arquitetura experimental.** Este documento define a direção do pipeline; não afirma que todos os estágios já estejam implementados.
