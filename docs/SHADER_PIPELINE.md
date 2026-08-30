# 🎨 Silva Vision — Pipeline de Shaders

## Ordem-base

```text
1️⃣ Diagnóstico de depth (somente desenvolvimento)
2️⃣ AA, se necessário e compatível
3️⃣ Exposição / balanço de branco
4️⃣ Tonemapping / rolloff de highlights
5️⃣ Curvas / cor seletiva / LUT
6️⃣ Contraste local, se necessário
7️⃣ Efeitos dependentes de depth
8️⃣ Bloom/glow controlado
9️⃣ Debanding/dithering
🔟 Sharpen final
```

## 🧠 Por que a ordem importa?

Um shader de cor aplicado antes do tonemapping não produz necessariamente o mesmo resultado depois dele. O Silva Vision não vai usar ordem alfabética nem “liga tudo”.

## 🛡️ Depth Gate

Efeitos que dependem do depth buffer:

- MXAO/SSAO;
- SSR;
- GI/RTGI-style;
- DOF;
- depth fog;
- depth outlines.

Se o depth estiver ausente, invertido, instável ou incompatível com a combinação de AA/upscaling, o efeito cai para um **fallback seguro**.

## ⚡ Perfis

| Perfil | Objetivo |
|---|---|
| 🛡️ SAFE | diagnóstico e estabilidade |
| 🚀 PERFORMANCE | máximo ganho visual por custo |
| ⚖️ BALANCED | preset principal |
| 🔥 HIGH | qualidade elevada |
| 💎 ULTRA | qualidade máxima compatível |

## 🚫 Proibições

- duas nitidezes fazendo o mesmo trabalho;
- vários blooms concorrendo;
- AO + GI + SSR sem justificativa;
- DOF em gameplay por padrão;
- efeito caro sem fallback;
- usar sharpen para mascarar baixa qualidade de textura/LOD.

## 📌 Registro obrigatório de shader

Todo efeito novo precisa registrar:

`finalidade → dependência → ganho visual → custo → artefatos → fallback → perfil recomendado`

## 🔬 Fontes de pesquisa

A arquitetura foi comparada com coleções públicas de ReShade. O repositório oficial `crosire/reshade-shaders` é uma referência importante para o ecossistema; `prod80-ReShade-Repository` é referência especialmente útil para cor, contraste, exposição, LUT e processamento seletivo. Não copiamos efeitos automaticamente: licença e compatibilidade precisam ser verificadas antes de redistribuição.
