#!/bin/bash

# ==============================================================================
# SCRIPT 1: Contador Básico de Archivos y Carpetas
# Descripción: Pide una ruta por teclado, valida que exista y cuenta únicamente 
#              el contenido visible directo del directorio.
# ==============================================================================

# 1. Pedir la ruta de un directorio al usuario
read -p "Escribe la ruta de un directorio: " ruta

# Bucle while: repite la pregunta mientras la ruta NO sea un directorio válido (! -d)
while ! [ -d "$ruta" ]; do
    echo "Error: '$ruta' no existe."
    read -p "Escribe la ruta de un directorio: " ruta
done

echo "Directorio: $ruta"

# Inicializamos los contadores a cero
archivos=0
carpetas=0

# 2. Recorremos únicamente los elementos visibles dentro del directorio
for elemento in "$ruta"/*; do
    # Si la carpeta estuviera vacía, comprueba que el objeto exista realmente
    if ! [ -e "$elemento" ]; then
        echo "No hay archivos ni carpetas en el directorio."
    fi

    # Comprobamos el tipo de objeto e incrementamos el contador correspondiente
    if [ -f "$elemento" ]; then
        archivos=$((archivos + 1))       # -f : es un archivo normal
    elif [ -d "$elemento" ]; then
        carpetas=$((carpetas + 1))       # -d : es un directorio / carpeta
    fi
done

# 3. Mostramos el resultado
echo "Archivos: $archivos"
echo "Carpetas: $carpetas"
