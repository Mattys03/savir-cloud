@echo off
chcp 65001 > nul
title Savir Cloud - Local Orchestrator (Windows)
echo ====================================================
echo      INICIANDO SAVIR CLOUD (LOCALMENTE - WINDOWS)
echo ====================================================
echo.

:: Verificar se Java está instalado
where java >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️ Erro: O Java não foi encontrado no seu PATH.
    echo Certifique-se de ter o Java 17+ instalado para rodar os JARs.
    echo.
    pause
    exit /b
)

:: Verificar existência dos JARs
if not exist "auth-service\target\auth-service-1.0.0.jar" (
    echo ⚠️ Erro: auth-service-1.0.0.jar não encontrado em auth-service\target\
    echo Execute 'mvn clean package' no projeto antes de rodar localmente.
    echo.
    pause
    exit /b
)
if not exist "catalog-service\target\catalog-service-1.0.0.jar" (
    echo ⚠️ Erro: catalog-service-1.0.0.jar não encontrado em catalog-service\target\
    echo Execute 'mvn clean package' no projeto antes de rodar localmente.
    echo.
    pause
    exit /b
)

echo [1/3] Iniciando Auth Service na porta 8081...
start /b java -jar auth-service\target\auth-service-1.0.0.jar > auth.log 2>&1

echo [2/3] Iniciando Catalog Service na porta 8082...
start /b java -jar catalog-service\target\catalog-service-1.0.0.jar > catalog.log 2>&1

echo.
echo Aguardando 6 segundos para inicialização dos serviços Spring Boot...
timeout /t 6 /nobreak > nul

echo [3/3] Abrindo o Frontend no seu navegador padrão...
start "" "frontend\index.html"

echo.
echo ====================================================
echo            SISTEMA EM EXECUÇÃO LOCAL!
echo ====================================================
echo.
echo - Auth Service rodando em: http://localhost:8081
echo - Catalog Service rodando em: http://localhost:8082
echo - Frontend aberto via: frontend\index.html
echo.
echo Pressione QUALQUER TECLA para fechar o sistema e liberar as portas...
echo ====================================================
pause > nul

echo.
echo Finalizando processos Java das portas 8081 e 8082...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8081" ^| findstr "LISTENING"') do taskkill /f /pid %%a >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8082" ^| findstr "LISTENING"') do taskkill /f /pid %%a >nul 2>&1

echo Sistema encerrado com sucesso!
timeout /t 2 > nul
exit
