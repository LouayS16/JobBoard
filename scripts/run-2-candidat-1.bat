@echo off
title [2/4] Candidat - Instance 1 (Port 8081)
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d "%~dp0..\codeSource_correctionProsit\backend\backend\microservices\candidat"
echo ========================================================
echo  DEMARRAGE DE CANDIDAT (INSTANCE 1) SUR LE PORT 8081
echo ========================================================
call mvnw.cmd spring-boot:run
pause
