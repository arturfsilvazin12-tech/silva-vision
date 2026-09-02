# Silva Vision V0.5 — Mega Block 25

## Objetivo
Consolidar a camada visual noturna e de superfícies sem introduzir dependências de servidor e sem liberar chaves de `VisualSettings` ainda não validadas.

## Novas camadas
- `visual_night_core.lua`: demanda noturna urbana, faróis, luzes distantes, contraste e interação noite/chuva.
- `visual_vehicle_material.lua`: estado de pintura, superfície molhada, reflexos, faróis e emergência em veículos.
- `visual_tunnel_atmosphere.lua`: exposição, ambiente, contraste e atmosfera para interiores/túneis.

Todas são **state-only**: não criam entidades, não alteram veículos e não escrevem `VisualSettings`.

## Integração
O Composer passa a transportar também `headlight`, `nightUrban`, `vehicleWet` e `tunnel`. O Central Apply consome esses fatores somente nas chaves já catalogadas como válidas.

## Segurança visual
Continuam bloqueadas até validação real:
- `streetlight.color.*`
- `distantlights.streetlight.HDRIntensity`
- `coronastar.*`
- `vehicleinteriorlight.*`
- `emissive.multiplier`

O resultado da validação local anterior não encontrou um `visualsettings.dat` standalone, portanto nenhuma dessas chaves foi promovida por suposição.

## Cliente-only
O bloco não força clima, não exige acesso a servidor e não depende de recurso instalado no servidor. Ele observa o estado que o FiveM/GTA já apresenta ao cliente.

## Diagnóstico
`svstatus` passa a mostrar Night Core, headlight, material molhado, reflexão e túnel. `svintegrity` verifica os exports dos três novos módulos.

## Estado
Mega Block 25 está integrado ao `fxmanifest.lua`. A validação final de aparência e FPS ainda depende de teste real no FiveM.
