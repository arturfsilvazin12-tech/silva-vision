# 🧠🇧🇷 Silva Vision — Arquitetura V02

## Objetivo

Transformar o projeto em módulos independentes, testáveis e reversíveis.

```text
GAME
 ↓
[ WORLD ] ─── clima / atmosfera / luz / água / veículos
 ↓
[ POST FX ] ─ exposição / tonemap / cor / contraste / bloom / sharpen
 ↓
[ PROFILE ] ─ Performance / Balanced / Quality / Ultra / Cinematic
 ↓
[ VALIDATION ] ─ compilação / A-B / FPS / artefatos
 ↓
[ RELEASE ]
```

## Contrato de cada módulo

Todo componente futuro deve declarar:

- objetivo visual;
- dependências;
- custo esperado;
- parâmetros;
- modo de desativação;
- riscos conhecidos;
- procedimento de teste;
- estado: experimental ou estável.

## Regra de integração

Um componente novo entra no preset padrão somente depois de funcionar isoladamente e demonstrar benefício visual ou técnico.

## Citizen / nativos

Arquivos nativos continuam separados do pipeline ReShade. Nenhuma estrutura desconhecida será fabricada para preencher pastas.
