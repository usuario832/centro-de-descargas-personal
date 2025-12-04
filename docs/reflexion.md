# 🤔 Reflexión sobre Sistemas Operativos

## ¿Cómo se relaciona tu proyecto con conceptos de procesos?

Básicamente cada contenedor es un proceso aislado. Al principio no lo entendía bien, pero después de usar  `podman stats`  vi que cada servicio (qBittorrent, Jackett, Portainer) tiene su propio PID y funciona independiente. Lo bueno es que todos comparten el mismo kernel pero están separados.
Cuando apagaba un contenedor, todos sus procesos internos se cerraban limpios. También vi cómo se comunican entre ellos a través de la red virtual.

## ¿Qué recursos del sistema usa más?

qBittorrent usa más que todos. Llegó a usar 2 núcleos de CPU cuando descargaba varios torrents y entre 512MB hasta 2GB de RAM según cuántos torrents tenía activos. El disco también sufría bastante escribiendo archivos grandes.

Jackett es súper ligero, menos de 512MB de RAM y casi no usa CPU porque solo trabaja cuando busco algo. Portainer ni se siente.

Tuve que poner límites en el compose para que qBittorrent no mate mi PC. Ahí aprendí de los cgroups que controlan cuántos recursos puede usar cada contenedor.

## ¿Qué aprendiste sobre aislamiento y namespaces?

Esto me costó entenderlo. Pensaba que los contenedores eran como mini PCs virtuales, pero no - son procesos con su propia "vista" del sistema:  

**PID namespace**: Cada contenedor ve sus propios procesos. El proceso principal piensa que es el PID 1, aunque en mi Windows tiene otro número.  

**Network namespace**: Por eso pude usar http://jackett:9117 en vez de buscar la IP. Cada contenedor tiene su propia red virtual.  

**Mount namespace**: Cuando mapeo carpetas tipo ./configs:/config, el contenedor cree que /config es su directorio, pero realmente está en mi carpeta del proyecto.  

**User namespace**: Las variables PUID y PGID arreglaron los problemas de permisos. Sin esto, los archivos que creaba el contenedor tenían permisos raros.

Lo más útil fue cuando Jackett no se conectaba con qBittorrent. Me obligó a entender que aunque están separados, se hablan por la red bridge. También cuando un contenedor se cayó, los otros siguieron jalando normal - eso demuestra el aislamiento real.