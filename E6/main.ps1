Clear-Host
Import-Module auditoriabasica

Write-Host "=== Auditoría básica de usuarios y servicios ==="
Write-Host "1. Mostrar usuarios inactivos"
Write-Host "2. Mostrar servicios externos activos"

$op = Read-Host "Selecciona una opción: "

switch ($op) {
    "1" {
        $usuarios = obtener-usuariosinactivos
        $usuarios | Format-Table name, enabled, lastlogon -AutoSize
        $usuarios | Export-Csv -Path ".\users_inac.csv" -NoTypeInformation
        Write-Host "`n📄 Reporte generado: users_inac.csv"
    }
    "2" {
        $servicios = obtener-serviciosexternos
        $servicios | Format-Table displayname, status, starttype -AutoSize
        $servicios | ConvertTo-Html | Out-File ".\serv_e.html"
        Write-Host "`n📄 Reporte generado: serv_e.html"
    }
    default {
        Write-Host "Opción inváida"
    }
}