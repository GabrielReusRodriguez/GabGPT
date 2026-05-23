# --- Configuracion de llama-server para runtime ---
# Variables de Entorno.

# Chuletas y documentacion ---
# https://github.com/ggml-org/llama.cpp/blob/master/docs/multi-gpu.md
# https://vucense.com/dev-corner/llama-cpp-tutorial-run-gguf-models-2026/
# https://github.com/ggml-org/llama.cpp/blob/master/docs/build.md#hip

# Mejora la carga de datos en arquitecturas compatibles
ROCB_ENABLE_PREFETCH=1
# Forzamos el uso de memoria Pinned para OCulink
GGML_HIP_ALLOC_GRAPH=1
GGML_HIP_ROCWMMA=1
# IDs de GPU que queremos que vea (ver listado con rocm-smi y rocminfo)
##HIP_VISIBLE_DEVICES=0,1
HIP_VISIBLE_DEVICES=1
# en esta variable indicamos que GPUs puede ver llama.cpp . EL primer id es la principal 
#HIP_VISIBLE_DEVICES=0,1

#GPU_DEVICE_ORDINAL=0,1
#ROCR_VISIBLE_DEVICES=0,1
##ROCR_VISIBLE_DEVICES="0,1"
##ROCR_VISIBLE_DEVICES=0,1
ROCR_VISIBLE_DEVICES=1
#CUDA_VISIBLE_DEVICES="0,1"
#GPU_DEVICE_ORDINAL=0,1
#HIP_VISIBLE_DEVICES=0
#HIP_VISIBLE_DEVICES=ROCm0
# Número de capas que ejecutará la GPU
#GPU_CFG_NUM_LAYERS=99

#| `-dev, --device <dev1,dev2,..>` | comma-separated list of devices to use for offloading (none = don't offload)<br/>use --list-devices to see a list of available devices<br/>(env: LLAMA_ARG_DEVICE) |
#| `--list-devices` | print list of available devices and exit |
# Lo puedes sabe con llamacpp-cli --list-devices
##LLAMA_ARG_DEVICE=ROCm1
#LLAMA_ARG_DEVICE=ROCm0
LLAMA_ARG_DEVICE=none

# https://github.com/ROCm/rocm-examples

# --- Configuración de CPU ---
# Número de threads que usará la CPU en la LLM
#CPU_CFG_NUM_THREADS=12

# Argumentos de llama-server.
# https://github.com/ggml-org/llama.cpp/blob/fc2b0053/tools/server/README.md?plain=1#L39-L40

LLAMA_ARG_HOST=0.0.0.0
# Desactivo la Web UI
LLAMA_ARG_WEBUI=false
# API key
# LLAMA_API_KEY= key

# --threads-batch 12 \
#  --batch-size 512 \
#  --ubatch-size 128 \


#| `-b, --batch-size N` | logical maximum batch size (default: 2048)<br/>(env: LLAMA_ARG_BATCH) |
LLAMA_ARG_BATCH=512
#| `-ub, --ubatch-size N` | physical maximum batch size (default: 512)<br/>(env: LLAMA_ARG_UBATCH) |

LLAMA_ARG_CTX_SIZE=40960
#LLAMA_ARG_CTX_SIZE=30960
# | `--mlock` | force system to keep model in RAM rather than swapping or compressing<br/>(env: LLAMA_ARG_MLOCK) |
LLAMA_ARG_MLOCK=1
LLAMA_ARG_FLASH_ATTN=on
# Número de capas que ejecutará la GPU
#LLAMA_ARG_N_GPU_LAYERS=99
LLAMA_ARG_N_GPU_LAYERS=auto
# Cuantizamos la caché para que el contexto sea menos preciso => f16 a f8 pero esto hace que quema el doble en la misma VRAM
# | `-ctk, --cache-type-k TYPE` | KV cache data type for K<br/>allowed values: f32, f16, bf16, q8_0, q4_0, q4_1, iq4_nl, q5_0, q5_1<br/>(default: f16)<br/>(env: LLAMA_ARG_CACHE_TYPE_K) |
# | `-ctv, --cache-type-v TYPE` | KV cache data type for V<br/>allowed values: f32, f16, bf16, q8_0, q4_0, q4_1, iq4_nl, q5_0, q5_1<br/>(default: f16)<br/>(env: LLAMA_ARG_CACHE_TYPE_V) |
LLAMA_ARG_CACHE_TYPE_K=q8_0
LLAMA_ARG_CACHE_TYPE_V=q8_0

# | `-sm, --split-mode {none,layer,row}` | how to split the model across multiple GPUs, one of:<br/>- none: use one GPU only<br/>- layer (default): split layers and KV across GPUs<br/>- row: split rows across GPUs<br/>(env: LLAMA_ARG_SPLIT_MODE) |
#LLAMA_ARG_SPLIT_MODE=layer
#LLAMA_ARG_SPLIT_MODE=layer
#LLAMA_ARG_SPLIT_MODE=none

#EXPERIMENTAL
# Esto hace que llama.cpp solo vea tus dos GPUs AMD
#MESA_VK_DEVICE_SELECT=1002:7550,1002:150e ./llama-cli -m modelo.gguf -ngl 99
# FIN EXPERIMENTAL

# | `-ts, --tensor-split N0,N1,N2,...` | fraction of the model to offload to each GPU, comma-separated list of proportions, e.g. 3,1<br/>(env: LLAMA_ARG_TENSOR_SPLIT) |
#LLAMA_ARG_TENSOR_SPLIT="1,2"
#LLAMA_ARG_TENSOR_SPLIT=5,5

