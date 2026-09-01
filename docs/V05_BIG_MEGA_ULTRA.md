# Silva Vision V0.5 — BIG MEGA ULTRA UPDATE

## Estado

Atualização estrutural aplicada no branch `main`.

## 1. Central Apply 2.0

`visual_apply.lua` passou a ser a autoridade para os VisualSettings classificados como `validated`.

Ele agora:

- escolhe o perfil visual a partir do estado da Policy;
- adapta luzes distantes ao período noturno;
- aumenta reflexos de distant lights quando a superfície está molhada;
- adapta partículas de chuva ao clima observado;
- diferencia chuva normal de tempestade;
- mantém iluminação de chuva neutra em RGB 1/1/1;
- protege interiores contra excesso de luminosidade;
- ajusta faróis de forma moderada durante a noite;
- mantém todos os limites em faixas conservadoras;
- nunca escreve parâmetros `pending`.

## 2. Perfis

Os perfis deixaram de escrever diretamente VisualSettings. Eles agora funcionam como configuração para o Central Apply:

- Performance — menor carga;
- Balanced — padrão;
- Quality — qualidade elevada;
- Cinematic — máxima qualidade dentro dos limites definidos.

## 3. Registry de camadas

Novo `visual_layers.lua` documenta a prioridade:

1. V04 Timecycle;
2. Visual Policy;
3. Central Apply;
4. Runtime/Directors;
5. ReShade.

Comando: `svlayers`.

## 4. Diagnóstico

O `svstatus` continua disponível para verificar o estado do cliente durante os testes.

## 5. Client-only

Nada nesta atualização exige resource no servidor, controla o clima do servidor ou altera gameplay/handling.

## 6. Iluminação branca

Streetlight/corona/emissive continuam deliberadamente bloqueados no catálogo `pending`. O próximo salto de iluminação será liberado somente após validação dos nomes reais no ambiente de build/teste.

## 7. Objetivo visual

A direção visual desta versão é:

- noite mais legível;
- luzes distantes mais presentes;
- asfalto molhado mais vivo;
- chuva mais perceptível;
- faróis fortes sem explosão global;
- interiores sem lavagem excessiva;
- iluminação neutra/branca;
- ReShade responsável pelo acabamento final, sem duplicar exposição/bloom agressivos.

## Comandos de teste

`svstatus`

`svlayers`

`svprofile Balanced`

`svprofile Quality`

`svprofile Cinematic`

`svapply reapply`

## Importante

Esta é uma atualização de arquitetura e runtime. O resultado visual final ainda precisa ser validado no FiveM real; nenhum FPS ou compatibilidade visual é declarado sem teste.
