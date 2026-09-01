# V0.5 — White Lights Pipeline

## Objetivo
Liberar iluminação branca forte e realista sem aplicar chaves especulativas no FiveM.

## Fluxo

1. `SV_WHITE_LIGHTS_VALIDATE.ps1` localiza o `visualsettings.dat`.
2. O arquivo é lido sem alteração.
3. As chaves candidatas são listadas como `FOUND` ou `NOT FOUND`.
4. A presença da chave é apenas evidência inicial.
5. Formato e semântica precisam ser confirmados.
6. Só então a chave entra no `visual_settings_catalog.lua` como validada.
7. O `visual_apply.lua` passa a ser o único writer.
8. O efeito é testado no FiveM em A/B.

## Chaves candidatas

- `streetlight.color.red`
- `streetlight.color.green`
- `streetlight.color.blue`
- `distantlights.streetlight.HDRIntensity`
- `coronastar.size`
- `coronastar.intensity`
- `vehicleinteriorlight.color.red`
- `vehicleinteriorlight.color.green`
- `vehicleinteriorlight.color.blue`
- `vehicleinteriorlight.intensity`
- `emissive.multiplier`

## Regra

Nenhuma chave candidata é liberada automaticamente. O objetivo é obter iluminação forte sem quebrar exposição, interiores, chuva, sirenes ou compatibilidade com servidores.

## Execução local

```powershell
Set-ExecutionPolicy -Scope Process Bypass
& "$env:USERPROFILE\Desktop\SilvaVision_BUILD\tools\SV_WHITE_LIGHTS_VALIDATE.ps1"
```

Se o script estiver sendo executado diretamente do repositório clonado, ajuste o caminho do arquivo conforme a pasta local do projeto.
