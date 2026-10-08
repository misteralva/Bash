# 📝 Ejercicio: Contador de archivos

**Nivel:** 🟢 Básico
**Solución:** [`contador-archivos.sh`](contador-archivos.sh)

---

## Enunciado

Crea un script llamado `contador-archivos.sh` que haga lo siguiente:

1. Pida al usuario la **ruta de un directorio** (una carpeta).
2. Compruebe que esa ruta **existe y es un directorio**. Si no lo es, debe avisar y volver a preguntar hasta que sea correcta.
3. Cuente cuántos **archivos** y cuántas **carpetas** hay directamente dentro de ese directorio.
4. Muestre el resultado.

**Importante:** solo se cuenta el contenido directo del directorio. Lo que haya dentro de sus subcarpetas **no** se cuenta.

## Ejemplos de salida esperada

**Caso 1: directorio válido**

```text
Escribe la ruta de un directorio: /home/david/ejercicios-bash
Directorio: /home/david/ejercicios-bash
Archivos: 2
Carpetas: 5
```

**Caso 2: ruta no válida**

```text
Escribe la ruta de un directorio: /ruta/que/no/existe
(mensaje de error)
Escribe la ruta de un directorio: /home/david
Directorio: /home/david
Archivos: 4
Carpetas: 3
```

> Las cifras de los ejemplos son orientativas. El resultado real depende del contenido de cada directorio. El texto exacto del mensaje de error es libre: lo importante es que avise y vuelva a preguntar.

## Conceptos clave

### 1. Comprobar si algo es un archivo o un directorio

Bash tiene pruebas que se usan dentro de un `if` con corchetes:

| Prueba | Es verdadera si... |
|---|---|
| `-d ruta` | la ruta existe y es un **directorio** (*directory*) |
| `-f ruta` | la ruta existe y es un **archivo normal** (*file*) |
| `-e ruta` | la ruta existe, sea del tipo que sea (*exists*) |

Ejemplo con otro tema:

```bash
if [ -d "/etc" ]; then
    echo "/etc es una carpeta."
fi
```

### 2. Recorrer el contenido de un directorio

El símbolo `*` es un **comodín**: representa "cualquier nombre". Con un bucle `for` se puede recorrer todo lo que hay dentro de una carpeta:

```bash
for elemento in /etc/*; do
    echo "Encontrado: $elemento"
done
```

| Parte | Qué significa |
|---|---|
| `/etc/*` | "Todo lo que hay directamente dentro de `/etc`". Bash lo sustituye por la lista de nombres. |
| `elemento` | Variable que toma, en cada vuelta, uno de esos nombres. |

Detalles que conviene conocer:

- El comodín `*` **no incluye** los archivos ocultos (los que empiezan por un punto).
- Si el directorio está **vacío**, el `*` no se sustituye por nada y la variable recibe el texto literal `/ruta/*`. Hay que tenerlo en cuenta al contar.

### 3. Usar contadores

Un **contador** es una variable que empieza en 0 y aumenta de uno en uno. Las cuentas se hacen con `$(( ... ))`:

```bash
total=0
total=$((total + 1))
total=$((total + 1))
echo "$total"
```

Resultado: `2`.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `read -p` | Pedir la ruta al usuario. |
| `while` con `-d` | Repetir la pregunta hasta que la ruta sea un directorio. |
| `for` con `*` | Recorrer el contenido de un directorio. |
| `-f` y `-d` | Distinguir archivos de carpetas. |
| `if / elif` | Decidir en qué contador se suma. |
| Contadores con `$(( ))` | Llevar la cuenta de archivos y de carpetas. |
| Comillas en variables | Evitar problemas con nombres que tienen espacios. |

## Cómo ejecutarlo

```bash
chmod +x contador-archivos.sh
./contador-archivos.sh
```

| Parte | Qué significa |
|---|---|
| `chmod +x` | Da permiso de ejecución al archivo (solo hace falta una vez). |
| `./contador-archivos.sh` | Ejecuta el script que está en la carpeta actual. |

## 🧪 Casos que se deben probar

| Entrada | Resultado esperado |
|---|---|
| Un directorio con archivos y carpetas | Las dos cuentas correctas |
| Un directorio **vacío** | `Archivos: 0` y `Carpetas: 0` |
| Un directorio con **nombres con espacios** | Se cuentan igual que los demás |
| La ruta `.` (el directorio actual) | Funciona sobre la carpeta donde se ejecuta |
| Una ruta que **no existe** | Error y vuelve a preguntar |
| La ruta de un **archivo** (no de un directorio) | Error y vuelve a preguntar |
| *(Enter vacío)* | Error y vuelve a preguntar |

Para comprobar que las cifras son correctas, se pueden comparar con el resultado del comando `ls -l` sobre el mismo directorio.

## 🎯 Retos extra

- [ ] Contar también los **archivos y carpetas ocultos**.
- [ ] Mostrar además los **nombres** de los archivos y de las carpetas, no solo cuántos hay.
- [ ] Contar **dentro de las subcarpetas** también (recuento recursivo).
- [ ] Aceptar la ruta como **argumento** al ejecutar el script (`./contador-archivos.sh /ruta`) y preguntarla solo si no se ha indicado.

## ✅ Solución

El código resuelto, con comentarios, está en [`contador-archivos.sh`](contador-archivos.sh).
