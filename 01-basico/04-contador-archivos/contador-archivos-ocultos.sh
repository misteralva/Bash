#!/bin/bash

# ==============================================================================
# SCRIPT 2: Recuento de Archivos Visibles y Ocultos (Reto 1)
# Descripción: Incluye en el recuento los elementos ocultos (.*) ignorando
#              los punteros de sistema '.' (actual) y '..' (padre).
# ==============================================================================

read -p "Escribe la ruta de un directorio: " ruta

while ! [ -d "$ruta" ]; do
    echo "Error: '$ruta' no existe."
    read -p "Escribe la ruta de un directorio: " ruta
done

echo "Directorio: $ruta"

archivos=0
carpetas=0

# Usamos dos patrones: "$ruta"/* (visibles) y "$ruta"/.* (ocultos)
for elemento in "$ruta"/* "$ruta"/.*; do
    
    # Ignoramos la propia carpeta actual ($ruta/.) y la carpeta padre ($ruta/..)
    if [ "$elemento" = "$ruta/." ] || [ "$elemento" = "$ruta/.." ]; then
        continue  # Salta a la siguiente iteración del bucle
    fi

    # Clasificación de elementos
    if [ -f "$elemento" ]; then
        archivos=$((archivos + 1))
    elif [ -d "$elemento" ]; then
        carpetas=$((carpetas + 1))
    fi
done

echo "Archivos: $archivos"
echo "Carpetas: $carpetas"
