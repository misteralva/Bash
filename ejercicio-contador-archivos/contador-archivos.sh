#!/bin/bash

read -p "Escribe la ruta de un directorio: " ruta


if [ -d $ruta ]; then

	echo El directorio existe: "$ruta"
 
else
	echo El directorio no existe

fi

for i in $ruta/*; do
	echo "Encontrado: $i"
done
