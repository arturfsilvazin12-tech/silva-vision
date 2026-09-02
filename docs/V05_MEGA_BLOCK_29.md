# SILVA VISION V0.5 — MEGA BLOCK 29

## Objetivo

Criar uma camada específica para tornar chuva, asfalto molhado, poças, reflexos e cenas de emergência mais coerentes no runtime client-side.

## Entrega

- `core/client/visual_rain_surface_director.lua`
  - chuva e tempestade suavizadas;
  - umidade e poças;
  - resposta de reflexão de superfície;
  - visibilidade/neblina;
  - interação limitada com emergência;
  - integração com o budget de desempenho.
- Central Apply passa a consumir esse estado.
- Status e integridade passam a diagnosticar o novo diretor.
- Nova camada `RAIN_SURFACE` no registro de prioridades.

## Segurança

- Client-only.
- Nenhum weather é forçado.
- Nenhum estado do servidor é alterado.
- Nenhuma entidade ou veículo é criado/modificado.
- Central Apply continua sendo a única camada autorizada a escrever VisualSettings.
- Nenhuma chave streetlight/corona/emissive especulativa foi liberada.
- Apenas chaves VisualSettings já aprovadas pelo catálogo continuam sendo usadas.

## Comandos

- `svrain show`
- `svrain on`
- `svrain off`
- `svrain reapply`
- `svstatus`
- `svintegrity recheck`

## Teste de hoje

Prioridade: entrar no FiveM e observar uma cena de noite com chuva, cidade molhada e viatura/emergency lighting.

Verificar: chuva iluminada, reflexos no asfalto, poças, luzes distantes, faróis, reflexos de emergência e estabilidade de FPS.

A calibração final do ReShade permanece separada enquanto `SilvaVision_FINAL.ini` e os shaders locais não estiverem versionados no repositório.
