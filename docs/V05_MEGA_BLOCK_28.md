# SILVA VISION V0.5 — MEGA BLOCK 28

## Objetivo

Transformar o estado consolidado do **Final Visual Fusion** em uma resposta visual mais perceptível no runtime, sem abrir parâmetros não validados.

## Entregas

### Central Apply

`core/client/visual_apply.lua` agora consome `GetVisualFinalFusionState()`.

A fusão influencia de forma limitada:

- tamanho das luzes distantes;
- reflexos de luzes distantes;
- upscale/reflexos distantes;
- densidade de chuva;
- intensidade dos faróis;
- resposta em superfícies molhadas.

Os valores continuam presos aos limites já utilizados pelo Central Apply e passam pela validação de `IsVisualSettingValidated()` antes de qualquer escrita.

### Diagnóstico

`core/client/visual_status.lua` agora exibe os principais valores do Final Fusion:

- wet/rain/storm;
- surface/reflection;
- atmosphere/fog/visibility/lightning;
- night/street;
- emergency/signal/contrast/priority;
- quality/tunnel.

## Segurança

- client-only;
- nenhum weather é forçado;
- nenhum estado do servidor é alterado;
- nenhuma entidade é criada/modificada;
- nenhuma chave `streetlight`, `corona` ou `emissive` especulativa foi liberada;
- Central Apply continua sendo a única camada autorizada a escrever VisualSettings.

## Resultado esperado

O bloco deve aumentar a resposta visual principalmente em **noite, chuva, superfícies molhadas, iluminação urbana e cenas de emergência**, mas sem transformar valores de diagnóstico em alterações ilimitadas.

## Validação obrigatória

Ainda é necessário testar no FiveM. O commit não significa que o resultado visual já foi comprovado em runtime.

Checklist mínimo:

1. entrar no FiveM;
2. usar `svintegrity recheck`;
3. usar `svstatus`;
4. usar `svfusion show`;
5. testar dia/noite;
6. testar chuva e tempestade;
7. testar cidade molhada/reflexos;
8. testar viatura/emergency;
9. observar FPS/frame time;
10. confirmar que não há spam/erro no console.

## ReShade

O preset e os shaders locais continuam separados do GitHub porque ainda não estão versionados no repositório. A integração final do ReShade será feita após os arquivos locais serem validados/sincronizados.
