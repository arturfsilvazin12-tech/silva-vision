# Silva Vision V0.5 — Big Update 01

## Entregue

### 1. Central Visual Apply
Uma única camada aplica os overrides visuais seguros. Ela consome a Visual Policy e adapta os valores ao estado do cliente.

### 2. Estados dinâmicos
A aplicação considera:
- dia/noite;
- chuva/tempestade;
- superfície molhada;
- interior;
- emergência;
- perfil visual.

### 3. Proteção de parâmetros
A aplicação só escreve nomes classificados como `validated` no catálogo. Parâmetros `pending` continuam documentados, mas não são forçados.

### 4. Iluminação e reflexos
Foram preparados ajustes conservadores para distant lights, reflexos, upscale das luzes, chuva e faróis. Não há exposição global nem bloom global forçado nesta camada.

### 5. Servidores
A camada permanece client-only: ela observa o estado disponível localmente e não exige resource no servidor nem tenta controlar o clima do servidor.

## Comandos de diagnóstico
- `svpolicy show`
- `svcompat refresh`
- `svfallback show`
- `svapply show`
- `svapply reapply`

## Próxima fase
Validar os nomes `pending` contra a cópia real de `visualsettings.dat` no ambiente de build e, somente depois, liberar streetlights/coronas/emissive. Em seguida: integração visual do ReShade e testes A/B no FiveM.
