# 🇧🇷 SILVA VISION — plano de instalação seguro
# Esta versão NÃO copia arquivos para GTA/FiveM automaticamente.
# Ela apenas prepara diretórios locais e um relatório.
$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$stamp=Get-Date -Format 'yyyyMMdd-HHmmss'
$out=Join-Path $root ('_SV_INSTALL_REPORT_'+$stamp+'.txt')
$dirs=@('backup','shaders','presets','config','world','performance')
$lines=@('🇧🇷 SILVA VISION — RELATÓRIO DE INSTALAÇÃO','Data: '+(Get-Date),'','Modo: preparação segura')
foreach($d in $dirs){$p=Join-Path $root $d;if(Test-Path $p){$lines+=('✅ '+$d)}else{$lines+=('⚠️ ausente: '+$d)}}
$lines+='','Nenhum arquivo do GTA/FiveM foi alterado por este script.','A instalação final depende da validação no PC.'
$lines | Set-Content -Encoding UTF8 $out
Write-Host ($lines -join "`n")
Write-Host "`n📄 Relatório: $out"
