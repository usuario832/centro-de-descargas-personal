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

1. Abrir la terminal en la carpeta donde se encuentra el archivo `.yml`

Variables requeridas en .env

QB_USERNAME=
QB_PASSWORD=
QB_PORT=

Cree un archivo `.env` en la raíz del proyecto y defina estas variables.

## Intrucciones de uso
Iniciar el Sistema

Navegar a la carpeta del proyecto

cd C:\Users\TuUsuario\Documents\centro-descargas

Iniciar servicios:

  podman-compose up -d

Verificar estado:

  podman ps
  
Configuración Inicial de qBittorrent

Abre: http://localhost:8080

Credenciales por defecto:

Usuario: admin

Contraseña: Ver en logs

powershell  

  podman logs centro-de-descargas | Select-String "password"
  
Configuración Inicial de Jackett

Abre: http://localhost:9117

# Agregar Indexers:
Haz clic en + Add indexer
Busca y agrega:

°1337x

°The Pirate Bay

°EZTV

°YTS

°RARBG

Copiar API Key:

Arriba a la derecha verás: API Key: [cadena larga]
copiar
Guardar (se usara mas adelante para conectar con el qbittorrent

# Probar indexers:

Haz clic en Test All

Verifica que aparezcan ✅ verdes

Buscar y Descargar Torrents

Opción 1: Desde Jackett

En Jackett, escribe en el buscador

Haz clic en Buscar

Haz clic en el enlace magnet  del resultado

Cópialo

Opción 2: Agregar Torrent en qBittorrent

En qBittorrent: File → Add Torrent Link

Pega el enlace magnet

Selecciona carpeta destino:

Películas → downloads/movies/

Series → downloads/series/

Música → downloads/music/

Haz clic en OK

Encontrar Archivos Descargados

Ubicación en tu PC:
C:\Users\TuUsuario\Documents\centro-descargas\downloads\

Desde qBittorrent:

Clic derecho en torrent → Open Destination Folder

Ver Logs

podman logs centro-de-descargas

Logs en tiempo real

podman logs -f centro-de-descargas

Logs de Jackett

podman logs buscador-centro-de-descargas
  
## Capturas de Pantalla

- qBittorrent

![alt text](<Captura de pantalla 2025-11-27 152917.png>)

- Jackett

![alt text](<Captura de pantalla 2025-11-27 160750.png>)

## Créditos y Recursos utilizados
