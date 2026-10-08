#!/bin/bash

# 1. Pedir la ruta al usuario y validar que sea un directorio existente
read -p "Escribe la ruta de un directorio: " ruta

while ! [ -d "$ruta" ]; do
    echo "Error: '$ruta' no existe o no es un directorio válido."
    read -p "Escribe la ruta de un directorio: " ruta
done

echo "Directorio: $ruta"
echo "-----------------------------------"

# 2. Mostrar los nombres de los elementos (Reto 2 combinado con find)
echo "--- Archivos encontrados ---"
find "$ruta" -type f

echo ""
echo "--- Carpetas encontradas ---"
# -mindepth 1 evita mostrar la propia carpeta de origen
find "$ruta" -mindepth 1 -type d

echo "-----------------------------------"

# 3. Recuento recursivo con find y wc -l (Reto 3)
# -type f : busca solo archivos
# wc -l   : cuenta el número de líneas que devuelve find
archivos=$(find "$ruta" -type f | wc -l)

# -type d     : busca solo directorios
# -mindepth 1 : no cuenta la carpeta principal ($ruta) como subcarpeta
carpetas=$(find "$ruta" -mindepth 1 -type d | wc -l)

# 4. Mostrar el resultado final
echo "Archivos (total en subcarpetas): $archivos"
echo "Carpetas (subcarpetas totales): $carpetas"
