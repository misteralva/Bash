# 📝 Ejercicio: Validador de contraseñas

**Nivel:** 🟡 Intermedio
**Solución:** [`validador-contrasenas.sh`](validador-contrasenas.sh)

---

## Enunciado

Crea un script llamado `validador-contrasenas.sh` que haga lo siguiente:

1. Pida una contraseña **sin mostrarla** en pantalla mientras se escribe.
2. Compruebe que cumple todos estos requisitos: tener **al menos 8 caracteres**, **una mayúscula**, **una minúscula**, **un número** y **un símbolo**.
3. Si no es válida, muestre **todos** los requisitos que no cumple (no solo el primero) y vuelva a pedirla.
4. Si es válida, muestre un mensaje de aceptación y termine.

## ⚠️ Antes de empezar

Este ejercicio es **didáctico**. El script no guarda ni envía la contraseña a ningún sitio. Aun así, **no uses contraseñas reales** para probarlo: utiliza contraseñas inventadas.

## Ejemplos de salida esperada

```text
Escribe una contraseña:
La contraseña no es válida:
 - Debe tener al menos 8 caracteres.
 - Debe incluir al menos una mayúscula.
 - Debe incluir al menos un símbolo.
Escribe una contraseña:
¡Contraseña válida!
```

La contraseña no se ve mientras se escribe. En los ejemplos, el espacio tras los dos puntos está vacío a propósito.

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Leer sin mostrar lo escrito: `read -s`

```bash
read -s -p "Contraseña: " clave
echo
```

| Parte | Qué significa |
|---|---|
| `-s` | *silent*: no muestra en pantalla lo que se escribe. |
| `-p "..."` | Muestra un mensaje antes de leer. |
| `echo` (solo) | Escribe un salto de línea. Hace falta porque, al no verse el Enter, el siguiente texto saldría pegado. |

### 2. Longitud de una variable: `${#variable}`

```bash
palabra="murcielago"
echo "${#palabra}"
```

Resultado: `10`. Es el número de caracteres.

### 3. Comprobar si un texto **contiene** algo

Con `=~` y una plantilla **sin** `^` ni `$`, se comprueba si el texto contiene en algún punto lo que describe la plantilla:

```bash
palabra="Hola123"
if [[ "$palabra" =~ [0-9] ]]; then
    echo "Contiene un número"
fi
```

Existen clases de caracteres ya preparadas:

| Plantilla | Significa |
|---|---|
| `[[:upper:]]` | Una letra **mayúscula**. |
| `[[:lower:]]` | Una letra **minúscula**. |
| `[[:digit:]]` | Un **dígito**. |
| `[^[:alnum:]]` | Cualquier carácter que **no** sea letra ni número (es decir, un símbolo o un espacio). |

El `^` dentro de los corchetes significa "cualquier carácter que **no** sea...". No es el mismo `^` del inicio de una plantilla.

### 4. Acumular los fallos

Una forma sencilla de mostrar todos los requisitos que fallan es comprobarlos uno a uno y llevar un **contador de errores** (`errores=$((errores + 1))`), mostrando un mensaje en cada comprobación que falle. Al final, si el contador es 0, la contraseña es válida.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `read -s` | Pedir un dato sin mostrarlo. |
| `${#variable}` | Medir la longitud de un texto. |
| Clases de caracteres (`[[:upper:]]`, etc.) | Detectar tipos de carácter. |
| `=~` sin anclas | Comprobar si un texto contiene algo. |
| Contador de errores | Acumular y mostrar todos los fallos. |
| `while` | Repetir hasta tener una contraseña válida. |

## Cómo ejecutarlo

```bash
chmod +x validador-contrasenas.sh
./validador-contrasenas.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| `Abcdef1!` | Válida |
| `abc` | Inválida: corta, sin mayúscula, sin número y sin símbolo |
| `ABCDEFG1!` | Inválida: falta minúscula |
| `abcdefg1!` | Inválida: falta mayúscula |
| `Abcdefgh!` | Inválida: falta número |
| `Abcdefg12` | Inválida: falta símbolo |
| `Ab1!` | Inválida: demasiado corta |
| *(Enter vacío)* | Inválida: incumple todos los requisitos |

## 🎯 Retos extra

- [ ] Pedir la contraseña **dos veces** y comprobar que coinciden.
- [ ] Clasificar la fortaleza como **débil**, **media** o **fuerte** según los requisitos que cumple y su longitud.
- [ ] Permitir como máximo **3 intentos**.
- [ ] Rechazar contraseñas que **contengan el nombre del usuario** (variable `$USER`).

## ✅ Solución

El código resuelto, con comentarios, está en [`validador-contrasenas.sh`](validador-contrasenas.sh).
