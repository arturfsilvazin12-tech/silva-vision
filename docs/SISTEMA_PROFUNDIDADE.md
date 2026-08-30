# 🧠 Silva Vision — Sistema de Profundidade

## 🎯 Por que existe

Vários efeitos de pós-processamento dependem do depth buffer. Quando ele está incorreto, podem surgir halos, AO errado, DOF estranho, SSR quebrado e outros artefatos.

## 🛡️ Depth Gate

```text
Depth válido?
 ├─ SIM → permitir efeitos dependentes de depth
 └─ NÃO → fallback seguro
```

## 🔎 Efeitos candidatos

- AO;
- SSR;
- DOF;
- efeitos atmosféricos seletivos;
- sharpen seletivo;
- correções de cor por distância.

## ⚙️ Regras

1. Não assumir que depth está disponível em toda configuração.
2. Não ativar vários efeitos depth pesados simultaneamente sem orçamento.
3. Verificar compatibilidade com AA/upscaling.
4. Permitir desligamento individual.
5. Manter preset sem depth como fallback.

## 🧪 Testes futuros

Comparar:

- depth nativo;
- depth com AA;
- depth com upscaling;
- depth em interiores;
- depth à noite;
- depth durante chuva.

## 📌 Objetivo

Quando um efeito não puder operar corretamente, a imagem deve continuar bonita e estável em vez de apresentar artefatos.
