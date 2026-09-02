# Silva Vision V0.5 — Mega Block 24

## Objetivo

O Mega Block 24 fecha uma camada de coordenação visual para quatro áreas que ainda estavam separadas: **noite urbana**, **materiais de veículos**, **atmosfera de túneis/interiores** e integração desses sinais no Composer/Central Apply.

Tudo continua **client-only**. Nenhuma camada força clima do servidor, cria entidades ou depende de recurso server-side.

## Novas camadas

### 1. Night Core
`core/client/visual_night_core.lua`

Calcula, com suavização:
- demanda urbana noturna;
- necessidade visual de faróis;
- demanda de luzes distantes;
- contraste de emergência;
- combinação noite + piso molhado;
- fator de qualidade.

Não escreve `VisualSettings`.

### 2. Vehicle Material
`core/client/visual_vehicle_material.lua`

Produz sinais para:
- material molhado;
- reflexão de veículos;
- condição noturna;
- emergência;
- necessidade de faróis.

Não altera veículos ou entidades diretamente.

### 3. Tunnel Atmosphere
`core/client/visual_tunnel_atmosphere.lua`

Coordena:
- entrada/saída de interior;
- profundidade de túnel;
- exposição;
- ambiente;
- contraste;
- atmosfera.

Não força timecycle nem clima.

## Composer

O Composer agora recebe as três camadas e combina seus pesos com:
- Scene Director;
- Solar Cycle;
- Weather Blend/FX;
- Reflection Director;
- Exposure Guard;
- Lighting Balance;
- Light Governor.

Isso evita que cada sistema tente corrigir a imagem por conta própria.

## Central Apply

O Central Apply recebeu proteção adicional contra mistura de tipos boolean/número e passou a considerar os novos sinais de forma conservadora.

As únicas escritas continuam sendo chaves já presentes no catálogo validado. As chaves de:
- `streetlight.*`
- `coronastar.*`
- `vehicleinteriorlight.*`
- `emissive.multiplier`

continuam **PENDING/BLOCKED** até existir validação real do `visualsettings.dat` e teste controlado no FiveM.

## Diagnóstico

`svstatus` agora mostra também:
- night urban;
- demanda de farol;
- material molhado de veículo;
- reflexão de veículo;
- túnel e profundidade;
- exposição de túnel;
- Weather FX.

`svintegrity show` passa a verificar os novos exports.

## Manifest

Versão do recurso: `0.5.0-dev-mega-block-24`.

Os novos módulos são carregados antes do Composer para formar o grafo completo de estado antes da aplicação visual.

## Teste local recomendado

Após sincronizar o repositório no FiveM:

```text
refresh
restart silva-vision-core
svintegrity recheck
svstatus
svlayers
svnightcore show
svvehmat show
svtunnelatm show
```

Teste em pelo menos:
1. dia limpo;
2. pôr do sol;
3. noite urbana;
4. noite com chuva;
5. tempestade;
6. interior/túnel;
7. veículo com faróis;
8. veículo de emergência.

## Critério de sucesso

O bloco é considerado **integrado no código** quando os exports aparecem no `svintegrity` sem `missing` e os estados mudam coerentemente durante os cenários.

Isso não significa que o resultado visual final esteja aprovado: a aprovação visual depende do teste real no FiveM.
