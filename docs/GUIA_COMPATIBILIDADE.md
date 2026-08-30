# 🛡️ Silva Vision — Guia de Compatibilidade

## 🚦 Princípio

O mod deve coexistir com o ambiente FiveM sempre que tecnicamente possível. Nenhum componente deve ser tratado como universal sem teste.

## ⚠️ Áreas de risco

- `visualsettings.dat`
- arquivos de timecycle/weather
- água e arquivos de ambiente
- injetores ReShade/ENB
- efeitos dependentes de depth
- pacotes de textura/modelo
- recursos do servidor que aplicam timecycle

## 🧩 Matriz

| Camada | Risco | Estratégia |
|---|---|---|
| ReShade leve | 🟢 | Preset seletivo |
| ReShade depth | 🟡 | Depth Gate |
| Visual settings | 🟡 | Backup + isolamento |
| Timecycle | 🟠 | Detectar conflito |
| ENB + ReShade | 🟠 | Teste específico |
| Packs completos de terceiros | 🔴 | Não misturar por padrão |

## 🔄 Rollback

Toda instalação futura deverá ter um caminho claro para restaurar os arquivos originais.

## 🧪 Diagnóstico futuro

O projeto poderá incluir um relatório que registre:

- componentes detectados;
- arquivos presentes;
- perfil ativo;
- módulos opcionais;
- possíveis conflitos;
- recomendações de desativação.

## ❗ Importante

Compatibilidade com um servidor específico pode depender dos recursos daquele servidor. Um preset gráfico não deve prometer compatibilidade universal.
