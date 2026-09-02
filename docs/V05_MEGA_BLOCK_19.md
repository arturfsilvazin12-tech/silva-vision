# Silva Vision V0.5 — Mega Block 19

## Objetivo

O Mega Block 19 transforma os vários diretores contextuais em uma camada de cena única, sem quebrar o contrato client-only.

## Novo Scene Director

`core/client/visual_scene_director.lua`

O módulo consolida:

- hora e fase: sunrise/day/sunset/night;
- clima observado pelo cliente;
- chuva e tempestade;
- neblina e overcast;
- interior/exterior;
- veículo de emergência;
- demanda de iluminação urbana;
- demanda de reflexos;
- demanda atmosférica;
- fator cinematográfico;
- fator de qualidade contextual.

O módulo é **state-only**. Ele não chama `SetWeatherType*` e não escreve `SetVisualSettingFloat`.

## Central Apply

`core/client/visual_apply.lua` agora consome `GetVisualSceneState()` e usa a cena para modular somente chaves que já estão no catálogo validado.

A camada continua bloqueando:

- `streetlight.color.*`
- `coronastar.*`
- `vehicleinteriorlight.*`
- `emissive.multiplier`
- qualquer nova chave não validada.

## Ordem de inicialização

O Scene Director foi colocado depois de Context/Finish/Transition/Weather Finish e antes dos diretores de iluminação. O Central Apply inicia depois da cadeia contextual principal para evitar uma primeira aplicação com estado vazio.

## Comandos

- `svscene show`
- `svscene on`
- `svscene off`
- `svscene reapply`
- `svapply show`
- `svstatus`
- `svintegrity show`

## Segurança de compatibilidade

Nenhuma mudança de nome de arquivo existente foi feita. Nenhuma dependência de servidor foi adicionada. O clima do servidor continua sendo a autoridade; Silva Vision apenas observa e adapta o acabamento visual local.

## Próxima etapa

Mega Block 20 deve atacar acabamento visual/realtime com foco em ReShade + Timecycle, depois de validar o grafo no FiveM. Streetlight/corona/emissive continuam pendentes até existir `visualsettings.dat` local validado.
