# 🐧 Ejercicios de Bash

🇬🇧 [Read in English](README.md)

Colección de ejercicios de **scripting en Bash**, ordenados de menor a mayor dificultad. Cada ejercicio incluye un **enunciado** y su **solución** en un script.

---

## 📑 Índice

1. [¿Qué es este repositorio?](#1-qué-es-este-repositorio)
2. [¿Para quién es?](#2-para-quién-es)
3. [Cómo está organizado](#3-cómo-está-organizado)
4. [Hoja de ruta: qué se aprende](#4-hoja-de-ruta-qué-se-aprende)
5. [Tabla de ejercicios](#5-tabla-de-ejercicios)
6. [Leyenda de niveles y estados](#6-leyenda-de-niveles-y-estados)

---

## 1. ¿Qué es este repositorio?

**Bash** es el lenguaje que entiende la terminal de la mayoría de los sistemas Linux. Con él se pueden escribir **scripts**: archivos de texto con una lista de órdenes que el ordenador ejecuta una tras otra.

Este repositorio reúne ejercicios prácticos para aprender a escribir scripts desde cero. El objetivo es avanzar poco a poco, desde programas muy sencillos hasta herramientas útiles para la **administración de sistemas y redes**.

Todos los scripts se han escrito y probado en **Linux** (Ubuntu sobre WSL2).

---

## 2. ¿Para quién es?

Este repositorio tiene tres usos:

- **Estudio personal:** seguir el progreso y repasar lo aprendido.
- **Portfolio:** mostrar el trabajo realizado a quien quiera revisarlo.
- **Ayuda a otras personas:** cualquiera que esté empezando con Bash puede seguir los ejercicios en orden y consultar las soluciones explicadas.

No se necesita experiencia previa. Cada ejercicio explica los conceptos nuevos que utiliza.

---

## 3. Cómo está organizado

Cada ejercicio vive en **su propia carpeta**, con dos archivos:

```text
.
├── README.md                    ← Versión en inglés
├── README.es.md                 ← Este archivo (español)
├── GUIA-entorno-bash.md         ← Guía para preparar el entorno de trabajo
├── ejercicio-presentacion/
│   ├── Enunciado.md             ← Qué pide el ejercicio
│   └── presentacion.sh          ← La solución
├── ejercicio-xxxxx/
│   ├── Enunciado.md
│   └── xxxxx.sh
└── ...
```

| Archivo | Qué contiene |
|---|---|
| `Enunciado.md` | Lo que debe hacer el script, ejemplos de salida esperada, conceptos que se practican y retos extra opcionales. |
| `nombre.sh` | La solución, con comentarios que explican cada parte. |

**Forma recomendada de trabajar:** leer primero el enunciado, intentar resolverlo sin mirar la solución, y consultar el script solo para comparar o cuando haya dudas.

---

## 4. Hoja de ruta: qué se aprende

Los temas se van introduciendo de forma progresiva.

### 🟢 Nivel básico: los cimientos

- Estructura de un script (`#!/bin/bash`) y comentarios.
- Mostrar texto con `echo`.
- Pedir datos al usuario con `read`.
- Variables: guardar y usar datos.
- Condiciones con `if / elif / else`.
- Comparar números (`-eq`, `-lt`, `-ge`...) y textos.
- Bucles `for` y `while`.
- Comprobar archivos y carpetas.

### 🟡 Nivel intermedio: scripts más completos

- Validar datos con expresiones regulares (`=~`).
- Menús con `case`.
- Funciones para reutilizar código.
- Argumentos de un script (`$1`, `$2`, `$#`).
- Leer y escribir archivos de texto.
- Copias de seguridad con `tar`.
- Gestión de usuarios del sistema.
- Registro de acciones en archivos log.

### 🟠 Nivel avanzado: administración y redes

- Comprobar la conexión con equipos (`ping`).
- Revisar puertos abiertos.
- Analizar logs con `grep`, `awk`, `sort` y `uniq`.
- Controlar servicios con `systemctl`.
- Monitorizar CPU, memoria y disco.
- Buscar y limpiar archivos con `find`.

### 🔴 Retos finales: proyectos completos

- Unir varios scripts en una herramienta con menú.
- Automatizar instalaciones con control de errores.
- Generar informes en HTML.
- Programar tareas automáticas con `cron`.

---

## 5. Tabla de ejercicios

### 🟢 Nivel básico

| # | Ejercicio | Qué practica | Estado |
|---|---|---|---|
| 1 | [Presentación personalizada](ejercicio-presentacion/Enunciado.md) | `read`, variables, `if / elif / else`, validación con `while` | ✅ Completado |
| 2 | Par o impar | Operaciones con números y condiciones | ✅ Completado |
| 3 | Tabla de multiplicar | Bucle `for` | ⏳ Pendiente |
| 4 | Contador de archivos | Recorrer una carpeta y contar | ⏳ Pendiente |
| 5 | Conversor de temperatura | Menú y cálculos con decimales | ⏳ Pendiente |
| 6 | Comprobar si un archivo existe | Comprobaciones de archivos y carpetas | ⏳ Pendiente |

### 🟡 Nivel intermedio

| # | Ejercicio | Qué practica | Estado |
|---|---|---|---|
| 7 | Adivina el número | Números aleatorios, bucles y contadores | ⏳ Pendiente |
| 8 | Validador de contraseñas | Expresiones regulares | ⏳ Pendiente |
| 9 | Copia de seguridad automática | `tar`, fechas en nombres de archivo | ⏳ Pendiente |
| 10 | Gestor de usuarios | `useradd`, `userdel`, permisos de administrador | ⏳ Pendiente |
| 11 | Renombrador masivo | Bucles sobre archivos | ⏳ Pendiente |
| 12 | Agenda de contactos | Leer y escribir archivos de texto | ⏳ Pendiente |
| 13 | Paso de parámetros | Argumentos `$1`, `$2`, `$#` | ⏳ Pendiente |

### 🟠 Nivel avanzado

| # | Ejercicio | Qué practica | Estado |
|---|---|---|---|
| 14 | Ping a una lista de equipos | `ping`, lectura de archivos línea a línea | ⏳ Pendiente |
| 15 | Escáner de puertos simple | Comprobación de puertos con `nc` o `/dev/tcp` | ⏳ Pendiente |
| 16 | Monitor del sistema | CPU, RAM, disco y alertas en un log | ⏳ Pendiente |
| 17 | Analizador de logs | `grep`, `awk`, `sort`, `uniq` | ⏳ Pendiente |
| 18 | Informe de red | IP, máscara, puerta de enlace y DNS | ⏳ Pendiente |
| 19 | Comprobador de servicios | `systemctl` | ⏳ Pendiente |
| 20 | Limpieza de archivos antiguos | `find`, confirmaciones | ⏳ Pendiente |

### 🔴 Retos finales

| # | Ejercicio | Qué practica | Estado |
|---|---|---|---|
| 21 | Menú de administración completo | Funciones y menús que unen varios scripts | ⏳ Pendiente |
| 22 | Instalador automatizado | Instalación de un servidor web con control de errores | ⏳ Pendiente |
| 23 | Generador de informes HTML | Crear una página con el estado del sistema | ⏳ Pendiente |
| 24 | Backup programado con `cron` | Tareas automáticas | ⏳ Pendiente |

---

## 6. Leyenda de niveles y estados

| Símbolo | Significado |
|---|---|
| 🟢 | Nivel básico |
| 🟡 | Nivel intermedio |
| 🟠 | Nivel avanzado |
| 🔴 | Reto final |
| ✅ | Completado |
| 🚧 | En progreso |
| ⏳ | Pendiente |

> El orden y la lista de ejercicios pueden cambiar a medida que avance el aprendizaje.
