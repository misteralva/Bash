# 📝 Ejercicio: Backup programado con cron

**Nivel:** 🔴 Reto final
**Solución:** [`backup-cron.sh`](backup-cron.sh)

---

## Enunciado

Crea un script llamado `backup-cron.sh` que haga lo siguiente:

1. Cree un script **no interactivo** (que no use `read`) que haga una copia de seguridad `.tar.gz` de una carpeta, como en el ejercicio 9. La carpeta de origen y la de destino se definen en **variables al principio** del script (o se reciben como argumentos).
2. Cada copia debe llamarse `backup_NOMBRE_AAAA-MM-DD_HH-MM-SS.tar.gz`.
3. Registre el resultado en un archivo `backup-cron.log`: fecha y hora, **OK** o **ERROR** y, si ha ido bien, el **tamaño** de la copia.
4. Aplique una **rotación**: después de cada copia correcta, conserve solo las **7 copias más recientes** y borre las anteriores.
5. El script debe terminar con código de salida `0` si todo ha ido bien y `1` si ha habido un error (por ejemplo, si el origen no existe).
6. **Programe** la ejecución con `cron` para que se haga **todas las noches a las 02:00**, y deje por escrito la línea de `crontab` utilizada.

## ⚠️ Antes de empezar

- **La rotación borra archivos.** Asegúrate de que solo afecta a las copias que ha creado el script (por ejemplo, limitándolo a `backup_*.tar.gz` dentro de la carpeta de destino). Prueba siempre en una **carpeta de pruebas**.
- En **Ubuntu sobre WSL2**, `cron` puede no estar en marcha. Para arrancarlo: `sudo service cron start` (o, con systemd, `sudo systemctl enable --now cron`). Además, WSL se **apaga** cuando cierras todas las terminales, así que una tarea de las 02:00 solo se ejecutará si WSL está encendido a esa hora. En un servidor real, `cron` funciona siempre.
- Para comprobar que funciona sin esperar a la noche, programa temporalmente la tarea **cada minuto** y luego vuelve a la hora definitiva.

## Ejemplos de salida esperada

Contenido de `backup-cron.log` tras varias ejecuciones:

```text
[2026-10-08 02:00:01] OK: backup_ejercicios-bash_2026-10-08_02-00-01.tar.gz (12K)
[2026-10-09 02:00:01] OK: backup_ejercicios-bash_2026-10-09_02-00-01.tar.gz (12K)
[2026-10-10 02:00:01] ERROR: la carpeta de origen no existe
```

Línea de `crontab` (se muestra con `crontab -l`):

```text
0 2 * * * /home/david/ejercicios-bash/backup-cron.sh
```

Carpeta de destino tras 10 días de copias (con rotación de 7):

