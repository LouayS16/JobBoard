@echo off
title [1/4] Serveur Eureka (Port 8761)
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d "%~dp0..\codeSource_correctionProsit\backend\backend\microservices\eureka-server"
echo ========================================================
echo  DEMARRAGE DU SERVEUR EUREKA SUR LE PORT 8761
echo ========================================================
call mvnw.cmd spring-boot:run
pause
