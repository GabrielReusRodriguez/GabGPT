# --- Configuracion general ---
# La carpeta con las variables de entorno de ejecución.
GABGPT_SECRET_FOLDER=/mnt/share/.secrets/gabgpt



# --- Configuración de Llama.cpp ---
#########################################################################
# Puerto del contenedor
#LLAMACPP_CONTAINER_PORT=8080
LLAMACPP_GUEST_PORT=8080
# URL del servidor LLM
LLAMACPP_SERVER_URL=http://llama.cpp:8080/v1

# --- Modelos IA ---
# Carpeta con los modelos de IA
GABGPT_HOST_MODELS_FOLDER=/mnt/datos/ai/models/ 
GABGPT_GUEST_MODELS_FOLDER=/app/models

# Fichero del modelo a cargar.
#LLAMACPP_MODEL_FILE=

# Alias que aparecerá en los consumidores.
#LLAMACPP_ARG_ALIAS=


#LLAMACPP_MODEL_2_RUN=${LLAMACPP_CONTAINER_MODELS_FOLDER}/${LLAMACPP_MODEL_FILE}

# --- Arquitectura ---
# https://github.com/ggml-org/llama.cpp/blob/fc2b0053/tools/server/README.md?plain=1#L39-L40
# Parametros de la GPU
# Para forzar la ejecución de la arquitectura RDNA4 es gfx1200 o 12.0.0
AMDGPU_TARGETS=gfx1200
HSA_OVERRIDE_GFX_VERSION=12.0.0


# --- Configuración de Nginx Frontend ---
#########################################################################
NGINX_HOST_HTTP_PORT=80
NGINX_GUEST_HTTP_PORT=80
NGINX_HOST_HTTPS_PORT=443
NGINX_GUEST_HTTPS_PORT=443

# --- Configuración de OpenWebUI Frontend ---
#########################################################################
OPENWEBUI_HOST_PORT=3000
OPENWEBUI_GUEST_PORT=8080
OPENWEBUI_DATA_PATH=/mnt/datos/openwebui



# --- Configuracion n8n ---
#########################################################################
N8N_BASIC_AUTH_ACTIVE=true  	# Activa autenticación básica
N8N_BASIC_AUTH_USER=admin    	# Usuario para el login
N8N_BASIC_AUTH_PASSWORD=1234	# Contraseña para el login
N8N_HOST=0.0.0.0             	# Permite acceso desde cualquier host
N8N_PROTOCOL=https	    	# protocolo de acceso
N8N_PORT=5678                	# Puerto de n8n
NODE_ENV=production         	# Entorno de producción
N8N_GUEST_DATA_PATH=/mnt/datos/n8n_data	# Carpeta donde se guardan los ficheros de n8n
