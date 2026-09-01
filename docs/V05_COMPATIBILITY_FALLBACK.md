# Silva Vision V0.5 — Compatibility & Fallback

## Objetivo
O Silva Vision deve continuar funcionando como mod visual instalado somente no cliente, independentemente do servidor em que o jogador entrar.

## Capacidades verificadas localmente
- `SetVisualSettingFloat`
- timecycle runtime
- detecção de interior
- funções de veículo
- frame time

## Fallback
Quando uma capacidade não estiver disponível, o módulo correspondente deve:
1. não interromper o resource;
2. não tentar controlar o servidor;
3. manter o último estado seguro ou usar a camada ReShade;
4. registrar a capacidade no diagnóstico quando necessário.

## Compatibilidade de servidor
O servidor fornece o mundo/clima/gameplay. O Silva Vision apenas observa o estado disponível no cliente e adapta sua apresentação visual.

## Comando
`svcompat refresh`

O comando atualiza e mostra as capacidades detectadas.
