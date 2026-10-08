# 📝 Ejercicio: Copia de seguridad automática

**Nivel:** 🟡 Intermedio
**Solución:** [`copia-seguridad.sh`](copia-seguridad.sh)

---

## Enunciado

Crea un script llamado `copia-seguridad.sh` que haga lo siguiente:

1. Pida la **carpeta de origen** (la que se quiere copiar) y compruebe que existe y es un directorio. Si no, vuelve a preguntar.
2. Pida la **carpeta de destino**. Si no existe, el script debe crearla.
3. Cree un archivo comprimido `.tar.gz` con el contenido del origen, guardado en el destino, con el nombre `backup_NOMBRE_AAAA-MM-DD_HH-MM-SS.tar.gz`, donde `NOMBRE` es el nombre de la carpeta de origen.
4. Compruebe si la copia se ha hecho **correctamente** y muestre un mensaje de éxito (con el tamaño del archivo) o de error.

## Ejemplos de salida esperada

```text
Carpeta a copiar: /home/david/ejercicios-bash
Carpeta de destino: /home/david/copias
Creando copia de seguridad...
Copia creada: /home/david/copias/backup_ejercicios-bash_2026-10-07_18-30-45.tar.gz
Tamaño: 12K
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Comprimir con `tar`

```bash
tar -czf prueba.tar.gz fotos/
```

| Parte | Qué significa |
|---|---|
| `tar` | Agrupa archivos y carpetas en un solo archivo. |
| `c` | *create*: crear un archivo nuevo. |
| `z` | Comprimir con *gzip* (de ahí la extensión `.gz`). |
| `f` | *file*: lo siguiente es el nombre del archivo resultante. |
| `fotos/` | Lo que se quiere guardar. |

Para ver qué contiene una copia, sin extraerla, y para extraerla:

```bash
tar -tzf prueba.tar.gz
tar -xzf prueba.tar.gz
```

(`t` = *list*, `x` = *extract*.)

**Un detalle importante:** si se pasa una ruta absoluta (`/home/david/fotos`), `tar` avisa de que elimina la barra inicial. Para controlar qué ruta queda dentro del archivo existe la opción `-C`, que **cambia de directorio antes de empezar**:

```bash
tar -czf copia.tar.gz -C /home/david fotos
```

Aquí `tar` entra en `/home/david` y guarda la carpeta `fotos` con una ruta relativa limpia.

### 2. Fechas en nombres de archivo

```bash
date +%Y-%m-%d_%H-%M-%S
```

Resultado, por ejemplo: `2026-10-07_18-30-45`.

| Símbolo | Significa |
|---|---|
| `%Y` `%m` `%d` | Año, mes y día. |
| `%H` `%M` `%S` | Hora, minutos y segundos. |

Con `$( ... )` se guarda el resultado de un comando en una variable:

```bash
fecha=$(date +%Y-%m-%d_%H-%M-%S)
```

### 3. Nombre de una carpeta: `basename`

```bash
basename /home/david/fotos
```

Resultado: `fotos`.

### 4. Saber si un comando ha funcionado

Cada comando deja un **código de salida**: `0` si ha ido bien y otro número si ha fallado. Se puede comprobar directamente en un `if`:

```bash
if tar -czf prueba.tar.gz fotos/; then
    echo "Todo bien"
else
    echo "Ha fallado"
fi
```

La variable especial `$?` guarda el código de salida del último comando.

### 5. Crear carpetas y medir tamaños

`mkdir -p carpeta` crea la carpeta (y las intermedias) sin error si ya existe. `du -h archivo` muestra el tamaño en un formato legible (K, M, G).

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `tar -czf` | Crear archivos comprimidos. |
| `date +formato` | Obtener fechas para los nombres. |
| `$( ... )` | Guardar la salida de un comando en una variable. |
| `basename` | Obtener el nombre de una carpeta a partir de su ruta. |
| `mkdir -p` | Crear la carpeta de destino si falta. |
| Código de salida (`if comando`, `$?`) | Detectar si una operación ha fallado. |
| `du -h` | Mostrar el tamaño en formato legible. |

## Cómo ejecutarlo

```bash
chmod +x copia-seguridad.sh
./copia-seguridad.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| Origen válido y destino nuevo | Crea el destino y la copia |
| Origen válido y destino existente | Crea la copia sin errores |
| Origen que no existe | Error y vuelve a preguntar |
| Origen que es un archivo, no un directorio | Error y vuelve a preguntar |
| Origen con espacios en el nombre | Funciona igual |
| Destino sin permisos de escritura (por ejemplo, `/root`) | Mensaje de **error**, no de éxito |
| Dos copias seguidas | Dos archivos con nombres distintos (por la hora) |
| Comprobar el contenido con `tar -tzf` | Aparecen los archivos del origen |

## 🎯 Retos extra

- [ ] Excluir ciertas carpetas o archivos de la copia (pista: la opción `--exclude` de `tar`).
- [ ] Conservar solo las **5 copias más recientes** y borrar las anteriores.
- [ ] Comprobar la **integridad** de la copia al terminar (pista: `tar -tzf`).
- [ ] Aceptar el origen y el destino como **argumentos** del script.
- [ ] Evitar que el destino esté **dentro** del origen (la copia intentaría incluirse a sí misma).

## ✅ Solución

El código resuelto, con comentarios, está en [`copia-seguridad.sh`](copia-seguridad.sh).
