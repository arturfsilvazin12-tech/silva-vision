# Silva Vision V0.5 — White Lights Validator v2
# DIAGNOSTICO SOMENTE. Não altera, instala ou substitui arquivos.
# Procura visualsettings.dat em locais comuns do FiveM e no BUILD.

$ErrorActionPreference = 'SilentlyContinue'
$Build = Join-Path $env:USERPROFILE 'Desktop\SilvaVision_BUILD'
$FiveM = Join-Path $env:LOCALAPPDATA 'FiveM\FiveM.app'
$Reports = Join-Path $Build 'REPORTS'
New-Item -ItemType Directory -Force -Path $Reports | Out-Null
$Report = Join-Path $Reports 'WhiteLights_Validation.txt'

$Targets = @(
    'streetlight.color.red','streetlight.color.green','streetlight.color.blue',
    'distantlights.streetlight.HDRIntensity','coronastar.size','coronastar.intensity',
    'vehicleinteriorlight.color.red','vehicleinteriorlight.color.green','vehicleinteriorlight.color.blue',
    'vehicleinteriorlight.intensity','emissive.multiplier'
)

$Out = New-Object System.Collections.Generic.List[string]
$Out.Add('SILVA VISION V0.5 - WHITE LIGHTS VALIDATION V2')
$Out.Add(('Data: {0}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss')))
$Out.Add('MODO: SOMENTE LEITURA - nenhum arquivo foi modificado.')
$Out.Add('')

$Candidates = New-Object System.Collections.Generic.List[string]
@(
    (Join-Path $FiveM 'citizen\common\data\visualsettings.dat'),
    (Join-Path $FiveM 'citizen\common\data\visualsettings.dat.original'),
    (Join-Path $Build 'RPF_CLIENT\WORK\SILVA_VISION_V05\RPF\SilvaVision_WhiteLights\visualsettings.dat'),
    (Join-Path $Build 'RPF_CLIENT\WORK\SILVA_VISION_V05\RPF\SilvaVision_WhiteLights\visualsettings.dat.original.dat')
) | ForEach-Object { if (Test-Path -LiteralPath $_) { $Candidates.Add($_) } }

# Busca limitada e somente em pastas locais esperadas. Não baixa nada e não altera nada.
foreach ($Root in @($FiveM,$Build)) {
    if (Test-Path -LiteralPath $Root) {
        Get-ChildItem -LiteralPath $Root -Filter 'visualsettings.dat' -File -Recurse -ErrorAction SilentlyContinue |
            ForEach-Object { $Candidates.Add($_.FullName) }
    }
}
$Files = $Candidates | Select-Object -Unique

if (-not $Files) {
    $Out.Add('NENHUM visualsettings.dat encontrado como arquivo separado.')
    $Out.Add('OBSERVACAO: se o arquivo estiver somente dentro de um RPF, esta ferramenta não extrai RPF.')
    $Out.Add('Nesse caso, precisamos de uma cópia extraída/legível para validar as chaves com segurança.')
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

$Out.Add('REGRA: FOUND não significa APROVADO.')
$Out.Add('Aprovação exige formato, semântica e teste controlado no FiveM.')
$Out | Set-Content -LiteralPath $Report -Encoding UTF8
$Out | ForEach-Object { Write-Host $_ }
Write-Host "`nRELATORIO: $Report" -ForegroundColor Cyan
