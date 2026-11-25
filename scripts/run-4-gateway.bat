@echo off
title [4/4] Spring Cloud API Gateway (Port 8085)
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d "%~dp0..\Gateway"
echo ========================================================
echo  DEMARRAGE DE L'API GATEWAY SUR LE PORT 8085
echo ========================================================
call mvnw.cmd spring-boot:run
pause
