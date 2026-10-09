# 📝 Ejercicio: Generador de informes HTML

**Nivel:** 🔴 Reto final
**Solución:** [`informe-html.sh`](informe-html.sh)

---

## Enunciado

Crea un script llamado `informe-html.sh` que haga lo siguiente:

1. Genere un archivo `informe.html` con el **estado del sistema**: título, **fecha y hora**, **nombre del equipo**, **sistema operativo**, **tiempo encendido** (*uptime*), **uso del disco**, **uso de la memoria** y los **5 procesos que más memoria consumen**.
2. El archivo debe ser una página **HTML válida** (con `<!DOCTYPE html>`, `<head>` y `<body>`), con un **estilo sencillo** definido en el propio archivo.
3. El texto que proviene de comandos debe **escaparse** para que los símbolos `<`, `>` y `&` no rompan la página.
4. Al terminar, el script debe mostrar la **ruta del archivo** generado.
5. Si el archivo `informe.html` ya existe, debe **sobrescribirlo** con los datos actuales.

## Ejemplos de salida esperada

```text
$ ./informe-html.sh
Informe generado: /home/david/informe.html
```

Aspecto orientativo de la página:

```text
Informe del sistema
-------------------
Generado el: 2026-10-08 11:30:05
Equipo:      Dabid
Sistema:     Ubuntu 24.04 LTS
Encendido:   up 2 hours, 14 minutes

Disco
  (salida de df -h)

Memoria
  (salida de free -h)

Los 5 procesos que más memoria usan
  (salida de ps)
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Crear un archivo de varias líneas: *heredoc*

Un **heredoc** permite escribir un bloque de texto en un archivo. Si se escribe con `<<EOF` las variables y los comandos entre `$( ... )` **se sustituyen**:

```bash
nombre="David"
cat > saludo.html <<EOF
<h1>Hola, $nombre</h1>
<p>Año: $(date +%Y)</p>
EOF
```

| Parte | Qué significa |
|---|---|
| `cat > saludo.html` | Escribe en el archivo (lo crea o lo sobrescribe). |
| `<<EOF ... EOF` | El texto de en medio es el contenido. La línea de cierre debe ir **sola y sin espacios**. |
| `$nombre`, `$( ... )` | Se sustituyen por su valor. |

Con `<<'EOF'` (con comillas) **no** se sustituye nada: sirve para escribir texto con `$` literales, como el código CSS o JavaScript.

### 2. Datos del sistema

| Dato | Cómo obtenerlo |
|---|---|
| Nombre del equipo | `hostname` |
| Tiempo encendido | `uptime -p` |
| Disco | `df -h` |
| Memoria | `free -h` |
| Procesos que más memoria usan | `ps aux --sort=-%mem \| head -6` (la primera línea es la cabecera) |
| Sistema operativo | El archivo `/etc/os-release` |

Para leer el sistema operativo, ese archivo está escrito de forma que Bash lo puede **cargar** con `source` (o con un punto) y crea variables como `PRETTY_NAME`:

```bash
( . /etc/os-release; echo "$PRETTY_NAME" )
```

Los paréntesis ejecutan eso en un subproceso, para no llenar tu script de variables que no necesitas.

### 3. Mostrar texto "tal cual" en HTML: `<pre>`

El HTML junta los espacios y los saltos de línea. Para mantener el formato de la salida de un comando (columnas alineadas) se pone dentro de una etiqueta `<pre>`:

```html
<pre>
salida del comando
con varias líneas
</pre>
```

### 4. Escapar los caracteres especiales

En HTML, `<`, `>` y `&` tienen significado propio. Si la salida de un comando contiene alguno, puede **romper la página**. Se sustituyen por sus versiones seguras:

| Carácter | Se escribe como |
|---|---|
| `&` | `&amp;` |
| `<` | `&lt;` |
| `>` | `&gt;` |

Se puede hacer con `sed`:

```bash
echo 'a < b & c > d' | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g'
```

Resultado: `a &lt; b &amp; c &gt; d`. Fíjate en que el `&` se cambia **primero**: si no, se estropearían los `&` de las otras sustituciones. (La barra invertida en `\&` es necesaria porque, en `sed`, un `&` suelto significa "el texto que ha coincidido".)

### 5. Un estilo mínimo

Dentro del `<head>` se puede poner una etiqueta `<style>` con reglas CSS (colores, fuente, márgenes). Es un buen momento para usar `<<'EOF'` en esa parte, para que los símbolos del CSS no se confundan con variables.

### 6. Abrir el resultado

- En **Linux de escritorio**: `xdg-open informe.html`.
- En **WSL**: `explorer.exe informe.html` abre el archivo en el navegador de Windows.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| Heredoc (`<<EOF`, `<<'EOF'`) | Generar un archivo largo con datos del sistema. |
| `$( ... )` | Insertar la salida de comandos en el texto. |
| `uptime`, `df`, `free`, `ps`, `hostname` | Obtener la información del sistema. |
| `/etc/os-release` | Averiguar el sistema operativo. |
| `sed` para escapar | Evitar que la salida rompa el HTML. |
| HTML y CSS básicos (`<pre>`, `<style>`) | Dar formato a la página. |
| `date` | Indicar cuándo se generó el informe. |

## Cómo ejecutarlo

```bash
chmod +x informe-html.sh
./informe-html.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| Abrir `informe.html` en el navegador | Se ve una página ordenada con todos los apartados |
| Buscar `$(` o `$` sin sustituir (`grep -c '\$(' informe.html`) | Ninguna coincidencia: todo se ha sustituido |
| Ejecutarlo dos veces | El archivo se sobrescribe con los datos nuevos |
| Procesos con `<`, `>` o `&` en su línea de comandos | La página no se rompe |
| Comprobar los datos con `df -h` y `free -h` | Coinciden con los del informe |
| Estructura de la página | Tiene `<!DOCTYPE html>`, `<head>` y `<body>` |

## 🎯 Retos extra

- [ ] Mejorar el **diseño** con CSS (colores, bordes, tipografía).
- [ ] Mostrar el uso del disco y de la memoria con **colores de semáforo** (verde, naranja, rojo) según el porcentaje.
- [ ] Generar el disco como una **tabla HTML real** (pista: `awk` puede escribir etiquetas `<tr>` y `<td>`).
- [ ] Incluir la **fecha en el nombre** del archivo (`informe_2026-10-08.html`).
- [ ] Aceptar el **nombre del archivo de salida** como argumento.
- [ ] Programar la generación **cada hora** con `cron` (ver el ejercicio 24).

## ✅ Solución

El código resuelto, con comentarios, está en [`informe-html.sh`](informe-html.sh).
