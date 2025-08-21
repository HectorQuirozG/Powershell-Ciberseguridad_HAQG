function validar-arch {
    param ([string]$Ruta)
    
    try {
        if (Test-Path $Ruta) {
            $contenido = Get-Content $Ruta -ErrorAction Stop
            return "📄 Archivo encontrado y accesible: $Ruta"
        } else {
            throw "El archivo no existe"
        }
    }
    catch {
        return "⚠️ Error: $_"
    }
    finally {
        Write-Host "📝 Validación finalizada para $Ruta" -ForegroundColor Cyan
    }
}

validar-arch -Ruta "C:\archivo inexistente.txt"
validar-arch -Ruta "$Env:USERPROFILE\Desktop\archivo.txt"