# 📝 Ejercicio: Monitor del sistema

**Nivel:** 🟠 Avanzado
**Solución:** [`monitor-sistema.sh`](monitor-sistema.sh)

---

## Enunciado

Crea un script llamado `monitor-sistema.sh` que haga lo siguiente:

1. Muestre la **fecha y hora** actuales y el **porcentaje de uso** de tres recursos: **CPU**, **memoria RAM** y **disco** (la partición raíz `/`).
2. Defina al principio del script unos **umbrales** de alerta en variables: por ejemplo, disco por encima del **90 %**, RAM por encima del **80 %** y CPU por encima del **85 %**.
3. Si un recurso supera su umbral, muestre un **aviso** claro en pantalla.
4. Guarde cada aviso en un archivo `monitor.log`, con la fecha y la hora, **añadiendo** al final (sin borrar lo anterior).
5. Muestre los valores como **números enteros** (sin decimales).

## ⚠️ Antes de empezar

Para comprobar que las alertas funcionan sin esperar a que el disco se llene de verdad, **baja temporalmente los umbrales** (por ejemplo, disco al 1 %). Así el script debe avisar siempre.

## Ejemplos de salida esperada

**Sin alertas**

```text
=== Monitor del sistema ===
Fecha: 2026-10-07 18:30:45
CPU:   12 %
RAM:   46 %
Disco: 47 %
Todo en orden.
```

**Con alertas**

```text
=== Monitor del sistema ===
Fecha: 2026-10-07 18:31:10
CPU:   92 %
RAM:   46 %
Disco: 93 %
ALERTA: la CPU supera el 85 % (92 %).
ALERTA: el disco supera el 90 % (93 %).
```

Y en `monitor.log` queda:

```text
[2026-10-07 18:31:10] ALERTA: CPU al 92 % (umbral 85 %)
[2026-10-07 18:31:10] ALERTA: disco al 93 % (umbral 90 %)
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Quedarse con una columna: `awk`

`awk` divide cada línea en campos (separados por espacios) y permite elegir cuáles mostrar:

```bash
echo "uno dos tres" | awk '{print $2}'
```

Resultado: `dos`. También se puede elegir **una línea concreta** con `NR` (número de línea):

```bash
printf 'Cabecera\nvalor1 valor2\n' | awk 'NR==2 {print $2}'
```

Resultado: `valor2`. Y elegir una línea por su **contenido**:

```bash
free -m | awk '/Mem:/ {print $2, $3}'
```

Muestra los campos 2 y 3 de la línea que contiene `Mem:`.

### 2. Dónde están los datos

| Recurso | Comando | Qué mirar |
|---|---|---|
| Disco | `df /` | La columna **Use%** de la segunda línea. Viene con el símbolo `%` pegado (por ejemplo, `47%`). |
| Memoria | `free -m` | En la línea `Mem:`, las columnas de total y usada (en megabytes). El porcentaje se calcula. |
| CPU | `top -bn1` | La línea que empieza por `%Cpu`. El campo `id` es el porcentaje **inactivo**; el uso es `100 - id`. |

Para la CPU hay otra opción: usar la **carga media** del último minuto (`/proc/loadavg`) en relación con el número de núcleos (`nproc`). Elige la que prefieras y justifícala en un comentario.

Ejecuta cada comando en tu equipo y mira su salida antes de decidir cómo extraer el dato: **el formato puede variar** según el sistema y el idioma (por ejemplo, algunos sistemas usan coma decimal).

### 3. Quitar el símbolo `%` y los decimales

```bash
valor="93%"
echo "${valor%\%}"
```

Resultado: `93`. Con `%\%` se quita un `%` del final (la barra invertida indica que es el símbolo literal).

```bash
valor="37.8"
echo "${valor%.*}"
```

Resultado: `37`. Con `%.*` se quita desde el último punto hasta el final. Es una forma sencilla de pasar a **enteros**, porque Bash no sabe comparar números con decimales.

### 4. Calcular un porcentaje

Con enteros: `$(( usada * 100 / total ))`. Piensa qué pasa con el orden de las operaciones y por qué conviene **multiplicar antes de dividir**.

### 5. Fecha y hora para el log

```bash
date '+%Y-%m-%d %H:%M:%S'
```

Y para añadir una línea al final de un archivo: `echo "texto" >> archivo.log`.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `awk` con `NR` y patrones | Extraer datos de la salida de otros comandos. |
| `df`, `free`, `top` | Obtener el uso de disco, memoria y CPU. |
| `${variable%patrón}` | Quitar el `%` y los decimales. |
| Variables de configuración | Definir umbrales al principio del script. |
| Aritmética con `$(( ))` | Calcular porcentajes. |
| `date` y `>>` | Registrar alertas con fecha en un log. |
| `if` con `-gt` | Comparar valores con umbrales. |

## Cómo ejecutarlo

```bash
chmod +x monitor-sistema.sh
./monitor-sistema.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| Ejecución normal | Muestra tres valores enteros entre 0 y 100 |
| Umbral de disco bajado a 1 | Aviso de disco en pantalla y en `monitor.log` |
| Los tres umbrales bajados a 1 | Tres avisos |
| Ejecutarlo varias veces seguidas | `monitor.log` va **creciendo** (no se sobrescribe) |
| Comparar con `df -h /` y `free -m` | Los porcentajes coinciden |
| Si no hay alertas | No se escribe nada en el log |

## 🎯 Retos extra

- [ ] Permitir indicar los **umbrales como argumentos** del script.
- [ ] Repetir la comprobación **cada 5 segundos** hasta pulsar Ctrl + C (pista: `while true` y `sleep`).
- [ ] Mostrar una **barra visual** de uso, por ejemplo `[#####-----]`.
- [ ] Mostrar los **3 procesos** que más memoria consumen (pista: `ps` y `sort`).
- [ ] Mostrar un mensaje de despedida al pulsar Ctrl + C (pista: investiga `trap`).

## ✅ Solución

El código resuelto, con comentarios, está en [`monitor-sistema.sh`](monitor-sistema.sh).
