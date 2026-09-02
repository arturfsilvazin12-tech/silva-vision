# Silva Vision V0.5 — Mega Block 23

## Objetivo
Consolidar o controle visual contextual sem aumentar o risco de incompatibilidade com servidores FiveM.

## Entradas
- ciclo solar local: sunrise, day, golden hour, sunset, night
- clima observado: rain, storm, fog, overcast, wet, visibility
- reflexão/água
- contexto de emergência
- budget de desempenho
- exposure guard e lighting balance

## Novos módulos
- `core/client/visual_light_governor.lua`
- `core/client/visual_weather_fx.lua`

Ambos são **CLIENT ONLY / STATE ONLY** e não escrevem `VisualSettings`.

## Central Apply
A camada central continua sendo a única autorizada a escrever `VisualSettings`, e somente através de `IsVisualSettingValidated`. Nenhuma chave de streetlight, corona ou emissive foi liberada por suposição.

## Performance
O Light Governor limita o peso de demandas luminosas usando o budget existente. Chuva e efeitos meteorológicos recebem pesos graduais, sem alterar o clima do servidor.

## Segurança de compatibilidade
- sem forcing de weather
- sem dependência de servidor
- sem alterações de entidade para emergência
- sem parâmetros especulativos de iluminação urbana
- V04/timecycle permanece separado

## Diagnóstico
Comandos novos:
- `svlightgov show`
- `svweatherfx show`

Comandos existentes continuam disponíveis:
- `svcomposer show`
- `svapply show`
- `svintegrity show`
- `svstatus`
- `svlayers`

## Estado
Mega Block 23 está preparado para teste local no FiveM. O comportamento visual final ainda depende da execução real no cliente e da combinação de ReShade + Timecycle + ambiente do servidor.
