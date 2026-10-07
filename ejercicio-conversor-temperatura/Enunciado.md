# 📝 Ejercicio: Conversor de temperatura

**Nivel:** 🟢 Básico
**Solución:** [`conversor-temperatura.sh`](conversor-temperatura.sh)

---

## Enunciado

Crea un script llamado `conversor-temperatura.sh` que haga lo siguiente:

1. Muestre un **menú** con tres opciones: convertir de Celsius a Fahrenheit, convertir de Fahrenheit a Celsius y salir.
2. Según la opción elegida, pida una **temperatura** y compruebe que es un número válido (puede ser negativo y tener decimales).
3. Calcule la conversión y muestre el resultado con **dos decimales**.
4. Vuelva al menú hasta que el usuario elija salir.
5. Si la opción del menú no es válida, avise y vuelva a mostrar el menú.

## Ejemplos de salida esperada

**Caso 1: de Celsius a Fahrenheit**

```text
=== Conversor de temperatura ===
1) Celsius a Fahrenheit
2) Fahrenheit a Celsius
3) Salir
Elige una opción: 1
Temperatura en °C: 25
25 °C = 77.00 °F
```

**Caso 2: de Fahrenheit a Celsius**

```text
Elige una opción: 2
Temperatura en °F: 98.6
98.6 °F = 37.00 °C
```

**Caso 3: opción no válida**

```text
Elige una opción: 9
Opción no válida. Inténtalo de nuevo.
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Las fórmulas

| Conversión | Fórmula |
|---|---|
| De Celsius a Fahrenheit | `F = C × 9 / 5 + 32` |
| De Fahrenheit a Celsius | `C = (F − 32) × 5 / 9` |

### 2. Menús con `case`

La instrucción `case` compara una variable con varios valores y ejecuta el bloque que coincida:

```bash
case "$opcion" in
    1) echo "Has elegido uno" ;;
    2) echo "Has elegido dos" ;;
    *) echo "Opción no válida" ;;
esac
```

| Parte | Qué significa |
|---|---|
| `case "$opcion" in` | "Mira el valor de `opcion` y busca cuál de estos casos coincide." |
| `1)` | Un caso concreto. El bloque termina con `;;`. |
| `*)` | "Cualquier otro valor". Se pone al final, como opción por defecto. |
| `esac` | `case` al revés. Cierra la instrucción. |

### 3. Cálculos con decimales: `bc`

Bash solo calcula con números enteros (`$(( ))`). Para decimales se usa el programa `bc`:

```bash
echo "scale=2; 10 / 4" | bc
```

Resultado: `2.50`.

| Parte | Qué significa |
|---|---|
| `echo "..."` | Escribe la operación como texto. |
| `\|` | Envía ese texto al programa siguiente. |
| `bc` | Calcula la operación. |
| `scale=2` | Fija **2 decimales** en el resultado. |

Dos detalles de `bc` que conviene conocer:

- **Recorta, no redondea:** `(100-32)*5/9` da `37.77`, aunque el valor exacto sea `37.777...`.
- **Los resultados menores que 1 salen sin el cero inicial:** `1 / 2` da `.50`. Y si el resultado es exactamente cero, muestra solo `0`.

### 4. Plantilla para números con signo y decimales

```text
^-?[0-9]+(\.[0-9]+)?$
```

| Pieza | Significado |
|---|---|
| `-?` | Un signo menos **opcional**. |
| `[0-9]+` | Uno o más dígitos. |
| `(\.[0-9]+)?` | Una parte decimal **opcional**: un punto seguido de uno o más dígitos. |

Acepta `-40` y `36.6`. Rechaza `3.`, `.5` y `abc`.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `case` | Elegir entre varias opciones de un menú. |
| `bc` y `scale` | Calcular con decimales. |
| `=~` con expresión regular | Validar números con signo y decimales. |
| `while` | Repetir el menú hasta salir y repetir la pregunta hasta tener un dato válido. |
| Tubería `\|` | Pasar la salida de un comando a otro. |

## Cómo ejecutarlo

```bash
chmod +x conversor-temperatura.sh
./conversor-temperatura.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| Opción 1 con `0` | `32.00` |
| Opción 1 con `100` | `212.00` |
| Opción 1 con `-40` | `-40.00` (en -40 las dos escalas coinciden) |
| Opción 1 con `36.6` | `97.88` |
| Opción 2 con `98.6` | `37.00` |
| Opción 2 con `32` | `0` (`bc` muestra solo `0` cuando el resultado es exactamente cero) |
| Opción 2 con `100` | `37.77` (`bc` recorta, no redondea) |
| Temperatura `abc`, `3.` o vacía | Error y vuelve a preguntar |
| Opción `9` o vacía | Aviso de opción no válida y vuelve al menú |
| Opción 3 | Se despide y termina |

## 🎯 Retos extra

- [ ] Mostrar siempre un `0` delante en los resultados menores que 1 (por ejemplo, `0.50` en lugar de `.50`).
- [ ] Añadir una tercera escala: **Kelvin** (`K = C + 273.15`).
- [ ] Redondear el resultado en lugar de recortarlo.

## ✅ Solución

El código resuelto, con comentarios, está en [`conversor-temperatura.sh`](conversor-temperatura.sh).
