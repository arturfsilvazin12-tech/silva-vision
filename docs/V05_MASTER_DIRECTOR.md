# Silva Vision V0.5 — Master Director

## Objetivo
Centralizar o estado visual do cliente para que horário, clima, chuva, interior e veículo de emergência sejam tratados como um único contexto.

## Estado
- sunrise: 05–06
- day: 07–16
- sunset: 17–19
- night: 20–04
- wet: RAIN / THUNDER / CLEARING
- interior: interior ID diferente de zero
- emergency: classe de veículo 18

## Política
O Master Director é um coordenador de estado. Ele não substitui o ReShade e não força o clima do servidor.

Perfis são escolhidos de forma conservadora:
- interior → Balanced
- noite → Quality
- emergência → Quality
- restante → Balanced

## Segurança
- CLIENT ONLY
- sem edição automática de RPF
- sem exposição global
- sem bloom global adicional
- sem bitmasks desconhecidos
- valores extremos ficam fora da camada runtime

## Próxima integração
Conectar o estado do Master Director aos módulos já existentes sem duplicar `SetVisualSettingFloat`, permitindo uma única política para iluminação, atmosfera, superfície, água e performance.
