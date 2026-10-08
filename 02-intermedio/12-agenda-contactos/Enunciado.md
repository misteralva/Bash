# 📝 Ejercicio: Agenda de contactos

**Nivel:** 🟡 Intermedio
**Solución:** [`agenda-contactos.sh`](agenda-contactos.sh)

---

## Enunciado

Crea un script llamado `agenda-contactos.sh` que haga lo siguiente:

1. Guarde los contactos en un archivo de texto llamado `agenda.txt`, en la misma carpeta del script, con el formato `nombre:telefono` (un contacto por línea). Si el archivo no existe, el script debe crearlo.
2. Muestre un **menú**: añadir contacto, buscar contacto, listar contactos, borrar contacto y salir.
3. **Añadir:** pida nombre y teléfono. El nombre no puede estar vacío ni contener el carácter `:`. El teléfono debe tener entre 9 y 15 dígitos, con un `+` opcional al principio. No se permiten nombres repetidos.
4. **Buscar:** pida un texto y muestre los contactos cuyo nombre lo contenga, sin distinguir mayúsculas de minúsculas. Si no hay resultados, debe avisar.
5. **Listar:** muestre todos los contactos con un formato legible (`nombre - teléfono`) o avise de que la agenda está vacía.
6. **Borrar:** pida el nombre exacto, pida confirmación y elimine el contacto.
7. Vuelva al menú hasta que el usuario elija salir.

## Ejemplos de salida esperada

```text
=== Agenda de contactos ===
1) Añadir  2) Buscar  3) Listar  4) Borrar  5) Salir
Elige una opción: 1
Nombre: Ana Pérez
Teléfono: 600123456
Contacto añadido.

Elige una opción: 2
Buscar: ana
Ana Pérez - 600123456

Elige una opción: 3
Ana Pérez - 600123456
Luis Gómez - +34911223344
```

Contenido del archivo `agenda.txt` tras estas operaciones:

```text
Ana Pérez:600123456
Luis Gómez:+34911223344
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Guardar datos en un archivo

El operador `>>` **añade** texto al final de un archivo sin borrar lo anterior (`>` lo sobrescribiría). `touch archivo` crea el archivo vacío si no existe:

```bash
touch frutas.txt
echo "manzana:rojo" >> frutas.txt
echo "plátano:amarillo" >> frutas.txt
```

### 2. Buscar texto: `grep`

```bash
grep -i "MANZ" frutas.txt
```

| Opción | Qué hace |
|---|---|
| `-i` | Ignora la diferencia entre mayúsculas y minúsculas. |
| `-F` | Trata el texto como **texto literal**, no como una plantilla (evita que símbolos como `.` o `*` tengan un significado especial). |
| `-v` | Muestra las líneas que **no** coinciden. |
| `-q` | No muestra nada; solo deja el código de salida (`0` si encuentra algo). Útil dentro de un `if`. |

### 3. Separar campos: `cut`

```bash
cut -d: -f2 frutas.txt
```

Resultado: `rojo` y `amarillo`. Con `-d:` se indica el separador y con `-f2`, qué campo mostrar.

### 4. Leer un archivo línea a línea

```bash
while IFS=: read -r nombre telefono; do
    echo "$nombre - $telefono"
done < agenda.txt
```

| Parte | Qué significa |
|---|---|
| `IFS=:` | Indica que los campos de cada línea están separados por `:`. |
| `read -r nombre telefono` | Lee una línea y reparte los campos en las dos variables. |
| `< agenda.txt` | Hace que el bucle lea del archivo, línea a línea. |

### 5. Borrar una línea de un archivo

Dos formas posibles:

- Con `sed -i "/^patrón/d" archivo`: borra las líneas que empiezan por el patrón.
- Con `grep -v` guardando el resultado en un archivo temporal y renombrándolo.

Piensa qué ventajas e inconvenientes tiene cada una, sobre todo con nombres que contienen símbolos especiales.

### 6. Validar con cantidades: `{n,m}`

```text
^\+?[0-9]{9,15}$
```

| Pieza | Significado |
|---|---|
| `\+?` | Un signo `+` opcional (la barra invertida indica que es el símbolo literal). |
| `[0-9]{9,15}` | Entre **9 y 15** dígitos. |

### 7. Comprobar si un texto contiene un carácter

```bash
if [[ "$nombre" == *:* ]]; then
    echo "El nombre contiene dos puntos"
fi
```

Aquí `*:*` es un patrón que significa "cualquier cosa, luego `:`, luego cualquier cosa".

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `>>` y `touch` | Guardar datos en un archivo. |
| `grep -i`, `-F`, `-v`, `-q` | Buscar y filtrar contactos. |
| `cut -d: -f` | Separar el nombre y el teléfono. |
| `while read` con archivo | Recorrer la agenda. |
| `sed -i` o `grep -v` | Borrar un contacto. |
| `{9,15}` | Validar la longitud del teléfono. |
| `case` | Gestionar el menú. |

## Cómo ejecutarlo

```bash
chmod +x agenda-contactos.sh
./agenda-contactos.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| Añadir `Ana Pérez` / `600123456` | Se guarda como `Ana Pérez:600123456` |
| Añadir el mismo nombre otra vez | Error: ya existe |
| Nombre vacío o con `:` | Error y vuelve a preguntar |
| Teléfono `abc`, `12345` o vacío | Error y vuelve a preguntar |
| Teléfono `+34911223344` | Se acepta |
| Buscar `ANA` | Encuentra `Ana Pérez` (sin distinguir mayúsculas) |
| Buscar un texto inexistente | Aviso de que no hay resultados |
| Listar con la agenda vacía | Aviso de agenda vacía |
| Borrar un contacto existente y confirmar | Desaparece del archivo |
| Borrar un contacto que no existe | Aviso de que no existe |
| Cerrar y volver a abrir el script | Los contactos siguen ahí |

## 🎯 Retos extra

- [ ] **Modificar** el teléfono de un contacto existente.
- [ ] Mostrar la lista **ordenada alfabéticamente** (pista: `sort`).
- [ ] **Exportar** la agenda a un archivo CSV.
- [ ] Cuando una búsqueda devuelva **varios resultados**, mostrarlos numerados.
- [ ] Evitar también los **teléfonos repetidos**.

## ✅ Solución

El código resuelto, con comentarios, está en [`agenda-contactos.sh`](agenda-contactos.sh).
