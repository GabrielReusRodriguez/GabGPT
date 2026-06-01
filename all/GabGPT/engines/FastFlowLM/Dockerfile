#ARG BASE_IMAGE=ubuntu:24.04

FROM ubuntu:24.04
#FROM {BASE_IMAGE}

# Basado en el Dockerfile del repositorio oficial https://github.com/FastFlowLM/FastFlowLM.git
# Primero instalo las dependencias.
LABEL org.opencontainers.image.description="FastFlowLM build environment with all dependencies pre-installed"
LABEL org.opencontainers.image.source="https://github.com/FastFlowLM/FastFlowLM"

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
ARG UBUNTU_PPA=""
ARG BACKPORTS=""

# Set up PPA if needed
RUN if [ -n "$UBUNTU_PPA" ]; then \
        apt update && apt install -y software-properties-common && \
        add-apt-repository -y "$UBUNTU_PPA"; \
    fi

# setup backports if needed
RUN if [ -n "$BACKPORTS" ]; then \
        echo "deb http://deb.debian.org/debian $BACKPORTS main" >> /etc/apt/sources.list; \
        apt update; \
        apt install -t $BACKPORTS -y libxrt-dev; \
    fi

# Install all build dependencies
RUN apt update && apt install -y \
    build-essential \
    cargo \
    cmake \
    debhelper-compat \
    dpkg-dev \
    fakeroot \
    git \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libboost-dev \
    libboost-program-options-dev \
    libcurl4-openssl-dev \
    libdrm-dev \
    libfftw3-dev \
    libreadline-dev \
    libswresample-dev \
    libswscale-dev \
    libxrt-dev \
    nasm \
    ninja-build \
    patchelf \
    pkg-config \
    uuid-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Necesito el restc 1.85 y los repositorios de apt tienen hasta el 1.75 asi que lo instalo por separado.
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh  -s -- -y && \
    . "$HOME/.cargo/env" && \
    rustup toolchain install 1.85 && \
    rustup default 1.85

#RUN source $HOME/.cargo/env
#RUN rustup toolchain install 1.85

WORKDIR /app

# Ahora voy a compilarlo.

# Clonamos el repositorio.
RUN git clone --depth 1 --recursive https://github.com/FastFlowLM/FastFlowLM.git
WORKDIR FastFlowLM/src

# Configuramos la compilacion
# Con --preset linux-default, se instalará en /opt/fastflolm
RUN cmake --preset linux-default

#WORKDIR build 
# Hacemos Build del proyecto. Las variables CXX_FLAGS y C_FLAGS son para evitar un error entre el compilador gcc 12 y el protobuf
# Preparo los flags de compilacion del compilador 
#RUN cmake -B build \
#	-DCMAKE_CXX_FLAGS="-Wno-array-bounds -Wno-stringop-overread" \
#    	-DCMAKE_C_FLAGS="-Wno-array-bounds -Wno-stringop-overread"

# Compilo
RUN cmake --build build -j$(nproc)

# OPCIONAL:  instalamos el proyecto
RUN sudo cmake --install build


#CMD ["/bin/bash"]
