# Script PowerShell de Test et Validation du Load Balancing
Write-Host "========================================================" -ForegroundColor Yellow
Write-Host " TEST DU ROUTAGE ET DU LOAD BALANCER VIA L'API GATEWAY " -ForegroundColor Yellow
Write-Host "========================================================" -ForegroundColor Yellow

# 1. Verification de la Gateway
Write-Host "`n1. Verification de l'API Gateway..." -ForegroundColor Cyan
try {
    $health = Invoke-RestMethod -Uri "http://localhost:8085/actuator/health" -Method Get -TimeoutSec 3
    Write-Host "   API Gateway Status: $($health.status)" -ForegroundColor Green
} catch {
    Write-Host "   [ATTENTION] La Gateway n'est pas encore accessible sur http://localhost:8085" -ForegroundColor Red
    Write-Host "   Assurez-vous d'avoir execute run-4-gateway.bat" -ForegroundColor Gray
    exit 1
}

# 2. Envoi de requetes consecutives
Write-Host "`n2. Envoi de 10 requetes vers http://localhost:8085/mic1/candidates..." -ForegroundColor Cyan
1..10 | ForEach-Object {
    $i = $_
    try {
        $startTime = Get-Date
        $response = Invoke-RestMethod -Uri "http://localhost:8085/mic1/candidates" -Method Get
        $duration = [math]::Round(((Get-Date) - $startTime).TotalMilliseconds)
        Write-Host "   [Requete #$i] OK - $($response.Count) candidats recuperes en ${duration}ms" -ForegroundColor Green
    } catch {
        Write-Host "   [Requete #$i] Erreur: $_" -ForegroundColor Red
    }
    Start-Sleep -Milliseconds 300
}

Write-Host "`n========================================================" -ForegroundColor Yellow
Write-Host " Consultez maintenant la console de l'API Gateway !" -ForegroundColor Yellow
Write-Host " Observez les lignes 'DEBUG o.s.c.l.c.RandomLoadBalancer'" -ForegroundColor Cyan
Write-Host " pour constater la repartition aleatoire entre 8081 et 8091." -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Yellow
