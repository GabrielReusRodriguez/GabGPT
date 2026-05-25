#!/bin/env bash

# Importamos las variables de entorno del Modelo LLM.
# ---------------------------------------------------

echo "=== Cargando las ENV de llama.cpp ==="
echo "Modelo a cargar: $LLAMA_ARG_ALIAS - ${GABGPT_GUEST_MODELS_FOLDER}/${GABGPT_MODEL_FAMILY}/${GABGPT_MODEL_FILE}.env"

# Exporto todos las variables de entorno del fichero de entorno correspondiente.
export $(grep -v '^#' ${GABGPT_GUEST_MODELS_FOLDER}/${GABGPT_MODEL_FAMILY}/${GABGPT_MODEL_FILE}.env | xargs)


