@echo off
title Lancement automatique de l'architecture API Gateway
echo ========================================================
echo   DEMARRAGE AUTOMATIQUE DE TOUS LES COMPOSANTS
echo ========================================================

echo [1/4] Lancement du Serveur Eureka (Port 8761)...
start "1. Serveur Eureka (8761)" cmd /k "call "%~dp0run-1-eureka.bat""

echo Attente de 12 secondes pour l'initialisation d'Eureka...
timeout /t 12 /nobreak >nul

echo [2/4] Lancement de Candidat - Instance 1 (Port 8081)...
start "2. Candidat Instance 1 (8081)" cmd /k "call "%~dp0run-2-candidat-1.bat""

echo [3/4] Lancement de Candidat - Instance 2 (Port 8091)...
start "3. Candidat Instance 2 (8091)" cmd /k "call "%~dp0run-3-candidat-2.bat""

echo Attente de 12 secondes pour l'enregistrement dans Eureka...
timeout /t 12 /nobreak >nul

echo [4/4] Lancement de l'API Gateway (Port 8085)...
start "4. Spring Cloud API Gateway (8085)" cmd /k "call "%~dp0run-4-gateway.bat""

echo.
echo ========================================================
echo   TOUS LES COMPOSANTS SONT EN COURS D'EXECUTION !
echo   - Tableau de bord Eureka : http://localhost:8761
echo   - API Gateway Health     : http://localhost:8085/actuator/health
echo   - Routage Candidats       : http://localhost:8085/mic1/candidates
echo ========================================================
echo Vous pouvez maintenant executer test-gateway-loadbalancing.ps1
pause

