# 📝 Ejercicio: Menú de administración completo

**Nivel:** 🔴 Reto final
**Solución:** [`menu-administracion.sh`](menu-administracion.sh)

---

## Enunciado

Crea un script llamado `menu-administracion.sh` que haga lo siguiente:

1. Cree un **menú principal** con estas opciones: **1)** información del sistema (CPU, RAM y disco), **2)** comprobar equipos con `ping`, **3)** copia de seguridad de una carpeta, **4)** gestionar usuarios, **5)** comprobar servicios y **6)** salir.
2. Cada opción debe estar escrita en su propia **función**. No hace falta empezar de cero: **adapta tus soluciones** de los ejercicios 16, 14, 9, 10 y 19, convirtiéndolas en funciones.
3. Cree una función `registrar` que reciba un mensaje y lo guarde, con **fecha y hora**, en un archivo `admin.log`. Cada acción del menú debe quedar registrada.
4. Las opciones que necesitan **permisos de administrador** deben comprobarlo y, si no se tienen, **avisar sin cerrar el programa**.
5. Después de cada acción, espere a que el usuario pulse Enter y **limpie la pantalla** antes de volver al menú.
6. Controle las **opciones no válidas**. Al salir, registre el cierre de la sesión y termine con código de salida `0`.
7. El programa principal (el bucle del menú) debe estar **al final del script** y limitarse a llamar a las funciones.

## ⚠️ Antes de empezar

Este ejercicio **reúne** los anteriores, así que conviene haber hecho antes los ejercicios 9, 10, 14, 16 y 19, o al menos tener claras sus ideas. Algunas opciones modifican el sistema (copias, usuarios, servicios): **pruébalas solo en tu entorno de pruebas**.

## Ejemplos de salida esperada

```text
=============================
   MENÚ DE ADMINISTRACIÓN
=============================
1) Información del sistema
2) Comprobar equipos (ping)
3) Copia de seguridad
4) Gestionar usuarios
5) Comprobar servicios
6) Salir
-----------------------------
Elige una opción: 1

--- Información del sistema ---
CPU:   12 %
RAM:   46 %
Disco: 47 %

Pulsa Enter para continuar...
```

Opción que necesita permisos, sin ejecutar con `sudo`:

```text
Elige una opción: 4
Esta opción necesita permisos de administrador (ejecuta el script con sudo).

Pulsa Enter para continuar...
```

Contenido de `admin.log` tras estas acciones:

```text
[2026-10-08 10:15:02] Sesión iniciada
[2026-10-08 10:15:09] Opción 1: información del sistema
[2026-10-08 10:15:20] Opción 4: rechazada, sin permisos de administrador
[2026-10-08 10:15:31] Sesión finalizada
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Funciones

Una **función** es un bloque de código con nombre que se escribe una vez y se puede usar muchas veces:

```bash
saludar() {
    local nombre="$1"
    echo "Hola, $nombre"
}

saludar "David"
```

Resultado: `Hola, David`.

| Parte | Qué significa |
|---|---|
| `saludar() { ... }` | **Define** la función. Hasta que no se llama, no se ejecuta nada. |
| `saludar "David"` | **Llama** a la función, pasándole un argumento. |
| `$1` dentro de la función | El **primer argumento de la función** (no del script). |
| `local nombre` | Crea una variable que **solo existe dentro de la función** y no pisa otras variables con el mismo nombre. |

**Una función debe estar definida antes de llamarla.** Por eso, en el script, primero van todas las funciones y al final el programa principal.

### 2. Funciones que dicen "sí" o "no"

Una función devuelve el **código de salida de su última orden**, igual que cualquier comando. Así se pueden usar directamente en un `if`:

```bash
es_par() {
    [ $(( $1 % 2 )) -eq 0 ]
}

if es_par 4; then
    echo "El 4 es par"
fi
```

Con `return` se puede fijar el código de forma explícita (`return 0` es éxito y `return 1` es fallo). A diferencia de `exit`, **`return` solo sale de la función**; `exit` termina el script entero.

### 3. Una función para el registro

Si todas las acciones usan la misma función `registrar`, el formato del log es siempre el mismo, y si un día quieres cambiarlo, solo hay que tocar un sitio. Piensa qué recibe (el mensaje) y qué hace (añadir una línea con fecha a `admin.log`).

### 4. Organización del script

Una estructura clara es:

```text
1. Variables de configuración (nombre del log, etc.)
2. Funciones auxiliares (registrar, es_root, pausar...)
3. Una función por cada opción del menú
4. Una función mostrar_menu
5. Programa principal: el bucle que llama a las demás
```

Cada función debería hacer **una sola cosa**.

### 5. Reutilizar código de otros archivos: `source`

Si prefieres no copiar las funciones, Bash puede cargar otro archivo como si estuviera escrito en este:

```bash
source ./utilidades.sh
```

Es una alternativa para repartir el código en varios archivos. En este ejercicio es opcional.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| Funciones (`nombre() { ... }`) | Dividir el programa en partes reutilizables. |
| `$1` y `local` | Pasar datos a una función sin pisar variables. |
| `return` frente a `exit` | Salir de una función o del script. |
| `case` | Gestionar el menú. |
| `clear` y `read -p` | Pausar y limpiar la pantalla. |
| Log centralizado | Registrar todas las acciones con el mismo formato. |
| `$EUID` | Comprobar permisos de administrador. |
| Reutilización de código | Integrar soluciones de ejercicios anteriores. |

## Cómo ejecutarlo

```bash
chmod +x menu-administracion.sh
sudo ./menu-administracion.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| Elegir cada opción del 1 al 5 | Ejecuta la función correcta y registra la acción en el log |
| Opción `9`, texto o Enter vacío | Aviso de opción no válida y vuelve al menú |
| Opción 4 **sin** `sudo` | Aviso de permisos, **sin cerrar** el programa |
| Opción 6 | Registra el cierre y termina con código `0` |
| Revisar `admin.log` | Una línea por acción, con fecha y hora |
| Ejecutar varias sesiones seguidas | El log **crece** (no se sobrescribe) |
| Volver al menú tras cada acción | La pantalla se limpia y el menú reaparece |

## 🎯 Retos extra

- [ ] Añadir **colores** al menú (pista: investiga `tput`).
- [ ] Crear **submenús** (por ejemplo, dentro de usuarios: crear, listar, eliminar).
- [ ] Permitir ejecutar una opción **directamente por argumento** (por ejemplo, `./menu-administracion.sh info`).
- [ ] Añadir una opción `--help` que muestre la ayuda.
- [ ] Mostrar un mensaje de despedida al pulsar **Ctrl + C** (pista: investiga `trap`).
- [ ] Leer los valores de configuración (umbrales, rutas) desde un **archivo aparte**.

## ✅ Solución

El código resuelto, con comentarios, está en [`menu-administracion.sh`](menu-administracion.sh).
