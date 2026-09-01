# Silva Vision V0.5 — White Lights Validator
# DIAGNOSTICO SOMENTE. Não altera, instala ou substitui arquivos.

$ErrorActionPreference = 'SilentlyContinue'
$Build = Join-Path $env:USERPROFILE 'Desktop\SilvaVision_BUILD'
$FiveM = Join-Path $env:LOCALAPPDATA 'FiveM\FiveM.app'
$Candidates = @(
    (Join-Path $FiveM 'citizen\common\data\visualsettings.dat'),
    (Join-Path $Build 'RPF_CLIENT\WORK\SILVA_VISION_V05\RPF\SilvaVision_WhiteLights\visualsettings.dat'),
    (Join-Path $Build 'RPF_CLIENT\WORK\SILVA_VISION_V05\RPF\SilvaVision_WhiteLights\visualsettings.dat.original.dat')
)
$Targets = @(
    'streetlight.color.red','streetlight.color.green','streetlight.color.blue',
    'distantlights.streetlight.HDRIntensity','coronastar.size','coronastar.intensity',
    'vehicleinteriorlight.color.red','vehicleinteriorlight.color.green','vehicleinteriorlight.color.blue',
    'vehicleinteriorlight.intensity','emissive.multiplier'
)
$Reports = Join-Path $Build 'REPORTS'
New-Item -ItemType Directory -Force -Path $Reports | Out-Null
$Report = Join-Path $Reports 'WhiteLights_Validation.txt'
$Out = New-Object System.Collections.Generic.List[string]
$Out.Add('SILVA VISION V0.5 — WHITE LIGHTS VALIDATION')
$Out.Add(('Data: {0}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss')))
$Out.Add('MODO: SOMENTE LEITURA — nenhum arquivo foi modificado.')
$Out.Add('')

$Files = $Candidates | Where-Object { Test-Path $_ } | Select-Object -Unique
if (-not $Files) {
    $Out.Add('NENHUM visualsettings.dat encontrado.')
} else {
    foreach ($File in $Files) {
        $Out.Add(('ARQUIVO: {0}' -f $File))
        $Text = Get-Content -LiteralPath $File -Raw
        foreach ($Target in $Targets) {
            $Lines = $Text -split "`r?`n" | Where-Object { $_ -match [regex]::Escape($Target) }
            if ($Lines) {
                $Out.Add(('FOUND: {0}' -f $Target))
                foreach ($Line in $Lines) { $Out.Add(('  {0}' -f $Line.Trim())) }
            } else {
                $Out.Add(('NOT FOUND: {0}' -f $Target))
            }
        }
        $Out.Add('')
    }
}
$Out.Add('REGRA: encontrar uma chave NÃO significa que ela está aprovada para runtime.')
$Out.Add('Aprovação exige confirmação de formato, semântica e teste controlado no FiveM.')
$Out | Set-Content -LiteralPath $Report -Encoding UTF8
$Out | ForEach-Object { Write-Host $_ }
Write-Host "`nRELATORIO: $Report" -ForegroundColor Cyan
