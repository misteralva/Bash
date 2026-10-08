# 🧮 Calculadora Interactiva en Bash (`calculadora.sh`)

**Versión:** 2.0
**Lenguaje:** Bash (Shell de Linux)
**Tipo de programa:** Aplicación de terminal (se usa escribiendo en la pantalla negra de comandos)

---

## 📑 Índice

1. [¿Qué es este programa?](#1-qué-es-este-programa)
2. [Conceptos previos que conviene conocer](#2-conceptos-previos-que-conviene-conocer)
3. [Requisitos para usarlo](#3-requisitos-para-usarlo)
4. [Cómo ejecutar el script](#4-cómo-ejecutar-el-script)
5. [Cómo se usa el programa (ejemplo real)](#5-cómo-se-usa-el-programa-ejemplo-real)
6. [Reglas que debe cumplir el usuario](#6-reglas-que-debe-cumplir-el-usuario)
7. [Explicación del código, parte por parte](#7-explicación-del-código-parte-por-parte)
8. [El archivo de registro (`calculadora.log`)](#8-el-archivo-de-registro-calculadoralog)
9. [Resumen del flujo del programa](#9-resumen-del-flujo-del-programa)
10. [Limitaciones y detalles a tener en cuenta](#10-limitaciones-y-detalles-a-tener-en-cuenta)

---

## 1. ¿Qué es este programa?

`calculadora.sh` es una **calculadora que funciona dentro de la terminal** de Linux. No tiene ventanas ni botones. El usuario interactúa con ella leyendo mensajes en pantalla y escribiendo respuestas con el teclado.

El programa hace lo siguiente:

- Pide al usuario **dos números** al empezar.
- Comprueba que esos números **sean válidos**.
- Muestra un **menú** con operaciones: sumar, restar, multiplicar y dividir.
- Permite **cambiar los números** sin tener que cerrar el programa.
- Guarda un **registro (log)** de todo lo que ocurre en un archivo de texto.

La idea principal de la versión 2.0 es que los números se piden **una sola vez** y se **reutilizan** para todas las operaciones. Así, el usuario no tiene que escribirlos de nuevo cada vez que quiere hacer un cálculo distinto.

---

## 2. Conceptos previos que conviene conocer

Esta sección explica, con palabras simples, algunos términos que aparecen en el código. Si ya los conoce, puede pasar a la siguiente sección.

| Concepto | Explicación sencilla |
|---|---|
| **Terminal** | Una ventana donde se escriben órdenes con el teclado para que el ordenador las ejecute. |
| **Bash** | El "idioma" que entiende la terminal de la mayoría de sistemas Linux. |
| **Script** | Un archivo de texto con una lista de órdenes que el ordenador ejecuta una tras otra. |
| **Variable** | Un "cajón con nombre" donde se guarda un dato. Por ejemplo, `num1` guarda el primer número. |
| **Función** | Un bloque de código con un nombre. Se escribe una vez y se puede usar muchas veces, simplemente llamándolo por su nombre. |
| **Bucle** | Una instrucción que repite un bloque de código varias veces. |
| **`bc`** | Un programa de Linux que sirve para hacer cálculos matemáticos, incluidos los que tienen decimales. |
| **Log (registro)** | Un archivo donde el programa va anotando lo que sucede, como si fuera un diario. |
| **Expresión regular** | Una "plantilla" que sirve para comprobar si un texto tiene una forma concreta (por ejemplo, si parece un número). |

---

## 3. Requisitos para usarlo

Para que el programa funcione se necesita:

1. **Un sistema Linux** (o similar, como macOS o WSL en Windows) que tenga **Bash** instalado.
2. El programa **`bc`** instalado. Para comprobar si ya lo tiene, escriba en la terminal:

   ```bash
   bc --version
   ```

   Si el sistema responde que no lo encuentra, se instala así en Debian, Ubuntu y derivados:

   ```bash
   sudo apt update
   sudo apt install bc
   ```

---

## 4. Cómo ejecutar el script

**Paso 1.** Guarde el código en un archivo llamado `calculadora.sh`.

**Paso 2.** Abra una terminal y vaya a la carpeta donde guardó el archivo. Por ejemplo:

```bash
cd /ruta/de/la/carpeta
```

**Paso 3.** Dé permiso de ejecución al archivo. Por seguridad, Linux no deja ejecutar archivos nuevos hasta que se le indica:

```bash
chmod +x calculadora.sh
```

**Paso 4.** Ejecute el programa:

```bash
./calculadora.sh
```

> 💡 También se puede ejecutar sin dar permisos, escribiendo `bash calculadora.sh`.

---

## 5. Cómo se usa el programa (ejemplo real)

Al iniciar, el programa pide los dos números:

```text
Ingrese el primer número: 10
Ingrese el segundo número: 4
```

Después aparece el menú:

```text
--------------------------------
 Calculadora Bash
 Valores actuales: Num1 = 10 | Num2 = 4
--------------------------------
1) Sumar
2) Restar
3) Multiplicar
4) Dividir
5) Modificar Números
6) Salir
--------------------------------
Seleccione una opción [1-6]: 4
El resultado de la división es: 2.50

Presione Enter para continuar...
```

Al pulsar **Enter**, la pantalla se limpia y el menú vuelve a aparecer. El usuario puede elegir otra operación con los mismos números, cambiar los números (opción 5) o salir (opción 6).

---

## 6. Reglas que debe cumplir el usuario

Cuando el programa pide los números, aplica tres reglas. Si alguna no se cumple, muestra un error y **vuelve a pedir ambos números**.

| Regla | Ejemplo válido | Ejemplo no válido |
|---|---|---|
| Deben ser **números** (enteros o con decimales, usando punto) | `5`, `3.14` | `hola`, `3,14`, `-2` |
| Deben ser **mayores que 0** | `0.5`, `7` | `0`, `0.0` |
| Deben ser **diferentes entre sí** | `3` y `8` | `4` y `4` |

---

## 7. Explicación del código, parte por parte

### 7.1. La primera línea: el "shebang"

```bash
#!/bin/bash
```

Esta línea le indica al sistema que el archivo debe ejecutarse con **Bash**. Siempre va al principio. Se le llama *shebang*.

### 7.2. Los comentarios

```bash
# Script: calculadora.sh versión 2.0
# Descripción: Calculadora interactiva en Bash con reutilización de variables y registro en log.
```

Toda línea que empieza con `#` es un **comentario**. El ordenador la ignora. Sirve para que las personas entiendan el código.

### 7.3. El nombre del archivo de registro

```bash
LOG_FILE="calculadora.log"
```

Se crea una **variable** llamada `LOG_FILE` que guarda el texto `calculadora.log`. Es el nombre del archivo donde se guardará el registro. Al usar una variable, si algún día se quiere cambiar el nombre, solo hay que modificar esta línea.

### 7.4. Reiniciar el registro

```bash
> "$LOG_FILE"
```

El símbolo `>` sirve para **escribir en un archivo**. Si se usa sin ninguna orden delante, el resultado es **vaciar el archivo** (o crearlo si no existe).

Esto significa que **cada vez que se inicia el programa, el registro empieza desde cero**. Los datos de ejecuciones anteriores se borran.

> Las comillas `" "` alrededor de `$LOG_FILE` protegen el nombre por si algún día contiene espacios.

### 7.5. La función `ingresar_numeros`

Esta función se encarga de **pedir los dos números y comprobar que son correctos**.

```bash
ingresar_numeros() {
    while true; do
        read -p "Ingrese el primer número: " num1
        read -p "Ingrese el segundo número: " num2
        ...
    done
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Datos ingresados/modificados: num1=$num1, num2=$num2" >> "$LOG_FILE"
}
```

Vamos por partes:

**`ingresar_numeros() { ... }`**
Así se define una **función**. Todo lo que está entre las llaves `{ }` se ejecuta cuando se escribe el nombre `ingresar_numeros` más adelante en el programa.

**`while true; do ... done`**
Es un **bucle infinito**. Significa "repite esto una y otra vez, para siempre". Se sale de él únicamente con la orden `break`, que aparece cuando todas las comprobaciones se superan.

**`read -p "texto" variable`**
`read` **lee lo que el usuario escribe** y lo guarda en una variable. La opción `-p` (de *prompt*) muestra primero un mensaje en pantalla. Aquí, lo que se escribe se guarda en `num1` y `num2`.

#### Comprobación 1: ¿son números?

```bash
if ! [[ "$num1" =~ ^[0-9]+(\.[0-9]+)?$ ]] || ! [[ "$num2" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    echo "Error: Ingrese números válidos y positivos."
    continue
fi
```

Esta es la línea más compleja. Se explica por piezas:

- `[[ ... =~ ... ]]` comprueba si un texto **cumple una plantilla** (expresión regular).
- `!` significa **"no"**. Invierte el resultado. Es decir, la condición se lee: *"si num1 NO cumple la plantilla..."*.
- `||` significa **"o"**. La condición completa se lee: *"si num1 no es válido, O si num2 no es válido..."*.
- `continue` hace que el bucle **vuelva a empezar** desde arriba, saltándose lo que queda.

La plantilla `^[0-9]+(\.[0-9]+)?$` se descompone así:

| Parte | Significado |
|---|---|
| `^` | Aquí empieza el texto. |
| `[0-9]+` | Uno o más dígitos del 0 al 9. |
| `(\.[0-9]+)?` | Opcionalmente (`?`), un punto seguido de uno o más dígitos. Es la parte decimal. |
| `$` | Aquí termina el texto. |

Con esta plantilla, `12` y `12.5` son válidos. En cambio, `12.`, `.5`, `-3`, `1,5` y `abc` **no** lo son. Como la plantilla no admite el signo `-`, **los números negativos se rechazan en este paso**.

#### Comprobación 2: ¿son mayores que 0?

```bash
if [ "$(echo "$num1 <= 0" | bc)" -eq 1 ] || [ "$(echo "$num2 <= 0" | bc)" -eq 1 ]; then
    echo "Error: Los números deben ser estrictamente positivos (mayores que 0)."
    continue
fi
```

Bash por sí solo **no sabe comparar números con decimales**. Por eso se usa `bc`:

- `echo "$num1 <= 0"` escribe una operación, por ejemplo `0 <= 0`.
- `| bc` (la barra se llama *tubería* o *pipe*) **envía esa operación a `bc`** para que la resuelva.
- `bc` responde `1` si la afirmación es **verdadera** y `0` si es **falsa**.
- `$( ... )` captura esa respuesta para poder usarla.
- `-eq 1` comprueba si la respuesta es igual a 1.

En resumen: *"si num1 es menor o igual que 0, o si num2 es menor o igual que 0, muestra el error"*.

> ℹ️ Como la comprobación 1 ya rechaza los negativos, esta comprobación sirve en la práctica para detectar el **cero** (`0`, `0.0`, `00`, etc.).

#### Comprobación 3: ¿son diferentes?

```bash
if [ "$(echo "$num1 == $num2" | bc)" -eq 1 ]; then
    echo "Error: Los números no pueden ser iguales."
    continue
fi
```

Funciona igual que la anterior, pero comprueba si ambos números son **iguales** (`==`). Como `bc` compara **valores** y no texto, también detecta que `2` y `2.0` son el mismo número.

#### Salir del bucle y guardar en el registro

```bash
    break
done
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Datos ingresados/modificados: num1=$num1, num2=$num2" >> "$LOG_FILE"
```

- `break` **sale del bucle** porque todas las comprobaciones se superaron.
- `date '+%Y-%m-%d %H:%M:%S'` obtiene la fecha y hora actuales con el formato `2025-01-31 14:05:09`.
- `>>` **añade texto al final** de un archivo sin borrar lo anterior. (Recuerde: `>` borra, `>>` añade).

### 7.6. La función `mostrar_menu`

```bash
mostrar_menu() {
    echo "--------------------------------"
    echo "        Calculadora Bash        "
    echo "  Valores actuales: Num1 = $num1 | Num2 = $num2"
    echo "--------------------------------"
    echo "1) Sumar"
    ...
    read -p "Seleccione una opción [1-6]: " opcion
}
```

- `echo` **muestra texto en pantalla**.
- `$num1` y `$num2` se sustituyen por los valores guardados. Así el usuario siempre ve con qué números está trabajando.
- `read -p` pide una opción y la guarda en la variable `opcion`.

### 7.7. Las funciones de operaciones

Hay cuatro funciones: `sumar`, `restar`, `multiplicar` y `dividir`. Todas siguen **la misma estructura de tres pasos**:

```bash
sumar() {
    resultado=$(echo "$num1 + $num2" | bc)
    echo "El resultado de la suma es: $resultado"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Opción: Sumar ($num1 + $num2) = $resultado" >> "$LOG_FILE"
}
```

1. **Calcular:** se envía la operación a `bc` y el resultado se guarda en la variable `resultado`.
2. **Mostrar:** se enseña el resultado en pantalla.
3. **Registrar:** se anota la operación en el archivo log.

La resta (`-`) y la multiplicación (`*`) son idénticas, cambiando solo el símbolo.

#### Caso especial: la división

```bash
resultado=$(echo "scale=2; $num1 / $num2" | bc)
```

`scale=2` le indica a `bc` que muestre **2 decimales** en el resultado. Sin esta instrucción, `bc` haría una división entera y `10 / 4` daría `2` en lugar de `2.50`.

> ✅ **¿Puede haber una división entre cero?** No. Las reglas de validación obligan a que ambos números sean mayores que 0, así que el segundo número nunca será cero.

### 7.8. Primera petición de datos

```bash
ingresar_numeros
```

Esta línea **llama a la función** para pedir los números por primera vez, **antes** de mostrar el menú. Hasta ahora, las funciones solo estaban "definidas" (preparadas). Es aquí donde realmente se ejecuta la primera.

### 7.9. El bucle principal

```bash
while true; do
    mostrar_menu
    case $opcion in
        1) sumar ;;
        2) restar ;;
        3) multiplicar ;;
        4) dividir ;;
        5) ingresar_numeros ;;
        6)
            echo "Saliendo de la calculadora. ¡Hasta luego!"
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] Sesión finalizada por el usuario." >> "$LOG_FILE"
            exit 0
            ;;
        *)
            echo "Opción no válida. Por favor, intente nuevamente."
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] Opción no válida elegida: $opcion" >> "$LOG_FILE"
            ;;
    esac

    echo
    read -p "Presione Enter para continuar..."
    clear
done
```

Este es el **corazón del programa**. Es otro bucle infinito que repite siempre lo mismo:

1. Muestra el menú.
2. Ejecuta la opción elegida.
3. Espera a que el usuario pulse Enter.
4. Limpia la pantalla y vuelve al paso 1.

**La instrucción `case`** funciona como una lista de caminos. Se mira el valor de `opcion` y se ejecuta la parte que coincida:

| Si el usuario escribe... | El programa... |
|---|---|
| `1` | Llama a la función `sumar`. |
| `2` | Llama a la función `restar`. |
| `3` | Llama a la función `multiplicar`. |
| `4` | Llama a la función `dividir`. |
| `5` | Vuelve a llamar a `ingresar_numeros` para cambiar los números. |
| `6` | Se despide, anota el cierre en el log y **termina el programa** con `exit 0`. |
| *cualquier otra cosa* (`*`) | Avisa de que la opción no es válida y lo anota en el log. |

Detalles de sintaxis:

- `;;` marca el **final de cada opción** dentro de `case`.
- `*)` representa **"cualquier otro valor"**. Se coloca al final como opción por defecto.
- `esac` es `case` escrito al revés. Cierra la instrucción.
- `exit 0` termina el programa. El `0` es un código que significa "todo salió bien".
- `echo` solo, sin texto, imprime una **línea en blanco**.
- `clear` **borra la pantalla** de la terminal para que el menú se vea limpio.

---

## 8. El archivo de registro (`calculadora.log`)

Cada acción importante queda guardada con su fecha y hora. Después de una sesión de ejemplo, el archivo podría verse así:

```text
[2025-01-31 14:05:09] Datos ingresados/modificados: num1=10, num2=4
[2025-01-31 14:05:15] Opción: Dividir (10 / 4) = 2.50
[2025-01-31 14:05:22] Opción: Sumar (10 + 4) = 14
[2025-01-31 14:05:30] Opción no válida elegida: 9
[2025-01-31 14:05:41] Sesión finalizada por el usuario.
```

Se registran estos eventos:

- Cuando se introducen o modifican los números.
- Cada operación realizada, con sus valores y su resultado.
- Las opciones del menú que no son válidas.
- El cierre normal del programa.

Para leer el registro desde la terminal se puede usar:

```bash
cat calculadora.log
```

---

## 9. Resumen del flujo del programa

```text
INICIO
  │
  ▼
Vaciar el archivo log
  │
  ▼
Pedir los dos números ◄──────────────┐
  │                                  │
  ▼                                  │
¿Son válidos? ── No → mostrar error ─┘
  │ Sí
  ▼
Guardar en el log
  │
  ▼
┌─► Mostrar menú
│     │
│     ▼
│   Leer opción
│     │
│     ├─ 1, 2, 3, 4 → Calcular, mostrar y registrar
│     ├─ 5          → Volver a pedir los números
│     ├─ 6          → Despedirse y TERMINAR
│     └─ Otra       → Mostrar aviso de opción no válida
│     │
│     ▼
│   Pulsar Enter y limpiar pantalla
└─────┘
```

---

## 10. Limitaciones y detalles a tener en cuenta

- **Solo números positivos.** No se pueden usar números negativos ni el cero.
- **Punto decimal, no coma.** Se debe escribir `3.5`, no `3,5`.
- **El log se borra al iniciar.** No se conserva el historial de ejecuciones anteriores.
- **Cierre brusco.** Si el usuario cierra el programa con `Ctrl + C`, no se anota la línea de "Sesión finalizada" en el log.
- **Decimales en la división.** Se muestran 2 decimales. Además, `bc` omite el cero inicial en resultados menores que 1. Por ejemplo, `1 / 2` se muestra como `.50` y no como `0.50`.
- **Decimales en otras operaciones.** La suma, la resta y la multiplicación conservan los decimales que tengan los números originales, sin redondear.
- **Dependencia de `bc`.** Si `bc` no está instalado, los cálculos y las validaciones de cero e igualdad no funcionarán correctamente.

---
