#!/bin/env bash

# Servidor, puerto de escucha
: ${SERVER_PORT}:=8080
# Indicamos el número de threads
: ${SERVER_NUM_THREADS:=12}

# Indicamos la ruta al modelo
: ${LLAMA_MODEL_PATH:="/app/llama.cpp/models/tu-modelo.gguf"}
# El número de capas
: ${LLAMA_N_GPU_LAYERS:=50}
# Indicamos el tamaño de contexto.
: ${LLAMA_CTX_SIZE:=4096}


# Ejecutamos el servidor
exec python3 -m llama.cpp.server \
    --model "${LLAMA_MODEL_PATH}" \
    --host 0.0.0.0 \
    --port 8080 \
    --mlock \
    --flash-attn \
    --n-gpu-layers "${LLAMA_N_GPU_LAYERS}" \
    --ctx-size "${LLAMA_CTX_SIZE}"