```text
backup_ejercicios-bash_2026-10-04_02-00-01.tar.gz
backup_ejercicios-bash_2026-10-05_02-00-01.tar.gz
...
backup_ejercicios-bash_2026-10-10_02-00-01.tar.gz
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Qué es `cron`

`cron` es el **programador de tareas** de Linux: ejecuta comandos automáticamente en las horas que se le indican. Las tareas de cada usuario se guardan en su **crontab**:

| Comando | Qué hace |
|---|---|
| `crontab -e` | **Edita** tu lista de tareas. |
| `crontab -l` | **Muestra** tu lista de tareas. |
| `crontab -r` | **Borra** toda tu lista (¡cuidado!). |

### 2. La sintaxis: cinco campos y un comando

```text
┌──────── minuto (0-59)
│ ┌────── hora (0-23)
│ │ ┌──── día del mes (1-31)
│ │ │ ┌── mes (1-12)
│ │ │ │ ┌ día de la semana (0-7; el 0 y el 7 son domingo)
│ │ │ │ │
* * * * *  comando a ejecutar
```

El `*` significa "cualquier valor". Ejemplos:

| Línea | Cuándo se ejecuta |
|---|---|
| `0 2 * * *` | Todos los días a las 02:00. |
| `*/5 * * * *` | Cada 5 minutos. |
| `* * * * *` | **Cada minuto** (útil para probar). |
| `30 3 * * 1` | Los lunes a las 03:30. |
| `0 */6 * * *` | Cada 6 horas, en punto. |

### 3. Los problemas típicos de `cron`

`cron` no ejecuta las tareas como lo harías tú en tu terminal:

- **No está en tu carpeta de trabajo.** Todas las rutas deben ser **absolutas** (`/home/david/...`), tanto la del script como las que use dentro. Una ruta relativa fallará.
- **Tiene un `PATH` muy reducido**, así que algunos comandos pueden no encontrarse. Si ocurre, usa su ruta completa (puedes averiguarla con `command -v nombre`).
- **No hay nadie delante.** El script no puede usar `read` ni esperar una respuesta.
- **No ves lo que escribe.** Por eso se guarda la salida en un archivo, añadiendo `>> /ruta/salida.log 2>&1` al final de la línea (esto envía tanto la salida normal como los errores al archivo).

### 4. La rotación de copias

Para quedarse con las 7 más recientes hay que **listar las copias de la más nueva a la más antigua** y borrar las que pasen de la séptima:

```bash
ls -1t carpeta/backup_*.tar.gz | tail -n +8
```

| Parte | Qué significa |
|---|---|
| `ls -1t` | `-1` escribe **un nombre por línea** y `-t` ordena por fecha, de **más nueva a más antigua**. |
| `tail -n +8` | Muestra desde la **octava línea** hasta el final, es decir, **todo salvo las 7 primeras**. |

Esa lista son los archivos que sobran. Piensa cómo recorrerla con un bucle `while read -r` y borrar cada uno con `rm`, y qué pasa si en la carpeta hay menos de 8 copias.

### 5. Un script preparado para funcionar solo

- Ninguna pregunta al usuario.
- Variables de configuración al principio, fáciles de cambiar.
- Todo lo importante queda en el log.
- Código de salida claro (`0` correcto, `1` error), porque `cron` y otras herramientas lo usan para saber si ha ido bien.
- Reutiliza lo que ya sabes del ejercicio 9: `tar -czf`, `date`, `basename` y la comprobación del resultado.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `cron` y `crontab` | Programar tareas automáticas. |
| Sintaxis de 5 campos | Indicar cuándo se ejecuta cada tarea. |
| Rutas absolutas | Que el script funcione desde `cron`. |
| `>> archivo 2>&1` | Capturar la salida y los errores de una tarea automática. |
| `ls -1t` y `tail -n +N` | Elegir qué copias antiguas borrar. |
| Códigos de salida | Informar de si la tarea ha ido bien. |
| `tar`, `date` y `basename` | Crear las copias con nombre y fecha. |

## Cómo ejecutarlo

```bash
chmod +x backup-cron.sh
./backup-cron.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| Ejecutar el script a mano | Crea la copia y añade una línea `OK` al log |
| Origen que no existe | Línea `ERROR` en el log y código de salida `1` |
| Ejecutarlo 10 veces seguidas (con fechas distintas) | Quedan solo las **7 más recientes** |
| Ejecutarlo desde otra carpeta (`cd / && /ruta/completa/backup-cron.sh`) | Funciona igual (rutas absolutas) |
| Ejecutarlo sin teclado (`./backup-cron.sh < /dev/null`) | Funciona igual (sin `read`) |
| `crontab -l` | Aparece la línea de las 02:00 |
| Tarea programada **cada minuto** (para probar) | El log crece cada minuto |
| Con menos de 7 copias en la carpeta | La rotación no borra nada y no da error |
| Otros archivos en la carpeta de destino | No se tocan (solo `backup_*.tar.gz`) |

## 🎯 Retos extra

- [ ] Evitar que se **solapen** dos ejecuciones (pista: un archivo de bloqueo, o `flock`).
- [ ] **Comprobar la integridad** de cada copia al terminar (pista: `tar -tzf`).
- [ ] Recibir el **número de copias a conservar** como argumento.
- [ ] Hacer **copias semanales** además de las diarias, con otra rotación.
- [ ] Enviar un **aviso** si una copia falla (por ejemplo, escribiendo en un archivo especial de alertas).

## ✅ Solución

El código resuelto, con comentarios, está en [`backup-cron.sh`](backup-cron.sh).
