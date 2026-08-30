# ⚡ Silva Vision — Performance V1

## 🎯 Objetivo

Manter a identidade visual com o menor custo possível.

## 🧮 Orçamento

Cada efeito futuro recebe:

- custo estimado;
- dependência de depth;
- risco de artefato;
- ganho visual;
- perfil recomendado;
- fallback.

## 🟢 Balanced

Prioriza correção de cor, tonemapping, exposição, debanding e nitidez controlada. Evita efeitos caros quando o ganho visual for pequeno.

## 🔵 High

Permite efeitos adicionais de profundidade e reflexos quando o custo for justificável.

## 🔴 Ultra

Pode usar efeitos pesados, mas não liga tudo automaticamente. Qualquer efeito que introduza artefatos ou custo desproporcional pode ser excluído.

## 🧪 Benchmark

Comparar a mesma cena com:

1. jogo original;
2. Silva Neutral;
3. Balanced;
4. High;
5. Ultra.

Registrar FPS médio, 1% low, GPU ms, VRAM, resolução, horário e clima.

## 🛡️ Fallback

Se depth, shader ou componente externo falhar, o preset deve continuar utilizável com o componente problemático desativado.
