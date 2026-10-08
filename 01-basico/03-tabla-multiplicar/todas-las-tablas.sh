#!/bin/bash
# Script: todas-las-tablas.sh
# Descripción: Muestra seguidas las tablas de multiplicar del 1 al 10,
#              cada una con su título y separadas por una línea en blanco.

# Bucle exterior: "tabla" toma los valores del 1 al 10 (una tabla por vuelta).
for tabla in {1..10}; do

    echo "Tabla del $tabla:"

    # Bucle interior: "i" recorre los multiplicadores del 1 al 10.
    # Por cada vuelta del bucle exterior, este bucle se ejecuta completo.
    # No hace falta "10#" porque los números no los escribe el usuario
    # y nunca empiezan por cero.
    for i in {1..10}; do
        echo "$tabla x $i = $((tabla * i))"
    done

    # Línea en blanco para separar una tabla de la siguiente.
    echo

done
