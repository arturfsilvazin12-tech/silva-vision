# SILVA VISION V0.5 — MEGA BLOCK 27

## Entrega

O Mega Block 27 cria uma camada de **Final Visual Fusion** para reunir os estados já calculados pelo runtime antes da etapa de aplicação visual.

### Novo módulo

- `core/client/visual_final_fusion.lua`
  - consome Surface Response;
  - consome Atmosphere Director;
  - consome Emergency Contrast;
  - consome o Composer existente;
  - produz um estado final suavizado para diagnóstico e futuras integrações;
  - não escreve `VisualSettings`.

### Integração

- `core/fxmanifest.lua` atualizado para carregar a Fusion.
- `core/client/visual_layers.lua` atualizado com a camada `FINAL_FUSION`.
- `core/client/runtime_integrity.lua` agora valida `GetVisualFinalFusionState`.
- comando de diagnóstico: `svfusion show`.

## Segurança visual

O bloco continua estritamente client-side. Não força weather, não altera estado do servidor, não cria entidades e não libera parâmetros especulativos de streetlight/corona/emissive.

O Central Apply continua sendo a única camada autorizada a escrever `VisualSettings` validados.

## Estado

A Fusion já está registrada no runtime, mas a confirmação final de comportamento depende de teste dentro do FiveM. O preset/shaders locais do ReShade continuam separados porque não estão versionados neste repositório.

## Próximo teste

No FiveM, após atualizar o recurso:

```text
svfusion show
svintegrity recheck
svstatus
```

Depois testar noite, chuva, tempestade, piso molhado, reflexos e cena de emergência.
