Write-Host ""
Write-Host "===================================" -ForegroundColor Red
Write-Host "Deteniendo contenedores..." -ForegroundColor Red
Write-Host "===================================" -ForegroundColor Red
Write-Host ""

Write-Host "Deteniendo contenedores..." -ForegroundColor Yellow
podman-compose down
Write-Host ""
podman ps

Write-Host ""
Write-Host "===================================" -ForegroundColor Green
Write-Host "HASTA LA VISTA BABY" -ForegroundColor Green
Write-Host "===================================" -ForegroundColor Green
Write-Host ""