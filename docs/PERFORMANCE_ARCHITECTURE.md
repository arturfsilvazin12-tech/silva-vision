# Silva Vision — Arquitetura de desempenho

## Objetivo

A qualidade visual deve crescer sem transformar o preset padrão em um pacote pesado.

## Princípios

1. **Pós-processamento mínimo no Balanced.**
2. **Color grading concentrado em uma etapa sempre que possível**, evitando várias passagens equivalentes.
3. **Efeitos baseados em profundidade ficam opcionais.**
4. **AO, DOF e bloom pesado não entram no perfil Balanced por padrão.**
5. **Shaders caros devem possuir toggle próprio.**
6. **Performance Mode deve ser usado depois que o preset estiver ajustado.**
7. **Cada efeito novo precisa de comparação A/B e medição antes/depois.**
8. **Não perseguir FPS artificialmente alterando configurações do jogo sem medir o custo visual.**

## Perfis

| Perfil | Pós-processamento | Efeitos caros | Objetivo |
|---|---|---|---|
| Performance | mínimo | desligados | jogar |
| Balanced | baixo | opcionais | jogar + visual |
| Quality | moderado | seletivos | visual |
| Cinematic | alto | permitidos | captura |

## Estratégia de implementação

### Baixo custo

- exposição;
- contraste;
- gamma;
- saturação;
- temperatura/balanço de branco;
- color grading/LUT;
- sharpening moderado.

### Custo controlado

- SMAA/FXAA quando necessário;
- bloom discreto;
- efeitos atmosféricos simples.

### Alto custo / opcional

- ambient occlusion baseada em profundidade;
- depth of field;
- efeitos de iluminação complexos;
- múltiplas passagens de pós-processamento.

## Regra de qualidade

Um efeito não entra no Balanced apenas porque deixa a imagem mais bonita. Ele precisa justificar seu custo visualmente e passar por benchmark.

## Referências da pesquisa

A documentação e discussões da comunidade do ReShade indicam que efeitos simples de cor/contraste costumam ser baratos, enquanto DOF, bloom e principalmente AO baseado em profundidade podem ser significativamente mais caros. O ReShade também possui Performance Mode para otimizar a representação dos shaders após o ajuste. Essas referências orientam a arquitetura, mas os números finais serão medidos no PC alvo.

## Meta do projeto

**Visual perceptivelmente melhor com o menor custo possível.**
