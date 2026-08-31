# 🌐🔬 Silva Vision — Pesquisa Multi-Fonte

> Rodada de pesquisa cruzada: Reddit, Cfx.re, ReShade, GitHub, GTA5-Mods, Discord e comunidades de modding. O objetivo é extrair padrões técnicos e não copiar trabalhos de terceiros.

## 🧭 Fontes consultadas

- 🔴 Reddit: GTAV_Mods, FiveM, ReShade, Gta5Modding
- 🟣 Cfx.re / FiveM
- 🎨 ReShade Forum
- 🧑‍💻 GitHub / ReShade / ferramentas públicas
- 🎮 GTA5-Mods.com
- 💬 comunidades Discord públicas de graphics/FiveM
- 🎥 YouTube: tutoriais e demonstrações de pipelines gráficos

## 🔥 Descobertas que mudam o projeto

### 1. Timecycle pode entregar muito visual com custo menor
Relatos recentes de modders mostram que alterações específicas em timecycle podem produzir mudanças perceptíveis sem necessariamente exigir uma grande pilha de shaders. Isso reforça uma arquitetura híbrida: primeiro corrigir dados do jogo, depois pós-processamento.

### 2. Sunset precisa ser tratado por horário
A comunidade aponta que o laranja excessivo do nascer/pôr do sol pode ser corrigido nos valores específicos de zenith, céu, fog/falloff e cor solar, em vez de aplicar um filtro laranja global.

### 3. Banding noturno é um problema real
Discussões de mods atuais citam banding no céu, especialmente à noite e durante chuva. A solução pesquisada inclui debanding no pós-processamento, mas o Silva Vision deve primeiro evitar criar o problema com exposição/gradientes agressivos.

### 4. Poças possuem problemas próprios
Relatos sobre poças que aparecem/desaparecem à distância mostram que reflexo de superfície e distância de desenho não são a mesma coisa. O sistema de chuva precisa separar umidade, puddles, reflexos e LOD.

### 5. ReShade + FiveM tem problemas específicos
Existem relatos de instalação, detecção e compatibilidade variando entre versões e configurações do FiveM. O instalador futuro deve possuir diagnóstico e fallback, em vez de presumir que qualquer DLL funciona em qualquer configuração.

### 6. Depth é uma camada de risco
A documentação/fórum do ReShade mostra que depth pode depender de AA, configuração do buffer e contexto de aplicação. Em ambientes online, o acesso ao depth também possui restrições. Portanto, efeitos dependentes de depth não serão obrigatórios no perfil Balanced.

### 7. GPU ms importa mais que “FPS percebido”
Há relatos de FiveM/ReShade em que o custo total de GPU aumenta drasticamente durante determinadas condições. O projeto deve registrar GPU ms por efeito sempre que possível.

### 8. Efeitos devem ter orçamento
Bloom, SSR, AO, DOF e RT-like effects podem ser visualmente fortes, mas devem justificar o custo. A regra passa a ser **qualidade visual por milissegundo**.

### 9. Comunidades brasileiras mostram demanda por presets + graphics completos
Discords públicos de FiveM/GTAV mostram um ecossistema grande de presets, graphics packs e suporte de instalação. Isso indica que o Silva Vision deve ser fácil de instalar e possuir documentação clara, não apenas arquivos técnicos.

### 10. Mods atuais sugerem uma arquitetura híbrida
Os projetos mais interessantes combinam mudanças no jogo com pós-processamento. O Silva Vision seguirá esse caminho, mas com módulos independentes e rollback.

## 🧠 Decisões próprias do Silva Vision

### ⭐ SV Neutral
Referência visual. Poucos efeitos e custo previsível.

### ⚡ SV Balanced
Correção de cor + exposição + nitidez controlada; efeitos caros opcionais.

### 🌙 SV Night
Desenvolvido separadamente para não destruir o equilíbrio do dia.

### 🌧️ SV Rain
Clima tratado como conjunto: atmosfera + partículas + superfície + iluminação.

### 🎬 SV Cinematic
Efeitos artísticos separados do perfil de gameplay.

## 🚫 O que foi rejeitado

- copiar presets comerciais;
- copiar texturas ou shaders sem licença;
- usar 20 efeitos para “parecer Ultra”;
- aumentar farclip sem medir streaming/LOD;
- usar bloom global para compensar iluminação fraca;
- aplicar laranja global no pôr do sol;
- depender obrigatoriamente de depth no FiveM;
- prometer FPS sem benchmark.

## 🧪 Experimentos criados a partir da pesquisa

1. **SV Color Anchor** — referência neutra para impedir que cada preset altere a identidade cromática.
2. **SV Weather Matrix** — matriz de dia/noite × clima para validar transições.
3. **SV Bloom Budget** — orçamento por categoria de fonte luminosa.
4. **SV Depth Gate** — fallback automático de efeitos que precisam de depth.
5. **SV GPU Budget** — classificação de efeitos por ganho visual/custo.
6. **SV Rain Surface Model** — separar umidade, puddles e reflexo.
7. **SV Sunset Control** — controle específico de 17h–20h em vez de filtro global.
8. **SV Artifact Watchlist** — banding, ghosting, flicker, halos, clipping e LOD pop.

## 📌 Conclusão

A pesquisa não aponta para um único “mod mágico”. O padrão mais útil é uma combinação cuidadosa de dados do jogo, timecycle/visual settings, pós-processamento e otimização. O Silva Vision vai construir seus próprios componentes a partir desses princípios, mantendo referências e licenças separadas de qualquer código/asset redistribuído.
