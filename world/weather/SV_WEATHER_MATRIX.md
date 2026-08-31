# 🌦️ SV Weather Matrix

## Objetivo

Tratar clima como sistema, não como um filtro único.

| Perfil | Luz | Atmosfera | Superfície | Pós-processamento |
|---|---|---|---|---|
| ☀️ Clear | natural | limpa | seca | baixo |
| 🌤️ Cloudy | difusa | média | seca | baixo |
| 🌅 Sunset | quente localizada | média | seca | controlado |
| 🌧️ Rain | fria/difusa | úmida | molhada | médio |
| ⛈️ Storm | variável | densa | molhada | médio/alto |
| 🌫️ Fog | baixa | densa | variável | baixo |
| 🌙 Night | artificial | escura | seca/molhada | médio |

## Regras

- Não aumentar exposição global para resolver noite.
- Não usar saturação global para criar pôr do sol.
- Chuva deve separar partículas, superfície, reflexo e atmosfera.
- Storm deve preservar contraste de relâmpagos sem transformar o frame inteiro em branco.
- Fog deve ser validado à distância e em movimento.

## Estado

🟡 Planejamento técnico; arquivos de clima ainda precisam de validação no ambiente real.
