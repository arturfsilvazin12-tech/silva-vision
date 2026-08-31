# 🇧🇷 Silva Vision — validador básico de estrutura
# Não altera arquivos do GTA/FiveM.
$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$required=@('shaders','presets','config','world','performance','tools','docs')
Write-Host "🇧🇷 SILVA VISION — VERIFICAÇÃO" -ForegroundColor Cyan
foreach($d in $required){
  $p=Join-Path $root $d
  if(Test-Path $p){Write-Host "✅ $d"}else{Write-Host "❌ $d"}
}
$fx=Get-ChildItem (Join-Path $root 'shaders') -Filter '*.fx' -ErrorAction SilentlyContinue
Write-Host "`n🎨 Shaders encontrados: $($fx.Count)"
$ini=Get-ChildItem (Join-Path $root 'presets') -Filter '*.ini' -Recurse -ErrorAction SilentlyContinue
Write-Host "🎛️ Presets encontrados: $($ini.Count)"
Write-Host "`n⚠️ Este script verifica somente a estrutura. Compatibilidade ReShade/FiveM exige teste real."
