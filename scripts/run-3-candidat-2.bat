@echo off
title [3/4] Candidat - Instance 2 (Port 8091)
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d "%~dp0..\codeSource_correctionProsit\backend\backend\microservices\candidat"
echo ========================================================
echo  DEMARRAGE DE CANDIDAT (INSTANCE 2) SUR LE PORT 8091
echo ========================================================
call mvnw.cmd spring-boot:run "-Dspring-boot.run.arguments=--server.port=8091"
pause
