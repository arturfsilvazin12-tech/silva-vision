# 💡 Silva Vision — Sistema de Iluminação V1

## 🎯 Objetivo

Construir iluminação realista sem transformar a cidade inteira em uma fonte de bloom.

## 🧩 Fontes

| Fonte | Tratamento |
|---|---|
| ☀️ Sol | exposição + tonemapping |
| 💡 Poste | intensidade + temperatura |
| 🚗 Farol | emissivo + highlight |
| 🔴 Freio | emissivo vermelho controlado |
| 🚓 Emergência | preservar identidade cromática |
| 🌈 Neon | preservar matiz |
| 🪟 Interior | iluminação local |
| 🌧️ Chuva | interação com superfície/atmosfera |

## 🌙 Noite

A noite deve continuar sendo noite. A estratégia é preservar fontes artificiais e detalhe local, evitando elevar a exposição global.

## ✨ Bloom

Bloom deve ser tratado como resposta óptica e não como substituto de iluminação. Fontes intensas podem receber halo controlado; superfícies comuns não.

## 🌡️ Temperatura

O projeto evita aplicar uma cor única à cidade. A temperatura deve variar por tipo de fonte e contexto.

## 🚗 Veículos

Faróis, lanternas e emissivos devem ser avaliados separadamente. O objetivo é evitar clipping e halos gigantes.

## 🌧️ Chuva noturna

A iluminação deve ganhar presença através da interação com partículas e superfícies molhadas, não simplesmente aumentando brilho global.

## 🟡 Status

Parâmetros numéricos finais: **experimental** até teste real em FiveM.
