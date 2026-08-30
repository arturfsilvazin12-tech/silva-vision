# 🌦️ Silva Vision — Matriz de Clima

Esta matriz define a **intenção visual**. Os valores numéricos finais continuam experimentais até testes no jogo.

| Clima | ☀️ Sol | 🌫️ Atmosfera | 💧 Umidade | 💡 Luz urbana | 🎨 Cor |
|---|---|---|---|---|---|
| Extra Sunny | forte/controlado | limpa | baixa | normal | neutra/viva |
| Clear | natural | leve | baixa | normal | neutra |
| Clouds | suave | média | baixa | discreta | levemente fria |
| Clearing | variável | média→baixa | baixa | transição | neutra |
| Overcast | difuso | média | média | mais evidente | fria/neutra |
| Rain | difuso | alta | alta | refletida | fria/neutra |
| Thunder | dramático | alta | alta | intensa | fria + flashes |
| Foggy | fraco | muito alta | média | difusa | dessaturada controlada |
| Smog | fraco | urbana | média | difusa | quente/cinza controlado |
| Snow | difuso | média | alta | refletida | fria |
| Snowlight | suave | média | alta | refletida | fria clara |
| Blizzard | fraco | muito alta | alta | baixa distância | fria |
| Halloween | variável | temática | variável | temática | preservada |
| Xmas | variável | temática | variável | temática | preservada |

## 🌧️ Chuva

A chuva não deve depender somente de partículas. O perfil deve considerar:

- partículas;
- iluminação das gotas;
- superfície molhada;
- reflexos;
- atmosfera;
- exposição;
- resposta dos postes;
- faróis no asfalto;
- água/poças quando suportadas;
- custo de GPU.

## 🌙 Regra da noite

Noite = **escura + legível**, não “dia com exposição baixa”.

Os pretos devem permanecer profundos, enquanto luzes artificiais funcionam como pontos de interesse.

## 🌅 Transições

Amanhecer e pôr do sol receberão tratamento próprio para evitar uma única LUT/temperatura aplicada durante 24 horas.

## 🧪 Estado

🟢 Arquitetura definida  
🟡 Valores específicos aguardando testes  
🔴 Nenhum valor deve ser considerado definitivo sem validação no FiveM
