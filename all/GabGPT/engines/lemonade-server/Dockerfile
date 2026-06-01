# ==============================================================
# # 1. Build stage — compile lemonade C++ binaries
# # ============================================================
FROM ubuntu:24.04 AS builder
#FROM rocm/dev-ubuntu-24.04 as builder

# Avoid interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libssl-dev \
    pkg-config \
    git \
    && rm -rf /var/lib/apt/lists/*


# Copy source code
WORKDIR /app
RUN git clone --depth 1 --single-branch https://github.com/lemonade-sdk/lemonade.git

WORKDIR /app/lemonade
# Build the project

#RUN rm -rf build && \
#    mkdir -p build && \
#    cd build && \ 
#    cmake --build --preset default \
#    cmake .. && \
#    cmake --build . --config Release -j"$(nproc)"

# Ejecuto el script que se encarga de las dependencias y le paso CI = true  par que asuma que le digo que si a todo.
RUN CI=true ./setup.sh

RUN mkdir -p build
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
RUN cmake --build  build --config Release  -j"$(nproc)"

# Debug: Check build outputs
RUN echo "=== Build directory contents ===" && \
    ls -la build/ && \
    echo "=== Checking for resources ===" && \
    find build/ -name "*.json" -o -name "resources" -type d

# # ============================================================
# # 2. Runtime stage — small, clean image
# # ============================================================
FROM ubuntu:24.04

# Install runtime dependencies only
RUN apt-get update && apt-get install -y \
    libcurl4 \
    curl \
    libssl3 \
    zlib1g \
    vulkan-tools \
    libvulkan1 \
    unzip \
    libgomp1 \
    libatomic1 \
    libwebsockets-dev \
    && rm -rf /var/lib/apt/lists/*

# Create application directory
WORKDIR /app/lemonade

# Copy built executables and resources from builder
COPY --from=builder /app/lemonade/build/lemond /app/lemonade/lemond
COPY --from=builder /app/lemonade/build/lemonade /app/lemonade/lemonade
COPY --from=builder /app/lemonade/build/resources /app/lemonade/resources

# Make executables executable
RUN chmod +x /app/lemonade/lemond /app/lemonade/lemonade

# Create necessary directories
#RUN mkdir -p /opt/lemonade/llama/cpu \
#    /opt/lemonade/llama/vulkan \
#    /opt/lemonade/.cache/huggingface

# Expose default port
EXPOSE 13305

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:13305/live || exit 1

#RUN ls -la /app/lemonade/ && file /app/lemonade/lemond || true
# Default command: start server in headless mode
CMD ["/app/lemonade/lemond", "--host", "0.0.0.0"]

