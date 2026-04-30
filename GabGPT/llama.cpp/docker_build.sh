#!/bin/env bash

#: ${DOCKER_IMG_NAME:='llama-cpp-qwen'}
#: ${LLM_URL:='https://huggingface.co/Qwen/Qwen3-14B-GGUF/resolve/main/Qwen3-14B-Q5_K_M.gguf?download=true'}
#: ${LLM_FILE:='Qwen3-14B-Q5_K_M.gguf'}

docker build \
        --build-arg LLM_URL=${LLAMA_LLM_URL}  \
        --build-arg LLM_FILE=${LLAMA_LLM_FILE} \
        -t ${LLAMA_DOCKER_IMG_NAME} .