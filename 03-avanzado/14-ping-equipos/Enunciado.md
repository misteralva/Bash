# 📝 Ejercicio: Ping a una lista de equipos

**Nivel:** 🟠 Avanzado
**Solución:** [`ping-equipos.sh`](ping-equipos.sh)

---

## Enunciado

Crea un script llamado `ping-equipos.sh` que haga lo siguiente:

1. Reciba como **argumento** el nombre de un archivo con una lista de equipos (`./ping-equipos.sh equipos.txt`). Si no se indica, o el archivo no existe, muestre un mensaje de uso y termine con código de salida `1`.
2. Lea el archivo **línea a línea**. Cada línea contiene una IP o un nombre de equipo. Las **líneas vacías** y las que empiezan por `#` (comentarios) deben ignorarse.
3. Para cada equipo, envíe **un solo ping** con un tiempo máximo de espera de **2 segundos** y muestre `[OK]` si responde o `[FALLO]` si no.
4. Al terminar, muestre un **resumen**: cuántos equipos se han comprobado, cuántos responden y cuántos no.

## ⚠️ Antes de empezar

Para practicar, crea un archivo `equipos.txt` con este contenido (también lo tienes en la carpeta del ejercicio):

```text
# Equipos a comprobar
127.0.0.1
localhost
8.8.8.8

192.0.2.1
equipo-que-no-existe
```

- `127.0.0.1` y `localhost` son tu propio equipo: siempre responden.
- `8.8.8.8` es un servidor DNS público: solo responde si tienes conexión a Internet.
- `192.0.2.1` pertenece a un rango reservado para documentación: no responde nunca.
- `equipo-que-no-existe` no se puede resolver: no responde.

Hay redes que **bloquean el ping** (el protocolo ICMP). Si un equipo que sabes que funciona aparece como `[FALLO]`, puede ser por eso.

## Ejemplos de salida esperada

```text
$ ./ping-equipos.sh equipos.txt
Comprobando equipos de equipos.txt...
[OK]    127.0.0.1
[OK]    localhost
[OK]    8.8.8.8
[FALLO] 192.0.2.1
[FALLO] equipo-que-no-existe
Resumen: 5 equipos comprobados, 3 responden, 2 no responden.
```

```text
$ ./ping-equipos.sh
Uso: ./ping-equipos.sh ARCHIVO_DE_EQUIPOS
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Enviar un ping desde un script

```bash
ping -c 1 -W 2 127.0.0.1
```

| Parte | Qué significa |
|---|---|
| `ping` | Envía un paquete a un equipo y espera su respuesta. |
| `-c 1` | *count*: envía **solo 1** paquete (sin esta opción, `ping` no termina nunca en Linux). |
| `-W 2` | *wait*: espera como máximo **2 segundos** la respuesta. |

Como todo comando, `ping` deja un **código de salida**: `0` si el equipo ha respondido y otro valor si no. Se puede usar directamente en un `if`, ocultando lo que escribe en pantalla:

```bash
if ping -c 1 -W 2 127.0.0.1 &>/dev/null; then
    echo "Responde"
else
    echo "No responde"
fi
```

`&>/dev/null` descarta la salida normal y los errores. `/dev/null` es un "agujero negro" donde se envía lo que no interesa ver.

### 2. Leer un archivo línea a línea

```bash
while read -r linea; do
    echo "Leída: $linea"
done < "archivo.txt"
```

| Parte | Qué significa |
|---|---|
| `read -r linea` | Lee una línea del archivo y la guarda en la variable. La opción `-r` evita que las barras invertidas se interpreten. |
| `< "archivo.txt"` | Hace que el bucle lea del archivo, en lugar de leer del teclado. |
| El bucle termina | Cuando se acaban las líneas del archivo. |

### 3. Saltarse líneas: `continue`

`continue` interrumpe la vuelta actual del bucle y pasa a la siguiente. Se combina con `||` ("o") para ignorar varios casos:

```bash
[[ -z "$linea" || "$linea" == \#* ]] && continue
```

| Parte | Qué significa |
|---|---|
| `-z "$linea"` | Es verdadero si la línea está **vacía**. |
| `"$linea" == \#*` | Es verdadero si la línea **empieza por** `#`. La barra invertida evita que `#` se tome como un comentario. |
| `\|\|` | "o": basta con que una de las dos condiciones sea verdadera. |
| `&& continue` | "y, si se cumple, salta a la siguiente línea". |

### 4. Dos trampas habituales con archivos de texto

- **Última línea sin salto de línea:** `read` falla con la última línea si el archivo no termina en un salto de línea, y esa línea se ignora. Se soluciona usando `while read -r linea || [[ -n "$linea" ]]; do`.
- **Archivos creados en Windows:** las líneas terminan en `\r\n` y el `\r` se queda pegado al final del nombre del equipo, de modo que el ping falla. Se puede limpiar con `tr -d '\r'`.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `$1` y `$#` | Recibir el archivo como argumento y comprobarlo. |
| `ping -c 1 -W 2` | Probar si un equipo responde. |
| `&>/dev/null` | Ocultar la salida de un comando. |
| `while read -r` con `<` | Leer un archivo línea a línea. |
| `continue` y `\|\|` | Ignorar líneas vacías y comentarios. |
| Código de salida en un `if` | Decidir según si un comando ha funcionado. |
| Contadores | Elaborar el resumen final. |

## Cómo ejecutarlo

```bash
chmod +x ping-equipos.sh
./ping-equipos.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| El `equipos.txt` de ejemplo | `127.0.0.1` y `localhost` OK; `192.0.2.1` y `equipo-que-no-existe` FALLO |
| Sin conexión a Internet | `8.8.8.8` aparece como FALLO |
| Sin argumentos | Mensaje de uso y código `1` (compruébalo con `echo $?`) |
| Un archivo que no existe | Error claro y código `1` |
| Archivo vacío o solo con comentarios | Resumen con 0 equipos, sin errores |
| Archivo cuya última línea no termina en salto de línea | Esa última línea también se comprueba |
| Archivo creado con el Bloc de notas de Windows | Funciona igual (sin el `\r` pegado) |
| Con las líneas en blanco y los comentarios | No aparecen en el resultado ni en el resumen |

## 🎯 Retos extra

- [ ] Guardar el resultado de cada comprobación, con **fecha y hora**, en un archivo `ping.log`.
- [ ] Mostrar también el **tiempo de respuesta** de cada equipo (pista: la salida de `ping` contiene `time=`).
- [ ] Comprobar todos los equipos **a la vez** en lugar de uno por uno (pista: ejecutar en segundo plano con `&` y esperar con `wait`).
- [ ] Exportar el resultado a un archivo **CSV**.
- [ ] Admitir la ruta de un archivo con **espacios** en su nombre.

## ✅ Solución

El código resuelto, con comentarios, está en [`ping-equipos.sh`](ping-equipos.sh).
