# 📝 Ejercicio: Comprobar si un archivo existe

**Nivel:** 🟢 Básico
**Solución:** [`comprobar-archivo.sh`](comprobar-archivo.sh)

---

## Enunciado

Crea un script llamado `comprobar-archivo.sh` que haga lo siguiente:

1. Pida al usuario una **ruta** (de un archivo o de un directorio). Si la deja vacía, debe volver a preguntar.
2. Indique si la ruta **existe**.
3. Si existe, indique si es un **archivo normal**, un **directorio** u **otro tipo** de elemento.
4. Muestre si el usuario que ejecuta el script tiene permiso de **lectura**, **escritura** y **ejecución** sobre esa ruta.

## Ejemplos de salida esperada

**Caso 1: un archivo existente**

```text
Escribe una ruta: /etc/passwd
La ruta existe.
Tipo: archivo normal.
Permisos para tu usuario:
  Lectura: sí
  Escritura: no
  Ejecución: no
```

**Caso 2: una ruta que no existe**

```text
Escribe una ruta: /ruta/que/no/existe
La ruta no existe.
```

**Caso 3: un directorio**

```text
Escribe una ruta: /etc
La ruta existe.
Tipo: directorio.
Permisos para tu usuario:
  Lectura: sí
  Escritura: no
  Ejecución: sí
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Pruebas sobre archivos

Se usan dentro de un `if` con corchetes:

| Prueba | Es verdadera si la ruta... |
|---|---|
| `-e ruta` | **existe**, sea del tipo que sea (*exists*). |
| `-f ruta` | existe y es un **archivo normal** (*file*). |
| `-d ruta` | existe y es un **directorio** (*directory*). |
| `-r ruta` | existe y el usuario actual puede **leerla** (*read*). |
| `-w ruta` | existe y el usuario actual puede **escribir** en ella (*write*). |
| `-x ruta` | existe y el usuario actual puede **ejecutarla** (*execute*). |

Ejemplo con otro tema:

```bash
if [ -d "/tmp" ]; then
    echo "/tmp es un directorio."
fi
```

### 2. Hay más tipos que archivo y directorio

Algunos elementos existen pero no son ni archivos normales ni directorios. Por ejemplo, `/dev/null` es un archivo especial del sistema. Para esos casos se usa la categoría "otro tipo".

### 3. Las comillas importan

Escribe siempre la variable entre comillas: `[ -e "$ruta" ]`. Sin ellas, una ruta con espacios (como `Mis documentos`) se interpretaría como dos palabras distintas y la prueba fallaría.

### 4. Los permisos dependen de quién ejecuta

Las pruebas `-r`, `-w` y `-x` se refieren **al usuario que ejecuta el script**. Si lo ejecuta `root`, casi todo estará permitido.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `read -p` | Pedir la ruta al usuario. |
| `while` con `-z` | Volver a preguntar si la ruta está vacía. |
| `-e`, `-f`, `-d` | Comprobar existencia y tipo. |
| `-r`, `-w`, `-x` | Comprobar permisos del usuario actual. |
| `if / elif / else` | Distinguir entre archivo, directorio y otro tipo. |
| Comillas en variables | Admitir rutas con espacios. |

## Cómo ejecutarlo

```bash
chmod +x comprobar-archivo.sh
./comprobar-archivo.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| `/etc/passwd` | Existe, archivo normal, lectura sí (para un usuario normal) |
| `/etc` | Existe, directorio |
| `/ruta/inexistente` | La ruta no existe |
| `/dev/null` | Existe, otro tipo (ni archivo ni directorio) |
| `/etc/shadow` | Existe, archivo normal, lectura no (para un usuario normal) |
| El propio script, con y sin `chmod +x` | Ejecución: sí / no |
| Una ruta con espacios | Funciona igual que las demás |
| *(Enter vacío)* | Vuelve a preguntar |

## 🎯 Retos extra

- [ ] Mostrar también el **tamaño** del archivo (pista: investiga el comando `stat`).
- [ ] Detectar si la ruta es un **enlace simbólico** (pista: la prueba `-L`).
- [ ] Aceptar **varias rutas** como argumentos del script y comprobarlas todas.

## ✅ Solución

El código resuelto, con comentarios, está en [`comprobar-archivo.sh`](comprobar-archivo.sh).
