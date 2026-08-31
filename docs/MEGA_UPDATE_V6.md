# 🚀🇧🇷 SILVA VISION — MEGA UPDATE V6

## 🔥 O que entrou

### ✨ SV Bloom
Bloom próprio com threshold, intensidade e raio. A intenção é iluminar somente fontes que realmente ultrapassam o limiar, evitando o efeito de “tela borrada”.

### 🎞️ SV Filmic
Curva filmic experimental baseada em uma função de compressão de highlights. Serve como laboratório de look e não substitui uma calibração HDR completa.

### 🧠 SV Depth Gate
Camada de segurança para a futura família de efeitos depth. Nesta versão é deliberadamente neutra: não cria um efeito falso nem força o pipeline a depender de depth.

## 🧩 Pipeline atualizado

```text
GAME
 ↓
☀️ Exposure
 ↓
🎞️ Tonemap / Filmic
 ↓
🌡️ White Balance
 ↓
🎨 Color Anchor
 ↓
🌗 Local Contrast
 ↓
✨ Bloom
 ↓
🧠 Depth Gate
 ↓
🔍 Sharpen
 ↓
OUTPUT
```

## 🧪 Regras de integração

- Não ativar todos os shaders simultaneamente no primeiro teste.
- Testar cada módulo sozinho.
- Depois testar combinações de 2–3 módulos.
- Registrar FPS e estabilidade.
- Verificar dia, noite, chuva, pôr do sol e direção noturna.
- Se um efeito produzir artefatos, ele volta para experimental.

## ⚡ Perfil de custo estimado

| Módulo | Custo esperado | Prioridade |
|---|---|---|
| Exposure | 🟢 baixo | alta |
| White Balance | 🟢 baixo | alta |
| Color Anchor | 🟢 baixo | alta |
| Sharpen | 🟢 baixo | alta |
| Tonemap | 🟢 baixo | alta |
| Local Contrast | 🟡 moderado | média |
| Bloom | 🟡 moderado | média |
| Filmic | 🟢 baixo/moderado | média |
| Depth | 🟠 variável | opcional |

## 🚧 O que ainda NÃO está pronto

Os shaders não foram validados no computador do usuário. Não devem ser considerados release final nem instalados sobre a Citizen sem backup e teste.

## 🎯 Próximo bloco grande

1. criar presets combinados reais;
2. criar `SV_LUT.fx`/pipeline de LUT;
3. melhorar bloom com separação de qualidade;
4. desenvolver atmosfera/fog;
5. começar camada de timecycle/visualsettings;
6. criar instalador/rollback;
7. criar benchmark e matriz A/B.

## 🏆 Objetivo

Construir um sistema gráfico modular próprio, com identidade Silva Vision, em vez de empilhar arquivos de packs de terceiros.
