# Silva Vision — Pesquisa gráfica 2026

> Pesquisa técnica para decidir o que vale entrar no projeto. Nada abaixo é considerado validado no FiveM até passar por benchmark real.

## Conclusões principais

### 1. Pós-processamento seletivo

A pesquisa em ReShade mostra uma diferença grande entre técnicas. Correção de cor, níveis, curvas, vibrance e sharpening simples são candidatos fortes para o perfil Balanced. Efeitos baseados em profundidade, AO e alguns blooms/blur podem consumir muito mais GPU.

**Decisão:** o Balanced terá poucas passagens e nenhum efeito caro obrigatório.

### 2. Sharpening

LumaSharpen e alternativas leves devem ser avaliados antes de usar AA pesado. A biblioteca do ReShade documenta técnicas de sharpening e controle de halo. O repositório qUINT também oferece DELC Sharpen, pensado para preservar contraste local e reduzir artefatos.

**Decisão:** criar um módulo de nitidez com limite e intensidade controláveis.

### 3. Anti-aliasing

SMAA é uma opção interessante, mas não deve ser colocado automaticamente em qualidade máxima. O fórum oficial do ReShade registra que SMAA possui múltiplas passagens e que reduzir etapas pode diminuir custo. Também existem variantes mais enxutas, como FSMAA.

**Decisão:** testar AA em níveis baixo/médio e comparar com o AA nativo do GTA V.

### 4. Bloom

Bloom pode melhorar iluminação e letreiros, mas blur multipassado pode aumentar o custo. A coleção Anagrama documenta custos de referência para alguns efeitos em uma RTX 3070 a 4K; esses números não devem ser tratados como previsão para o PC do usuário.

**Decisão:** bloom baixo e opcional; nada de bloom exagerado no Balanced.

### 5. AO / profundidade

AO baseado em depth buffer pode entregar profundidade visual, mas aparece repetidamente na pesquisa como uma das áreas de maior custo. Em comunidades de FiveM, configurações de AO pesado também são associadas a quedas importantes.

**Decisão:** AO desligado no Performance e Balanced inicialmente; testar uma versão leve separadamente.

### 6. Timecycle / visualsettings

A pesquisa sobre GTA V indica que mudanças em `visualsettings.dat` e timecycle podem alterar iluminação, coronas, neblina, tonemap e exposição sem depender de uma pilha enorme de shaders. Isso é especialmente interessante para o objetivo de qualidade por FPS.

**Decisão:** priorizar ajustes próprios e controlados de iluminação antes de adicionar mais efeitos de pós-processamento.

### 7. Distância e luzes

Aumentar indiscriminadamente distância de renderização, distância das luzes ou quantidade de elementos visíveis pode gerar custo. Mods de referência oferecem versões de performance justamente reduzindo distância de iluminação e veículos.

**Decisão:** não aumentar distância global por padrão. Usar melhorias localizadas e medir.

### 8. Reflexos

Reflexos são visualmente importantes para veículos, chuva e superfícies molhadas, mas soluções de screen-space podem ter custo variável e limitações de material.

**Decisão:** testar reflexos de forma isolada no perfil Quality; não tornar SSR obrigatório no Balanced.

### 9. Céu, clima e atmosfera

Uma grande parte da aparência pode vir de exposição, temperatura de cor, neblina, densidade atmosférica e equilíbrio de céu/sol. Essas mudanças podem produzir grande diferença perceptual sem exigir uma sequência longa de shaders.

**Decisão:** criar uma camada de atmosfera baseada em presets de clima/horário.

### 10. Performance Mode

O Performance Mode do ReShade é uma etapa de finalização: ele compila os efeitos ativos com opções configuráveis transformadas em constantes. Não deve ser usado durante a fase de ajuste fino. A pesquisa também mostra que limitar a instalação aos shaders realmente utilizados reduz compilação e organização desnecessárias.

**Decisão:** configurar o preset primeiro, validar, e só depois finalizar em Performance Mode.

## O que será priorizado

| Recurso | Visual | Custo esperado | Prioridade |
|---|---:|---:|---:|
| Color grading | Alto | Baixo | Alta |
| Exposure / tonemap | Alto | Baixo | Alta |
| Sharpening controlado | Alto | Baixo | Alta |
| Atmosfera / timecycle | Alto | Baixo–médio | Alta |
| Iluminação nativa ajustada | Alto | Baixo–médio | Alta |
| AA leve | Médio–alto | Baixo–médio | Média |
| Bloom leve | Médio | Baixo–médio | Média |
| SSR | Alto | Médio–alto | Baixa no Balanced |
| AO depth-based | Alto | Alto | Opcional |
| DOF | Alto em screenshots | Alto | Cinematic |
| RTGI / iluminação ray traced | Alto | Muito alto | Fora do objetivo principal |

## Fontes consultadas

- ReShade — documentação e código-fonte oficial.
- ReShade shader collection.
- qUINT.
- ReShade Forum — Performance Mode.
- ReShade Forum — SMAA/LumaSharpen.
- Anagrama shader collection.
- FiveM/Cfx community discussions.
- Reddit r/FiveM.
- Reddit r/GTAV_Mods.
- Reddit r/ReShade.
- Nexus Mods — presets e mods de GTA V/FiveM.
- GitHub — projetos de visualsettings e shaders.
- YouTube — showcases e tutoriais de FiveM/ReShade.

## Regra de propriedade intelectual

A pesquisa serve para estudar técnicas. O Silva Vision deve usar código, shaders, texturas e assets somente quando a licença permitir. Não copiar arquivos de mods comerciais ou redistribuir assets sem autorização.
