# Silva Vision V0.5 — Última Pesquisa Técnica

> Pesquisa final focada somente em recursos que ainda não estavam consolidados no projeto. Não repetir Visual Pack, FS-Graphics, VENT, NVE ou referências já catalogadas.

## 1. Timecycle criado em runtime

O FiveM expõe `CREATE_TIMECYCLE_MODIFIER`, permitindo criar um modifier limpo e depois aplicar variáveis com `SET_TIMECYCLE_MODIFIER_VAR`. Isso abre uma camada runtime para ajustes específicos sem transformar o `timecycle_mods_1.xml` inteiro em dependência.

**Uso no Silva Vision:** pequenos modifiers de ambiente/estado, sempre com nomes próprios e rollback.

Fonte: documentação/nativos CFX.

## 2. Variáveis de timecycle em runtime

`SET_TIMECYCLE_MODIFIER_VAR(modifierName, varName, value1, value2)` permite alterar uma variável específica de um modifier. `GET_TIMECYCLE_MODIFIER_VAR` e `REMOVE_TIMECYCLE_MODIFIER_VAR` também existem.

**Uso:** ajustes finos de atmosfera, contraste ambiental, fog/haze e transições sem duplicar todo o XML.

## 3. Transição de timecycle

`SET_TRANSITION_TIMECYCLE_MODIFIER` permite carregar um modifier com transição. Isso é útil para amanhecer, pôr do sol, entrada/saída de túnel e estados climáticos.

**Uso:** substituir mudanças bruscas por transições controladas.

## 4. Controle de weather cycle

O código do FiveM possui suporte para ciclos climáticos customizados e multiplicadores de tempo do ciclo. Isso permite uma camada futura de Weather Director no cliente, sem precisar editar permanentemente os arquivos nativos.

**Uso:** chuva/tempestade/fog com sequência previsível para teste e screenshots.

## 5. VisualSettings por resource

O FiveM mantém overrides de visual settings associados ao resource e recarrega os valores quando o resource termina. Isso é particularmente importante para o Silva Vision: a camada `visualsettings` pode ser aplicada como override runtime e removida no rollback, em vez de substituir cegamente o arquivo original.

**Decisão:** preferir runtime override quando o parâmetro estiver disponível; manter arquivo nativo apenas como fallback experimental.

## 6. Light extra flags

Foi localizado `SET_LIGHT_EXTRAFLAGS(int extraFlags)`, client-side, para configuração adicional de uma luz existente.

**Uso potencial:** pesquisa futura de comportamento de luzes específicas. Não será usado na V0.5 sem descobrir e validar os bitmasks corretos.

## 7. O que NÃO entra

- nenhum RPF de terceiro copiado;
- nenhum pacote inteiro de graphics mod;
- nenhum valor extremo encontrado em presets;
- nenhum aumento global de bloom;
- nenhuma substituição de exposição que conflite com ReShade;
- nenhum bitmask de luz inventado;
- nenhuma alteração nativa sem backup.

## Resultado

A pesquisa adicionou quatro possibilidades novas e úteis à arquitetura:

1. **Runtime Timecycle Modifier**;
2. **Runtime Timecycle Variables**;
3. **Transições de Timecycle**;
4. **Weather Director/Cycle control**.

A camada de visualsettings runtime permanece a principal prioridade para V0.5; os novos recursos entram como infraestrutura para V0.6 quando forem validados no FiveM real.
