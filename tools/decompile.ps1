<#
.SYNOPSIS
    Decompila o HabboAir.swf inteiro para uma arvore de codigo-fonte .as legivel, usando o JPEXS (ffdec).

.EXAMPLE
    .\decompile.ps1 -FfdecDir C:\ffdec -SwfPath C:\airplus-local\HabboAir.swf -OutDir C:\airplus-local\HabboAir_src
#>
param(
    [string]$FfdecDir = "C:\ffdec",
    [Parameter(Mandatory = $true)][string]$SwfPath,
    [Parameter(Mandatory = $true)][string]$OutDir
)

$ffdecJar = Join-Path $FfdecDir "ffdec.jar"
if (-not (Test-Path $ffdecJar)) {
    Write-Error "Nao encontrei ffdec.jar em $FfdecDir. Ajuste -FfdecDir ou baixe o JPEXS (ver docs/SETUP.md)."
    exit 1
}
if (-not (Test-Path $SwfPath)) {
    Write-Error "Nao encontrei o SWF em $SwfPath."
    exit 1
}

Write-Host "Decompilando $SwfPath -> $OutDir (isso demora uns 10-15 minutos)..."
java -Xmx4g -jar $ffdecJar -onerror ignore -export script $OutDir $SwfPath

Write-Host "Concluido. Classes .as em: $OutDir\scripts"
