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

**Bash** es el lenguaje que entiende la terminal de la mayoría de sistemas Linux. Con él se pueden escribir **scripts**: archivos de texto con una lista de órdenes que el ordenador ejecuta una tras otra.

Este repositorio reúne ejercicios prácticos para aprender a escribir scripts desde cero. El objetivo es avanzar poco a poco, desde programas muy sencillos hasta herramientas útiles para la **administración de sistemas y redes**.

Todos los scripts se han escrito y probado en **Linux** (Ubuntu sobre WSL2).

---

## 2. ¿Para quién es?

Este repositorio tiene tres usos:

- **Estudio personal:** seguir el progreso y repasar lo aprendido.
- **Portfolio:** mostrar el trabajo realizado a quien quiera revisarlo.
- **Ayuda a otras personas:** cualquiera que esté empezando con Bash puede seguir los ejercicios en orden y consultar las soluciones.

No se necesita experiencia previa. Cada ejercicio explica los conceptos nuevos que utiliza.

---

## 3. Cómo está organizado

Los ejercicios se agrupan en **carpetas por nivel**, y dentro de cada nivel cada ejercicio vive en **su propia carpeta numerada**, con dos archivos:

```text
.
├── README.md                          ← Versión en inglés
├── README.es.md                       ← Este archivo (español)
├── GUIA-entorno-bash.md               ← Guía para preparar el entorno de trabajo
├── 01-basico/
│   ├── 01-presentacion/
│   │   ├── Enunciado.md               ← Qué pide el ejercicio
│   │   └── presentacion.sh            ← La solución
│   ├── 02-par-impar/
│   └── ...
├── 02-intermedio/
│   └── ...
├── 03-avanzado/
│   └── ...
└── 04-retos-finales/
    └── ...
```

| Carpeta de nivel | Nivel | Ejercicios |
|---|---|---|
| `01-basico` | 🟢 Básico | del 1 al 6 |
| `02-intermedio` | 🟡 Intermedio | del 7 al 13 |
| `03-avanzado` | 🟠 Avanzado | del 14 al 20 |
| `04-retos-finales` | 🔴 Retos finales | del 21 al 24 |

La numeración de los ejercicios es **global** (del 1 al 24) y coincide con la columna `#` de la tabla de abajo, así que el ejercicio 7 es siempre `07-...`.

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
- Menús con `case` y cálculos con `bc`.
- Comprobar archivos y carpetas.

### 🟡 Nivel intermedio: scripts más completos

- Validar datos con expresiones regulares (`=~`).
- Números aleatorios y contadores.
- Argumentos de un script (`$1`, `$2`, `$#`) y códigos de salida.
- Leer y escribir archivos de texto.
- Copias de seguridad con `tar`.
- Gestión de usuarios del sistema.
- Renombrado de archivos en bloque.

### 🟠 Nivel avanzado: administración y redes

- Comprobar la conexión con equipos (`ping`).
- Revisar puertos abiertos y trabajar con arrays.
- Analizar logs con `grep`, `awk`, `sort` y `uniq`.
- Controlar servicios con `systemctl`.
- Monitorizar CPU, memoria y disco.
- Leer la configuración de red con `ip`.
- Buscar y limpiar archivos con `find`.

### 🔴 Retos finales: proyectos completos

- Funciones para organizar y reutilizar código.
- Unir varios scripts en una herramienta con menú y registro.
- Automatizar instalaciones con control de errores.
- Generar informes en HTML.
- Programar tareas automáticas con `cron`.

---

## 5. Tabla de ejercicios

### 🟢 Nivel básico

