# INSTALACIÓN DEL CENTRO DE DESCARGAS

## Crear la carpeta .env (IMPORTANTE)

1. Abra el archivo .env.example

2. Copie los datos

3. Crea un archivo llamado .env

4. Pegue los datos

## Lanzar el contener

1. Abrir la terminal en la carpeta de centro-de-descargas-personal

2. En la terminal:

podman machine start

podman-compose up -d

## Datos del Usuario

- Por defecto

Usuario: admin

Contraseña: adminadmin

- Si desea realizar cambios

En el archivo .env modifique los siguientes datos

QB_USER=<usuario>

QB_PASS=<contraseña>
    
