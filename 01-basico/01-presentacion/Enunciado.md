# 📝 Ejercicio: Presentación personalizada

**Nivel:** 🟢 Básico
**Solución:** [`presentacion.sh`](presentacion.sh)

---

## Enunciado

Crea un script llamado `presentacion.sh` que haga lo siguiente:

1. Pida al usuario su **nombre**.
2. Pida al usuario su **edad**.
3. Muestre un **saludo** con el nombre.
4. Indique si la persona es **mayor de edad** (18 años o más) o **menor de edad**.

## Ejemplos de salida esperada

**Caso 1: persona mayor de edad**

```text
¿Cómo te llamas? Laura
¿Cuántos años tienes? 25
Hola, Laura. Encantado de conocerte.
Tienes 25 años, por lo tanto eres mayor de edad.
```

**Caso 2: persona menor de edad**

```text
¿Cómo te llamas? Marc
¿Cuántos años tienes? 15
Hola, Marc. Encantado de conocerte.
Tienes 15 años, por lo tanto eres menor de edad.
```

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `#!/bin/bash` | Indicar que el archivo es un script de Bash. |
| `read -p` | Pedir un dato al usuario y mostrar un mensaje. |
| Variables | Guardar el nombre y la edad. |
| `echo` | Mostrar texto en pantalla. |
| `if / else` | Tomar una decisión según una condición. |
| `-ge`, `-lt` | Comparar números (mayor o igual, menor que). |

## Cómo ejecutarlo

```bash
chmod +x presentacion.sh
./presentacion.sh
```

| Parte | Qué significa |
|---|---|
| `chmod +x` | Da permiso de ejecución al archivo (solo hace falta una vez). |
| `./presentacion.sh` | Ejecuta el script que está en la carpeta actual. |

## 🎯 Retos extra

- [ ] Validar que la edad sea un **número** (si el usuario escribe `abc`, mostrar un error).
- [ ] Añadir un tercer caso: si la edad es **65 o más**, mostrar un mensaje distinto.
- [ ] Si el nombre se deja **vacío**, volver a preguntarlo.

## ✅ Solución

El código resuelto, con comentarios, está en [`presentacion.sh`](presentacion.sh).
