# Silva Vision V0.5 — MEGA BLOCK 02

## Entrou

### White Lights Validator

Novo módulo `core/client/white_lights_validator.lua`.

Ele cria uma lista explícita dos parâmetros que ainda precisam de validação real:

- streetlight RGB;
- streetlight HDR;
- corona size/intensity;
- vehicle interior light RGB/intensity;
- emissive multiplier.

O módulo **não tenta adivinhar suporte escrevendo valores**. Sem uma fonte real do `visualsettings.dat`, os parâmetros continuam pending.

Comandos:

- `svwhitelights scan`
- `svwhitelights show`

### Contextual Quality Director

Novo `visual_quality_director.lua` acompanha:

- fase do dia;
- chuva/superfície molhada;
- veículo de emergência;
- interior;
- fator contextual suavizado.

Ele não escreve VisualSettings. Serve como camada de contexto para a próxima integração do Central Apply.

## Próxima integração

1. capturar/validar o `visualsettings.dat` real do ambiente FiveM;
2. gerar catálogo de chaves comprovadas;
3. liberar White Lights somente para chaves comprovadas;
4. integrar corona/emissive sem duplicar ReShade;
5. calibrar água, chuva e atmosfera;
6. A/B no FiveM;
7. benchmark;
8. só então congelar V0.5.

## Regra de segurança visual

Nenhum valor externo é considerado final apenas por parecer forte em outro preset/mod. Valores extremos continuam rejeitados até teste controlado.
