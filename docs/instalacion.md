# INSTALACIÓN DEL CENTRO DE DESCARGAS

1. Abrir la terminal en la carpeta de centro-de-descargas-personal


2. En la terminal ingresar los siguiente códigos:
    - podman machine start
    - podman-compose up -d

3. Para obtener la contraseña temporal ingresar en la terminal:
    - podman logs centro-de-descargas

    - Cuando termine de imprimir los resultados del código, observará una seccion como el siguiente ejemplo:

    ******** Information ********
    To control qBittorrent, access the WebUI at: http://localhost:8080
    The WebUI administrator username is: admin
    The WebUI administrator password was not set. A temporary password is provided for this session: RuMQryCxM

    - Usuario -> admin
    - Contraseña -> RuMQryCxM
    
