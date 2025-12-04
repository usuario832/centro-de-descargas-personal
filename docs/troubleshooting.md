# 🔧 Troubleshooting - Problemas y Soluciones
Este documento detalla los problemas encontrados durante el desarrollo del proyecto y cómo los resolvimos.

## ❌ Problema 1: Problemas con podman-compose

Tuve un problema donde  `podman-compose --version`  no funcionaba en PowerShell y es uno de los requisitos principales para levantar contenedores.

### **Aquí está la solución:**

**Instalar podman-compose**

```powershell
pip install podman-compose
```

**Agregar al PATH**

El problema es que el directorio Scripts de Python no está en el PATH. Encontré mi ruta ejecutando:

```powershell
powershellpython -m site --user-site
```

Luego cambié site-packages por Scripts en esa ruta. Por ejemplo:

Si sale: 

**C:\Users\TuUsuario\AppData\Roaming\Python\Python311\site-packages**

Usa: 

**C:\Users\TuUsuario\AppData\Roaming\Python\Python311\Scripts**


**Para agregarlo al PATH permanentemente:**

1. Busca "Variables de entorno" en Windows
2. Editar la variable Path del usuario
3. Agregar la ruta del directorio Scripts
4. Reiniciar PowerShell

O agregar temporalmente en la sesión actual:

```powershell
$env:Path += ";C:\Users\TuUsuario\AppData\Roaming\Python\Python311\Scripts"
```

Verificar

```powershell
powershellpodman-compose --version
```

Alternativa

También se puede ejecutar directamente con Python sin modificar el PATH:

```powershell
powershellpython -m podman_compose --version
```

## ❌ Problema 2: "Nombre de usuario o contraseña inválidos" en qBittorrent

Al intentar acceder a la interfaz web de qBittorrent en http://localhost:8080, aparecía:

```
Nombre de usuario o contraseña inválidos.
Respuesta del servidor: Fails.  
```

Causa:
No sabíamos cuáles eran las credenciales por defecto. La imagen de LinuxServer/qBittorrent permite configurar usuario y contraseña mediante variables de entorno, pero si no se configuran correctamente, usa valores internos que desconocíamos.

Intentos fallidos:

- Probamos: admin/admin
- Probamos: admin/adminadmin
- Probamos las credenciales del archivo .env pero no funcionaban

Solución:

Revisé los logs del contenedor para encontrar pistas:

```powershell
powershellpodman logs centro-de-descargas
```

Descubrí que las variables de entorno estaban mal configuradas en el podman-compose.yml. Tenía:
```yml
environment:
  - WEBUI_USERNAME=${QB_USER}
  - WEBUI_PASSWORD=${QB_PASS}
```

Investigué la documentación de la imagen y descubrí que las variables correctas son con el prefijo  `QBT_ `
**Corregí el podman-compose.yml:**

```yml
environment:
  - QBT_WEBUI_USERNAME=${QB_USER}
  - QBT_WEBUI_PASSWORD=${QB_PASS}
```

Me aseguré de que mi archivo .env tuviera los valores correctos:

```env
envPUID=1000
PGID=1000
TZ=America/Lima
QB_USER=admin
QB_PASS=tu_contraseña_segura
```

Recreé el contenedor para aplicar los cambios:

```powershell
powershellpodman-compose down
podman-compose up -d
```

Ahora pude acceder con las credenciales definidas en el .env:

Usuario: admin
Contraseña: adminadmin

Lección aprendida:
El prefijo correcto para las variables de entorno de qBittorrent en la imagen de LinuxServer es  `QBT_`, no solo  `WEBUI_`. Este tipo de detalles específicos de cada imagen se encuentran en su documentación oficial. Además, las variables de entorno deben estar definidas en el archivo  `.env`  para que podman-compose pueda leerlas correctamente.