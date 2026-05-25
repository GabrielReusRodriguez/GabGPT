
# Llamamos a llama.cpp-server. Las variables de entorno ya deberían estar colocadas 
# Aqui solo colovamos los flags que no tienen esas variables y serviran para TODOS los LLMs

echo "Arrancando servidor llama.cpp..."
exec /app/llama.cpp/build/bin/llama-server --log-disable
#exec /app/llama.cpp/build/bin/llama-server
