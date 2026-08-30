# 🎨 Silva Vision — Matriz Visual

## ☀️ Dia

**Prioridade:** textura, detalhe, contraste natural e highlights controlados.

Evitar saturação excessiva e sombras completamente pretas.

## 🌅 Amanhecer / pôr do sol

**Prioridade:** temperatura, exposição e transição.

A cor quente deve vir principalmente da iluminação e do balanço de branco, não de um filtro laranja global.

## 🌙 Noite

**Prioridade:** fontes de luz locais e preservação de detalhe nas sombras.

A exposição global não deve ser elevada apenas para tornar toda a cena clara.

## 🌧️ Chuva

**Prioridade:** superfície molhada + partículas + atmosfera + interação da iluminação.

Reflexo forte deve depender da condição da superfície; não transformar toda a cidade em espelho.

## ⛈️ Trovoada

Adicionar variação atmosférica e contraste sem criar flashes constantes ou clipping.

## 🌫️ Neblina

Usar como profundidade atmosférica. Remover completamente a névoa não é objetivo do Silva Vision.

## 💡 Cidade

A iluminação urbana deve ter variação por contexto:

- 🏙️ centro/comercial: quente-neutro e mais denso;
- 🏘️ residencial: mais suave;
- 🛣️ rodovia: iluminação mais uniforme;
- 🚓 emergência: cores preservadas;
- 🚗 faróis: neutros/brancos;
- 🌈 neon: preservar a identidade da fonte.

## 🚘 Veículos

Priorizar emissivo, faróis, lanternas, freios, vidro e reflexos sem clipping.

## 🌊 Água

Tratar como sistema próprio. Reflexo, transparência, ondas e resposta à chuva não devem depender exclusivamente de pós-processamento.

## 🔍 Profundidade

Efeitos que dependem de depth devem possuir condição de segurança. Se o depth estiver inválido, usar fallback ou desativar o efeito.
