Clear-Host

function verificar-puerto {
    param (
        [int]$Puerto
    )

    try {
        $cliente = New-Object System.Net.Sockets.TcpClient -ErrorAction Stop
        $cliente.Connect("8.8.8.8", $Puerto)
        $cliente.Close()
        return "Puerto $Puerto está abierto"
    }
    catch {
        return "Puerto $Puerto no está disponible"
    }
    finally {
        Write-Host "Verificación completada para el puerto $Puerto" -ForegroundColor Cyan
    }
}

Verificar-Puerto -Puerto 80
Verificar-Puerto -Puerto 9999
Verificar-Puerto -Puerto 22