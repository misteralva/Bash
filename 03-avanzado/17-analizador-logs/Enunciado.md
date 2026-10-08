# 📝 Ejercicio: Analizador de logs

**Nivel:** 🟠 Avanzado
**Solución:** [`analizador-logs.sh`](analizador-logs.sh)

---

## Enunciado

Crea un script llamado `analizador-logs.sh` que haga lo siguiente:

1. Reciba como **argumento** la ruta de un archivo de log de SSH (`./analizador-logs.sh auth-ejemplo.log`). Si no se indica, el archivo no existe o no se puede leer, muestre un mensaje de uso y termine con código `1`.
2. Cuente los **intentos fallidos** de acceso (líneas que contienen `Failed password`).
3. Cuente los **accesos correctos** (líneas que contienen `Accepted password`).
4. Muestre las **5 direcciones IP con más intentos fallidos**, ordenadas de mayor a menor, con el número de intentos de cada una.

## ⚠️ Antes de empezar

Un servidor real guarda estos registros en `/var/log/auth.log`, pero en Ubuntu sobre WSL normalmente **ese archivo no existe**. Por eso, la carpeta del ejercicio incluye un archivo de ejemplo, `auth-ejemplo.log`, con este contenido:

```text
Oct  3 10:15:01 servidor sshd[1234]: Failed password for root from 203.0.113.5 port 52341 ssh2
Oct  3 10:15:09 servidor sshd[1234]: Failed password for invalid user admin from 203.0.113.5 port 52345 ssh2
Oct  3 10:15:17 servidor sshd[1236]: Failed password for root from 203.0.113.5 port 52350 ssh2
Oct  3 10:16:02 servidor sshd[1301]: Accepted password for david from 192.168.1.20 port 40222 ssh2
Oct  3 10:17:45 servidor sshd[1355]: Failed password for invalid user test from 198.51.100.7 port 33010 ssh2
Oct  3 10:17:52 servidor sshd[1355]: Failed password for invalid user oracle from 198.51.100.7 port 33014 ssh2
Oct  3 10:18:30 servidor sshd[1402]: Failed password for root from 203.0.113.5 port 52360 ssh2
Oct  3 10:19:11 servidor sshd[1450]: Failed password for ana from 192.0.2.44 port 45100 ssh2
Oct  3 10:19:19 servidor sshd[1450]: Accepted password for ana from 192.168.1.35 port 45110 ssh2
Oct  3 10:20:05 servidor sshd[1500]: Failed password for root from 198.51.100.7 port 33020 ssh2
Oct  3 10:20:13 servidor sshd[1500]: Failed password for root from 198.51.100.7 port 33022 ssh2
Oct  3 10:21:40 servidor sshd[1555]: Failed password for invalid user admin from 203.0.113.5 port 52370 ssh2
Oct  3 10:22:02 servidor sshd[1601]: Failed password for ana from 192.0.2.44 port 45120 ssh2
Oct  3 10:23:15 servidor sshd[1650]: Failed password for root from 203.0.113.99 port 60001 ssh2
Oct  3 10:24:00 servidor sshd[1700]: Accepted password for david from 192.168.1.20 port 40230 ssh2
Oct  3 10:25:10 servidor sshd[1750]: Connection closed by 203.0.113.5 port 52380 [preauth]
Oct  3 10:25:33 servidor CRON[1800]: pam_unix(cron:session): session opened for user root
```

Son direcciones inventadas (de rangos reservados para documentación). Fíjate en que algunas líneas tienen `invalid user` y que hay líneas que **no** son intentos fallidos pero sí contienen una IP.

## Ejemplos de salida esperada

Con el archivo de ejemplo, el resultado debe ser:

```text
Archivo analizado: auth-ejemplo.log
Intentos fallidos: 12
Accesos correctos: 3
Top 5 IPs con más intentos fallidos:
  5  203.0.113.5
  4  198.51.100.7
  2  192.0.2.44
  1  203.0.113.99
```

Solo hay cuatro IPs distintas con intentos fallidos, así que la lista muestra cuatro.

