#!/bin/bash
# Script: par-impar.sh
# Descripción: Pide números enteros (positivos o negativos), comprueba que sean
#              válidos e indica si son pares o impares. El 0 tiene un mensaje
#              especial. Repite el proceso mientras el usuario quiera continuar.

# Variable que controla el bucle principal. Empieza en "s" para que el bucle
# se ejecute siempre la primera vez, sin tener que repetir el código antes.
continuar="s"

while [[ "$continuar" == "s" ]]; do

    # --- 1. Pedir el número y comprobar que es válido ---
    # Plantilla: un "-" opcional al principio (el "?" lo hace opcional),
    # seguido de uno o más dígitos. Acepta 8, -4 o 007, pero rechaza abc, 3.5 o "-".
    read -p "Escribe un número entero: " numero
    while ! [[ "$numero" =~ ^-?[0-9]+$ ]]; do
        echo "Error: '$numero' no es un número entero válido."
        read -p "Escribe un número entero: " numero
    done

    # --- 2. Quitar el signo "-" si lo tiene ---
    # ${numero#-} devuelve el contenido de la variable sin un "-" al principio.
    # Esto sirve porque la paridad no depende del signo (-4 y 4 son pares) y
    # porque "10#" solo funciona si va pegado a los dígitos, no a un signo.
    sin_signo="${numero#-}"

    # --- 3. Decidir: 0, par o impar ---
    # El 0 se comprueba primero porque también es par: si no, nunca llegaría
    # a su mensaje especial. Al llegar al "elif", el número ya no puede ser 0.
    if [ "$sin_signo" -eq 0 ]; then
        echo "El número $numero es par, y además es un número muy especial."

    # Resto de dividir entre 2. "10#" obliga a Bash a leer el número en base 10,
    # para que valores como 08 o 09 no den error al tomarse como octales.
    elif [ $((10#$sin_signo % 2)) -eq 0 ]; then
        echo "El número $numero es par."

    else
        echo "El número $numero es impar."
    fi

    # --- 4. Preguntar si se quiere repetir ---
    # La respuesta se guarda en "continuar". Con cualquier valor distinto de "s",
    # la condición del while deja de cumplirse y el bucle termina.
    read -p "¿Desea continuar? (s/n): " continuar
done

echo "Fin."
