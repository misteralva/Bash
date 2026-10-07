#!/bin/bash

read -p "Escribe la ruta de un directorio: " ruta

while ! [ -d "$ruta" ]; do
    echo "Error: '$ruta' no existe."
    read -p "Escribe la ruta de un directorio: " ruta


done

echo "Directorio: $ruta"

archivos=0
carpetas=0

for elemento in $ruta/*; do
    if ! [ -e "$elemento" ]; then
        echo "No hay archivos ni carpetas en el directorio."
    fi

    if [ -f "$elemento" ]; then
        archivos=$((archivos + 1))
    elif [ -d "$elemento" ]; then
        carpetas=$((carpetas + 1))
    fi
done


echo "Archivos: $archivos"
echo "Carpetas: $carpetas"


