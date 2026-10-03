#!/bin/bash
# Script: presentacion.sh
# Descripción: Pide el nombre y la edad, comprueba que los datos sean correctos,
#              saluda e indica si la persona es menor de edad, mayor de edad
#              o tiene 65 años o más.

read -p "¿Cómo te llamas? " nombre #Hace la pregunta y guarda la respuesta en la caja nombre.
while [[ -z "$nombre" ]]; do #Es verdadero si la caja está vacía. while[]; do "Mientras se cumpla esto, repite lo de dentro".
    echo "El nombre no puede estar vacío. Por favor, ingresa tu nombre."
    read -p "¿Cómo te llamas? " nombre #Da otra oportunidad. Sin él, el bucle no acabaría nunca.
done #Aquí termina el bucle.
read -p "¿Cuántos años tienes? " edad
while ! [[ "$edad" =~ ^[0-9]+$ ]]; do #	Pregunta: "¿son solo dígitos, de principio a fin?" ! Significa "no". Le da la vuelta a la pregunta. ! [[ ... ]] Se lee: "mientras no sean solo dígitos".
    echo "Por favor, ingresa un número válido para tu edad."
    read -p "¿Cuántos años tienes? " edad
done
echo "Hola, $nombre. Encantado de conocerte."

if [ "$edad" -lt 18 ]; then # ¿La edad es menor que 18? → menor de edad
    echo "Tienes $edad años, por lo tanto eres menor de edad."
elif [ "$edad" -ge 65 ]; then # Si no, ¿es mayor o igual que 65? → 65 o más
    echo "Tienes $edad años, por lo tanto eres mayor de edad y tienes 65 años o más."
else #	Si no ha pasado ninguna de las dos → mayor de edad
    echo "Tienes $edad años, por lo tanto eres mayor de edad."
fi # Fin de la bifurcación


# Herramienta	       Para qué sirve	                      Se parece a...
# while	               Repetir hasta que algo sea correcto	  Una persona que te dice "otra vez, que no lo he entendido"
# if / elif / else	   Elegir un camino entre varios	      Un cruce de caminos con carteles
