#!/bin/env bash

# Script para instalar ROCm en un pc con gpu AMD.
# Escrito para un ubuntu en KDE 24.0

# Documentación oficial https://rocm.docs.amd.com/projects/install-on-linux/en/latest/


# Paso 1. Instalar rocm tras tener el driver AMD actualizado y los repos de AMD instalados.
# 1.1 Instalo las dependencias 
sudo apt update
sudo apt install python3-setuptools python3-wheel
# Agregamos al usuario actual al grupo video y renbder pero si quisieramos agregar
# 	Mas usuarios podemos usar la guia 
# 	https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/prerequisites.html#group-permissions
sudo usermod -a -G render,video $LOGNAME # Add the current user to the render and video groups

# 1.2 Instalo ROCm
sudo apt install rocm

# Reboot para aplicar los cambios
echo -e "Si ha ido todo bien , debes hacer reboot"
