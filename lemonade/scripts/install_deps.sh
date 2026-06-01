#!/bin/bash


# 1. Actualiza primero tu lista de paquetes actuales
sudo apt update

# 2. Instala la herramienta que te falta
sudo apt install software-properties-common

# 3. Añado el repositorio de AMD lemonade
sudo add-apt-repository ppa:lemonade-team/stable
sudo apt update

# 4. Instalo las librerias
sudo apt install libxrt-npu2 amdxdna-dkms

# 5. Se debe hacer reboot
#sudo reboot
