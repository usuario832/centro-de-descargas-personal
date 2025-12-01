# Script de inicio - Centro de Descargas Personal

Write-Host "===================================" ForegroundColor Cyan
Write-Host "Iniciando servicios..." -ForegroundColor Cyan
Write-Host "===================================" ForegroundColor Cyan
Write-Host ""

Write-Host "Creando carpetas..." -ForegroundColor Yellow

mkdir configs 2>$null
mkdir downloads 2>$null
mkdir configs\qbittorrent 2>$null
mkdir configs\qbittorrent\qBittorrent 2>$null
mkdir configs\jackett 2>$null
mkdir configs\portainer 2>$null

Write-Host "Carpetas listas" -ForegroundColor Green
Write-Host ""

Write-Host "Configurando credenciales de qBittorrent..." -ForegroundColor Yellow

$contenido = @"
[Preferences]
WebUI\Username=admin
WebUI\Password_PBKDF2="@ByteArray(ARQ77eY1NUZaQsuDHbIMCA==:0WMRkYTUWVT9wVvdDtHAjU9b3b7uB8NR1Gur2hmQCvCDpm39Q+PsJRJPaCU51dEiz+dTzh8qbPsL8WkFljQYFQ==)"
"@

$ruta = ".\configs\qbittorrent\qBittorrent\qBittorrent.conf"

if (-not (Test-Path $ruta)) {
    $contenido | Out-File -FilePath $ruta -Encoding UTF8
    Write-Host "Credenciales correctamente configuradas" -ForegroundColor Green
} 
else {
    Write-Host "Archivo de configuracion ya existe" -ForegroundColor Gray
}

Write-Host ""

Write-Host "Levantando contenedores..." -ForegroundColor Yellow
podman-compose up -d

Write-Host ""
Write-Host "===================================" -ForegroundColor Green
Write-Host "Servicios iniciados!" -ForegroundColor Green
Write-Host "===================================" -ForegroundColor Green
Write-Host ""
Write-Host "qBittorrent: http://localhost:8080" -ForegroundColor Cyan
Write-Host "Jackett:     http://localhost:9117" -ForegroundColor Cyan
Write-Host "Portainer:   http://localhost:9000" -ForegroundColor Cyan
Write-Host ""

Write-Host "Esperando a que qBittorrent inicie..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

Write-Host ""
Write-Host "===================================" -ForegroundColor Green
Write-Host "CREDENCIALES DE ACCESO" -ForegroundColor Green
Write-Host "===================================" -ForegroundColor Green
Write-Host ""
Write-Host "Usuario: admin" -ForegroundColor Cyan
Write-Host "Contraseña: adminadmin" -ForegroundColor Cyan
Write-Host ""
Write-Host "(Configuradas en el .env)" -ForegroundColor Gray
Write-Host ""

Write-Host "===================================" -ForegroundColor Green
Write-Host "HASTA LA VISTA BABY" -ForegroundColor Green
Write-Host "===================================" -ForegroundColor Green
Write-Host ""