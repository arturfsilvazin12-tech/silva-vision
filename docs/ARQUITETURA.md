# 🧠 Silva Vision — Arquitetura

> Documento central do projeto. Português (Brasil).

## 🎯 Objetivo

Criar um pacote gráfico modular para FiveM/GTA V com foco em **realismo + cinematografia + iluminação urbana + clima + estabilidade + desempenho**.

## 🧩 Camadas

```text
🎮 GTA / FiveM
      │
      ├── 🌎 Mundo / Citizen
      │     ├── iluminação
      │     ├── clima
      │     ├── atmosfera
      │     └── materiais
      │
      ├── ⚙️ Visual Settings
      │     └── parâmetros globais do renderer
      │
      ├── 🌦️ Timecycle / Weather
      │     └── horário + clima + exposição ambiental
      │
      ├── 💧 Água
      │     └── ondas + superfície + reflexos
      │
      ├── 🎨 ReShade
      │     └── pós-processamento de tela
      │
      └── ✨ ENB (opcional)
            └── efeitos avançados quando realmente necessários
```

## 🔒 Regra de propriedade

Cada efeito deve possuir **um dono principal**. Se duas camadas fizerem a mesma coisa, uma delas deve ser removida ou reduzida.

### Exemplos

- Iluminação do mundo → dados do jogo/Citizen/visualsettings.
- Cor final → ReShade.
- Chuva → weather/timecycle + partículas; ReShade apenas complementa.
- Reflexos de água → sistema de água; ReShade não deve tentar recriar tudo.
- Bloom → um sistema principal, não três efeitos empilhados.

## 🧪 Estados do projeto

### 🟢 Confirmado
Encontrado em documentação/código público ou comportamento bem estabelecido.

### 🟡 Experimental
Parece promissor, mas precisa de teste dentro do FiveM.

### 🔴 Bloqueado
Risco de incompatibilidade, licença, instabilidade ou ausência de evidência suficiente.

## 📦 Regra de release

Nada vira pacote final somente porque o arquivo carrega. Deve existir:

1. caminho-alvo;
2. função conhecida;
3. compatibilidade conhecida;
4. backup/rollback;
5. documentação;
6. teste visual;
7. teste de desempenho.

## 🚫 O que não faremos

- renomear arquivos nativos sem necessidade;
- misturar packs inteiros cegamente;
- copiar assets proprietários;
- afirmar que um valor é perfeito sem teste;
- usar sharpening para esconder LOD/streaming ruim;
- transformar Ultra em “todos os shaders ligados”.
