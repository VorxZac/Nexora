# Solución de problemas

Esta guía cubre los problemas más comunes al copiar y adaptar las configuraciones.
Comprueba primero que la herramienta esté instalada y que estés editando el archivo
de destino correcto.

## Oh My Posh

### Los iconos aparecen como cuadros o símbolos incorrectos

Instala una Nerd Font y selecciónala en el perfil de la terminal. Cambiar la fuente
del editor no cambia la fuente de la terminal donde corre el shell.

### No aparecen la rama o el estado de Git

Comprueba que Git esté instalado y que la carpeta actual pertenezca a un repositorio.
Los segmentos de estado no tienen información que mostrar fuera de un repositorio.

### No aparece el indicador de Hyprland/Niri

El bloque depende de las variables `HYPRNIRI_ICON`, `HYPRNIRI_NAME` y
`HYPRNIRI_COLOR`. Define las variables que quieras usar en el entorno del shell. Si
ninguna tiene valor, los segmentos opcionales no dibujan contenido.

### Oh My Posh no carga la configuración

Confirma que el archivo se llame `config.json` y que su sintaxis sea JSON válido;
los temas de Oh My Posh no admiten comentarios `//`. Ejecuta:

```powershell
oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\config.json"
```

En Linux, reemplaza `pwsh` por el shell correspondiente y usa la ruta de `~/.config`.
Mantén `config.schema.json` junto a `config.json` para recibir validación del editor.

## Fastfetch

### VS Code indica que el esquema remoto no es de confianza

El esquema se descarga desde `raw.githubusercontent.com`. Este repositorio incluye
una excepción limitada a esa URL en [`.vscode/settings.json`](../.vscode/settings.json).
Abre la carpeta del repositorio como espacio de trabajo en VS Code; si el aviso ya
estaba abierto, recarga la ventana para que tome la configuración nueva. No hace
falta permitir todo el dominio.

### No aparece la imagen personalizada

Comprueba que `~/.config/fastfetch/L2.png` exista y que la terminal admita Sixel.
El instalador copia la imagen desde `assets/L2.png`. Si usas otra ubicación,
actualiza `logo.source` y consulta las
[opciones oficiales de Fastfetch](https://github.com/fastfetch-cli/fastfetch/wiki/Logo-options).
Si definiste `XDG_CONFIG_HOME` en una carpeta distinta de `~/.config`, también
actualiza la ruta de la imagen en `logo.source`.

### Los iconos de los módulos no se ven

Selecciona una Nerd Font en la terminal. Como alternativa, reemplaza los glifos de
`key` por etiquetas de texto en `config.jsonc`.

### Fastfetch no encuentra la configuración

Comprueba que el archivo se llame exactamente `config.jsonc` y esté en
`~/.config/fastfetch/`. Para probar una ubicación explícita:

```powershell
fastfetch --config "$HOME\.config\fastfetch\config.jsonc"
```

En Linux:

```bash
fastfetch --config "$HOME/.config/fastfetch/config.jsonc"
```

### La salida muestra campos vacíos o información distinta

Algunos valores dependen del hardware, los controladores, el escritorio y los
permisos disponibles. Fastfetch no puede mostrar datos que el sistema no expone.
Para personalizar la salida, edita la lista `modules` y el `format` de cada módulo.

## Cava

### No hay barras o no reaccionan al audio

En Windows, Cava usa por defecto el dispositivo de salida de audio del sistema.
Confirma que haya audio reproduciéndose y que el dispositivo predeterminado sea el
correcto.

En Linux, revisa el backend de audio activo. Si la selección automática falla,
descomenta `method` en `[input]` y elige el backend apropiado, por ejemplo `pipewire`
o `pulse`. Ajusta `source` solo cuando necesites seleccionar un dispositivo
específico. Los nombres disponibles dependen del sistema.

### La terminal muestra caracteres extraños o líneas incompletas

Prueba otra fuente de terminal o desactiva el interlineado adicional. Cava dibuja
las barras usando caracteres de terminal y su aspecto varía con la fuente y el
emulador.

### Cava no encuentra `config`

Coloca el archivo en `$XDG_CONFIG_HOME/cava/config` o, si esa variable no está
definida, en `~/.config/cava/config`. Para probar una ruta concreta:

```text
cava -p ~/.config/cava/config
```

### Los cambios no se reflejan

El archivo del repositorio tiene `live-config = 1`. Guarda los cambios y espera la
recarga; también puedes presionar `r` dentro de Cava. Presiona `q` o `Ctrl+C` para
salir.

## Peaclock

### No carga las opciones guardadas

Comprueba que el archivo se llame `config` y esté en `~/.peaclock/config`
(Windows: `%USERPROFILE%\.peaclock\config`). Para probar una ubicación distinta,
indícala al iniciar el programa:

```text
peaclock --config /ruta/a/config
```

En Windows, usa la ruta correspondiente al archivo, por ejemplo:

```powershell
peaclock --config "$HOME\.peaclock\config"
```

Cada línea del archivo debe ser un comando de Peaclock. Consulta el [README](../README.md#peaclock)
para ver un ejemplo de configuración y cómo guardar opciones desde la interfaz.

## Instalación y rutas

Si los ejemplos no coinciden con tu sistema, confirma la ruta que usa la versión
instalada y revisa la documentación de instalación en los [repositorios oficiales](../README.md#recursos-oficiales).
No cambies rutas de sistema ni permisos para resolver un problema de búsqueda de
configuración sin comprobar antes el directorio que la herramienta utiliza.
