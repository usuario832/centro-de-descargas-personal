# INSTALACIÓN DEL CENTRO DE DESCARGAS

## Pasos

1. Abrir la terminal en la carpeta de centro-de-descargas-personal

2. En la terminal:
- podman machine start
- podman-compose up -d

## Obtener el usuario y contraseña
1. En la terminal:
- podman logs centro-de-descargas

2. Al terminar de imprimir los resultados del código, observará una seccion como el siguiente ejemplo:

******** Information ********
To control qBittorrent, access the WebUI at: http://localhost:8080
The WebUI administrator username is: admin
The WebUI administrator password was not set. A temporary password is provided for this session: RuMQryCxM

- Usuario -> admin (El usuario por defecto es admin)
- Contraseña -> RuMQryCxM (Solo es un ejemplo)
    
