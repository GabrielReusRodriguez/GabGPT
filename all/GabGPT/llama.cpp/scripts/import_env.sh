

# Importamos las variables de entorno del Modelo LLM.
# ---------------------------------------------------


echo "=== Cargando las ENV de llama.cpp ==="
echo "Modelo a cargar: $LLAMA_ARG_ALIAS - ${LLAMACPP_CONTAINER_MODELS_FOLDER}/${LLAMACPP_MODEL_FAMILY}/${LLAMACPP_MODEL_FILE}.env"

# Exporto todos las variables de entorno del fichero de entorno correspondiente.
export $(grep -v '^#' ${LLAMACPP_CONTAINER_MODELS_FOLDER}/${LLAMACPP_MODEL_FAMILY}/${LLAMACPP_MODEL_FILE}.env | xargs)
#export $(grep -v '^#' /app/models/Qwen/Qwen-3-14B-Q4_K_M.env  | xargs)

env

