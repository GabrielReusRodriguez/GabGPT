# https://rocm.docs.amd.com/projects/install-on-linux/en/latest/how-to/docker.html

# Usamos una imagen base con ROCm (para AMD GPU)
FROM rocm/rocm-terminal:lastest

# Instalamos dependencias necesarias
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Clonamos el repositorio de llama.cpp
WORKDIR /app
RUN git clone https://github.com/ggml-org/llama.cpp.git
WORKDIR /app/llama.cpp

# Compilamos llama.cpp con soporte para ROCm (AMD GPU)
# Añade aquí tus flags personalizadas para el compilador
RUN cmake -S . -B build \
        -DGGML_CUDA=OFF \
        -DGGML_HIP=ON \
        -DGGML_HIP_TARGETS=gx1200 \
        -DGGML_FAST_MATH=ON \
        -DGGML_CUDA_FORCE_MMAP=ON \
        -DGGML_HIP_UMA=OFF \
        -DGGML_NATIVE=ON \
        -DGGML_AVX512=ON \
        -DGGML_AVX512_VBMI=ON \
        -DGGML_AVX512_VNNI=ON \
        -DLLAMA_OPENSSL=ON \
        -DCMAKE_BUILD_TYPE=Release 
#        -DCMAKE_C_COMPILER=$ROCM_PATH/llvm/bin/clang \
#        -DCMAKE_CXX_COMPILER=$ROCM_PATH/llvm/bin/clang++ 
        
RUN cmake --build build -- -j $(nproc)

# Copiamos el modelo (opcional: puedes montarlo como volumen)
# RUN wget -O /app/llama.cpp/models/llama-2-7b.Q4_K_M.gguf https://example.com/tu-modelo.gguf

# Puerto para el servidor de inferencia
EXPOSE 8080

# Declaramos las variables de entorno necesarias para runtime
# Aquí indicamos que ids de gpu es la que queremos que vea, podemos ver el listado de gpus con rocm-smi y rocminfo (chip ID)
ENV HIP_VISIBLE_DEVICES=0
# Forzamos el uso de memoria Pinned para OCulink.
ENV GGML_HIP_ALLOC_GRAPH=1
# Para forzar la ejecución de la arquitectura RDNA4
ENV HSA_OVERRIDE_GFX_VERSION=12.0.0

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
