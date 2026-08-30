# ⚡ Silva Vision — Perfis de Qualidade

## 🟢 SAFE

Objetivo: identidade visual com custo mínimo.

- correção de cor;
- tonemapping;
- exposição controlada;
- debanding quando necessário;
- sharpen leve.

## 🟢 PERFORMANCE

Objetivo: melhorar a imagem sem depender de efeitos caros por profundidade.

Prioridade para efeitos de baixo custo e mudanças no pipeline de cor.

## 🟢 BALANCED

Perfil principal planejado.

Combina iluminação visual, tratamento de cor e efeitos seletivos, mantendo um orçamento de GPU.

## 🟡 HIGH

Pode usar efeitos depth mais caros, desde que o custo seja medido e haja fallback.

## 🟡 ULTRA

Voltado para screenshots e hardware mais forte. Não significa “ligar tudo”.

## 🧠 Regra adaptativa

O futuro sistema de diagnóstico poderá sugerir um perfil baseado no custo observado, mas nunca deverá prometer FPS específico antes de medir a máquina e o cenário.

## 🎯 Filosofia

**Qualidade por watt/frame, não quantidade de shaders.**
