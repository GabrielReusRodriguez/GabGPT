#!/bin/env bash

# Script para instalar ROCm en un pc con gpu AMD.
# Escrito para un ubuntu en KDE 24.0

# Documentación oficial https://rocm.docs.amd.com/projects/install-on-linux/en/latest/

# Documentación de los paso post - instalacion
# 	https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/post-install.html

# 1. Configure ROCm shared objects
# 	Configuramos el linker del sustena para indicarle DONDE encontrar las librerias so para las aplicacions ROCm

sudo tee --append /etc/ld.so.conf.d/rocm.conf <<EOF
/opt/rocm/lib
/opt/rocm/lib64
EOF
sudo ldconfig

# 2. Configurao el PATH 
#	Usaré el update-alternatives

sudo update-alternatives --config rocm

# 3. Configuro el LD_LIBRARY_PATH
# 	SOLO es necesario para instalaciones multi version o para una version espeficia. 
# 	De momento lo saltamos
# export LD_LIBRARY_PATH=/opt/rocm-7.2.2/lib


