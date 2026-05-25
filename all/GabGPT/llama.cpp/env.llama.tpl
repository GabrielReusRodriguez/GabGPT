# --- Configuracion de llama-server para runtime ---
# Variables de Entorno.
# Configuracion de llama-server

GABGPT_MODEL_FAMILY=Qwen
GABGPT_MODEL_FILE=Qwen-3-14B-Q4_K_M

LLAMA_ARG_ALIAS=Qwen3-14B-Q4_K_M
LLAMA_ARG_MODEL=${GABGPT_CONTAINER_MODELS_FOLDER}/${GABGPT_MODEL_FAMILY}/${GABGPT_MODEL_FILE}.gguf
