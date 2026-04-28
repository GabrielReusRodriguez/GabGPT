#!/bin/env bash



# Script para instalar ROCm en un pc con gpu AMD.
# Escrito para un ubuntu en KDE 24.0

# Documentación oficial https://rocm.docs.amd.com/projects/install-on-linux/en/latest/


# Paso 1. Actualizar el kernel
# 1.1 Para ello, actualizo los repos de ubuntu

#https://repo.radeon.com/amdgpu-install/25.35.1/ubuntu/noble/amdgpu-install_7.2.1.70201-1_all.deb
wget https://repo.radeon.com/amdgpu-install/7.2.2/ubuntu/noble/amdgpu-install_7.2.2.70202-1_all.deb
sudo apt install ./amdgpu-install_7.2.2.70202-1_all.deb
sudo sed -i "s|graphics/7.2.2|graphics/7.2.1|" /etc/apt/sources.list.d/rocm.list
sudo apt update

# 1.2 Instalo el modeulo del  kernel
# 1.2.1 Para eso, antes elimino cualquier driver AMD GPU anterior del kernel.
sudo apt autoremove amdgpu-dkms

# 1.2.2 Instalo el modulo driver AMD para el kernel.
sudo apt install "linux-headers-$(uname -r)" "linux-modules-extra-$(uname -r)"
sudo apt install amdgpu-dkms

# Reboot para aplicar los cambios
echo 'Ahora puedes  hacer reboot si todo ha ido bien'
