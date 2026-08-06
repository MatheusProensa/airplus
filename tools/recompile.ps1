<#
.SYNOPSIS
    Reimporta classes .as editadas de volta num .swf, gerando um novo .swf customizado.
    ImportFolder deve conter a subpasta "scripts\..." espelhando o pacote das classes editadas
    (ex: ImportFolder\scripts\com\sulake\habbo\window\LilithCustoms.as).

.EXAMPLE
    .\recompile.ps1 -FfdecDir C:\ffdec -InSwf C:\airplus-local\HabboAir.swf `
        -OutSwf C:\airplus-local\HabboAir_custom.swf -ImportFolder C:\airplus-local\import_folder
#>
param(
    [string]$FfdecDir = "C:\ffdec",
    [Parameter(Mandatory = $true)][string]$InSwf,
    [Parameter(Mandatory = $true)][string]$OutSwf,
    [Parameter(Mandatory = $true)][string]$ImportFolder
)

$ffdecJar = Join-Path $FfdecDir "ffdec.jar"
if (-not (Test-Path $ffdecJar)) {
    Write-Error "Nao encontrei ffdec.jar em $FfdecDir. Ajuste -FfdecDir ou baixe o JPEXS (ver docs/SETUP.md)."
    exit 1
}

Write-Host "Recompilando $InSwf + $ImportFolder -> $OutSwf ..."
java -Xmx4g -jar $ffdecJar -onerror ignore -air -importScript $InSwf $OutSwf $ImportFolder

if (Test-Path $OutSwf) {
    Write-Host "OK: $OutSwf gerado."
} else {
    Write-Error "Algo falhou, o arquivo de saida nao foi criado. Veja o log acima."
}
