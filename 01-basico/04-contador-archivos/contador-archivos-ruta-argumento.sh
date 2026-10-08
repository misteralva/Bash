#!/bin/bash

# ==============================================================================
# SCRIPT 4: Búsqueda Recursiva y Argumento por Línea de Comandos (Retos 3 y 4)
# Descripción: Permite pasar la ruta como argumento ($1) o la pide por teclado.
#              Cuenta todo el contenido (archivos y subcarpetas) de forma recursiva.
# ==============================================================================

# Capturamos el primer argumento posicional ($1) al ejecutar el script
ruta=$1

# Si no se ha pasado ningún argumento (-z evalúa si la variable está vacía)
if [ -z "$ruta" ]; then
    read -p "Escribe la ruta de un directorio: " ruta
fi

# Validamos que la ruta capturada exista y sea un directorio
while ! [ -d "$ruta" ]; do
    echo "Error: '$ruta' no existe o no es un directorio válido."
    read -p "Escribe la ruta de un directorio: " ruta
done

echo "Directorio: $ruta"
echo "-----------------------------------"

# Listamos todos los archivos encontrados de forma recursiva
echo "--- Archivos encontrados ---"
find "$ruta" -type f

echo ""
# Listamos todas las subcarpetas (-mindepth 1 evita incluir la carpeta inicial $ruta)
echo "--- Carpetas encontradas ---"
find "$ruta" -mindepth 1 -type d

echo "-----------------------------------"

# Recuento recursivo conectando 'find' con 'wc -l' (cuenta las líneas devueltas)
archivos=$(find "$ruta" -type f | wc -l)
carpetas=$(find "$ruta" -mindepth 1 -type d | wc -l)

# Mostramos el resultado final
echo "Archivos (total en subcarpetas): $archivos"
echo "Carpetas (subcarpetas totales): $carpetas"
