# Silva Vision V0.5 — MEGA BLOCK 03

## Objetivo

Construir uma camada visual adaptativa que preserve o look forte do Silva Vision sem transformar FPS em uma variável descontrolada.

## Novidades

### 1. Lighting Director state-only

`lighting_director.lua` não aplica mais VisualSettings diretamente. Ele apenas produz estado de fase/noite/chuva para a arquitetura central.

### 2. Budget Adapter

`visual_budget_adapter.lua` consome o orçamento de performance disponível e expõe um multiplicador limitado entre 0.70 e 1.00. Nenhum parâmetro gráfico é escrito diretamente por este módulo.

### 3. White Lights continuam protegidas

Como o `visualsettings.dat` não foi encontrado como arquivo separado no ambiente local, streetlight/corona/emissive permanecem bloqueados para escrita especulativa.

## Estratégia visual

O Silva Vision passa a separar quatro responsabilidades:

- **World/Timecycle:** iluminação estrutural e ambiente;
- **Central Apply:** parâmetros VisualSettings comprovados;
- **Budget:** adaptação de custo;
- **ReShade:** acabamento, contraste, highlights, leitura de chuva e efeitos pós-processamento.

## Resultado esperado

Mais consistência entre dia/noite/chuva/emergência, menos conflito entre módulos e uma base segura para o próximo salto de iluminação.

## Não faz parte deste bloco

- forçar clima do servidor;
- alterar Citizen do usuário automaticamente;
- editar common.rpf;
- habilitar chaves não comprovadas;
- prometer ganho de FPS sem benchmark real.