HSA_ENABLE_ASYNC_COPY=1
HSA_ENABLE_SDMA=1
##HSA_ENABLE_SDMA=1
#HSA_XNACK=1
#HSA_DISABLE_P2P=1
#HSA_ENABLE_SDMA=0
#HSA_XNACK=0
# Prueba
#ROC_MALLOC_MAX_MANAGED_SIZE=16304
ROC_MALLOC_MAX_MANAGED_SIZE=40304
#HIP_FORCE_P2P=0
# AMD_LOG_LEVEL: Set to 3 if you want to see detailed error logs if it crashes again.
#AMD_LOG_LEVEL=3
# MIOPEN_DEBUG: Helps optimize how the GPU calculates the math (GEMM) for the LLM.
MIOPEN_DEBUG_CONV_GEMM=1
#HIP_TRACE_API=0X2
#HCC_SERIALIZE_COPY=0x3
#HCC_SERIALIZE_KERNEL=0x3
#CUDA_VISIBLE_DEVICES=1
# Fin prueba

# | `-mg, --main-gpu INDEX` | the GPU to use for the model (with split-mode = none), or for intermediate results and KV (with split-mode = row) (default: 0)<br/>(env: LLAMA_ARG_MAIN_GPU) |
#LLAMA_ARG_MAIN_GPU=0

# | `-fit, --fit [on\|off]` | whether to adjust unset arguments to fit in device memory ('on' or 'off', default: 'on')<br/>(env: LLAMA_ARG_FIT) |
#LLAMA_ARG_FIT=on

# | `-fitc, --fit-ctx N` | minimum ctx size that can be set by --fit option, default: 4096<br/>(env: LLAMA_ARG_FIT_CTX) |
# LLAMA_ARG_FIT_CTX=


# --- Logging ---
###################################################################################################################################
# | `-lv, --verbosity, --log-verbosity N` | Set the verbosity threshold. Messages with a higher verbosity will be ignored. Values:<br/> - 0: generic output<br/> - 1: error<br/> - 2: warning<br/> - 3: info<br/> - 4: debug<br/>(default: 3)<br/><br/>(env: LLAMA_LOG_VERBOSITY) |
LLAMA_LOG_VERBOSITY=-1
# | `--log-file FNAME` | Log to file<br/>(env: LLAMA_LOG_FILE) |
LLAMA_LOG_FILE=/dev/null


# | `-np, --parallel N` | number of server slots (default: -1, -1 = auto)<br/>(env: LLAMA_ARG_N_PARALLEL) |
# LLAMA_ARG_N_PARALLEL=

# --- Arquitectura Mixture of Experts ---
###################################################################################################################################


# | `-cmoed, --cpu-moe-draft` | keep all Mixture of Experts (MoE) weights in the CPU for the draft model<br/>(env: LLAMA_ARG_CPU_MOE_DRAFT) |
#LLAMA_ARG_CPU_MOE_DRAFT

# | `-ncmoed, --n-cpu-moe-draft N` | keep the Mixture of Experts (MoE) weights of the first N layers in the CPU for the draft model<br/>(env: LLAMA_ARG_N_CPU_MOE_DRAFT) |
# LLAMA_ARG_N_CPU_MOE_DRAFT=


# --- Models ---
###################################################################################################################################


# | `-a, --alias STRING` | set model name aliases, comma-separated (to be used by API)<br/>(env: LLAMA_ARG_ALIAS) |
# LLAMA_ARG_ALIAS=


# | `--threads-http N` | number of threads used to process HTTP requests (default: -1)<br/>(env: LLAMA_ARG_THREADS_HTTP) |
# LLAMA_ARG_THREADS_HTTP=






# | `-n, --predict, --n-predict N` | number of tokens to predict (default: -1, -1 = infinity)<br/>(env: LLAMA_ARG_N_PREDICT) |
# | `-fa, --flash-attn [on\|off\|auto]` | set Flash Attention use ('on', 'off', or 'auto', default: 'auto')<br/>(env: LLAMA_ARG_FLASH_ATTN) |
# | `--mlock` | force system to keep model in RAM rather than swapping or compressing<br/>(env: LLAMA_ARG_MLOCK) |
# | `--mmap, --no-mmap` | whether to memory-map model. (if mmap disabled, slower load but may reduce pageouts if not using mlock) (default: enabled)<br/>(env: LLAMA_ARG_MMAP) |
# | `-dio, --direct-io, -ndio, --no-direct-io` | use DirectIO if available. (default: disabled)<br/>(env: LLAMA_ARG_DIO) |
# | `--numa TYPE` | attempt optimizations that help on some NUMA systems<br/>- distribute: spread execution evenly over all nodes<br/>- isolate: only spawn threads on CPUs on the node that execution started on<br/>- numactl: use the CPU map provided by numactl<br/>if run without this previously, it is recommended to drop the system page cache before using this<br/>see https://github.com/ggml-org/llama.cpp/issues/1437<br/>(env: LLAMA_ARG_NUMA) |
# | `-sm, --split-mode {none,layer,row}` | how to split the model across multiple GPUs, one of:<br/>- none: use one GPU only<br/>- layer (default): split layers and KV across GPUs<br/>- row: split rows across GPUs<br/>(env: LLAMA_ARG_SPLIT_MODE) |
# | `-mg, --main-gpu INDEX` | the GPU to use for the model (with split-mode = none), or for intermediate results and KV (with split-mode = row) (default: 0)<br/>(env: LLAMA_ARG_MAIN_GPU) |
# | `--log-disable` | Log disable |
