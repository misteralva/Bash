# 📝 Ejercicio: Paso de parámetros

**Nivel:** 🟡 Intermedio
**Solución:** [`paso-parametros.sh`](paso-parametros.sh)

---

## Enunciado

Crea un script llamado `paso-parametros.sh` que haga lo siguiente:

1. El script no pide nada por teclado: recibe **tres argumentos** al ejecutarlo, con el formato `./paso-parametros.sh NUM1 OPERACION NUM2`.
2. Las operaciones válidas son `suma`, `resta`, `multiplicacion` y `division` (esta última, **entera**).
3. Compruebe que se han recibido **exactamente tres argumentos**, que los dos números son **enteros no negativos** y que la operación es válida.
4. **Rechace la división entre 0.**
5. Si algo falla, muestre un **mensaje de uso** explicando cómo se ejecuta el script, escríbalo en la **salida de errores** y termine con código de salida `1`.
6. Si todo es correcto, muestre el resultado con el formato `NUM1 operacion NUM2 = RESULTADO` y termine con código `0`.

## Ejemplos de salida esperada

```text
$ ./paso-parametros.sh 8 suma 3
8 suma 3 = 11

$ ./paso-parametros.sh 7 division 2
7 division 2 = 3

$ ./paso-parametros.sh 5 division 0
Error: no se puede dividir entre 0.

$ ./paso-parametros.sh 5
Uso: ./paso-parametros.sh NUM1 OPERACION NUM2
     Operaciones: suma, resta, multiplicacion, division

$ ./paso-parametros.sh 5 potencia 2
Error: operación no válida.
Uso: ./paso-parametros.sh NUM1 OPERACION NUM2
     Operaciones: suma, resta, multiplicacion, division
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Argumentos de un script

Todo lo que se escribe después del nombre del script al ejecutarlo se llama **argumentos**. Bash los guarda en variables especiales:

| Variable | Contiene |
|---|---|
| `$0` | El nombre del propio script. |
| `$1`, `$2`, `$3`... | El primer, segundo y tercer argumento. |
| `$#` | **Cuántos** argumentos se han recibido. |
| `$@` | **Todos** los argumentos. |

Ejemplo con un script llamado `saludo.sh`:

```bash
#!/bin/bash
echo "Script: $0"
echo "Número de argumentos: $#"
echo "Primero: $1"
```

Al ejecutar `./saludo.sh hola mundo`, se muestra:

```text
Script: ./saludo.sh
Número de argumentos: 2
Primero: hola
```

### 2. Comprobar el número de argumentos

```bash
if [ "$#" -ne 3 ]; then
    echo "Faltan o sobran argumentos"
fi
```

### 3. Códigos de salida

Todo programa termina con un **código de salida**: `0` significa "todo ha ido bien" y cualquier otro número significa "ha habido un error". Se fija con `exit`:

```bash
exit 1
```

Después de ejecutar un script, se consulta el último código con:

```bash
echo $?
```

### 4. Escribir en la salida de errores

Los mensajes de error se envían a un canal distinto del normal, la **salida de errores**, con `>&2`:

```bash
echo "Algo ha salido mal" >&2
```

Así, si alguien redirige la salida normal a un archivo, los errores siguen apareciendo en pantalla.

### 5. Por qué no se usan los símbolos `+`, `-` y `*`

Si se ejecutara `./script.sh 3 * 4`, el intérprete sustituiría el `*` por la lista de archivos de la carpeta antes de llamar al script. Por eso el ejercicio usa **palabras** para las operaciones. (Existe una forma de evitarlo escribiendo `'*'` entre comillas, que puedes usar en un reto extra.)

### 6. Reutiliza lo que ya sabes

Ya tienes las piezas para validar números (`=~`), elegir según un valor (`case`), hacer cálculos (`$(( ))`) y evitar el problema de los ceros iniciales (`10#`).

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `$1`, `$2`, `$3`, `$#`, `$0` | Leer los argumentos del script. |
| `exit` y `$?` | Terminar con un código de salida y consultarlo. |
| `>&2` | Escribir mensajes en la salida de errores. |
| `case` con palabras | Elegir la operación. |
| `=~` | Validar que los argumentos son números. |
| `$(( ))` | Hacer las cuatro operaciones. |
| `10#` | Evitar el problema de los ceros iniciales. |

## Cómo ejecutarlo

```bash
chmod +x paso-parametros.sh
./paso-parametros.sh 8 suma 3
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| `8 suma 3` | `8 suma 3 = 11`, código `0` |
| `8 resta 3` | `8 resta 3 = 5` |
| `8 multiplicacion 3` | `8 multiplicacion 3 = 24` |
| `7 division 2` | `7 division 2 = 3` |
| `5 division 0` | Error: no se puede dividir entre 0, código `1` |
| Sin argumentos o con solo uno | Mensaje de uso, código `1` |
| Cuatro argumentos | Mensaje de uso, código `1` |
| `abc suma 3` | Error: no es un número, código `1` |
| `5 potencia 2` | Error: operación no válida, código `1` |
| `08 suma 01` | `08 suma 01 = 9`, sin errores |
| Comprobar el código con `echo $?` tras cada caso | `0` si todo va bien, `1` si hay error |

## 🎯 Retos extra

- [ ] Aceptar también los símbolos `+`, `-`, `x` y `'/'` (pista: el asterisco hay que escribirlo entre comillas).
- [ ] Admitir números **negativos**.
- [ ] Admitir números **decimales** (pista: `bc`).
- [ ] Aceptar **más de dos números** en la suma (`./paso-parametros.sh suma 1 2 3 4`).
- [ ] Añadir una opción `--help` que muestre la ayuda.

## ✅ Solución

El código resuelto, con comentarios, está en [`paso-parametros.sh`](paso-parametros.sh).
