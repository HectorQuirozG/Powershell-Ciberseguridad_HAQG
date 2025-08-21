Set-StrictMode -Version latest
function verificar-integridad {
<#
.SYNOPSIS
Verifica si los archivos criticos han sido modificados desde la ultima revision

.DESCRIPTION
Calcula el hash actual de cada archivo, lo compara con un registro previo y alerta si hay modificaciones

.PARAMETER Ruta
Ruta de la carpeta que contiene los archivos a verificar
.EXAMPLE
verificar-integridad -ruta "C:\ArchivosCriticos"

.NOTES
Ideal para detectar alteraciones en archivos de configuración o scripts sensibles
#>

    param(
        [Parameter(Mandatory = $true)]
        [String]$Ruta
    )

    $fechaActual = Get-Date -Format "yyy-MM-dd HH:mm:ss"
    $registroActual = @()
    $registroCambios = @()

    $archivoRegistro = ".\reporte_integridad.csv"
    $archivoCambios = ".\archivos_modificados.csv"

    try {
        $archivos = Get-ChildItem -Path $Ruta -File -Recurse

        foreach ($archivo in $archivos){
            $hashActual = Get-FileHash -Path $archivo.FullName -Algorithm SHA256

            $registroActual += [PSCustomObject]@{
                Nombre = $archivo.Name
                Ruta = $archivo.FullName
                Hash = $hashActual.Hash
                FechaValidacion = $fechaActual
            }
            
            if (Test-Path $archivoRegistro){
                $registroPrevio = Import-Csv -Path $archivoRegistro
                $registroAnterior = $registroPrevio | Where-Object {
                $_.Nombre -eq $archivo.Name -and $_.Ruta 