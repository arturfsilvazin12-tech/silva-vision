# 🗂️ Silva Vision — Regras de Arquivos

## 🔒 Regra principal

Não renomear arquivos nativos do GTA/FiveM apenas para organizar o projeto.

## 🔍 Antes de modificar

Registrar:

- nome original;
- localização esperada;
- formato;
- função;
- dependências;
- possível conflito;
- método de restauração.

## 📦 Organização

O repositório pode organizar arquivos por função, mas a estrutura de distribuição deve respeitar o caminho exigido pelo jogo/recurso.

## ♻️ Backup

Toda alteração de arquivo existente deve possuir estratégia de backup e rollback.

## 🧪 Experimental

Arquivos que dependem de validação no jogo devem ser marcados como experimentais e não apresentados como release final.

## 🚫 Terceiros

Código, shaders, texturas e outros assets externos só podem ser redistribuídos quando a licença permitir. Caso contrário, manter referência/documentação e exigir instalação separada pelo usuário.
