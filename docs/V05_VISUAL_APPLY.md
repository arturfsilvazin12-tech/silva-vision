# Silva Vision V0.5 — Central Visual Apply

A camada `visual_apply.lua` é o primeiro ponto central de aplicação de visual settings runtime.

## Princípios
- client-only;
- somente settings catalogados como validados;
- sem controle do clima do servidor;
- sem exposição global forçada;
- sem bloom global agressivo;
- valores limitados a faixas conservadoras;
- estado recebido da Visual Policy.

## Precedência
`Visual Policy → Central Visual Apply → ReShade`

Os módulos legados continuam presentes durante a migração. A centralização será expandida gradualmente para evitar uma troca brusca e facilitar rollback.

## Comandos
- `svapply on`
- `svapply off`
- `svapply reapply`
