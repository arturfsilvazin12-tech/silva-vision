# 🎨 Silva Vision — Pipeline de Cor

## 🎯 Objetivo

Construir uma imagem com aparência natural e cinematográfica sem depender de saturação exagerada.

## 🔗 Ordem conceitual

```text
JOGO
 ↓
Exposição
 ↓
Balanço de branco
 ↓
Tonemapping
 ↓
Contraste
 ↓
Curvas/LUT
 ↓
Correção seletiva
 ↓
Debanding
 ↓
Nitidez final
```

## ☀️ Dia

Priorizar detalhe em céu e superfícies. Highlights devem ter roll-off; sombras devem conservar informação.

## 🌅 Golden hour

A temperatura quente deve ser localizada pela iluminação e pelo balanço de branco. Evitar aplicar laranja sobre toda a imagem.

## 🌙 Noite

Não compensar uma iluminação ruim levantando a exposição global. A iluminação artificial deve criar contraste local.

## 🌧️ Chuva

A correção deve considerar que superfícies molhadas produzem highlights e reflexos mais fortes. O pós-processamento não deve criar reflexos onde o motor não os possui.

## 🧪 LUT

LUTs serão tratados como camada de look, não como correção universal. O projeto deve manter um perfil neutro para comparação A/B.

## 🛡️ Segurança

Evitar clipping de branco, esmagamento de preto, banding e halos de sharpening.

## 📌 Referências técnicas

A biblioteca prod80 demonstra uma abordagem detalhada de cor/contraste, com efeitos organizados por ordem sugerida e suporte a processamento seletivo por profundidade, sombras, meios-tons e highlights. A implementação final do Silva Vision deve respeitar licenças e manter identidade própria.
