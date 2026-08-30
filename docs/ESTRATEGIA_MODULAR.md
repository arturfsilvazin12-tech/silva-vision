# 🧱 Silva Vision — Estratégia Modular

## 📦 Princípio

O usuário não deve precisar instalar o projeto inteiro para obter uma melhoria específica.

## Camadas

### 🟢 Base
Configuração essencial e segura.

### 🎨 Visual
ReShade e ajustes de cor.

### 💡 Iluminação
Visual settings e componentes de iluminação compatíveis.

### 🌦️ Clima
Timecycle/weather quando houver suporte adequado.

### 🌊 Ambiente
Água, materiais, vegetação e outras melhorias opcionais.

### ⚡ Performance
Perfis de custo diferentes.

## 🔄 Atualização

Cada módulo deve possuir:

- versão;
- changelog;
- dependências;
- arquivos afetados;
- risco de conflito;
- método de rollback.

## 🚫 Regra contra monólito

Não juntar indiscriminadamente Citizen, RPF, ENB, ReShade, texturas e timecycle em um único pacote. Isso dificulta diagnóstico e pode provocar conflitos difíceis de reverter.

## 🧪 Estado

A arquitetura é definitiva como direção, mas os módulos individuais continuam sendo validados progressivamente.
