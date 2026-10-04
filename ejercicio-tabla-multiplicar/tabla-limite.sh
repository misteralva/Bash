#!/bin/bash
# Script: tabla-limite.sh
# Descripción: Pide un número entero y un límite, comprueba que ambos sean
#              válidos y muestra la tabla de multiplicar desde el 1 hasta
#              el límite indicado.

# --- 1. Pedir el número y comprobar que es válido ---
read -p "Escribe un número entero: " numero
while ! [[ "$numero" =~ ^[0-9]+$ ]]; do
    echo "Error: '$numero' no es un número entero válido."
    read -p "Escribe un número entero: " numero
done

# --- 2. Pedir el límite y comprobar que es válido ---
# Plantilla: ceros opcionales al principio (0*), después una cifra del 1 al 9
# y, por último, más dígitos opcionales. Así se acepta 5, 12 o 08, pero se
# rechaza el 0 (una tabla que llegara hasta 0 no mostraría ninguna operación).
read -p "¿Hasta qué número quieres la tabla? " limite
while ! [[ "$limite" =~ ^0*[1-9][0-9]*$ ]]; do
    echo "Error: '$limite' no es un límite válido (debe ser un entero de 1 o más)."
    read -p "¿Hasta qué número quieres la tabla? " limite
done

# --- 3. Mostrar la tabla hasta el límite ---
# {1..$limite} no funciona porque Bash expande las llaves antes de sustituir
# las variables. Por eso se usa el "for" de tres partes: (inicio; condición; avance).
#   i=1          -> inicio: i empieza valiendo 1
#   i<=10#$limite -> condición: se repite mientras i no supere el límite
#   i++          -> avance: al terminar cada vuelta, i aumenta en 1
# "10#" evita que valores como 08 se lean como octales, tanto en el límite
# como en el número.
echo "Tabla del $numero hasta el $limite:"
for (( i=1; i<=10#$limite; i++ )); do
    echo "$numero x $i = $((10#$numero * i))"
done