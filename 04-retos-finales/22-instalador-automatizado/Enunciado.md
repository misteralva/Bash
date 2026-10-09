# 📝 Ejercicio: Instalador automatizado

**Nivel:** 🔴 Reto final
**Solución:** [`instalador-automatizado.sh`](instalador-automatizado.sh)

---

## Enunciado

Crea un script llamado `instalador-automatizado.sh` que haga lo siguiente:

1. Compruebe que el script se ejecuta con **permisos de administrador**. Si no, avise y termine con código `1`.
2. Compruebe que hay **conexión a Internet** (por ejemplo, con un `ping` a `1.1.1.1`). Si no la hay, aborte.
3. **Actualice** el índice de paquetes (`apt-get update`).
4. **Instale Apache** (`apache2`) solo si **no está ya instalado**. Si ya lo está, avise y continúe (el script debe poder ejecutarse varias veces sin problemas).
5. Cree una **página de inicio** personalizada en `/var/www/html/index.html` con el nombre del equipo y la fecha de la instalación.
6. **Active y arranque** el servicio, y compruebe que está activo.
7. Compruebe con `curl` que el servidor **responde con el código 200**.
8. Registre **cada paso** en un archivo `instalador.log`, con fecha y hora. Si algún paso falla, muestre un mensaje claro, regístrelo y termine con código `1`.
9. Al terminar, muestre un **resumen** con la dirección para visitar la página.

## ⚠️ Antes de empezar

Este script **instala software y modifica el sistema**. Ejecútalo solo en tu entorno de pruebas (Ubuntu en WSL2 o una máquina virtual).

- Necesita **systemd** activado (mira el apartado "Antes de empezar" del ejercicio 19).
- Si ya hay algo escuchando en el **puerto 80** (por ejemplo, otro servidor web), Apache puede no arrancar.
- Desde Windows, con WSL2, podrás ver la página abriendo `http://localhost` en el navegador.
- Para **deshacer** la instalación: `sudo apt-get remove --purge -y apache2`.

Es recomendable haber hecho antes el ejercicio 21, porque aquí **conviene usar funciones**: una por cada paso, más una función `error_salir` para los fallos.

## Ejemplos de salida esperada

```text
$ sudo ./instalador-automatizado.sh
[1/7] Comprobando permisos de administrador... OK
[2/7] Comprobando conexión a Internet... OK
[3/7] Actualizando el índice de paquetes... OK
[4/7] Instalando Apache... OK
[5/7] Creando la página de inicio... OK
[6/7] Activando el servicio... OK
[7/7] Comprobando que el servidor responde... OK (código 200)

Instalación terminada. Visita http://localhost para ver la página.
```

Segunda ejecución (ya instalado):

```text
[4/7] Instalando Apache... ya estaba instalado, se omite
```

Sin Internet:

```text
[2/7] Comprobando conexión a Internet... FALLO
Error: no hay conexión a Internet. Instalación cancelada.
```

Contenido de `instalador.log`:

```text
[2026-10-08 11:02:10] Inicio de la instalación
[2026-10-08 11:02:11] Permisos de administrador: OK
[2026-10-08 11:02:11] Internet: OK
...
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Saber si un paquete está instalado

```bash
dpkg -s apache2 &>/dev/null
```

`dpkg -s` consulta el estado de un paquete y deja un **código de salida**: `0` si está instalado y otro valor si no. Con `&>/dev/null` se oculta lo que escribe:

```bash
if dpkg -s apache2 &>/dev/null; then
    echo "Ya está instalado"
