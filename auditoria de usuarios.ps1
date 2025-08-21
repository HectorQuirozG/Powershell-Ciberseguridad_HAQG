$usuarios = Get-LocalUser
$sinLogon = @()
$conLogon = @()
foreach ($u in $usuarios){
    if (-not $u.LastLogon){
        $sinLogon += "$($u.Name): Estado = $($u.Enabled), Último acceso = NUNCA"
    } else {
        $conLogon += "$($u.Name): Estado = $($Enabled), Último acceso = $($u.LastLogon)"
    }
}

$sinLogon | Out-File -FilePath "$pscommandpath\usuarios_sin_logon.txt"
$conLogon | Out-File -FilePath "$pscommandpath\usuarios_sin_logon.txt"

Write-Output "`n Usuarios que NUNCA han iniciado sesión:"
$sinLogon | ForEach-Object {Write-Output $_}
Write-Output "`n Usuarios que SÍ han iniciado sesión:"
$conLogon | ForEach-Object {Write-Output $_}