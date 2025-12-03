# Centro de descargas con Qbittorent + Jackett + Portainer
Sistema automatizado de descargas de torrents con interfaz web, búsqueda integrada en múltiples sitios y organización automática de archivos.

## Grupo
- Fabrizio Rodriguez - 25200220@ue.edu.pe
- Leo Rimachi - 25200432@ue.edu.pe


## Problema que Resuelve
Facilita la gestión de descargas de archivos grandes mediante torrents, con búsqueda centralizada y almacenamiento organizado, todo desde una interfaz web moderna.

## Requisitos Previos 💻

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

## Instrucciones de instalación

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
- Nómbralo: jackett.py 

**PASO 5: Copiar el plugin en la carpeta correcta**

1. Abre el explorador de archivos
2. Navega al proyecto
3. Entra a la carpeta engines
-  **configs\qbittorrent\qBittorrent\nova3\engines**
4. Copia el archivo  `jackett.py`  en la carpeta engines
5. Crea un archivo llamado  `jackett.json`
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

9. Guarda el archivo  `Ctlr + S`  o cierralo

**PASO 6: Abre el Powershell en la carpeta del proyecto**
1. Ejecuta:

```powershell
podman-compose restart qbittorrent
```

**PASO 7: Abre la web y ve a qBittorrent -> http://localhost:8080**

**Ya puedes comenzar a buscar y descargar**

### Para detener los contendores

**PASO 1: Abre el Powershell en la carpeta del proyecto**

1. Ejecuta:

```powershell
.\scripts/stop.ps1
```

## Intrucciones de uso

## Capturas de Pantalla

- qBittorrent

![alt text](<Captura de pantalla 2025-11-27 152917.png>)

- Jackett

![alt text](<Captura de pantalla 2025-11-27 160750.png>)

## Créditos y Recursos utilizados
