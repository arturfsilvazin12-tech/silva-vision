# 🚀🇧🇷 SILVA VISION — MEGA UPDATE V14

## 🛠️ Ferramentas

### `SV_VALIDATE.ps1`
Valida a estrutura local e contabiliza shaders/presets.

### `SV_INSTALL_PLAN.ps1`
Novo preparador seguro: cria um relatório de instalação e verifica diretórios esperados sem tocar no GTA/FiveM.

## 🧠 Princípio de segurança

O projeto agora possui duas fases claramente separadas:

**Preparação local → Validação no PC → Instalação real**

Isso impede que um script experimental altere arquivos do jogo antes dos testes.

## 📦 Estrutura operacional

```text
Silva Vision
├── shaders
├── presets
├── config
├── world
├── performance
├── tools
│   ├── SV_VALIDATE.ps1
│   └── SV_INSTALL_PLAN.ps1
└── docs
```

## 🎯 Próxima grande etapa

Criar o instalador real somente depois que o caminho/versão do FiveM e a instalação do ReShade forem confirmados no computador.

## 🟡 Estado

Arquitetura avançada / implementação experimental / validação pendente.
