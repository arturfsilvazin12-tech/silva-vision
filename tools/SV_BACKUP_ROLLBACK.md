# 🛡️ Silva Vision — Backup & Rollback

## Regra

Nenhum instalador futuro deve substituir arquivos sem backup.

## Fluxo

```text
ORIGINAL
  ↓
BACKUP
  ↓
SILVA VISION
  ↓
TESTE
  ↓
OK → manter
ERRO → RESTORE
```

## Estrutura planejada

```text
SilvaVision_Backup/
├── manifest.txt
├── original/
├── modified/
└── logs/
```

## O manifest deve registrar

- arquivo original;
- tamanho;
- hash;
- data do backup;
- versão Silva Vision;
- arquivo substituto.

## Objetivo

Se uma atualização quebrar o visual, o usuário poderá voltar ao estado anterior sem reinstalar o FiveM.