| # | Ejercicio | Qué practica | Estado |
|---|---|---|---|
| 1 | [Presentación personalizada](01-basico/01-presentacion/Enunciado.md) | `read`, variables, `if / elif / else`, validación con `while` | ✅ Completado |
| 2 | [Par o impar](01-basico/02-par-impar/Enunciado.md) | Resto (`%`), condiciones y validación | ✅ Completado |
| 3 | [Tabla de multiplicar](01-basico/03-tabla-multiplicar/Enunciado.md) | Bucles `for` (también el de tres partes y los anidados) | ✅ Completado |
| 4 | [Contador de archivos](01-basico/04-contador-archivos/Enunciado.md) | Recorrer una carpeta, `-f`, `-d` y contadores | 🚧 En progreso |
| 5 | [Conversor de temperatura](01-basico/05-conversor-temperatura/Enunciado.md) | `case`, `bc` y decimales | ⏳ Pendiente |
| 6 | [Comprobar si un archivo existe](01-basico/06-comprobar-archivo/Enunciado.md) | `-e`, `-f`, `-d`, `-r`, `-w`, `-x` | ⏳ Pendiente |

### 🟡 Nivel intermedio

| # | Ejercicio | Qué practica | Estado |
|---|---|---|---|
| 7 | [Adivina el número](02-intermedio/07-adivina-numero/Enunciado.md) | `$RANDOM`, bucles y contadores | ⏳ Pendiente |
| 8 | [Validador de contraseñas](02-intermedio/08-validador-contrasenas/Enunciado.md) | Expresiones regulares y `read -s` | ⏳ Pendiente |
| 9 | [Copia de seguridad automática](02-intermedio/09-copia-seguridad/Enunciado.md) | `tar`, fechas en nombres de archivo | ⏳ Pendiente |
| 10 | [Gestor de usuarios](02-intermedio/10-gestor-usuarios/Enunciado.md) | `useradd`, `userdel`, permisos de administrador | ⏳ Pendiente |
| 11 | [Renombrador masivo](02-intermedio/11-renombrador-masivo/Enunciado.md) | Bucles sobre archivos | ⏳ Pendiente |
| 12 | [Agenda de contactos](02-intermedio/12-agenda-contactos/Enunciado.md) | Leer y escribir archivos de texto | ⏳ Pendiente |
| 13 | [Paso de parámetros](02-intermedio/13-paso-parametros/Enunciado.md) | Argumentos `$1`, `$2`, `$#` y códigos de salida | ⏳ Pendiente |

### 🟠 Nivel avanzado

| # | Ejercicio | Qué practica | Estado |
|---|---|---|---|
| 14 | [Ping a una lista de equipos](03-avanzado/14-ping-equipos/Enunciado.md) | `ping`, lectura de archivos línea a línea | ⏳ Pendiente |
| 15 | [Escáner de puertos simple](03-avanzado/15-escaner-puertos/Enunciado.md) | Comprobación de puertos con `/dev/tcp`, arrays | ⏳ Pendiente |
| 16 | [Monitor del sistema](03-avanzado/16-monitor-sistema/Enunciado.md) | CPU, RAM, disco y alertas en un log | ⏳ Pendiente |
| 17 | [Analizador de logs](03-avanzado/17-analizador-logs/Enunciado.md) | `grep`, `awk`, `sort`, `uniq` | ⏳ Pendiente |
| 18 | [Informe de red](03-avanzado/18-informe-red/Enunciado.md) | IP, prefijo, puerta de enlace y DNS | ⏳ Pendiente |
| 19 | [Comprobador de servicios](03-avanzado/19-comprobador-servicios/Enunciado.md) | `systemctl` | ⏳ Pendiente |
| 20 | [Limpieza de archivos antiguos](03-avanzado/20-limpieza-archivos/Enunciado.md) | `find`, confirmaciones | ⏳ Pendiente |

### 🔴 Retos finales

| # | Ejercicio | Qué practica | Estado |
|---|---|---|---|
| 21 | [Menú de administración completo](04-retos-finales/21-menu-administracion/Enunciado.md) | Funciones y menús que unen varios scripts | ⏳ Pendiente |
| 22 | [Instalador automatizado](04-retos-finales/22-instalador-automatizado/Enunciado.md) | Instalación de un servidor web con control de errores | ⏳ Pendiente |
| 23 | [Generador de informes HTML](04-retos-finales/23-informe-html/Enunciado.md) | Crear una página con el estado del sistema | ⏳ Pendiente |
| 24 | [Backup programado con `cron`](04-retos-finales/24-backup-cron/Enunciado.md) | Tareas automáticas | ⏳ Pendiente |

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
