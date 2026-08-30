# 🌧️ Silva Vision — Sistema de Chuva 2.0

## 🧩 Componentes

1. 💧 Partículas de chuva
2. 💡 Iluminação das partículas
3. 🛣️ Resposta de superfícies molhadas
4. 🌊 Reflexos/água
5. 🌫️ Atmosfera
6. ☁️ Céu e nuvens
7. 🎨 Exposição e cor
8. 🚘 Resposta visual dos veículos

## 🔬 Parâmetros descobertos

Projetos públicos de `visualsettings.dat` mostram controles independentes para número de partículas, shader iluminado, gravidade, diffuse, ambient, wrap, luz padrão, mapas de colisão de chuva e velocidade de água/reflexo.

Isso indica que o sistema não deve ser tratado como um único controle de intensidade.

## 🟢 Meta

Chuva convincente durante movimento, especialmente à noite, sem transformar a cidade inteira em um espelho.

## 🌙 Chuva noturna

Prioridade alta para:

- luzes urbanas refletidas;
- faróis;
- asfalto molhado;
- contraste local;
- atmosfera úmida.

## ☀️ Chuva diurna

Prioridade para:

- céu carregado;
- contraste reduzido de forma controlada;
- superfícies molhadas;
- partículas visíveis sem excesso.

## ⚠️ Riscos

- excesso de partículas;
- clipping das luzes;
- reflexo uniforme;
- neblina exagerada;
- perda de detalhe;
- custo de GPU;
- conflito com outro weather pack.

## 🧪 Estado

🟡 **Experimental:** os valores numéricos finais só serão promovidos após testes reais no ambiente-alvo.
