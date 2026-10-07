# 📝 Ejercicio: Renombrador masivo

**Nivel:** 🟡 Intermedio
**Solución:** [`renombrador-masivo.sh`](renombrador-masivo.sh)

---

## Enunciado

Crea un script llamado `renombrador-masivo.sh` que haga lo siguiente:

1. Pida una **carpeta** y compruebe que existe y es un directorio.
2. Pida la **extensión actual** de los archivos (sin el punto, por ejemplo `txt`) y la **extensión nueva** (por ejemplo `md`). Ninguna puede estar vacía y deben ser distintas.
3. **Renombre** todos los archivos de esa carpeta que tengan la extensión actual, cambiándola por la nueva, y muestre cada cambio (`antiguo -> nuevo`).
4. Si el nombre nuevo **ya existe**, no debe sobrescribirlo: avisa y salta ese archivo.
5. Al terminar, muestre cuántos archivos se han **renombrado** y cuántos se han **omitido**.

## ⚠️ Antes de empezar

Este script cambia nombres de archivos reales. Prueba siempre en una **carpeta de pruebas**, no en tus carpetas de trabajo. Puedes crearla así:

```bash
mkdir ~/prueba && cd ~/prueba
touch a.txt b.txt "c d.txt" e.log
```

`touch` crea archivos vacíos. Las comillas de `"c d.txt"` sirven para crear un nombre con un espacio.

## Ejemplos de salida esperada

```text
Carpeta: /home/david/prueba
Extensión actual (sin punto): txt
Extensión nueva (sin punto): md
a.txt -> a.md
b.txt -> b.md
c d.txt -> c d.md
Resumen: 3 renombrados, 0 omitidos.
```

**Caso con un nombre ya ocupado** (suponiendo que ya existe `a.md`):

```text
Aviso: 'a.md' ya existe. Se omite 'a.txt'.
b.txt -> b.md
Resumen: 1 renombrados, 1 omitidos.
```

> Las cifras y los textos de los ejemplos son orientativos. El texto exacto de los mensajes es libre, siempre que el comportamiento sea el descrito.

## Conceptos clave

### 1. Recorrer los archivos con una extensión

El comodín `*` sustituye "cualquier nombre". Con una variable en la extensión:

```bash
for archivo in "$carpeta"/*."$ext"; do
    echo "Encontrado: $archivo"
done
```

Cuidado con dos detalles:

- Si **no hay ningún archivo** con esa extensión, el `*` no se sustituye y la variable recibe el texto literal del patrón. Conviene comprobar que el elemento existe de verdad (por ejemplo, con `-f`).
- Las comillas alrededor de `"$carpeta"` y `"$ext"` evitan problemas con nombres con espacios.

### 2. Quitar el final de un texto: `${variable%patrón}`

```bash
archivo="foto.jpg"
echo "${archivo%.jpg}"
echo "${archivo%.jpg}.png"
```

Resultado: `foto` y `foto.png`.

| Parte | Qué significa |
|---|---|
| `${archivo%.jpg}` | El contenido de `archivo` **sin** el `.jpg` del final. |
| `%` | "Quita del **final** lo que coincida". (El `#` hacía lo mismo, pero por el principio). |

### 3. Mover y renombrar: `mv`

`mv origen destino` mueve un archivo. Si el destino está en la misma carpeta, en la práctica **lo renombra**. Con la opción `-n` (*no clobber*) no sobrescribe archivos existentes, aunque aquí conviene comprobarlo tú mismo para poder mostrar un aviso.

### 4. Solo el nombre, sin la ruta: `basename`

```bash
basename /home/david/prueba/a.txt
```

Resultado: `a.txt`. Sirve para mostrar los cambios sin la ruta completa.

## Conceptos que se practican

| Concepto | Para qué sirve |
|---|---|
| `for` con comodín `*` | Recorrer archivos de una extensión. |
| `${variable%patrón}` | Quitar la extensión antigua. |
| `mv` | Renombrar archivos. |
| `-e` y `-f` | Detectar nombres ya ocupados y archivos que existen de verdad. |
| `basename` | Mostrar solo el nombre del archivo. |
| Contadores | Contar renombrados y omitidos. |
| Comillas en variables | Admitir nombres con espacios. |

## Cómo ejecutarlo

```bash
chmod +x renombrador-masivo.sh
./renombrador-masivo.sh
```

`chmod +x` da permiso de ejecución al archivo (solo hace falta una vez).

## 🧪 Casos que se deben probar

| Caso | Resultado esperado |
|---|---|
| Carpeta con 3 archivos `.txt` | 3 renombrados |
| Extensión sin ningún archivo coincidente | 0 renombrados, con un mensaje claro (y sin errores raros) |
| Archivo con espacios (`c d.txt`) | Se renombra bien |
| Nombre nuevo que ya existe | Se omite y se avisa |
| Extensión actual igual a la nueva | Error |
| Extensión vacía | Error y vuelve a preguntar |
| Extensión con punto (`.txt`) | Rechazada o normalizada, a tu elección |
| Carpeta que no existe | Error y vuelve a preguntar |

## 🎯 Retos extra

- [ ] Añadir un **modo simulación**: mostrar qué se renombraría sin cambiar nada y pedir confirmación antes de hacerlo de verdad.
- [ ] Permitir añadir un **prefijo o sufijo** a los nombres.
- [ ] Convertir los nombres a **minúsculas** (pista: `${variable,,}`).
- [ ] **Numerar** los archivos (`foto_001`, `foto_002`...).
- [ ] Guardar un registro para poder **deshacer** los cambios.

## ✅ Solución

El código resuelto, con comentarios, está en [`renombrador-masivo.sh`](renombrador-masivo.sh).
