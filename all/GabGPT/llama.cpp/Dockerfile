# https://rocm.docs.amd.com/projects/install-on-linux/en/latest/how-to/docker.html

# Usamos una imagen base con ROCm (para AMD GPU)
FROM rocm/dev-ubuntu-24.04:latest
#FROM rocm/:latest

ARG AMDGPU_TARGETS

USER root

# Instalamos dependencias necesarias y borramos el almacen temporal de apt /var/lib/lists/*
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    hipblas-dev     \
    wget \
    && rm -rf /var/lib/apt/lists/*


RUN apt upgrade -y


# Clonamos el repositorio de llama.cpp
WORKDIR /app
RUN git clone --depth 1 https://github.com/ggml-org/llama.cpp.git

# Copiamos los scripts auxiliares
WORKDIR /app/scripts
COPY ./scripts/llama_optimized_compilation.sh /app/scripts/llama_optimized_compilation.sh
RUN chmod +x /app/scripts/llama_optimized_compilation.sh

#  Compilamos llama.cpp con los flags optimizados.
WORKDIR /app/llama.cpp
RUN /app/scripts/llama_optimized_compilation.sh


