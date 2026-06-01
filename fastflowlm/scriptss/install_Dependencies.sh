#!/bin/env bash


#https://lemonade-server.ai/flm_npu_linux.html
#
# Instalamos el repositorio lemonae que tiene los debs con soporte para AMD XRT stack
sudo add-apt-repository ppa:lemonade-team/stable
sudo apt update

sudo apt install lemonade-server
