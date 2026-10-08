# 📝 Ejercicio: Limpieza de archivos antiguos

**Nivel:** 🟠 Avanzado
**Solución:** [`limpieza-archivos.sh`](limpieza-archivos.sh)

---

## Enunciado

Crea un script llamado `limpieza-archivos.sh` que haga lo siguiente:

1. Pida una **carpeta** y compruebe que existe y es un directorio. Por **seguridad**, debe rechazar la raíz del sistema (`/`) y la carpeta personal del usuario (`$HOME`).
2. Pida un número de **días** (entero de 1 o más).
3. Busque los **archivos** (no las carpetas) de esa carpeta y sus subcarpetas que lleven **más de ese número de días sin modificarse**.
4. Muestre **cuántos** son, su **tamaño total** y la lista de nombres. Si no hay ninguno, termine con un mensaje.
5. Pida una **confirmación**: el usuario debe escribir la palabra completa `si` para continuar. Cualquier otra respuesta cancela el borrado.
6. Borre los archivos y muestre cuántos se han eliminado.

## ⚠️ Antes de empezar

**Este script borra archivos de forma permanente, y en Linux no hay papelera.** Para practicar con seguridad:

- Prueba **solo en una carpeta de pruebas** creada para esto, nunca en tus carpetas de trabajo.
- **Nunca** ejecutes un `find` con la raíz `/` ni con tu carpeta personal.
- Antes de borrar, el script debe **mostrar** lo que va a borrar.

Puedes crear una carpeta de pruebas con archivos de distintas edades así:

```bash
mkdir -p ~/prueba-limpieza/sub
cd ~/prueba-limpieza
touch -d "40 days ago" viejo1.log "viejo 2.log" sub/viejo3.txt
touch -d "10 days ago" reciente.log
touch hoy.log
```

| Parte | Qué significa |
|---|---|
| `touch -d "40 days ago"` | Crea el archivo y le asigna una fecha de modificación **de hace 40 días**. |
| `"viejo 2.log"` | Un nombre con espacio, a propósito, para comprobar que el script lo maneja bien. |

## Ejemplos de salida esperada

Con la carpeta de pruebas de arriba y `30` días:

```text
Carpeta a limpiar: /home/david/prueba-limpieza
Borrar archivos con más de (días): 30
Se han encontrado 3 archivos con más de 30 días (0 KB en total):
  /home/david/prueba-limpieza/viejo1.log
  /home/david/prueba-limpieza/sub/viejo3.txt
  /home/david/prueba-limpieza/viejo 2.log
Escribe 'si' para borrarlos: si
Se han eliminado 3 archivos.
```

Cuando no hay nada que borrar:

```text
No hay archivos con más de 30 días. No se borra nada.
```

Cuando se cancela:

```text
Escribe 'si' para borrarlos: no
Operación cancelada. No se ha borrado nada.
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Buscar archivos por antigüedad: `find`

```bash
find carpeta -type f -mtime +30
```

| Parte | Qué significa |
|---|---|
| `find carpeta` | Busca dentro de la carpeta **y de todas sus subcarpetas**. |
| `-type f` | Solo **archivos** normales (*file*), no carpetas. |
| `-mtime +30` | Modificados hace **más de 30 días**. |

El orden en que `find` muestra los resultados no está garantizado.

**Cómo cuenta los días `-mtime`:** el tiempo se mide en periodos completos de 24 horas y las fracciones se descartan. Por eso `+30` significa "más de 30 periodos completos": un archivo de **exactamente** 30 días no coincide, y uno de 31 sí.

### 2. Contar y sumar tamaños

```bash
find carpeta -type f -mtime +30 | wc -l
find carpeta -type f -mtime +30 -printf '%s\n' | awk '{s+=$1} END {print s+0}'
```

| Parte | Qué significa |
|---|---|
| `wc -l` | Cuenta líneas, es decir, cuántos archivos ha encontrado `find`. |
| `-printf '%s\n'` | En lugar del nombre, escribe el **tamaño en bytes** de cada archivo. |
| `awk '{s+=$1} END {print s+0}'` | Suma todos los valores y, al final, escribe el total. El `+0` asegura que salga `0` si no había ninguno. |

Para pasar bytes a kilobytes, divide entre 1024 con `$(( ... / 1024 ))`.

### 3. Nombres con espacios: `-print0`

Si el nombre de un archivo tiene espacios, procesarlo como una lista de palabras lo rompe. La forma segura es que `find` separe los nombres con un carácter nulo (`\0`), que no puede aparecer en un nombre:

```bash
find carpeta -type f -mtime +30 -print0 | while IFS= read -r -d '' archivo; do
    echo "Archivo: $archivo"
