<p align="center">
  <img src="assets/silva-vision-banner.svg" alt="Silva Vision — banner" width="100%">
</p>

<h1 align="center">SILVA VISION</h1>

<p align="center">
  <strong>FiveM / GTA V — visual mod project</strong><br>
  Realismo sem exagero.
</p>

<p align="center">
  <code>v0.2.0-dev</code> · <code>PT-BR</code> · <code>Experimental</code>
</p>

---

## Sobre

O Silva Vision é uma base gráfica modular criada para buscar uma imagem mais natural, atmosférica e cinematográfica sem exagerar nos filtros.

**Foco:** iluminação · atmosfera · clima · água · veículos · pós-processamento · desempenho.

## Estrutura

```text
silva-vision/
├── core/        # parâmetros e lógica visual
├── presets/     # perfis de imagem
├── shaders/     # shaders
├── world/       # ambiente e iluminação
├── tools/       # validação e instalação
├── docs/        # especificações e testes
├── assets/      # identidade visual
└── .github/     # fluxo do projeto
```

## Perfis

| Perfil | Objetivo |
|---|---|
| Performance | maior margem de FPS |
| Balanced | equilíbrio entre imagem e custo |
| Quality | qualidade visual elevada |
| Cinematic | captura e vídeo |

## Como desenvolvemos

```text
PESQUISA
   ↓
IMPLEMENTAÇÃO
   ↓
TESTE ISOLADO
   ↓
A/B + BENCHMARK
   ↓
CORREÇÃO
   ↓
RELEASE
```

Nada é chamado de **estável** antes de ser testado no ambiente-alvo.

## Regras

- Não inventar formatos de arquivos nativos.
- Não renomear arquivos nativos sem validação.
- Não prometer ganho de FPS sem benchmark.
- Não distribuir assets de terceiros sem licença.
- Manter componentes experimentais separados.
- Sempre prever rollback quando houver alteração de instalação.

## Status

**Base:** em reconstrução  
**Presets:** experimentais  
**Integração FiveM:** aguardando teste real  
**Release estável:** não lançado

## Documentação

Veja `docs/` para arquitetura, qualidade, compatibilidade, instalação e testes.

---

<p align="center">
  <strong>SILVA VISION</strong><br>
  Realismo sem exagero.
</p>
