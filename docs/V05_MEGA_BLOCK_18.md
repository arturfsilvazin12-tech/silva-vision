# Silva Vision V0.5 — Mega Block 18

## Objetivo

Mega Block 18 fecha a camada de integridade do runtime antes de novos efeitos. O objetivo é impedir que o projeto acumule módulos que chamam exports inexistentes ou com nomes divergentes.

## O que foi consolidado

- `visual_weather_finish.lua` confirma a exportação `GetWeatherFinishState`.
- `visual_quality_director.lua` confirma a exportação `GetVisualQualityContext`.
- `master_director.lua` consome os nomes reais dessas exports.
- `fxmanifest.lua` inclui `visual_weather_finish.lua` e o novo `runtime_integrity.lua` em ordem explícita.
- Versão do core elevada para `0.5.0-dev-mega-block-18`.

## Novo diagnóstico

`core/client/runtime_integrity.lua` verifica, após a inicialização, as principais exports usadas pelo grafo visual.

Comandos:

```text
svintegrity show
svintegrity recheck
svintegrity on
svintegrity off
```

Estado esperado:

```text
integrity=OK
exports=17/17
missing=0
```

## Regra de segurança

O Integrity é somente diagnóstico. Ele não escreve `VisualSettings`, não força clima, não altera entidades e não depende de servidor.

## Próxima etapa

Com o grafo de runtime validado no FiveM, a próxima fase pode concentrar-se no acabamento visual forte: iluminação noturna, chuva/reflexos, atmosfera, emergência e ReShade, sempre usando chaves e técnicas já validadas.
