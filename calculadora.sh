#!/bin/bash

# Script: calculadora.sh versión 2.0
# Descripción: Calculadora interactiva en Bash con reutilización de variables y registro en log.

LOG_FILE="calculadora.log"

# Requisito c): Reiniciar el archivo log cada vez que se inicie el script
> "$LOG_FILE"

# Requisito a) y b): Pedir números al inicio y validar las reglas
ingresar_numeros() {
    while true; do
        read -p "Ingrese el primer número: " num1
        read -p "Ingrese el segundo número: " num2

        # Validar que sean numéricos (enteros o decimales)
        if ! [[ "$num1" =~ ^[0-9]+(\.[0-9]+)?$ ]] || ! [[ "$num2" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
            echo "Error: Ingrese números válidos y positivos."
            continue
        fi

        # Regla b): Deben ser positivos (mayores que 0)
        # bc devuelve 1 si la condición es verdadera, 0 si es falsa
        if [ "$(echo "$num1 <= 0" | bc)" -eq 1 ] || [ "$(echo "$num2 <= 0" | bc)" -eq 1 ]; then
            echo "Error: Los números deben ser estrictamente positivos (mayores que 0)."
            continue
        fi

        # Regla b): Deben ser diferentes
        if [ "$(echo "$num1 == $num2" | bc)" -eq 1 ]; then
            echo "Error: Los números no pueden ser iguales."
            continue
        fi

        # Si supera todas las validaciones, salimos del bucle
        break
    done

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Datos ingresados/modificados: num1=$num1, num2=$num2" >> "$LOG_FILE"
}

mostrar_menu() {
    echo "--------------------------------"
    echo " Calculadora Bash "
    echo " Valores actuales: Num1 = $num1 | Num2 = $num2"
    echo "--------------------------------"
    echo "1) Sumar"
    echo "2) Restar"
    echo "3) Multiplicar"
    echo "4) Dividir"
    echo "5) Modificar Números"
    echo "6) Salir"
    echo "--------------------------------"
    read -p "Seleccione una opción [1-6]: " opcion
}

sumar() {
    resultado=$(echo "$num1 + $num2" | bc)
    echo "El resultado de la suma es: $resultado"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Opción: Sumar ($num1 + $num2) = $resultado" >> "$LOG_FILE"
}

restar() {
    resultado=$(echo "$num1 - $num2" | bc)
    echo "El resultado de la resta es: $resultado"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Opción: Restar ($num1 - $num2) = $resultado" >> "$LOG_FILE"
}

multiplicar() {
    resultado=$(echo "$num1 * $num2" | bc)
    echo "El resultado de la multiplicación es: $resultado"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Opción: Multiplicar ($num1 * $num2) = $resultado" >> "$LOG_FILE"
}

dividir() {
    resultado=$(echo "scale=2; $num1 / $num2" | bc)
    echo "El resultado de la división es: $resultado"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Opción: Dividir ($num1 / $num2) = $resultado" >> "$LOG_FILE"
}

# Solicitud inicial de datos antes de entrar al menú principal
ingresar_numeros

# Bucle principal
while true; do
    mostrar_menu

    case $opcion in
        1)
            sumar
            ;;
        2)
            restar
            ;;
        3)
            multiplicar
            ;;
        4)
            dividir
            ;;
        5)
            ingresar_numeros
            ;;
        6)
            echo "Saliendo de la calculadora. ¡Hasta luego!"
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] Sesión finalizada por el usuario." >> "$LOG_FILE"
            exit 0
            ;;
        *)
            echo "Opción no válida. Por favor, intente nuevamente."
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] Opción no válida elegida: $opcion" >> "$LOG_FILE"
            ;;
    esac

    echo
    read -p "Presione Enter para continuar..."
    clear
done
