# Silva Vision V0.5 — Status Diagnostics

## Objetivo

Adicionar uma visão única do estado visual do cliente durante os testes no FiveM.

## Comando principal

`svstatus`

Mostra:

- fase do dia;
- clima observado;
- estado molhado/chuva;
- interior;
- veículo de emergência;
- perfil ativo;
- disponibilidade de Visual Settings;
- disponibilidade de timecycle;
- modo de fallback;
- motivo do fallback;
- estado do Central Apply;
- último estado aplicado.

## Controles

- `svstatus` — imprime o diagnóstico.
- `svstatus on` — liga o diagnóstico automático inicial.
- `svstatus off` — desliga apenas a impressão automática.

## Regra

O diagnóstico é somente leitura. Não força clima, não altera handling, não edita RPF e não depende do servidor.

## Próxima fase

Usar o diagnóstico durante o teste real para separar problemas de runtime, VisualSettings, timecycle, ReShade e compatibilidade antes de liberar parâmetros de iluminação pendentes.
