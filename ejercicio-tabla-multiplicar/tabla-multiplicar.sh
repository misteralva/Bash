#!/bin/bash

read -p "Escribe un número entero: " numero

while ! [[ "$numero" =~ ^[0-9]+$ ]]; do
        echo "Error: '$numero' no es un número entero válido."
        read -p "Escribe un número entero: " numero
done

echo "Tabla del $numero:"
for i in {1..10}; do
    echo "$numero x $i = $((10#$numero * i))"
done