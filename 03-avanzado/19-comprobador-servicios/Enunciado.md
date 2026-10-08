# 📝 Ejercicio: Comprobador de servicios

**Nivel:** 🟠 Avanzado
**Solución:** [`comprobador-servicios.sh`](comprobador-servicios.sh)

---

## Enunciado

Crea un script llamado `comprobador-servicios.sh` que haga lo siguiente:

1. Defina en el script una **lista de servicios** a vigilar (por ejemplo, `ssh`, `cron` y `apache2`).
2. Para cada servicio, distinga entre tres estados: **no instalado**, **activo** o **inactivo**, y muestre el resultado.
3. Si un servicio está **inactivo**, pregunte si se desea **reiniciarlo** (`s/n`). Si la respuesta es `s`, reinícielo y compruebe después si ha arrancado.
4. Si el script **no se ejecuta como administrador**, no debe fallar: debe avisar de que para reiniciar servicios hacen falta permisos.
5. Al terminar, muestre un **resumen** con cuántos servicios están activos, inactivos y no instalados.

## ⚠️ Antes de empezar

Este ejercicio necesita **systemd**, el sistema que gestiona los servicios en Linux. En Ubuntu sobre WSL2 puede venir desactivado. Para comprobarlo:

```bash
ps -p 1 -o comm=
```

Si la respuesta es `systemd`, todo está listo. Si no, hay que activarlo editando `/etc/wsl.conf`:

```bash
sudo nano /etc/wsl.conf
```

Con este contenido:

```text
[boot]
systemd=true
```

Después, desde **PowerShell** de Windows, reinicia WSL con `wsl --shutdown` y vuelve a abrir Ubuntu.

Para probar el reinicio, **detén un servicio inofensivo** que no necesites, por ejemplo `sudo systemctl stop cron`, y deja que tu script lo detecte y lo arranque. **No detengas servicios que no conozcas.**

## Ejemplos de salida esperada

```text
$ sudo ./comprobador-servicios.sh
Comprobando servicios...
ssh       ACTIVO
cron      INACTIVO
apache2   NO INSTALADO

El servicio 'cron' está inactivo. ¿Quieres reiniciarlo? (s/n): s
Reiniciando 'cron'...
'cron' arrancado correctamente.

Resumen: 2 activos, 0 inactivos, 1 no instalado.
```

Sin permisos de administrador:

```text
El servicio 'cron' está inactivo. ¿Quieres reiniciarlo? (s/n): s
Para reiniciar servicios hacen falta permisos de administrador (usa sudo).
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Saber si un servicio está activo

```bash
systemctl is-active --quiet cron
```

| Parte | Qué significa |
|---|---|
| `systemctl` | La herramienta que gestiona los servicios. |
| `is-active` | Pregunta si el servicio está funcionando. |
| `--quiet` | No escribe nada: solo deja el **código de salida** (`0` si está activo). |

Por eso se puede usar directamente en un `if`:

```bash
if systemctl is-active --quiet cron; then
    echo "cron está activo"
fi
```

### 2. Distinguir "inactivo" de "no instalado"

`is-active` devuelve error tanto si el servicio está **parado** como si **no existe**. Para diferenciarlos hace falta una segunda comprobación. Investiga el comando:

```bash
systemctl list-unit-files "cron.service"
```

Ejecútalo con un servicio que exista y con otro que no, y observa qué muestra en cada caso. Después piensa cómo detectar la diferencia con un `grep -q` (que no escribe nada y solo deja el código de salida).

### 3. Otras acciones de `systemctl`

| Comando | Qué hace |
|---|---|
| `sudo systemctl restart nombre` | Reinicia el servicio (necesita permisos). |
| `sudo systemctl start nombre` | Lo arranca. |
| `sudo systemctl stop nombre` | Lo detiene. |
| `systemctl is-enabled nombre` | Indica si arranca automáticamente con el sistema. |

### 4. Listas de servicios: arrays

```bash
servicios=(ssh cron apache2)
for s in "${servicios[@]}"; do
    echo "Servicio: $s"
done
```

`(ssh cron apache2)` crea un array, y `"${servicios[@]}"` es la lista de **todos** sus elementos.

### 5. Esperar un momento: `sleep`

Después de reiniciar un servicio puede tardar unos instantes en estar activo. `sleep 2` pausa el script durante 2 segundos antes de volver a comprobar.

### 6. Comprobar si se es administrador

Ya viste que `$EUID` vale `0` para `root`:

```bash
if [ "$EUID" -eq 0 ]; then
    echo "Soy administrador"
fi
```

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `systemctl is-active --quiet` | Saber si un servicio funciona. |
| `systemctl list-unit-files` con `grep -q` | Detectar si un servicio está instalado. |
| Arrays y `for` | Recorrer la lista de servicios. |
| `sleep` | Dar tiempo al servicio para arrancar. |
| `$EUID` | Comprobar si se tienen permisos de administrador. |
| Contadores | Elaborar el resumen. |
| Confirmación `s/n` | Evitar reinicios no deseados. |

## Cómo ejecutarlo

```bash
chmod +x comprobador-servicios.sh
sudo ./comprobador-servicios.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| Servicio activo (`ssh` o `cron`) | `ACTIVO` |
| Servicio instalado y detenido | `INACTIVO` y pregunta si reiniciar |
| Servicio que no existe (`apache2` sin instalar) | `NO INSTALADO`, sin intentar reiniciarlo |
| Reiniciar con `s` | Se reinicia y se confirma que está activo |
| Responder `n` | No se reinicia |
| Ejecutar **sin** `sudo` con un servicio inactivo | Aviso de permisos, sin errores |
| Cambiar la lista de servicios en el script | El script funciona con cualquier lista |
| Resumen final | Los tres números suman el total de servicios |

## 🎯 Retos extra

- [ ] Recibir los servicios como **argumentos** o desde un **archivo**.
- [ ] Registrar los resultados, con fecha, en un **log**.
- [ ] Añadir una opción `--auto` que **reinicie sin preguntar**.
- [ ] Mostrar también si cada servicio **arranca con el sistema** (pista: `is-enabled`).
- [ ] Presentar los resultados en una **tabla alineada** con `printf`.

## ✅ Solución

El código resuelto, con comentarios, está en [`comprobador-servicios.sh`](comprobador-servicios.sh).
