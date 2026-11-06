# Guía de configuración

Esta guía explica cómo están organizadas las configuraciones, qué cambia al
editarlas y qué partes dependen del sistema. Las cuatro herramientas funcionan de
manera independiente; puedes instalar solo la que quieras personalizar.

## Oh My Posh

**Archivo:** [`oh-my-posh/config.json`](../oh-my-posh/config.json)  
**Formato:** JSON estricto, sin comentarios.  
**Esquema:** [`oh-my-posh/config.schema.json`](../oh-my-posh/config.schema.json),
una copia local del esquema del repositorio oficial.

Oh My Posh dibuja el prompt al iniciar cada shell. Este tema organiza la salida en
tres bloques: contexto del proyecto a la izquierda, estado de la sesión a la
derecha y una línea final para escribir comandos.

### Colores y estructura

- `version` identifica el formato del tema y debe seguir el formato que acepta la
  versión instalada de Oh My Posh.
- `palette` concentra los colores reutilizados por los segmentos. Los valores como
  `p:mauve` o `p:surface` hacen referencia a esa paleta; cambiar un color allí
  actualiza todas sus apariciones.
- `blocks` define la posición y composición de cada línea. `alignment: left` y
  `alignment: right` controlan la alineación; `overflow: hide` oculta el bloque
  derecho si falta espacio en la terminal.
- `console_title_template` define el título de la ventana de terminal. El tema lo
  establece como `PowerShell`; cámbialo si utilizas otro shell y quieres que la
  barra de título lo refleje.
- `final_space` deja un espacio al final del prompt para separar el cursor del
  último segmento.

### Bloque izquierdo: contexto del proyecto

- Los segmentos `os` y `session` muestran el icono del sistema, el usuario y el
  nombre del equipo. El tema recorta el prefijo literal `DESKTOP-` del nombre del
  host; si ese prefijo no coincide con tu equipo, modifica la plantilla.
- Los segmentos `path` muestran primero un icono de carpeta y después una ruta
  abreviada. `max_depth` limita cuántos niveles del directorio aparecen.
- Dos segmentos `git` muestran el icono de estado y los detalles de la rama. La
  plantilla puede indicar cambios sin guardar, cambios preparados, commits por
  subir o bajar y stashes. Git debe estar disponible y el directorio actual debe
  pertenecer a un repositorio para mostrar esos datos.
- Los segmentos de Node.js, Python, Go, Rust, .NET, Java, PHP, Ruby, Lua, Kotlin,
  Swift, Dart, Zig y Julia muestran iconos o versiones cuando Oh My Posh detecta
  contexto relacionado. No es necesario que todos esos lenguajes estén instalados.

### Bloque derecho y línea de entrada

- El segmento de texto opcional de Hyprland/Niri solo muestra valores cuando el
  entorno define `HYPRNIRI_ICON`, `HYPRNIRI_NAME` o `HYPRNIRI_COLOR`.
- `executiontime` muestra cuánto tardó el último comando si superó el umbral de
  500 ms.
- `time` presenta la hora en formato de 12 horas (`03:04`). Cambia `time_format`
  si prefieres otro formato.
- `status` indica si el último comando terminó correctamente y muestra su código
  de salida. El segmento `shell` identifica el shell actual.
- El bloque final muestra un símbolo distinto para la sesión normal y para una
  sesión elevada. `transient_prompt` simplifica el prompt de comandos anteriores;
  `secondary_prompt` se usa al introducir una instrucción multilínea.

Los iconos se escriben como glifos Unicode de uso privado. Para que se vean como
están diseñados, instala una Nerd Font y selecciónala también en la configuración
de la terminal. Si un icono aparece como un cuadro, el problema suele ser la fuente
activa, no el JSON.

Para obtener sugerencias de propiedades, mantén `config.schema.json` junto a
`config.json`. La inicialización también permite comprobar que Oh My Posh puede leer
el tema:

```powershell
oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\config.json"
```

Sustituye `pwsh` por `bash`, `zsh` o `fish` al usar otro shell.

## Fastfetch

**Archivo:** [`fastfetch/config.jsonc`](../fastfetch/config.jsonc)  
**Formato:** JSONC, JSON con comentarios.  
**Esquema:** el `$schema` del archivo apunta al esquema publicado por Fastfetch en
su rama `dev`.

### Imagen y presentación

