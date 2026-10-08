# 📝 Ejercicio: Informe de red

**Nivel:** 🟠 Avanzado
**Solución:** [`informe-red.sh`](informe-red.sh)

---

## Enunciado

Crea un script llamado `informe-red.sh` que haga lo siguiente:

1. Muestre un **informe de la configuración de red** del equipo con estos datos: nombre del equipo, **interfaz** principal, **dirección IP**, **prefijo de red** (por ejemplo, `/24`), **puerta de enlace** (*gateway*) y **servidores DNS**.
2. Si hay **varios servidores DNS**, muestre cada uno en su línea.
3. Compruebe si hay **conexión** con la puerta de enlace y con un servidor de Internet (por ejemplo, `1.1.1.1`) y muestre `OK` o `FALLO` para cada uno.
4. Presente la información con un **formato ordenado y alineado**, fácil de leer.
5. Si el equipo no tiene ninguna ruta por defecto (no hay red), debe **avisarlo** en lugar de mostrar datos vacíos.

## ⚠️ Antes de empezar

Si trabajas con **Ubuntu en WSL2**, la red de Linux es una red virtual distinta de la de Windows. Es normal que la IP y la puerta de enlace que veas **no coincidan** con las de tu Windows.

Los valores de los ejemplos son orientativos. Los tuyos serán distintos.

## Ejemplos de salida esperada

```text
=== Informe de red ===
Equipo:            Dabid
Interfaz:          eth0
Dirección IP:      172.20.10.2
Prefijo de red:    /20
Puerta de enlace:  172.20.0.1
Servidores DNS:    10.255.255.254
                   1.1.1.1

Conexión con la puerta de enlace: OK
Conexión con Internet (1.1.1.1):  OK
```

Sin red:

```text
=== Informe de red ===
Equipo:            Dabid
No se ha encontrado ninguna ruta por defecto: el equipo no tiene conexión de red.
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. El comando `ip`

| Comando | Qué muestra |
|---|---|
| `hostname` | El nombre del equipo. |
| `ip -4 -o addr show scope global` | Las direcciones IPv4 de cada interfaz, **una línea por interfaz**. |
| `ip route show default` | La **ruta por defecto**: por dónde sale el tráfico hacia otras redes. |

Una línea de `ip -4 -o addr show scope global` se parece a esta:

```text
2: eth0    inet 172.20.10.2/20 brd 172.20.15.255 scope global eth0\       valid_lft forever preferred_lft forever
```

Y la de la ruta por defecto:

```text
default via 172.20.0.1 dev eth0 proto kernel
```

Ejecuta los comandos en tu equipo y observa en qué **posición** está cada dato.

### 2. Elegir un campo por su posición o por su vecino

`awk` numera los campos de cada línea con `$1`, `$2`, `$3`... Por ejemplo, en la ruta por defecto, la puerta de enlace es el tercer campo:

```bash
echo "default via 172.20.0.1 dev eth0" | awk '{print $3}'
```

Resultado: `172.20.0.1`.

Pero la posición no siempre es fija. Una alternativa es buscar una palabra y mostrar **la siguiente**:

```bash
echo "default via 172.20.0.1 dev eth0" | awk '{for (i=1; i<=NF; i++) if ($i=="dev") print $(i+1)}'
```

Resultado: `eth0`. (`NF` es el número de campos de la línea.)

### 3. Separar la IP del prefijo

La IP viene pegada al prefijo: `172.20.10.2/20`. Se puede separar con estas dos formas:

```bash
dato="192.168.1.5/24"
echo "${dato%/*}"
echo "${dato#*/}"
```

Resultado: `192.168.1.5` y `24`.

| Parte | Qué significa |
|---|---|
| `${dato%/*}` | Quita del **final** todo desde la última `/`. |
| `${dato#*/}` | Quita del **principio** todo hasta la primera `/`. |

### 4. Los servidores DNS

Están en el archivo `/etc/resolv.conf`, en líneas que empiezan por `nameserver`:

```bash
grep '^nameserver' /etc/resolv.conf | awk '{print $2}'
```

La plantilla `^nameserver` selecciona solo las líneas que **empiezan** por esa palabra.

### 5. Alinear el texto

La forma más sencilla de alinear columnas es `printf` con un ancho fijo:

```bash
printf '%-18s %s\n' "Equipo:" "Dabid"
```

| Parte | Qué significa |
|---|---|
| `%-18s` | Un texto, ocupando **18 caracteres** y alineado a la izquierda. |
| `%s` | Otro texto, sin ancho fijo. |
| `\n` | Salto de línea (a diferencia de `echo`, `printf` no lo añade solo). |

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `ip addr` e `ip route` | Obtener la configuración de red. |
| `awk` con campos y `NF` | Extraer IP, interfaz y puerta de enlace. |
| `${variable%patrón}` y `${variable#patrón}` | Separar IP y prefijo. |
| `grep '^patrón'` | Leer los DNS de `/etc/resolv.conf`. |
| `printf` con anchos | Presentar el informe alineado. |
| `ping -c 1 -W 2` | Comprobar la conectividad. |
| Control de errores | Avisar si no hay red. |

## Cómo ejecutarlo

```bash
chmod +x informe-red.sh
./informe-red.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| Equipo con red | Todos los datos rellenados y las dos comprobaciones en `OK` |
| Comparar con `ip addr` y `ip route` a mano | Los datos coinciden |
| Varios servidores DNS | Cada uno en su línea |
| Sin conexión (por ejemplo, desactivando la red) | Aviso claro, sin datos vacíos ni errores |
| Sin acceso a Internet pero con puerta de enlace | Puerta de enlace `OK` e Internet `FALLO` |
| Que las columnas queden alineadas | Los valores empiezan todos en la misma columna |

## 🎯 Retos extra

- [ ] Convertir el prefijo (`/20`) en una **máscara de red** (`255.255.240.0`).
- [ ] Mostrar la **IP pública** del equipo (pista: `curl -s --max-time 3` a un servicio que la devuelva).
- [ ] Mostrar **todas las interfaces** del equipo, no solo la principal.
- [ ] Guardar el informe en un archivo con la **fecha** en el nombre.
- [ ] Generar el informe en formato **HTML**.

## ✅ Solución

El código resuelto, con comentarios, está en [`informe-red.sh`](informe-red.sh).
