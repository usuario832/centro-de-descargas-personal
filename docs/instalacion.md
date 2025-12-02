# INSTALACIÓN DEL CENTRO DE DESCARGAS

1. Abrir Powershell o WSL
2. Ubicarse en la carpeta centro de descargas personal
3. Si no quiere cambiar las credenciales por defecto saltarse este paso

Copiar el contenido del archivo .env.example

Crear un archivo `.env`

Pegar el contenido en el archivo nuevo archivo

Modificar:

QB_USER=<usuario>
QB_PASS=<contraseña>

Por ultimo guardar el archivo

4. Ejecutar los siguiente comandos:

podman machine start

.\scripts/start.ps1

5. Copiar las credenciales

Por defecto es:
- Usuario: admin
- Contraseña: adminadmin

6. Ingresar a la web
7. En la busqueda ingresar "localhost:8080" (sin las comillas)
8. Ingresar las credenciales (copiadas en el paso 5)
    
