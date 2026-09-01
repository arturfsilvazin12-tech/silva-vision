# Silva Vision V0.5 — Big Update 02

## Diagnóstico central

A V0.5 agora possui uma camada de diagnóstico que reúne o estado da Visual Policy, capacidades detectadas, fallback e Central Visual Apply.

## O que mudou

- novo `core/client/visual_status.lua`;
- comando `svstatus`;
- diagnóstico de fase/clima/chuva/interior/emergência;
- diagnóstico de perfil;
- diagnóstico de VisualSettings e timecycle;
- diagnóstico de fallback;
- diagnóstico do Central Apply;
- registro do último estado visual aplicado.

## Segurança

O diagnóstico não força clima do servidor, não modifica handling, não edita RPF e não adiciona dependências de servidor.

## Ordem

`Client Only → Compatibility → Policy → Fallback → Catalog → Central Apply → Runtime → Directors → ReShade`

## Teste previsto

Após instalar a build de teste no cliente, executar `svstatus` e usar o resultado para validar o ambiente antes de liberar os parâmetros pendentes de streetlight/corona/emissive.
