# 📝 Ejercicio: Tabla de multiplicar

**Nivel:** 🟢 Básico
**Solución:** [`tabla-multiplicar.sh`](tabla-multiplicar.sh)

---

## Enunciado

Crea un script llamado `tabla-multiplicar.sh` que haga lo siguiente:

1. Pida al usuario un **número entero** (formado solo por dígitos, sin signo).
2. Compruebe que lo escrito **es realmente un número**. Si no lo es, debe avisar y volver a preguntar hasta que lo sea.
3. Muestre la **tabla de multiplicar** de ese número, **del 1 al 10**, usando un bucle `for`.

## Ejemplos de salida esperada

**Caso 1: tabla del 7**

```text
Escribe un número entero: 7
Tabla del 7:
7 x 1 = 7
7 x 2 = 14
7 x 3 = 21
7 x 4 = 28
7 x 5 = 35
7 x 6 = 42
7 x 7 = 49
7 x 8 = 56
7 x 9 = 63
7 x 10 = 70
```

**Caso 2: entrada no válida**

```text
Escribe un número entero: hola
(mensaje de error)
Escribe un número entero: 3
Tabla del 3:
3 x 1 = 3
3 x 2 = 6
...
3 x 10 = 30
```

> El texto exacto del mensaje de error es libre. Lo importante es que avise y vuelva a preguntar.

## Concepto clave: el bucle `for`

Un **bucle** repite un bloque de código varias veces. El bucle `for` es especialmente útil cuando se sabe **cuántas veces** hay que repetir. Cada repetición se llama **vuelta** o **iteración**.

Ejemplo con otro tema, que cuenta del 1 al 3:

```bash
for i in 1 2 3; do
    echo "Vuelta número $i"
done
```

Resultado:

```text
Vuelta número 1
Vuelta número 2
Vuelta número 3
```

| Parte | Qué significa |
|---|---|
| `for i in 1 2 3` | "Para cada valor de la lista `1 2 3`, guárdalo en la variable `i` y repite lo de dentro." |
| `do` | Aquí empieza el bloque que se repite. |
| `$i` | El valor que tiene la variable en cada vuelta. |
| `done` | Aquí termina el bloque. |

Cuando la lista es larga, se puede escribir como un **rango**:

```bash
for i in {1..5}; do
    echo "$i"
done
```

La parte `{1..5}` equivale a `1 2 3 4 5`.

Para hacer cálculos se usa la forma `$(( ... ))`:

```bash
echo $((4 * 3))
```

Resultado: `12`.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `read -p` | Pedir un dato al usuario. |
| `while` con `=~` | Repetir la pregunta hasta que el dato sea un número. |
| `for` | Repetir una acción un número de veces conocido. |
| `{1..10}` | Generar un rango de números. |
| `$(( ... ))` | Hacer cálculos aritméticos. |
| `*` dentro de `$(( ))` | Multiplicar. |

## Cómo ejecutarlo

```bash
chmod +x tabla-multiplicar.sh
./tabla-multiplicar.sh
```

| Parte | Qué significa |
|---|---|
| `chmod +x` | Da permiso de ejecución al archivo (solo hace falta una vez). |
| `./tabla-multiplicar.sh` | Ejecuta el script que está en la carpeta actual. |

## 🧪 Casos que se deben probar

| Entrada | Resultado esperado |
|---|---|
| `7` | Tabla del 7, de `7 x 1 = 7` a `7 x 10 = 70` |
| `1` | Tabla del 1 |
| `0` | Tabla del 0 (todos los resultados son 0) |
| `12` | Tabla del 12, de `12 x 1 = 12` a `12 x 10 = 120` |
| `abc` | Error y vuelve a preguntar |
| *(Enter vacío)* | Error y vuelve a preguntar |
| `3.5` | Error y vuelve a preguntar (no es un entero) |
| `08` | Tabla del 8, sin errores |

## 🎯 Retos extra

- [ ] Preguntar también **hasta qué número** llega la tabla, en lugar de usar siempre el 10.
- [ ] Mostrar la tabla en **orden inverso**, del 10 al 1.
- [ ] Mostrar **todas las tablas del 1 al 10** seguidas, usando un bucle dentro de otro (bucle anidado).

## ✅ Solución

El código resuelto, con comentarios, está en [`tabla-multiplicar.sh`](tabla-multiplicar.sh).
