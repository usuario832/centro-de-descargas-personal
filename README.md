# Centro de descargas con qBittorent + Jackett + Portainer
Sistema automatizado de descargas de torrents con interfaz web, búsqueda integrada en múltiples sitios y organización automática de archivos.

## 👥 Grupo
- Fabrizio Rodriguez - 25200220@ue.edu.pe
- Leo Rimachi - 25200432@ue.edu.pe


## 🎯 Problema que Resuelve
Facilita la gestión de descargas de archivos grandes mediante torrents, con búsqueda centralizada y almacenamiento organizado, todo desde una interfaz web moderna.

## 💻 Requisitos Previos

### Software:

- Windows 10/11 con WSL2 
- Podman Desktop instalado
- Python 3 con pip (para instalar podman compose)
- podman-compose

### Hardware mínimo:

- RAM: 4 GB (recomendado: 8 GB)
- CPU: 2 núcleos (recomendado: 4 núcleos)
- Disco: 10 GB libres (50 GB+ si descargas mucho)
- Internet: Conexión activa

## 📥 Instrucciones de instalación

### Activar Contenedores

**PASO 1: Ingresa al archivo centro-de-descargas-personal**  
**PASO 2: En la ruta del archivo escribe Powershell (está en la parte superior)**  
**PASO 3 (OPCIONAL): Saltarse este paso si no deseas cambiar las credenciales**  

1. Copiar el contenido del archivo  `.env.example`
2. Crear un archivo  `.env`
3. Pegar el contenido en el archivo  `.env`
4. Modifica la contraseña o usuario
5. Guardar el archivo  `Ctlr + S`

**PASO 4: Ejecuta los comandos en el Powershell:**  

```powershell
podman machine start

.\scripts/start.ps1
```

**PASO 5: Copia las credenciales**

Por defecto es:
- Usuario: admin
- Contraseña: adminadmin

**PASO 6: Ingresa a la web y ve a qBittorrent -> http://localhost:8080**  
**PASO 7: Ingresa las credenciales**  

### Conectar Jackett con qBittorrent

**PASO 1: Ingresa a la web y ve a Jackett -> http://localhost:9117**  
**PASO 2: Busca la API Key (está en la esquina superior)**

1. Copia el codigó (Ejemplo: a1b2c3d4e5f6g7h8i9j0)

**PASO 3: Descargar Indexadores**

1. En Jackett, haz clic en **"Add indexer"**
2. Busca sitios publicos populares:

- **1337x**
- **The Pirate Bay**
- **RARBG**
- **YTS**

3. Haz clic en el **"+"** al lado de cada uno para añadirlos

**PASO 4: Descargar el plugin de búsqueda en qBittorrent**

1. Abre la web y ingresa a https://raw.githubusercontent.com/qbittorrent/search-plugins/master/nova3/engines/jackett.py
2. Guarda el archivo  `Ctrl + S`
- Nómbralo: `jackett.py `

**PASO 5: Copiar el plugin en la carpeta correcta**

1. Abre el explorador de archivos
2. Navega al proyecto
3. Entra a la carpeta engines   
-  **configs\qbittorrent\qBittorrent\nova3\engines**
4. Copia el archivo  `jackett.py`  en la carpeta engines
5. Crea un archivo llamado  `jackett.json` en la misma carpeta
6. Abre el archivo  `jackett.json`  con bloc de notas
7. Pega lo siguiente:

```json
{  
    "api_key": "PEGA_AQUI_TU_API_KEY",  
    "tracker_first": false,  
    "url": "http://jackett:9117"  
}
```

8. Reemplaza `PEGA_AQUI_TU_API_KEY` con la API Key que copiaste en el paso 2, ejemplo:

```json
{
    "api_key": "a1b2c3d4e5f6g7h8i9j0",
    "thread_count": 20,
    "tracker_first": false,
    "url": "http://jackett:9117"
}
```

9. Guarda el archivo  `Ctlr + S`  o ciérralo

**PASO 6: Abre el Powershell en la carpeta del proyecto**
1. Ejecuta:

```powershell
podman-compose restart centro-de-descargas
```

**PASO 7: Abre la web y ve a qBittorrent -> http://localhost:8080**

**¡Ya puedes comenzar a buscar y descargar!**

### Para detener los contendores

**PASO 1: Abre el Powershell en la carpeta del proyecto**

1. Ejecuta:

```powershell
.\scripts/stop.ps1
```

## 📖 Intrucciones de uso

**Buscar y descargar torrents**

1. Abre qBittorrent en http://localhost:8080
2. Ve a la pestaña "Search" (Búsqueda)
3. En el cuadro de búsqueda, escribe lo que deseas descargar
4. Selecciona "Jackett" como motor de búsqueda
5. Haz clic en "Search"
6. Revisa los resultados y haz doble clic en el que te interese

**Configurar límites de velocidad**

1. En qBittorrent, ve a Opciones (ícono de engranaje)
2. Ve a "Speed" (Velocidad)
3. Configura:

- Límite de subida (Upload)
- Límite de bajada (Download)

4. Aplica los cambios

**Organizar descargas por categorías**

1. En qBittorrent, haz clic derecho en cualquier torrent
2. Selecciona "Category" → "New category"
3. Crea categorías como: Películas, Series, Música, etc.
4. Asigna cada descarga a su categoría correspondiente

**Ver estadísticas de uso**

1. Abre Portainer en http://localhost:9000
2. Inicia sesión (primera vez: crear usuario administrador)
3. Ve a "Containers"
4. Revisa el uso de CPU, RAM y red de cada contenedor

**Comandos útiles**

```powershell

# Ver estado de los contenedores
podman ps

# Ver logs de qBittorrent
podman logs centro-de-descargas

# Ver logs de Jackett
podman logs buscador-centro-de-descargas

# Reiniciar un contenedor específico
podman restart centro-de-descargas

# Ver uso de recursos
podman stats
```

## 📸 Capturas de Pantalla

- qBittorrent - Interfaz principal

![qBittorrent Interface](demo/Captura de pantalla 2025-11-27 152917.png)

- Jackett - Panel de indexadores

![Jackett Dashboard](demo/Captura de pantalla 2025-11-27 160750.png)

## 🙏 Créditos y Recursos utilizados

**Imágenes de Docker**
Este proyecto utiliza las siguientes imágenes oficiales:

- linuxserver/qbittorrent - Cliente BitTorrent con interfaz web

    - Versión: latest
    - Mantenedor: LinuxServer.io

- linuxserver/jackett - Proxy para indexadores de torrents

    - Versión: latest
    - Mantenedor: LinuxServer.io

- portainer/portainer-ce - Gestión visual de contenedores

    - Versión: latest
    - Mantenedor: Portainer.io

**Tecnologías utilizadas**

- Podman - Motor de contenedores sin daemon
- Podman Compose - Orquestación de contenedores
- BitTorrent Protocol - Protocolo P2P para transferencia de archivos

**Plugins y extensiones**

- qBittorrent Search Plugins - Plugins oficiales de búsqueda para qBittorrent

    - Jackett Plugin: Integración con Jackett

**Documentación consultada**

- Documentación oficial de Podman
- LinuxServer.io Documentation
- qBittorrent Wiki
- Jackett Wiki
- Portainer Documentation

**Recursos de aprendizaje**

- Awesome Selfhosted - Lista curada de software auto-hospedable
- Docker Hub - Repositorio de imágenes de contenedores
- r/selfhosted - Comunidad de auto-hospedaje
