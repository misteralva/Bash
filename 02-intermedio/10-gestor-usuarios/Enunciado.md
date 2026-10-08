# 📝 Ejercicio: Gestor de usuarios

**Nivel:** 🟡 Intermedio
**Solución:** [`gestor-usuarios.sh`](gestor-usuarios.sh)

---

## Enunciado

Crea un script llamado `gestor-usuarios.sh` que haga lo siguiente:

1. Compruebe que el script se ejecuta con **permisos de administrador** (root). Si no, debe avisar y terminar con código de salida `1`.
2. Muestre un **menú** con cuatro opciones: crear usuario, listar usuarios, eliminar usuario y salir.
3. **Crear:** pida el nombre, compruebe que tiene un formato válido (minúsculas, números, guiones y guiones bajos, empezando por una letra o un guion bajo) y que **no existe** ya, y cree el usuario con su carpeta personal.
4. **Listar:** muestre los usuarios "normales" del sistema (los de identificador de usuario `1000` o más, sin contar usuarios especiales).
5. **Eliminar:** pida el nombre, compruebe que existe, **impida borrar a `root` y al usuario que está usando el script**, pida confirmación (`s/n`) y bórrelo junto con su carpeta personal.
6. Vuelva al menú hasta que el usuario elija salir.

## ⚠️ Antes de empezar

Este script **modifica usuarios reales del sistema**. Para practicar con seguridad:

- Ejecútalo solo en tu entorno de pruebas (por ejemplo, Ubuntu en WSL2 o una máquina virtual), **nunca en un servidor real**.
- Prueba **solo con usuarios inventados**, como `prueba1` o `prueba2`.
- Eliminar un usuario con su carpeta personal **borra sus archivos para siempre**. No elimines tu propio usuario ni ninguno que necesites.

## Ejemplos de salida esperada

**Caso 1: sin permisos**

```text
$ ./gestor-usuarios.sh
Error: este script debe ejecutarse como administrador (usa sudo).
```

**Caso 2: con permisos, crear y listar**

```text
$ sudo ./gestor-usuarios.sh
=== Gestor de usuarios ===
1) Crear usuario
2) Listar usuarios
3) Eliminar usuario
4) Salir
Elige una opción: 1
Nombre del nuevo usuario: prueba1
Usuario 'prueba1' creado correctamente.

Elige una opción: 2
Usuarios del sistema:
david
prueba1
```

**Caso 3: eliminar con confirmación**

```text
Elige una opción: 3
Nombre del usuario a eliminar: prueba1
¿Seguro que quieres eliminar a 'prueba1' y su carpeta personal? (s/n): s
Usuario 'prueba1' eliminado.
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Comprobar que se es administrador

```bash
if [ "$EUID" -ne 0 ]; then
    echo "Este script necesita permisos de administrador."
    exit 1
fi
```

| Parte | Qué significa |
|---|---|
| `$EUID` | Variable con el identificador del usuario que ejecuta el script. El de `root` es `0`. |
| `-ne 0` | "No es igual a 0". |
| `exit 1` | Termina el script con código de salida `1` (un valor distinto de 0 indica error). |

Para ejecutar con permisos de administrador se antepone `sudo`: `sudo ./gestor-usuarios.sh`.

### 2. Saber si un usuario existe: `id`

El comando `id nombre` muestra información del usuario y **falla** si no existe. Se puede usar en un `if` ocultando su salida:

```bash
if id "prueba1" &>/dev/null; then
    echo "El usuario existe"
fi
```

`&>/dev/null` descarta tanto la salida normal como los errores. `/dev/null` es un "agujero negro" donde se envía lo que no interesa ver.

### 3. Crear y borrar usuarios

| Comando | Qué hace |
|---|---|
| `useradd -m nombre` | Crea el usuario. La opción `-m` crea también su carpeta personal. |
| `passwd nombre` | Pide y fija la contraseña del usuario (de forma interactiva). |
| `userdel -r nombre` | Elimina el usuario. La opción `-r` borra también su carpeta personal. |

### 4. Dónde se guardan los usuarios: `/etc/passwd`

Cada línea de `/etc/passwd` describe un usuario, con campos separados por `:`:

```text
david:x:1000:1000:David:/home/david:/bin/bash
```

| Campo | Ejemplo | Significado |
|---|---|---|
| 1 | `david` | Nombre de usuario |
| 3 | `1000` | Identificador del usuario (UID) |
| 6 | `/home/david` | Carpeta personal |
| 7 | `/bin/bash` | Intérprete de comandos |

Los usuarios creados por personas suelen tener UID desde `1000`. Existe un usuario especial, `nobody`, con UID `65534`, que no interesa mostrar.

### 5. Filtrar columnas con `awk`

`awk` permite seleccionar campos de cada línea. Con `-F:` se indica que el separador es `:`:

```bash
echo "uno:dos:tres" | awk -F: '{print $2}'
```

Resultado: `dos`. Y se pueden poner condiciones sobre los campos:

```bash
awk -F: '$3 >= 1000 && $3 < 60000 {print $1}' /etc/passwd
```

Se lee: "en cada línea, si el campo 3 está entre 1000 y 59999, escribe el campo 1".

### 6. Quién ha usado `sudo`: `$SUDO_USER`

Cuando se ejecuta con `sudo`, la variable `$SUDO_USER` contiene el nombre del usuario **original** (por ejemplo, `david`), mientras que `$USER` pasa a ser `root`. Es útil para impedir que el script borre al usuario que lo está usando.

### 7. Validar el nombre del usuario

Una plantilla posible: `^[a-z_][a-z0-9_-]*$`. Piensa qué significa cada parte y qué nombres acepta y rechaza.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `$EUID` y `exit` | Comprobar permisos y terminar con un código de error. |
| `id usuario &>/dev/null` | Saber si un usuario existe. |
| `useradd -m`, `userdel -r` | Crear y eliminar usuarios. |
| `awk -F:` | Filtrar columnas de `/etc/passwd`. |
| `case` | Gestionar el menú. |
| Confirmaciones `s/n` | Evitar borrados accidentales. |
| `$SUDO_USER` | Proteger al usuario que ejecuta el script. |

## Cómo ejecutarlo

```bash
chmod +x gestor-usuarios.sh
sudo ./gestor-usuarios.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| Ejecutar **sin** `sudo` | Aviso y termina con código `1` (compruébalo con `echo $?`) |
| Crear `prueba1` | Se crea; aparece al listar |
| Crear `prueba1` otra vez | Error: el usuario ya existe |
| Crear `Mal Nombre` o `1abc` | Error: formato no válido |
| Listar usuarios | Aparecen los usuarios normales, sin `root` ni `nobody` |
| Eliminar `prueba1` y responder `s` | Se elimina, junto con su carpeta personal |
| Eliminar `prueba1` y responder `n` | No se borra |
| Eliminar un usuario que no existe | Error: el usuario no existe |
| Eliminar `root` | Rechazado |
| Eliminar tu propio usuario | Rechazado |
| Opción `9` | Aviso de opción no válida |

## 🎯 Retos extra

- [ ] Registrar cada acción (con fecha y hora) en un archivo **log**.
- [ ] Añadir una opción para **añadir un usuario a un grupo** (pista: `usermod -aG`).
- [ ] Añadir opciones para **bloquear y desbloquear** usuarios (pista: `usermod -L` y `usermod -U`).
- [ ] Mostrar la **información de un usuario** (UID, grupos, carpeta personal).

## ✅ Solución

El código resuelto, con comentarios, está en [`gestor-usuarios.sh`](gestor-usuarios.sh).
