# scripts/start-all.ps1
$env:JAVA_HOME = "C:\Program Files\Java\jdk-17"
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"

$baseDir = Split-Path -Parent $PSScriptRoot

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "   DEMARRAGE DE TOUS LES COMPOSANTS (POWERSHELL)" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan

Write-Host "[1/4] Lancement d'Eureka Server (8761)..." -ForegroundColor Yellow
$eurekaDir = Join-Path $baseDir "codeSource_correctionProsit\backend\backend\microservices\eureka-server"
Start-Process -FilePath "cmd.exe" -ArgumentList "/k cd /d `"$eurekaDir`" && mvnw.cmd spring-boot:run" -WorkingDirectory $eurekaDir

Write-Host "Attente de 15s pour initialisation Eureka..." -ForegroundColor Gray
Start-Sleep -Seconds 15

Write-Host "[2/4] Lancement de Candidat Instance 1 (8081)..." -ForegroundColor Yellow
$candidatDir = Join-Path $baseDir "codeSource_correctionProsit\backend\backend\microservices\candidat"
Start-Process -FilePath "cmd.exe" -ArgumentList "/k cd /d `"$candidatDir`" && mvnw.cmd spring-boot:run" -WorkingDirectory $candidatDir

Write-Host "[3/4] Lancement de Candidat Instance 2 (8091)..." -ForegroundColor Yellow
Start-Process -FilePath "cmd.exe" -ArgumentList "/k cd /d `"$candidatDir`" && mvnw.cmd spring-boot:run -Dspring-boot.run.arguments=--server.port=8091" -WorkingDirectory $candidatDir

Write-Host "Attente de 15s pour enregistrement Eureka..." -ForegroundColor Gray
Start-Sleep -Seconds 15

Write-Host "[4/4] Lancement de API Gateway (8085)..." -ForegroundColor Yellow
$gatewayDir = Join-Path $baseDir "Gateway"
Start-Process -FilePath "cmd.exe" -ArgumentList "/k cd /d `"$gatewayDir`" && mvnw.cmd spring-boot:run" -WorkingDirectory $gatewayDir

Write-Host "========================================================" -ForegroundColor Green
Write-Host "   TOUS LES SERVICES SONT EN COURS D'EXECUTION !" -ForegroundColor Green
Write-Host "   - Eureka Dashboard : http://localhost:8761" -ForegroundColor Green
Write-Host "   - API Gateway      : http://localhost:8085/mic1/candidates" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green
