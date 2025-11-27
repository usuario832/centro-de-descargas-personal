#!/bin/bash

echo "Asegurando permisos en volúmenes persistentes..."

find ./configs -type d -exec podman unshare chown $(id -u):$(id -g) {} \;
find ./downloads -type d -exec podman unshare chown $(id -u):$(id -g) {} \;

echo "Iniciando contenedores..."

podman-compose up -d

if [ $? -eq 0 ]; then
    echo "Todos los servicios han sido iniciados correctamente."
    echo "Puedes acceder a los servicios:"
    echo " - Portainer: http://localhost:9000"
    echo " - qBittorent: http://localhost:8080"
    echo " - Jackett: http://localhost:9117"
    echo "======================================="
    echo "Registro en qBittorrent"
    echo "Usuario por defecto: admin"
    echo "Contraseña por defecto: adminadmin"
else
    echo "Error: Fallo al iniciar los servicios."
fi