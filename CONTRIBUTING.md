# Contribuir

Las correcciones y mejoras son bienvenidas. Mantén cada cambio enfocado en las
configuraciones de terminal y su documentación.

## Antes de proponer cambios

- Indica qué herramienta, shell y sistema operativo afecta el cambio.
- Conserva rutas portables. No incluyas nombres de usuario o equipo, direcciones
  de red, credenciales, claves, tokens ni otras rutas personales.
- Comprueba que tienes permiso para redistribuir cualquier imagen o recurso que
  añadas a `assets/`.
- No incorpores binarios, fuentes ni logotipos de terceros sin revisar su licencia
  y atribución requerida. Los enlaces a los repositorios oficiales están en el
  [README](README.md#recursos-oficiales).
- Describe los requisitos y las diferencias de comportamiento entre plataformas.

## Formato y documentación

- Mantén el tema de Oh My Posh en JSON válido, sin comentarios.
- Fastfetch usa JSONC; conserva el formato y la URL del esquema del archivo.
- Cava usa INI; documenta cualquier método de entrada que dejes activo y para qué
  sistema o servicio de audio aplica.
- Peaclock usa comandos en texto plano; documenta cualquier comando nuevo y la
  ubicación de configuración que corresponda.
- Actualiza la [guía de configuración](docs/configuration-guide.md) si cambias el
  propósito o el comportamiento de una opción.
- Actualiza la [solución de problemas](docs/troubleshooting.md) si añades una
  dependencia, una ruta o un requisito nuevo.
- Mantén los ejemplos de instalación claros sobre qué archivos reemplazan y qué
  ajustes son opcionales.

## Revisión antes de enviar

- Revisa manualmente la sintaxis de los archivos modificados con la herramienta
  correspondiente.
- Comprueba que las rutas, los nombres de archivo, los enlaces y los comandos
  coincidan con el contenido del repositorio.
- Verifica que las capturas o recursos de ejemplo no revelen datos del equipo.
- Conserva `.vscode/settings.json` acotado a las URL de esquemas que realmente
  utilice el repositorio; no agregues confianza comodín para dominios externos.

## Licencia y atribución

El contenido original está bajo [The Unlicense](LICENSE). El esquema local de Oh
My Posh está bajo MIT; sus avisos se conservan en
[`THIRD-PARTY-NOTICES.md`](THIRD-PARTY-NOTICES.md). Cualquier otro recurso de
terceros conserva su licencia original. Incluye procedencia y atribución cuando
las condiciones de redistribución lo requieran.