- `logo.type` está configurado como `sixel` y `logo.source` apunta a
  `~/.config/fastfetch/L2.png`. Las instrucciones de instalación copian allí la
  imagen `assets/L2.png`; para usar otra imagen, cambia `source`. El instalador
  acepta `XDG_CONFIG_HOME`, pero esta ruta de imagen sigue fija en `~/.config`;
  si usas otra carpeta XDG, actualiza `logo.source`.
- La captura `assets/Cyberpunk.png` ilustra la apariencia conjunta de las
  herramientas en uso; no se usa como logo de Fastfetch.
- En Windows, Fastfetch expande `~` en rutas a partir de la versión 2.41.0. Si
  configuras una ruta propia en una versión anterior, actualiza Fastfetch o usa
  `%USERPROFILE%/` en la ruta.
- `logo.width` limita el ancho y `logo.padding` separa la imagen de los módulos.
  Sixel debe estar disponible tanto en Fastfetch como en la terminal.
- `display.separator` define el espacio entre cada etiqueta y su valor.
- Cada `key` personaliza la etiqueta del módulo y cada `keyColor` aplica su color.
  Los iconos de las etiquetas también requieren una fuente que contenga esos
  glifos.

### Orden y grupos de módulos

La matriz `modules` determina qué información aparece y en qué orden. La cadena
`"break"` introduce una separación visual:

1. **Sistema y sesión:** sistema operativo, kernel, modelo del equipo, shell,
   terminal y cantidad de paquetes detectados.
2. **Entorno de escritorio:** gestor de ventanas, tema, iconos y fuente de la
   terminal. Algunos módulos solo muestran datos en los sistemas donde están
   disponibles.
3. **Hardware y pantalla:** procesador, GPU, memoria, discos y monitores. Los
   detalles de frecuencia, controlador, resolución o refresco dependen del equipo y
   de los permisos que tenga Fastfetch.
4. **Paleta:** dos módulos `custom` dibujan franjas con valores RGB para que los
   colores del tema queden visibles al final de la salida.

