# Silva Vision V0.5 — Visual Policy

A Visual Policy é a camada de decisão central do runtime.

## Estados
- fase: sunrise, day, sunset, night
- clima: CLEAR, RAIN, THUNDER, CLEARING, FOGGY, OVERCAST, SMOG, SNOW, XMAS
- wet: chuva/estado molhado
- interior: detecção por interior ID
- emergency: veículo classe 18
- profile: Balanced ou Quality

## Regra de arquitetura
Os módulos de iluminação, clima, superfície, atmosfera, água e performance devem consumir o estado central em vez de criar regras conflitantes.

A policy não altera diretamente o ReShade e não força o clima do servidor.

## Comandos
- `svpolicy show`
- `svpolicy on`
- `svpolicy off`