done
```

| Parte | Qué significa |
|---|---|
| `-print0` | Separa los resultados con el carácter nulo. |
| `read -r -d ''` | Lee hasta ese carácter nulo (`-d ''` cambia el separador). |
| `IFS=` | Evita que se recorten espacios al principio o al final del nombre. |

**Un detalle importante:** una tubería (`|`) ejecuta el `while` en un proceso aparte, así que las variables que se modifican dentro (como un contador) **no se conservan** al terminar. Piensa cómo evitarlo (pista: puedes **contar fuera**, con `wc`, y usar el bucle solo para mostrar o borrar).

### 4. Borrar

`find` puede borrar por sí mismo con `-delete`:

```bash
find carpeta -type f -mtime +30 -delete
```

Es lo más seguro con nombres raros, pero **no se puede deshacer**. Asegúrate de que las condiciones son idénticas a las que usaste para **mostrar** la lista: lo que se borra debe ser exactamente lo que se enseñó.

### 5. Proteger rutas peligrosas

Una carpeta vacía o la raíz `/` convertirían este script en un arma de destrucción masiva. Comprueba, **antes de hacer nada**, que la ruta no es `/` y que no es `$HOME`. Piensa cómo comparar las rutas aunque el usuario las escriba con una barra final (`/home/david/`).

### 6. Confirmaciones más seguras

Pedir `s/n` se contesta sin pensar. Pedir que se escriba una palabra completa (`si`) obliga a leer la pregunta.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `find -type f -mtime` | Buscar archivos por antigüedad. |
| `wc -l` y `awk` | Contar archivos y sumar tamaños. |
| `-print0` y `read -d ''` | Manejar nombres con espacios. |
| `find -delete` | Borrar los archivos encontrados. |
| Validaciones de seguridad | Impedir borrar `/` o la carpeta personal. |
| Confirmación explícita | Evitar borrados accidentales. |
| `touch -d` | Crear archivos de prueba con fechas antiguas. |

## Cómo ejecutarlo

```bash
chmod +x limpieza-archivos.sh
./limpieza-archivos.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| Carpeta de pruebas con `30` días | Encuentra 3 archivos (`viejo1.log`, `viejo 2.log`, `sub/viejo3.txt`) |
| Con `5` días | Encuentra 4 (se añade `reciente.log`) |
| Con `100` días | No hay nada que borrar |
| Responder `no` o Enter a la confirmación | No se borra nada |
| Responder `si` | Se borran exactamente los mostrados, y `hoy.log` y `reciente.log` siguen ahí |
| Carpeta `/` | **Rechazada** |
| Carpeta personal (`$HOME` o `~`) | **Rechazada** |
| Carpeta inexistente o un archivo | Error y vuelve a preguntar |
| Días `abc`, `0`, `-5` o vacío | Error y vuelve a preguntar |
| Días `030` | Se trata como 30, sin errores |
| Comprobar después con `ls -R` | Quedan solo los archivos recientes |

## 🎯 Retos extra

- [ ] Añadir un **modo simulación** (`--dry-run`) que solo muestre lo que se borraría.
- [ ] Filtrar por **extensión** (por ejemplo, solo `*.log`; pista: `-name`).
- [ ] En lugar de borrar, **mover** los archivos a una carpeta de cuarentena.
- [ ] Registrar en un **log** qué se ha borrado y cuándo.
- [ ] Recibir la carpeta y los días como **argumentos**.

## ✅ Solución

El código resuelto, con comentarios, está en [`limpieza-archivos.sh`](limpieza-archivos.sh).