```text
$ ./analizador-logs.sh
Uso: ./analizador-logs.sh ARCHIVO_DE_LOG
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Contar líneas que contienen un texto

```bash
grep -c "Failed password" auth-ejemplo.log
```

La opción `-c` (*count*) muestra **cuántas líneas** coinciden, en lugar de mostrarlas.

### 2. Extraer solo una parte de la línea

```bash
echo "Failed password for root from 203.0.113.5 port 52341" | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}'
```

Resultado: `203.0.113.5`.

| Parte | Qué significa |
|---|---|
| `-o` | Muestra **solo la parte que coincide**, no la línea entera. |
| `-E` | Permite usar plantillas ampliadas (como `{1,3}`). |
| `[0-9]{1,3}` | Entre 1 y 3 dígitos. |
| `(\.[0-9]{1,3}){3}` | Un punto y otros 1 a 3 dígitos, **repetido 3 veces**. |

Es una plantilla que reconoce direcciones IPv4. No comprueba que cada número sea menor que 256, pero es suficiente para este ejercicio.

### 3. Contar repeticiones y ordenarlas

La combinación más útil de este ejercicio es una **cadena de tuberías**. Con otro ejemplo:

```bash
printf 'pera\nmanzana\npera\nuva\npera\nmanzana\n' | sort | uniq -c | sort -rn
```

Resultado:

```text
      3 pera
      2 manzana
      1 uva
```

| Paso | Qué hace |
|---|---|
| `sort` | Ordena las líneas alfabéticamente, para que las repetidas queden **juntas**. |
| `uniq -c` | Agrupa las líneas **consecutivas** repetidas y escribe cuántas hay delante. |
| `sort -rn` | Ordena por ese número: `-n` (numérico) y `-r` (de mayor a menor). |
| `head -5` | (Se añade al final) Se queda solo con las 5 primeras líneas. |

**Por qué hace falta el primer `sort`:** `uniq` solo junta líneas repetidas que estén **seguidas**. Si no se ordena antes, cuenta mal:

```bash
printf 'pera\nmanzana\npera\n' | uniq -c
```

Mostraría `pera` dos veces por separado.

### 4. El orden de los filtros importa

Una IP puede aparecer en líneas que **no** son intentos fallidos (por ejemplo, `Connection closed by 203.0.113.5`). Si se extraen las IPs de todo el archivo, ese equipo saldría con **6** intentos en lugar de **5**. Piensa **qué filtro debe ir primero** para que solo se cuenten las líneas relevantes.

### 5. Comprobar el archivo

Ya conoces `-f` (existe y es un archivo normal). Para saber si se puede leer existe `-r`.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `$1` y `$#` | Recibir el archivo como argumento. |
| `-f` y `-r` | Comprobar que el archivo existe y se puede leer. |
| `grep -c` | Contar líneas que coinciden. |
| `grep -oE` | Extraer solo las direcciones IP. |
| `sort \| uniq -c \| sort -rn \| head` | Contar repeticiones y sacar un ranking. |
| Tuberías encadenadas | Combinar varios comandos pequeños. |

## Cómo ejecutarlo

```bash
chmod +x analizador-logs.sh
./analizador-logs.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| `auth-ejemplo.log` | 12 fallidos, 3 correctos, ranking como el del ejemplo |
| IP `203.0.113.5` en el ranking | Debe salir con **5** intentos (no 6) |
| Sin argumentos | Mensaje de uso y código `1` |
| Archivo que no existe | Error claro y código `1` |
| Archivo vacío | 0 fallidos, 0 correctos y ranking vacío, sin errores |
| Archivo sin ningún intento fallido | El ranking no muestra IPs, sin errores |
| Una ruta con espacios | Funciona igual |

## 🎯 Retos extra

- [ ] Mostrar también los **usuarios más atacados** (pista: investiga `sed` o `awk` para quedarte con el nombre que aparece tras `for`).
- [ ] Mostrar un **aviso** si alguna IP supera un número determinado de intentos (por ejemplo, 5).
- [ ] Permitir **filtrar por hora** (por ejemplo, solo las líneas de las 10:20 a las 10:25).
- [ ] Guardar el informe en un archivo con **fecha** en el nombre.
- [ ] Probarlo con el archivo real `/var/log/auth.log` de un servidor (necesita `sudo`).

## ✅ Solución

El código resuelto, con comentarios, está en [`analizador-logs.sh`](analizador-logs.sh).
