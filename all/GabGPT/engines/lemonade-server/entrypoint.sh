#!/bin/bash
set -e

FLAG_FILE="/app/lemonade/built_in/.data/.backends_installed"

# 1. Si no existe el archivo bandera, levantamos el server temporal y descargamos todo
if [ ! -f "$FLAG_FILE" ]; then
    echo "[Deploy] Primera ejecución detectada. Preparando backends con hardware real..."
    
    # Arrancamos el servidor en segundo plano
    /app/lemonade/lemond --host 127.0.0.1 &
    LEMOND_PID=$!
    
    echo "[Deploy] Esperando a que el servidor responda..."
    until curl --output /dev/null --silent --fail http://127.0.0.1:13305/live; do
 	# Verificamos si por alguna razón el proceso lemond murió dentro del bucle para no esperar eternamente
        if ! kill -0 $LEMOND_PID 2>/dev/null; then
            echo "[Error] lemond se detuvo inesperadamente antes de responder. Abortando."
            exit 1
        fi
        echo "[Deploy] El servidor aún no está listo... reintentando en 2 segundos..."
        sleep 2
    done

    echo "[Deploy] ¡Servidor Lemonade en línea y respondiendo bien! Procediendo..."
    sleep 2 # Una pequeña pausa de cortesía para estabilizar el socket

    instalar_backend() {
        echo "[Deploy] Instalando $1..."
        /app/lemonade/lemonade backends install "$1" || echo "[Deploy] Falló $1, continuando..."
        sleep 2
    }

    # Ahora sí detectará tu iGPU y tu NPU gracias a los dispositivos mapeados
    instalar_backend "llamacpp:rocm"
#    instalar_backend "llamacpp:cpu"
#    instalar_backend "kokoro:cpu"
#    instalar_backend "sd-cpp:cpu"
#    instalar_backend "sd-cpp:rocm"
#    instalar_backend "vllm:rocm"
#    instalar_backend "whispercpp:cpu"

    # Creamos el flag para que la próxima vez se salte este paso largo
    mkdir -p "$(dirname "$FLAG_FILE")"
    touch "$FLAG_FILE"

    echo "[Deploy] Finalizada la instalación inicial. Reiniciando..."
    kill $LEMOND_PID
    wait $LEMOND_PID 2>/dev/null
else
    echo "[Deploy] Los backends ya se encuentran instalados en el almacenamiento persistente."
fi

echo "[Deploy] Iniciando Lemonade Server en modo producción..."
exec /app/lemonade/lemond --host 0.0.0.0
