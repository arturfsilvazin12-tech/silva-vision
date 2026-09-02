# Silva Vision V0.5 — Mega Block 20

## Objetivo

Construir uma camada de composição visual em tempo real entre contexto do mundo, orçamento de performance e Central Apply.

## Novos componentes

### Visual Composer
`core/client/visual_composer.lua`

Consolida Scene, Weather Finish, Water Reflection e Budget em fatores suaves:

- noite;
- superfície molhada;
- tempestade;
- neblina;
- demanda urbana;
- reflexos;
- atmosfera;
- fator cinematográfico;
- peso de iluminação;
- peso de chuva.

O Composer é **state-only**.

### Profile Director
`core/client/visual_profile_director.lua`

Calcula uma recomendação de perfil baseada em contexto e desempenho. Não substitui um perfil manual.

Regras principais:

- desempenho pesado → Performance;
- interior → Balanced;
- emergência → Quality;
- noite → Quality;
- cena cinematográfica → Cinematic;
- chuva → Quality;
- restante → Balanced.

## Central Apply V20

O Central Apply passou a consumir o Composer. Os fatores compostos modulam somente nomes presentes no catálogo validado.

Continuam bloqueados:

- `streetlight.color.*`;
- `coronastar.*`;
- `vehicleinteriorlight.*`;
- `emissive.multiplier`;
- qualquer chave não validada.

## Pipeline

```text
Client Guard
  ↓
Compatibility
  ↓
Policy
  ↓
Scene
  ↓
Weather Finish
  ↓
Water / Atmosphere
  ↓
Budget
  ↓
Visual Composer
  ↓
Profile Director
  ↓
Central Apply
  ↓
Timecycle / ReShade
```

## Comandos novos

- `svcomposer show`
- `svcomposer on`
- `svcomposer off`
- `svcomposer reapply`
- `svprofilerec show`
- `svprofilerec on`
- `svprofilerec off`

## Segurança

O bloco permanece client-only. Não controla clima do servidor, não altera handling, não depende de recurso server-side e não libera parâmetros de iluminação urbana sem validação.

## Teste

Após sincronizar a build no FiveM:

1. `svintegrity recheck`
2. `svscene show`
3. `svcomposer show`
4. `svprofilerec show`
5. `svstatus`
6. `svapply show`

A validação visual real continua dependendo do teste dentro do FiveM.
