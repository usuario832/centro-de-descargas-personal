# 🔧 Troubleshooting - Problemas y Soluciones
Este documento detalla los problemas encontrados durante el desarrollo del proyecto y cómo los resolvimos.

## ❌ Problema 1: "Nombre de usuario o contraseña inválidos" en qBittorrent
Síntoma:
Al intentar acceder a la interfaz web de qBittorrent en http://localhost:8080, aparecía:
Nombre de usuario o contraseña inválidos.
Respuesta del servidor: Fails.
Mostrar imagen
Causa:
No sabíamos cuáles eran las credenciales por defecto. La imagen de LinuxServer/qBittorrent permite configurar usuario y contraseña mediante variables de entorno, pero si no se configuran correctamente, usa valores internos que desconocíamos.
Intentos fallidos:

Probamos: admin/admin
Probamos: admin/adminadmin
Probamos: las credenciales del archivo .env pero no funcionaban

Solución:

Revisamos los logs del contenedor para encontrar pistas:

bashpodman logs centro-de-descargas

Descubrimos que las variables WEBUI_USER y WEBUI_PASS no estaban siendo leídas correctamente porque:

En el compose.yml usábamos ${QB_USER} y ${QB_PASS}
Pero en el .env las definimos como QB_USERNAME y QB_PASSWORD
¡No coincidían!


Corregimos el compose.yml para usar las variables correctas:

yamlenvironment:
  - WEBUI_USER=${QB_USERNAME:-admin}
  - WEBUI_PASS=${QB_PASSWORD:-adminadmin}

O alternativamente, actualizamos el .env para que coincidiera:

bashQB_USER=admin
QB_PASS=tu_contraseña_segura

Recreamos el contenedor para aplicar los cambios:

bashpodman-compose down
podman-compose up -d
Lección aprendida:
Las variables de entorno deben coincidir exactamente entre el archivo .env y el compose.yml. Los contenedores no pueden "adivinar" qué variables usar. Esto refuerza el concepto de que los procesos aislados en contenedores dependen completamente de la configuración explícita que se les proporciona.

## ❌ Problema 2: Error al ejecutar podman-compose (CalledProcessError)
Síntoma:
Al intentar ejecutar podman-compose up -d, aparecía un error largo en la terminal:
subprocess.CalledProcessError: Command 'podman ps --filter label=io.podman.compose.project=centro-de-descargas-personal...' 
returned non-zero exit status 125.
Mostrar imagen
Causa:
Este error suele ocurrir por una de estas razones:

Podman no está corriendo correctamente en Windows/WSL
Permisos insuficientes para acceder al socket de Podman
Versión incompatible de podman-compose con la versión de Podman instalada
Archivos de configuración corruptos en ~/.config/containers/

Solución:

Verificamos que Podman estaba funcionando:

bashpodman --version
podman ps  # Ver si el comando básico funciona

Reiniciamos el servicio de Podman (en WSL):

bashpodman machine stop
podman machine start

Verificamos la versión de podman-compose:

bashpodman-compose --version

Si el problema persistía, actualizamos podman-compose:

bashpip3 install --upgrade podman-compose

Como último recurso, probamos ejecutar con sudo (aunque no es recomendado en rootless):

bashsudo podman-compose up -d

Solución final que funcionó:

Eliminamos configuraciones antiguas que causaban conflictos
Usamos Podman Desktop para Windows en lugar de WSL puro
Ejecutamos directamente desde PowerShell



Lección aprendida:
La compatibilidad entre herramientas de contenedores y el sistema operativo host es crucial. Podman en Windows funciona a través de una máquina virtual (Podman Machine), y cualquier problema con esta VM puede causar errores en cascada. Esto nos enseñó sobre las abstracciones del sistema operativo y cómo diferentes capas de software deben comunicarse correctamente.