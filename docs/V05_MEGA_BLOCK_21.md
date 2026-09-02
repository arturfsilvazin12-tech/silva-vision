# Silva Vision V0.5 — MEGA BLOCK 21

## Objetivo

Aumentar a qualidade contextual do pipeline visual sem transformar o mod em um controlador de clima do servidor e sem liberar chaves de `VisualSettings` que ainda não foram validadas.

## Entregas

### 1. Solar Cycle
`core/client/visual_sun_cycle.lua`

Cria pesos suaves para amanhecer, dia, golden hour, pôr do sol e noite. O resultado alimenta o Composer e o Central Apply.

### 2. Weather Blend
`core/client/visual_weather_blend.lua`

Normaliza RAIN, THUNDER, CLEARING, FOGGY, OVERCAST, SMOG, SNOW e XMAS em pesos de chuva, tempestade, neblina, nublado, umidade e visibilidade.

O clima é somente observado; não é forçado.

### 3. Emergency Scene
`core/client/visual_emergency_scene.lua`

Detecta contexto de veículo de emergência local e cria pesos de sinal/reflexo. Não força sirene, não altera entidade e não escreve emissive/corona.

### 4. Composer V21
O Composer passou a combinar solar + weather blend + água + emergência + budget. O resultado continua sendo somente estado.

### 5. Central Apply V21
O único escritor de `VisualSettings` continua centralizado. Foram refinadas apenas chaves já validadas:

- distant lights
- rain
- interior light
- headlights

Todas continuam com limites rígidos e validação pelo catálogo runtime.

### 6. Profile Director
Corrigida a confiança do recomendador: agora ela depende da estabilidade da recomendação, em vez de comparar o alvo consigo mesmo.

### 7. Integrity + Status
O diagnóstico passou a verificar os três novos exports e exibir solar, golden hour e sinal de emergência.

## Pipeline

`Time/Weather -> Scene -> Solar + Weather Blend + Emergency -> Composer -> Profile Director -> Budget -> Central Apply -> ReShade/Timecycle`

## Segurança

- CLIENT ONLY.
- Nenhuma dependência de servidor para funcionar.
- Nenhum weather forcing.
- Nenhuma escrita em streetlight/corona/emissive pendentes.
- ReShade continua separado do core.
- V04/timecycle permanece preservado.

## Teste local

Após atualizar o recurso no FiveM:

```text
svintegrity recheck
svstatus
svsun show
svweatherblend show
svevent show
svcomposer show
svprofilerec show
svapply show
```

O esperado é `integrity=OK` e todos os exports presentes. A confirmação visual real ainda depende de teste no FiveM.