El módulo `title` muestra, en orden, el icono de monitor, el nombre del equipo y el
icono de usuario con el texto fijo `Zach`; no obtiene ese texto del usuario del
sistema ni añade la etiqueta `DESKTOP`. Fastfetch
obtiene el hostname al ejecutarse y el formato Lua quita `DESKTOP-` solo cuando
aparece al inicio, para evitar repetirlo. Este formato requiere Fastfetch 2.64 o posterior con soporte Lua;
compruébalo con `fastfetch --list-features`. Cambia `Zach` por el texto que quieras mostrar.
Consulta el esquema o la [guía oficial del módulo Title](https://github.com/fastfetch-cli/fastfetch/wiki/Modules-Title)
para ver formatos disponibles.

VS Code puede descargar el esquema remoto para completar y validar propiedades.
El archivo [`.vscode/settings.json`](../.vscode/settings.json) confía solo en la
URL exacta utilizada aquí; no añade confianza para todo el dominio de GitHub.

## Cava

**Archivo:** [`cava/config`](../cava/config)  
**Formato:** INI. Las líneas que empiezan con `;` están comentadas y no se aplican.

### `[general]` — ritmo y distribución

- `live-config = 1` hace que Cava vuelva a leer el archivo al guardarlo.
- `framerate` establece la frecuencia de actualización. Valores altos pueden
  consumir más recursos o revelar límites de la terminal.
- `autosens` ajusta automáticamente la respuesta de las barras. Mientras está
  activo, Cava no usa `sensitivity`; desactívalo si quieres fijar la sensibilidad
  manualmente con ese valor.
- `bars = 0` deja que Cava ajuste el número de barras al espacio disponible.
  `bar_width`, `bar_spacing` y `center_align` modifican su separación y posición.
- `max_height` limita la altura visual. `lower_cutoff_freq` y
  `higher_cutoff_freq` seleccionan el rango de frecuencias representado.
- `sleep_timer` suspende la visualización después del tiempo indicado sin señal;
  el valor `0` desactiva esa pausa.

### `[input]` — fuente de audio

La configuración deja que Cava elija la fuente automáticamente. En Linux, si no
recibe señal o captura el micrófono en vez de la salida, indica el backend que usa
tu sesión, por ejemplo `pipewire` o `pulse`, y ajusta `source` según el dispositivo.
Las líneas de ejemplo están comentadas. En Windows, Cava intenta capturar la salida
predeterminada sin configuración adicional; el proyecto permite cambiar `source`
si se requiere otro dispositivo.

### `[output]` — dibujo en la terminal

- `method = noncurses` selecciona el modo de salida configurado.
- `orientation = bottom` dibuja las barras desde la parte inferior.
- `channels = stereo` conserva los canales izquierdo y derecho.
- `reverse` invierte su orden; `show_idle_bar_heads` deja una referencia visual
  cuando el audio está en silencio.
- `xaxis = none` oculta etiquetas de frecuencia.
- `synchronized_sync` está comentado. Actívalo solo si la terminal admite esa
  secuencia de sincronización de pantalla.

### `[color]` — degradado

`gradient = 1` habilita la mezcla de los ocho colores definidos en
`gradient_color_1` a `gradient_color_8`. `background = default` y
`foreground = default` heredan los colores de la terminal. `horizontal_gradient`
permite cambiar la dirección del degradado cuando se habilita.

### `[smoothing]` y `[eq]` — respuesta

- `monstercat` y `waves` controlan métodos de suavizado. En esta configuración se
  activa `monstercat` y se deja `waves` apagado.
- `noise_reduction` reduce fluctuaciones rápidas. Un valor mayor genera barras más
  estables, pero puede hacer que reaccionen con más lentitud.
- Los índices de `[eq]` cambian la ganancia visual de distintas bandas. Auméntalos
  para destacar esas frecuencias y redúcelos para atenuarlas.

Si Cava no reacciona, consulta primero el método de entrada de audio disponible en
tu sistema y la [documentación oficial de captura y configuración](https://github.com/karlstav/cava#capturing-audio).

## Peaclock

Peaclock lee comandos desde un archivo de texto llamado `config`; cada línea
contiene un comando y las líneas que empiezan con `#` son comentarios. El proyecto
incluye [`peaclock/config`](../peaclock/config) como ejemplo opcional, pero
`scripts/install.sh` no lo copia. La ruta predeterminada es
`~/.peaclock/config`; también puedes indicar otra con `--config` o `--config-dir`.
Para instalar el ejemplo manualmente, copia el archivo a esa ruta. Haz una copia
de seguridad si ya tienes una configuración.

El ejemplo define `timer-exec` con `notify-send`, un comando habitual en Linux.
Reemplázalo o coméntalo si tu sistema no dispone de ese comando y quieres usar la
notificación al terminar un temporizador.

Por ejemplo, este archivo selecciona el reloj digital de 24 horas, muestra los
segundos y la fecha, y ajusta dos colores:

```text
mode clock
view digital
set hour-24 on
set seconds on
set date on
style background #1b1e24
style date #4feae7
```

Puedes crear o modificar el archivo con cualquier editor de texto. También puedes
cambiar opciones desde la interfaz de Peaclock y guardar el estado actual con
`mkconfig ~/.peaclock/config`; para sobrescribirlo en guardados posteriores, usa
`mkconfig! ~/.peaclock/config`. Los comandos `mode`, `view`, `set` y `style`
permiten elegir modo, presentación, opciones de visualización y colores. La
[sección de Peaclock del README](../README.md#peaclock) incluye pasos de creación
del archivo para Windows, Linux y macOS.

## Rutas habituales

| Herramienta | Windows | Linux | macOS |
| --- | --- | --- | --- |
| Oh My Posh | `%USERPROFILE%\.config\oh-my-posh\config.json` y `config.schema.json`; inicialización en `$PROFILE`. | `~/.config/oh-my-posh/config.json` y `config.schema.json`; inicialización en el archivo del shell. | `~/.config/oh-my-posh/config.json` y `config.schema.json`; inicialización en el archivo del shell. |
| Fastfetch | `~/.config/fastfetch/config.jsonc`. | `~/.config/fastfetch/config.jsonc`. | `~/.config/fastfetch/config.jsonc`. |
| Cava | `~/.config/cava/config`. | `$XDG_CONFIG_HOME/cava/config` o, si no está definida, `~/.config/cava/config`. | `$XDG_CONFIG_HOME/cava/config` o, si no está definida, `~/.config/cava/config`. |
| Peaclock | `%USERPROFILE%\.peaclock\config`. | `~/.peaclock/config`. | `~/.peaclock/config`. |

Los comandos del README copian las configuraciones versionadas de Oh My Posh,
Fastfetch y Cava a sus ubicaciones. Peaclock incluye un ejemplo en
`peaclock/config`, que se copia manualmente a `~/.peaclock/config`. Haz una copia
de seguridad antes de reemplazar configuraciones que ya hayas personalizado.
