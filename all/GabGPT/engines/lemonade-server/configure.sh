#!/bin/bash

set -e

echo "[Deploy] Iniciando lemond en segundo plano para preparar backends..."
# Arrancamos el servidor en segundo plano
./lemond --host 127.0.0.1 &
LEMOND_PID=$!

echo "[Deploy] Esperando a que el servidor responda..."
# Esperamos unos segundos a que el socket/puerto esté listo
sleep 3

echo "[Deploy] Descargando e instalando backends (ROCm y CPU)..."
# Ahora que el servidor responde, forzamos la instalación local
/app/lemonade/lemonade backends install llamacpp:rocm
/app/lemonade/lemonade backends install llamacpp:cpu
/app/lemonade/lemonade backends install kokoro:cpu
/app/lemonade/lemonade backends install sd-cpp:cpu
/app/lemonade/lemonade backends install sd-cpp:rocm
/app/lemonade/lemonade backends install vllm:rocm
/app/lemonade/lemonade backends install whisper:cpu

echo "[Deploy] Backends listos. Reiniciando servidor en modo producción..."
# Matamos el servidor temporal en segundo plano
kill $LEMOND_PID
wait $LEMOND_PID 2>/dev/null

# Arrancamos el servidor final en primer plano (para que Docker no se apague)
#exec ./lemond --host 0.0.0.0


