# Script de inicio - Centro de Descargas Personal

Write-Host "===================================" ForegroundColor Cyan
Write-Host "Iniciando servicios..." -ForegroundColor Cyan
Write-Host "===================================" ForegroundColor Cyan
Write-Host ""

# Crear carpetas necesarias
Write-Host "Creando carpetas..." -ForegroundColor Yellow

mkdir configs 2>$null
mkdir downloads 2>$null
mkdir configs\qbittorrent 2>$null
mkdir configs\jackett 2>$null
mkdir configs\portainer 2>$null

Write-Host "Carpetas listas" -ForegroundColor Green
Write-Host ""

# Iniciar contenedores
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