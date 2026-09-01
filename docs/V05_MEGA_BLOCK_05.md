# Silva Vision V0.5 — MEGA BLOCK 05

## Unified Visual Context

Foi adicionada uma ponte client-side de contexto em `core/client/visual_context_bridge.lua`.

Ela consolida:

- fase do dia;
- clima observado;
- estado molhado/chuva;
- tempestade;
- fator noturno suavizado;
- contexto de veículo de emergência;
- interior/exterior;
- intensidade visual contextual suavizada.

## Segurança

A ponte é STATE ONLY. Ela não chama `SetVisualSettingFloat`, não força clima e não depende de servidor.

O Central Apply permanece responsável pelas escritas aprovadas.

## Objetivo visual

A camada permite que os próximos módulos de acabamento respondam ao contexto sem cada sistema criar sua própria detecção de noite/chuva/emergência.

## Próximo passo

Usar o contexto consolidado para controlar de forma conservadora o acabamento de noite, chuva, reflexos e emergência, mantendo o custo dentro do Budget.
