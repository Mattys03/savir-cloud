#!/bin/bash

# Configura UTF-8
export LANG=C.UTF-8

echo "===================================================="
echo "   INICIANDO SAVIR CLOUD (LOCALMENTE - LINUX MINT)"
echo "===================================================="
echo ""

# Verificar se Java está instalado
if ! command -v java &> /dev/null
then
    echo "⚠️ Erro: Java (JRE/JDK) não está instalado ou não foi adicionado ao PATH."
    echo "Por favor, instale o Java 17+ para rodar o sistema localmente."
    exit 1
fi

# Verificar existência dos JARs
if [ ! -f "auth-service/target/auth-service-1.0.0.jar" ] || [ ! -f "catalog-service/target/catalog-service-1.0.0.jar" ]; then
    echo "⚠️ Erro: JARs do projeto não encontrados nos diretórios target/."
    echo "Por favor, compile o projeto antes ou verifique os arquivos."
    exit 1
fi

echo "[1/3] Iniciando Auth Service na porta 8081..."
java -jar auth-service/target/auth-service-1.0.0.jar > auth.log 2>&1 &
AUTH_PID=$!

echo "[2/3] Iniciando Catalog Service na porta 8082..."
java -jar catalog-service/target/catalog-service-1.0.0.jar > catalog.log 2>&1 &
CATALOG_PID=$!

echo "Aguardando 6 segundos para inicialização dos serviços Spring Boot..."
sleep 6

echo "[3/3] Abrindo o Frontend no navegador padrão..."
if command -v xdg-open &> /dev/null
then
    xdg-open frontend/index.html
elif command -v gnome-open &> /dev/null
then
    gnome-open frontend/index.html
else
    echo "Não foi possível abrir o navegador automaticamente."
    echo "Abra manualmente o arquivo: frontend/index.html"
fi

echo ""
echo "===================================================="
echo "           SISTEMA EM EXECUÇÃO LOCAL!"
echo "===================================================="
echo ""
echo " - Auth Service rodando em: http://localhost:8081 (PID: $AUTH_PID)"
echo " - Catalog Service rodando em: http://localhost:8082 (PID: $CATALOG_PID)"
echo " - Frontend aberto via: frontend/index.html"
echo ""
echo "Pressione [ENTER] para ENCERRAR o sistema e liberar as portas..."
echo "===================================================="
read -r

echo "Finalizando processos Java..."
kill -9 $AUTH_PID 2>/dev/null
kill -9 $CATALOG_PID 2>/dev/null

# Limpeza garantida de portas por segurança
AUTH_PORT_PID=$(lsof -t -i:8081 2>/dev/null)
if [ ! -z "$AUTH_PORT_PID" ]; then
    kill -9 $AUTH_PORT_PID 2>/dev/null
fi

CATALOG_PORT_PID=$(lsof -t -i:8082 2>/dev/null)
if [ ! -z "$CATALOG_PORT_PID" ]; then
    kill -9 $CATALOG_PORT_PID 2>/dev/null
fi

echo "Sistema encerrado com sucesso!"
