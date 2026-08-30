# 🧪 Silva Vision — Plano de Testes

## 🎯 Objetivo

Validar o comportamento do mod em situações que normalmente revelam problemas invisíveis em screenshots.

## 🗺️ Cenários

### 🌞 Dia
- avenida aberta;
- área residencial;
- centro urbano;
- vegetação;
- interior/exterior.

### 🌇 Golden hour
- amanhecer;
- pôr do sol;
- transição para noite.

### 🌙 Noite
- centro;
- bairro;
- rodovia;
- túnel;
- área sem iluminação.

### 🌧️ Chuva
- chuva leve;
- chuva forte;
- noite chuvosa;
- veículos em movimento;
- asfalto molhado.

### ⛈️ Tempestade
- relâmpagos;
- céu carregado;
- iluminação artificial;
- exposição.

## 🔎 Artefatos

Procurar:

- flicker;
- ghosting;
- halos;
- banding;
- clipping;
- bloom excessivo;
- reflexos impossíveis;
- sombras esmagadas;
- pop-in;
- perda de textura;
- depth incorreto;
- UI afetada.

## ⚡ Desempenho

Registrar antes/depois:

| Métrica | Original | Silva Vision |
|---|---:|---:|
| FPS médio | — | — |
| 1% low | — | — |
| GPU ms | — | — |
| VRAM | — | — |
| Resolução | — | — |

## 🧾 Regra

Não transformar uma medição de uma máquina em promessa universal de FPS. Cada resultado deve registrar hardware, resolução, preset, local, horário e clima.

## 🟡 Até haver testes

Arquivos e valores que ainda não foram testados no jogo devem permanecer marcados como **experimental** e não como release final.
