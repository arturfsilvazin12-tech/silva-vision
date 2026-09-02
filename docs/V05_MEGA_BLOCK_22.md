# Silva Vision V0.5 — MEGA BLOCK 22

## Objetivo

O Mega Block 22 transforma o pipeline visual em uma camada de equilíbrio contínuo. O foco é melhorar iluminação noturna, chuva/reflexos, exposição e coerência entre luz ambiente, luz distante, faróis e cenas de emergência sem depender do servidor.

## Novos módulos

- `visual_exposure_guard.lua` — limita extremos de exposição e entrega um fator seguro.
- `visual_reflection_director.lua` — consolida reflexo de chuva/água/puddle com o budget.
- `visual_lighting_balance.lua` — calcula equilíbrio entre ambiente, luz urbana, faróis e emergência.

Todos são **CLIENT ONLY / STATE ONLY**.

## Composer 22

O Composer agora recebe:

`Scene + Solar Cycle + Weather Blend + Emergency Scene + Reflection + Exposure + Lighting Balance + Budget`

E produz um pacote único para o Central Apply.

## Central Apply 22

Continua sendo a única camada autorizada a escrever `SetVisualSettingFloat`.

As escritas continuam restritas ao catálogo de chaves já validadas. Não foram liberadas chaves especulativas de `streetlight`, `coronastar` ou `emissive`.

## Segurança

- Não força clima do servidor.
- Não altera sirene, estado de veículo ou entidades.
- Não exige recurso server-side.
- Não altera nomes existentes do projeto.
- Não substitui o Timecycle V04.
- Não modifica o pipeline ReShade que não está versionado no repositório.

## Diagnóstico

`svstatus` agora mostra exposição, balanço de iluminação, reflexos de água e fator de poça.

`svintegrity show` verifica os novos exports.

## Teste local

Depois de atualizar o recurso no FiveM:

```text
svintegrity recheck
svstatus
svcomposer show
svexposure show
svreflection show
svlightbalance show
```

O objetivo do teste é verificar `integrity=OK` e observar os fatores mudando naturalmente entre dia/noite, seco/chuva e interior/exterior.

## Estado

**Código:** integrado no GitHub.

**Runtime FiveM:** ainda precisa de teste real no PC.

**Streetlight/corona/emissive:** continuam bloqueados até validação real do `visualsettings.dat`.
