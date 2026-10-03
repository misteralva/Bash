#!/bin/bash
# Script: presentacion.sh
# Descripción: Pide el nombre y la edad, comprueba que los datos sean correctos,
#              saluda e indica si la persona es menor de edad, mayor de edad
#              o tiene 65 años o más.

read -p "¿Cómo te llamas? " nombre
while [[ -z "$nombre" ]]; do
    echo "El nombre no puede estar vacío. Por favor, ingresa tu nombre."
    read -p "¿Cómo te llamas? " nombre
done
read -p "¿Cuántos años tienes? " edad
while ! [[ "$edad" =~ ^[0-9]+$ ]]; do
    echo "Por favor, ingresa un número válido para tu edad."
    read -p "¿Cuántos años tienes? " edad
done
echo "Hola, $nombre. Encantado de conocerte."

if [ "$edad" -lt 18 ]; then
    echo "Tienes $edad años, por lo tanto eres menor de edad."
elif [ "$edad" -ge 65 ]; then
    echo "Tienes $edad años, por lo tanto eres mayor de edad y tienes 65 años o más."
else
    echo "Tienes $edad años, por lo tanto eres mayor de edad."
fi
