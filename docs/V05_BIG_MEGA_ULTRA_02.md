# Silva Vision V0.5 — BIG MEGA ULTRA 02

## Implementado

- Adaptive Visual Budget client-side.
- Perfil manual separado do ajuste automático de desempenho.
- Central Apply recebe o multiplicador de orçamento.
- Runtime visual convertido em shim para evitar dupla escrita.
- Lighting Runtime convertido em registry; streetlight/corona/emissive continuam bloqueados como `pending`.
- Emergency Lighting virou detector de estado; não escreve `emissive.multiplier`.
- Vehicle Lighting e Tunnel Runtime não escrevem mais VisualSettings diretamente.
- Performance Governor não troca mais perfil silenciosamente.
- `svstatus` agora mostra perfil solicitado/manual, budget, multiplicador e frame time.
- `svlayers` mostra a ordem arquitetural.

## Controle de desempenho

O `visual_budget.lua` usa frame time suavizado e quatro tiers:

- NATIVE: 1.00x
- LIGHT: 0.94x
- MEDIUM: 0.84x
- HEAVY: 0.74x

O budget reduz somente parâmetros já aprovados pelo Central Apply. Ele não altera resolução, gráficos do GTA, handling ou gameplay.

## Controle de perfil

`svprofile Quality` fixa Quality manualmente.

`svprofileauto on` devolve a decisão contextual ao sistema.

O Governor antigo não altera mais o perfil automaticamente, evitando disputa entre comandos.

## Segurança visual

O catálogo atual possui 17 parâmetros validados para escrita. Streetlight, corona, vehicle interior color e emissive continuam fora da escrita até validação real. Essa proteção é intencional.

## Client-only

A atualização continua sem dependência de servidor. O clima é observado localmente; o projeto não força clima do servidor.

## Próxima fase: White Lights Validation

A próxima etapa é trabalhar com uma cópia real do `visualsettings.dat` do ambiente local, localizar e validar:

- streetlight.color.*
- distantlights.streetlight.HDRIntensity
- coronastar.size
- coronastar.intensity
- vehicleinteriorlight.color.*
- vehicleinteriorlight.intensity
- emissive.multiplier

Somente depois da validação esses parâmetros poderão entrar no catálogo `validated`.

## Teste mínimo no FiveM

`svstatus`

`svlayers`

`svbudget show`

`svprofile Quality`

`svapply reapply`

O comportamento visual final deve ser medido no FiveM real antes de qualquer release estável.
