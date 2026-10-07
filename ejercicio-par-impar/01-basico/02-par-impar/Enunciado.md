# 📝 Ejercicio: Par o impar

**Nivel:** 🟢 Básico
**Solución:** [`par-impar.sh`](par-impar.sh)

---

## Enunciado

Crea un script llamado `par-impar.sh` que haga lo siguiente:

1. Pida al usuario un **número entero**.
2. Compruebe que lo escrito **es realmente un número**. Si no lo es, debe avisar y volver a preguntar hasta que lo sea.
3. Indique si el número es **par** o **impar**.

## Ejemplos de salida esperada

**Caso 1: número par**

```text
Escribe un número entero: 8
El número 8 es par.
```

**Caso 2: número impar**

```text
Escribe un número entero: 7
El número 7 es impar.
```

**Caso 3: entrada no válida**

```text
Escribe un número entero: hola
Eso no es un número entero. Inténtalo de nuevo.
Escribe un número entero: 12
El número 12 es par.
```

## Concepto clave: el resto de una división

Un número es **par** si, al dividirlo entre 2, **no sobra nada**. Es **impar** si sobra 1. Lo que sobra se llama **resto**, y en Bash se calcula con el símbolo `%` (módulo) dentro de `$(( ... ))`:

```bash
echo $((7 % 3))
echo $((10 % 5))
```

| Línea | Resultado | Por qué |
|---|---|---|
| `$((7 % 3))` | `1` | 7 entre 3 da 2 y sobra 1. |
| `$((10 % 5))` | `0` | 10 entre 5 da 2 y no sobra nada. |

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `read -p` | Pedir un dato al usuario. |
| `while` | Repetir la pregunta hasta que el dato sea válido. |
| `=~` y expresiones regulares | Comprobar que el texto está formado solo por dígitos. |
| `$(( ... ))` | Hacer cálculos aritméticos. |
| `%` | Obtener el resto de una división. |
| `if / else` | Decidir entre dos caminos. |

## Cómo ejecutarlo

```bash
chmod +x par-impar.sh
./par-impar.sh
```

| Parte | Qué significa |
|---|---|
| `chmod +x` | Da permiso de ejecución al archivo (solo hace falta una vez). |
| `./par-impar.sh` | Ejecuta el script que está en la carpeta actual. |

## 🧪 Casos que se deben probar

| Entrada | Resultado esperado |
|---|---|
| `8` | par |
| `7` | impar |
| `0` | par (caso límite) |
| `1` | impar (caso límite) |
| `abc` | Error y vuelve a preguntar |
| *(Enter vacío)* | Error y vuelve a preguntar |
| `3.5` | Error y vuelve a preguntar (no es un entero) |

## 🎯 Retos extra

- [ ] Aceptar también números **negativos** (por ejemplo, `-4`).
- [ ] Mostrar un mensaje especial cuando el número sea el **0**.
- [ ] Preguntar al final si se quiere probar **otro número** y repetir mientras la respuesta sea `s`.

> ⚠️ **Aviso para el primer reto:** en Bash, el resto de un número negativo puede salir negativo (por ejemplo, `-3 % 2` da `-1`). Conviene pensar cómo afecta eso a la condición.

## ✅ Solución

El código resuelto, con comentarios, está en [`par-impar.sh`](par-impar.sh).