fi
```

Para saber si un **programa** existe en el sistema, otra opción es `command -v nombre`, que también deja un código de salida.

### 2. Instalar sin preguntas

```bash
apt-get install -y apache2
```

La opción `-y` responde "sí" automáticamente a las preguntas de confirmación. Es imprescindible en un script, porque nadie va a estar delante para pulsar la tecla.

### 3. Escribir un archivo de varias líneas: *heredoc*

Para crear un archivo con mucho texto sin escribir un `echo` por línea se usa un **heredoc**:

```bash
nombre="David"
cat > saludo.html <<EOF
<h1>Hola, $nombre</h1>
<p>Año: $(date +%Y)</p>
EOF
```

| Parte | Qué significa |
|---|---|
| `cat > saludo.html` | Escribe en el archivo lo que recibe. |
| `<<EOF` | "Lo que viene a continuación, hasta una línea que diga solo `EOF`, es el contenido." |
| `$nombre` y `$( ... )` | Se **sustituyen** por su valor, como en un texto entre comillas dobles. |

La palabra `EOF` es solo un nombre y puede ser cualquiera, pero la línea de cierre debe estar **sola y sin espacios**. Si se escribe `<<'EOF'` (con comillas), **no** se sustituye nada y el texto se copia tal cual.

### 4. Comprobar que un servidor web responde

```bash
curl -s -o /dev/null -w "%{http_code}" http://localhost
```

| Parte | Qué significa |
|---|---|
| `curl` | Hace una petición web desde la terminal. |
| `-s` | Silencioso: sin barra de progreso. |
| `-o /dev/null` | Descarta el contenido de la página. |
| `-w "%{http_code}"` | Al terminar, escribe solo el **código de respuesta** (200 = correcto, 404 = no encontrado). |

Con `$( ... )` se guarda el código en una variable para poder compararlo con `200`.

### 5. Activar y arrancar un servicio

```bash
systemctl enable --now apache2
```

`enable` hace que el servicio **arranque con el sistema** y `--now` lo **arranca ya**, en un solo comando.

### 6. Registrar y escribir a la vez: `tee -a`

```bash
echo "Instalando Apache" | tee -a instalador.log
```

`tee` escribe el texto **en pantalla y en el archivo** al mismo tiempo. La opción `-a` (*append*) añade al final sin borrar lo anterior.

### 7. Abortar ante un fallo

Una buena práctica es comprobar **cada paso** y, si falla, parar con un mensaje claro. Piensa cómo sería una función `error_salir` que reciba el mensaje, lo muestre en la salida de errores, lo registre y termine con `exit 1`.

### 8. Que se pueda repetir: idempotencia

Un instalador **idempotente** se puede ejecutar varias veces y siempre deja el sistema en el mismo estado, sin errores ni duplicados. Por eso se comprueba antes de instalar y se **sobrescribe** la página en lugar de añadir contenido.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `dpkg -s` y `command -v` | Detectar si algo ya está instalado. |
| `apt-get -y` | Instalar sin intervención. |
| Heredoc (`<<EOF`) | Crear archivos con varias líneas y variables. |
| `curl -w "%{http_code}"` | Comprobar que un servidor responde. |
| `systemctl enable --now` | Activar y arrancar servicios. |
| `tee -a` | Mostrar y registrar a la vez. |
| Funciones y `error_salir` | Estructurar cada paso y gestionar fallos. |
| Idempotencia | Poder ejecutar el script varias veces sin problemas. |

## Cómo ejecutarlo

```bash
chmod +x instalador-automatizado.sh
sudo ./instalador-automatizado.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| Primera ejecución | Instala, crea la página y responde 200 |
| **Segunda ejecución** seguida | Omite la instalación y termina bien |
| Sin `sudo` | Aviso y código de salida `1` |
| Sin conexión a Internet | Aborta con un mensaje claro y código `1` |
| Abrir `http://localhost` en el navegador | Se ve tu página con el nombre del equipo y la fecha |
| Revisar `instalador.log` | Una línea por paso, con fecha y hora |
| Detener Apache y volver a ejecutar | El script lo vuelve a arrancar |
| Comprobar el código de salida con `echo $?` | `0` si todo va bien, `1` si hay un fallo |

## 🎯 Retos extra

- [ ] Permitir elegir entre **Apache** y **Nginx**.
- [ ] Instalar también **PHP** y crear una página de prueba que lo use.
- [ ] Crear un **host virtual** con un dominio de pruebas.
- [ ] Crear un script **desinstalador** que deshaga todo.
- [ ] Añadir un modo `--silencioso` que no muestre nada por pantalla (solo el log).

## ✅ Solución

El código resuelto, con comentarios, está en [`instalador-automatizado.sh`](instalador-automatizado.sh).
