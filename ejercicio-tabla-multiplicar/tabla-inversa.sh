#!/bin/bash
# Script: tabla-inversa.sh
# Descripción: Pide un número entero, comprueba que sea válido y muestra
#              su tabla de multiplicar del 10 al 1 (orden inverso).

# --- 1. Pedir el número y comprobar que es válido ---
# La plantilla exige que el texto esté formado solo por dígitos.
read -p "Escribe un número entero: " numero
while ! [[ "$numero" =~ ^[0-9]+$ ]]; do
    echo "Error: '$numero' no es un número entero válido."
    read -p "Escribe un número entero: " numero
done

# --- 2. Mostrar la tabla de mayor a menor ---
# {10..1} es un rango que empieza en 10 y baja hasta 1.
# "10#" obliga a Bash a leer el número en base 10, para que valores como
# 08 o 010 no se interpreten como octales (base 8) y den error o un
# resultado equivocado.
echo "Tabla del $numero (de mayor a menor):"
for i in {10..1}; do
    echo "$numero x $i = $((10#$numero * i))"
done