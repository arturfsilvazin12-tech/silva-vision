# Silva Vision V0.5 — Runtime Architecture

## Objetivo

A camada runtime é client-side e coordena os sistemas visuais sem substituir o pipeline ReShade.

## Camadas

1. **Visual Runtime** — aplica overrides de VisualSettings selecionados.
2. **Profiles** — Performance, Balanced, Quality e Cinematic.
3. **Timecycle Runtime** — estado atmosférico com transição gradual.
4. **Visual Director** — observa horário, clima e interior/túnel e publica o estado visual.
5. **ReShade** — permanece responsável por exposição, tone, cor, detalhe, bloom e pós-processamento.

## Estados observados

- sunrise: 05:00–06:59
- day: 07:00–16:59
- sunset: 17:00–19:59
- night: 20:00–04:59
- rain/wet: RAIN, THUNDER, CLEARING
- atmosphere: FOGGY, OVERCAST, SMOG
- interior/tunnel: detectado pelo estado do ped/interior

## Segurança

- client-only;
- sem alteração automática de RPF;
- sem valores extremos;
- ReShade continua dono da exposição global;
- recursos experimentais podem ser desligados;
- qualquer valor nativo deve ser validado no FiveM real antes de virar padrão de release.

## Comandos de teste

- `svprofile` — lista perfis.
- `svprofile Performance`
- `svprofile Balanced`
- `svprofile Quality`
- `svprofile Cinematic`
- `svdirector on`
- `svdirector off`
- `svdirector debug`

## Próxima integração

A próxima etapa é ligar o estado do Director aos grupos de iluminação já estudados: streetlights brancas, distant lights, coronas, headlights, sirenes, interiores e túneis. Os valores devem permanecer separados por grupo para permitir A/B e rollback.
