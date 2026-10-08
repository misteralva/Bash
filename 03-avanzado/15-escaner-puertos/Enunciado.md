# 📝 Ejercicio: Escáner de puertos simple

**Nivel:** 🟠 Avanzado
**Solución:** [`escaner-puertos.sh`](escaner-puertos.sh)

---

## Enunciado

Crea un script llamado `escaner-puertos.sh` que haga lo siguiente:

1. Pida el **equipo** que se quiere comprobar (una IP o un nombre). No puede estar vacío y solo debe contener letras, números, puntos y guiones.
2. Pida una lista de **puertos** separados por espacios. Si el usuario pulsa Enter sin escribir nada, se usan por defecto `22 80 443 8080`.
3. Compruebe que cada puerto es un número entero entre **1 y 65535**. Los que no lo sean se avisan y se **saltan**.
4. Compruebe cada puerto con un **tiempo máximo de 1 segundo** y muestre `ABIERTO` o `CERRADO`.
5. Al terminar, muestre un **resumen** con cuántos puertos están abiertos de los que se han comprobado.

## ⚠️ Antes de empezar

**Escanea solo equipos que sean tuyos o sobre los que tengas permiso expreso.** Explorar los puertos de equipos ajenos puede considerarse un intento de intrusión y es ilegal en muchos países.

Para practicar de forma segura, usa **tu propio equipo** (`127.0.0.1`). Para tener un puerto abierto con el que probar, abre otra terminal y ejecuta:

```bash
python3 -m http.server 8080
```

Este comando arranca un pequeño servidor web en el puerto `8080` de tu equipo. Para detenerlo, pulsa **Ctrl + C** en esa terminal.

## Ejemplos de salida esperada

```text
Equipo a comprobar: 127.0.0.1
Puertos (separados por espacios, Enter para 22 80 443 8080): 22 80 8080 abc
Aviso: 'abc' no es un puerto válido. Se omite.
Comprobando 127.0.0.1...
Puerto 22    CERRADO
Puerto 80    CERRADO
Puerto 8080  ABIERTO
Resumen: 1 puerto abierto de 3 comprobados.
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Comprobar un puerto sin programas extra: `/dev/tcp`

Bash puede abrir una conexión TCP si se escribe en una ruta especial con la forma `/dev/tcp/equipo/puerto`. Si la conexión se establece, el comando tiene éxito. Si el puerto está cerrado, falla:

```bash
timeout 1 bash -c 'echo > /dev/tcp/$1/$2' _ "127.0.0.1" "8080"
```

| Parte | Qué significa |
|---|---|
| `timeout 1` | Cancela el comando si tarda más de **1 segundo**. Sin él, un equipo que no responde podría dejar el script esperando mucho tiempo. |
| `bash -c '...'` | Ejecuta el texto entre comillas simples como un pequeño programa de Bash. |
| `echo > /dev/tcp/$1/$2` | Intenta conectar con el equipo `$1` y el puerto `$2`. |
| `_ "127.0.0.1" "8080"` | Los argumentos que recibe el pequeño programa: `_` ocupa la posición `$0` y los dos siguientes son `$1` y `$2`. |

Como en el ejercicio anterior, se puede usar en un `if`, ocultando la salida con `&>/dev/null`.

**Por qué se pasan como argumentos y no dentro del texto:** si el equipo que escribe el usuario se insertara directamente dentro del texto de `bash -c "..."`, alguien podría escribir `127.0.0.1; rm algo` y ese segundo comando se **ejecutaría**. Pasar los valores como argumentos, además de validarlos, evita ese riesgo. Es un fallo de seguridad muy común, llamado **inyección de comandos**.

### 2. Alternativa: `nc` (netcat)

```bash
nc -z -w 1 127.0.0.1 8080
```

| Parte | Qué significa |
|---|---|
| `-z` | Solo comprueba si el puerto está abierto, sin enviar datos. |
| `-w 1` | Espera como máximo 1 segundo. |

Tiene un código de salida `0` si el puerto está abierto. Puede que `nc` no esté instalado en tu sistema.

### 3. Listas de valores: arrays

Un **array** es una variable que guarda varios valores:

```bash
colores=(rojo verde azul)
echo "${colores[1]}"
echo "${#colores[@]}"
for c in "${colores[@]}"; do
    echo "$c"
done
```

| Parte | Qué significa |
|---|---|
| `(rojo verde azul)` | Crea el array con tres elementos. |
| `${colores[1]}` | El elemento en la posición 1 (se empieza a contar en 0, así que es `verde`). |
| `${#colores[@]}` | **Cuántos** elementos tiene. |
| `"${colores[@]}"` | **Todos** los elementos. Las comillas son importantes. |

Para leer una línea y repartirla en un array:

```bash
read -r -a lista
```

La opción `-a` guarda cada palabra escrita (separadas por espacios) como un elemento del array.

### 4. Validar el equipo y los puertos

- Una plantilla razonable para el equipo: `^[A-Za-z0-9.-]+$`. Piensa qué acepta y qué rechaza (por ejemplo, `127.0.0.1; ls`).
- Para los puertos: comprueba primero que son solo dígitos y después que están entre 1 y 65535. Acuérdate del `10#` por si alguien escribe `080`.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `/dev/tcp` y `timeout` | Comprobar si un puerto acepta conexiones. |
| `bash -c` con argumentos | Evitar la inyección de comandos. |
| Arrays y `read -a` | Manejar una lista de puertos. |
| `for` sobre un array | Recorrer los puertos. |
| Validación con `=~` y rangos | Comprobar host y puertos. |
| Valores por defecto | Usar `22 80 443 8080` si no se escribe nada. |

## Cómo ejecutarlo

```bash
chmod +x escaner-puertos.sh
./escaner-puertos.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| `127.0.0.1` con un servidor en el 8080 | Puerto 8080 `ABIERTO` |
| `127.0.0.1`, puerto sin servidor (por ejemplo, 9999) | `CERRADO` |
| Enter en la lista de puertos | Se comprueban `22 80 443 8080` |
| Puertos `0`, `65536`, `abc`, `-1`, `3.5` | Aviso y se omiten; los válidos se comprueban igual |
| Puerto `080` | Se trata como 80, sin errores |
| Equipo vacío | Error y vuelve a preguntar |
| Equipo `127.0.0.1; ls` | **Rechazado** por la validación |
| Equipo inexistente (`equipo-que-no-existe`) | Todos `CERRADO` (sin quedarse bloqueado) |
| Todos los puertos de la lista no válidos | Resumen con 0 comprobados, sin errores |

## 🎯 Retos extra

- [ ] Aceptar **rangos** de puertos, como `1-1024`.
- [ ] Permitir pasar el equipo y los puertos como **argumentos** del script.
- [ ] Mostrar el **nombre del servicio** habitual de cada puerto abierto (pista: `getent services 80`).
- [ ] Hacer que el **tiempo máximo de espera** se pueda configurar.
- [ ] Guardar el resultado en un archivo con **fecha y hora**.

## ✅ Solución

El código resuelto, con comentarios, está en [`escaner-puertos.sh`](escaner-puertos.sh).
