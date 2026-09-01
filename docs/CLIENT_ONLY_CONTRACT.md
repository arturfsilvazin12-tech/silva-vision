# Silva Vision — Client-Only Contract

## Regra principal
Silva Vision é um mod visual para o jogador. A instalação necessária deve ficar no cliente FiveM.

## Não exigir
- resource instalado pelo servidor;
- acesso à pasta do servidor;
- alterações em scripts do servidor;
- alteração de gameplay/handling;
- controle do clima do servidor;
- dependência de um servidor próprio.

## Permitido
- ReShade e shaders no cliente;
- overrides visuais locais;
- leitura de horário/clima/interior do cliente;
- adaptação de iluminação, água, atmosfera e VFX no cliente;
- perfis de qualidade/performance locais.

## Regra de compatibilidade
Quando uma função exigir participação do servidor para produzir o efeito visual, ela não pode ser requisito da release client-only. Deve existir fallback local ou a função fica experimental/desativada.
