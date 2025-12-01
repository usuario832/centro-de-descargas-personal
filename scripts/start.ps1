# Script de inicio - Centro de Descargas Personal

Write-Host "===================================" ForegroundColor Cyan
Write-Host "Iniciando servicios..." -ForegroundColor Cyan
Write-Host "===================================" ForegroundColor Cyan
Write-Host ""

Write-Host "Creando carpetas..." -ForegroundColor Yellow

mkdir configs 2>$null
mkdir downloads 2>$null
mkdir configs\qbittorrent 2>$null
mkdir configs\jackett 2>$null
mkdir configs\portainer 2>$null

Write-Host "Carpetas listas" -ForegroundColor Green
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

Write-Host "Buscando contraseña temporal..." -ForegroundColor Yellow
Write-Host ""

$logs = podman logs centro-de-descargas 2>&1
$passwordLine = $logs | Select-String "temporary password"

if ($passwordLine) {
    Write-Host "===================================" -ForegroundColor Green
    Write-Host "CONTRASEÑA ENCONTRADA!" -ForegroundColor Green
    Write-Host "===================================" -ForegroundColor Green
    Write-Host ""
    Write-Host $passwordLine -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Usa esta contraseña para entrar a qBittorrent" -ForegroundColor White
    Write-Host ""
} 
else {
    Write-Host "No se encontró la contraseña aún" -ForegroundColor Red
    Write-Host "Búscala manualmente con:" -ForegroundColor Red
    Write-Host "podman logs centro-de-descargas" -ForegroundColor Red
    Write-Host ""
}