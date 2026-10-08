# 📝 Ejercicio: Adivina el número

**Nivel:** 🟡 Intermedio
**Solución:** [`adivina-numero.sh`](adivina-numero.sh)

---

## Enunciado

Crea un script llamado `adivina-numero.sh` que haga lo siguiente:

1. El script elige un **número aleatorio entre 1 y 100** y no lo muestra.
2. Pide al usuario que lo adivine y comprueba que lo escrito es un **número entero entre 1 y 100**. Si no lo es, avisa y vuelve a preguntar (ese intento **no cuenta**).
3. Después de cada intento válido, indica si el número secreto es **más alto** o **más bajo**.
4. Cuando el usuario acierta, muestra **cuántos intentos** ha necesitado y termina.

## Ejemplos de salida esperada

```text
He pensado un número entre 1 y 100. ¡Adivínalo!
Tu intento: 50
Más alto.
Tu intento: 75
Más bajo.
Tu intento: abc
Error: introduce un número entero entre 1 y 100.
Tu intento: 63
¡Correcto! Lo has conseguido en 3 intentos.
```

Observa que el intento `abc` no se cuenta: los intentos válidos son `50`, `75` y `63`.

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Números aleatorios: `$RANDOM`

Bash tiene una variable especial, `RANDOM`, que da un número entero aleatorio entre 0 y 32767 cada vez que se lee. Combinada con el resto de una división (`%`) se puede limitar a un rango:

```bash
echo $((RANDOM % 6 + 1))
```

Simula una tirada de dado.

| Parte | Qué significa |
|---|---|
| `RANDOM` | Un número aleatorio entre 0 y 32767. |
| `% 6` | El resto de dividir entre 6: da un valor entre 0 y 5. |
| `+ 1` | Desplaza el rango: ahora va de 1 a 6. |

Piensa qué cuentas necesitas para obtener un valor entre 1 y 100.

### 2. Bucle infinito con salida: `while true` y `break`

Cuando no se sabe cuántas vueltas habrá, se usa un bucle que se repite siempre y se rompe desde dentro:

```bash
while true; do
    read -p "Escribe 'salir': " texto
    if [ "$texto" = "salir" ]; then
        break
    fi
done
```

| Parte | Qué significa |
|---|---|
| `while true` | "Repite para siempre". `true` es un comando que siempre tiene éxito. |
| `break` | Sale inmediatamente del bucle. |

### 3. Un contador de intentos

Una variable que empieza en 0 y sube de uno en uno cada vez que ocurre algo:

```bash
contador=0
contador=$((contador + 1))
```

Piensa **en qué punto exacto** del bucle debe sumarse, para que los intentos no válidos no cuenten.

### 4. Comprobar un rango

Para saber si un número está entre dos límites se combinan dos comparaciones con `&&` ("y"):

```bash
if [ "$n" -ge 1 ] && [ "$n" -le 10 ]; then
    echo "Está entre 1 y 10"
fi
```

### 5. Cuidado con los ceros a la izquierda

Si el usuario escribe `08`, Bash lo trata como un número octal y puede dar error. Ya conoces la solución: el prefijo `10#` dentro de `$(( ))`. Piensa en qué comparaciones necesitas aplicarlo.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `$RANDOM` y `%` | Generar un número aleatorio dentro de un rango. |
| `while true` y `break` | Repetir hasta que ocurra algo concreto. |
| Contadores | Contar los intentos del usuario. |
| `-ge`, `-le`, `-lt`, `-gt` y `&&` | Comprobar rangos y comparar con el número secreto. |
| Validación con `=~` | Aceptar solo números enteros. |
| `10#` | Evitar el problema de los ceros a la izquierda. |

## Cómo ejecutarlo

```bash
chmod +x adivina-numero.sh
./adivina-numero.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| Intentar `1` y `100` | Se aceptan como válidos (los límites cuentan) |
| Intentar `0` y `101` | Error y vuelve a preguntar, sin contar intento |
| Intentar `abc`, `3.5` o vacío | Error y vuelve a preguntar, sin contar intento |
| Intentar `08` | Se trata como 8, sin errores |
| Acertar a la primera | Termina con `1 intento` (o el texto equivalente) |
| Varios intentos con alguno inválido en medio | Los inválidos no suman al total |
| Ejecutar el script varias veces | El número secreto cambia |

## 🎯 Retos extra

- [ ] Limitar a **7 intentos** como máximo. Si se agotan, mostrar el número secreto y terminar.
- [ ] Permitir elegir la **dificultad** (rango de 1 a 10, 1 a 100 o 1 a 1000).
- [ ] Preguntar al final si se quiere **jugar otra vez** (`s/n`).
- [ ] Escribir bien el singular y el plural: `1 intento` frente a `3 intentos`.

## ✅ Solución

El código resuelto, con comentarios, está en [`adivina-numero.sh`](adivina-numero.sh).
