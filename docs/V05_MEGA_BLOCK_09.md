# Silva Vision V0.5 — Mega Block 09

## Objetivo

Adicionar transição visual contextual sem criar um segundo writer de `VisualSettings`.

## Alterações

### `core/client/visual_transition_director.lua`

Novo módulo **CLIENT ONLY / STATE ONLY**.

Ele observa:
- hora/fase: sunrise, day, sunset, night;
- clima já presente no cliente;
- chuva;
- tempestade;
- fator noturno.

Os valores são suavizados para evitar mudanças bruscas quando o relógio ou o clima muda.

### `core/client/visual_apply.lua`

O Central Apply agora consome o estado do Transition Director para contextualizar:
- distant lights;
- reflexos distantes;
- upscale das luzes distantes;
- chuva;
- intensidade de chuva em tempestade;
- faróis noturnos/emergência.

Somente chaves já aceitas pelo catálogo de validação continuam podendo ser escritas.

### `core/fxmanifest.lua`

Registrado o novo módulo e versão elevada para:

`0.5.0-dev-mega-block-09`

## Segurança arquitetural

- Não força clima do servidor.
- Não depende de recurso server-side.
- Não altera gameplay.
- Não escreve chaves streetlight/corona/emissive ainda pendentes.
- Não substitui o V04 Timecycle.
- Central Apply continua sendo o único writer de `VisualSettings`.

## Comandos de diagnóstico

`svtransition show`

`svapply show`

`svlighting show`

`svcontext show`

`svfinish show`

`svbudget show`

## Estado

**Implementado no GitHub. Teste visual no FiveM ainda necessário.**
