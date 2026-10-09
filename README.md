# 🐧 Bash Exercises

🇪🇸 [Leer en español](README.es.md)

A collection of **Bash scripting exercises**, ordered from easiest to hardest. Each exercise includes a **statement** (what to do) and its **solution** in a script.

> 📝 **Note:** the exercise statements and the comments inside the scripts are currently written in Spanish, and so are the folder names.

---

## 📑 Table of contents

1. [What is this repository?](#1-what-is-this-repository)
2. [Who is it for?](#2-who-is-it-for)
3. [How it is organized](#3-how-it-is-organized)
4. [Roadmap: what is learned](#4-roadmap-what-is-learned)
5. [Exercise table](#5-exercise-table)
6. [Legend of levels and statuses](#6-legend-of-levels-and-statuses)

---

## 1. What is this repository?

**Bash** is the language that the terminal of most Linux systems understands. With it, you can write **scripts**: text files containing a list of commands that the computer runs one after another.

This repository gathers practical exercises to learn how to write scripts from scratch. The goal is to progress step by step, from very simple programs to useful tools for **system and network administration**.

All scripts were written and tested on **Linux** (Ubuntu running on WSL2).

---

## 2. Who is it for?

This repository has three uses:

- **Personal study:** to follow progress and review what has been learned.
- **Portfolio:** to show the work done to anyone who wants to review it.
- **Helping others:** anyone starting with Bash can follow the exercises in order and read the solutions.

No previous experience is needed. Each exercise explains the new concepts it uses.

---

## 3. How it is organized

Exercises are grouped in **folders by level**, and inside each level every exercise lives in its **own numbered folder**, with two files:

```text
.
├── README.md                          ← This file (English)
├── README.es.md                       ← Spanish version of this file
├── GUIA-entorno-bash.md               ← Guide to set up the working environment
├── 01-basico/
│   ├── 01-presentacion/
│   │   ├── Enunciado.md               ← What the exercise asks for
│   │   └── presentacion.sh            ← The solution
│   ├── 02-par-impar/
│   └── ...
├── 02-intermedio/
│   └── ...
├── 03-avanzado/
│   └── ...
└── 04-retos-finales/
    └── ...
```

| Level folder | Level | Exercises |
|---|---|---|
| `01-basico` | 🟢 Basic | 1 to 6 |
| `02-intermedio` | 🟡 Intermediate | 7 to 13 |
| `03-avanzado` | 🟠 Advanced | 14 to 20 |
| `04-retos-finales` | 🔴 Final challenges | 21 to 24 |

Exercise numbers are **global** (1 to 24) and match the `#` column of the table below, so exercise 7 is always `07-...`.

| File | What it contains |
|---|---|
| `Enunciado.md` | The statement: what the script must do, examples of the expected output, the concepts practiced, and optional extra challenges. |
| `name.sh` | The solution, with comments that explain each part. |

**Recommended way to work:** read the statement first, try to solve it without looking at the solution, and open the script only to compare or when in doubt.

---

## 4. Roadmap: what is learned

Topics are introduced gradually.

### 🟢 Basic level: the foundations

- Structure of a script (`#!/bin/bash`) and comments.
- Showing text with `echo`.
- Asking the user for data with `read`.
- Variables: storing and using data.
- Conditions with `if / elif / else`.
- Comparing numbers (`-eq`, `-lt`, `-ge`...) and text.
- `for` and `while` loops.
- Menus with `case` and calculations with `bc`.
- Checking files and folders.

### 🟡 Intermediate level: more complete scripts

- Validating data with regular expressions (`=~`).
- Random numbers and counters.
- Script arguments (`$1`, `$2`, `$#`) and exit codes.
- Reading and writing text files.
- Backups with `tar`.
- Managing system users.
- Renaming files in bulk.

### 🟠 Advanced level: administration and networking

- Checking the connection to other machines (`ping`).
- Checking open ports and working with arrays.
- Analyzing logs with `grep`, `awk`, `sort` and `uniq`.
- Controlling services with `systemctl`.
- Monitoring CPU, memory and disk.
- Reading the network configuration with `ip`.
- Searching for and cleaning files with `find`.

### 🔴 Final challenges: complete projects

- Functions to organize and reuse code.
- Combining several scripts into one tool with a menu and a log.
- Automating installations with error control.
- Generating reports in HTML.
- Scheduling automatic tasks with `cron`.

---

## 5. Exercise table

### 🟢 Basic level

| # | Exercise | What it practices | Status |
|---|---|---|---|
| 1 | [Personalized introduction](01-basico/01-presentacion/Enunciado.md) | `read`, variables, `if / elif / else`, validation with `while` | ✅ Completed |
| 2 | [Even or odd](01-basico/02-par-impar/Enunciado.md) | Remainder (`%`), conditions and validation | ✅ Completed |
| 3 | [Multiplication table](01-basico/03-tabla-multiplicar/Enunciado.md) | `for` loops (including the three-part form and nested loops) | ✅ Completed |
| 4 | [File counter](01-basico/04-contador-archivos/Enunciado.md) | Going through a folder, `-f`, `-d` and counters | 🚧 In progress |
| 5 | [Temperature converter](01-basico/05-conversor-temperatura/Enunciado.md) | `case`, `bc` and decimals | ⏳ Pending |
| 6 | [Check if a file exists](01-basico/06-comprobar-archivo/Enunciado.md) | `-e`, `-f`, `-d`, `-r`, `-w`, `-x` | ⏳ Pending |

### 🟡 Intermediate level

| # | Exercise | What it practices | Status |
|---|---|---|---|
| 7 | [Guess the number](02-intermedio/07-adivina-numero/Enunciado.md) | `$RANDOM`, loops and counters | ⏳ Pending |
| 8 | [Password validator](02-intermedio/08-validador-contrasenas/Enunciado.md) | Regular expressions and `read -s` | ⏳ Pending |
| 9 | [Automatic backup](02-intermedio/09-copia-seguridad/Enunciado.md) | `tar`, dates in file names | ⏳ Pending |
| 10 | [User manager](02-intermedio/10-gestor-usuarios/Enunciado.md) | `useradd`, `userdel`, administrator permissions | ⏳ Pending |
| 11 | [Mass renamer](02-intermedio/11-renombrador-masivo/Enunciado.md) | Loops over files | ⏳ Pending |
| 12 | [Contact book](02-intermedio/12-agenda-contactos/Enunciado.md) | Reading and writing text files | ⏳ Pending |
| 13 | [Passing parameters](02-intermedio/13-paso-parametros/Enunciado.md) | Arguments `$1`, `$2`, `$#` and exit codes | ⏳ Pending |

### 🟠 Advanced level

| # | Exercise | What it practices | Status |
|---|---|---|---|
| 14 | [Ping a list of machines](03-avanzado/14-ping-equipos/Enunciado.md) | `ping`, reading files line by line | ⏳ Pending |
| 15 | [Simple port scanner](03-avanzado/15-escaner-puertos/Enunciado.md) | Checking ports with `/dev/tcp`, arrays | ⏳ Pending |
| 16 | [System monitor](03-avanzado/16-monitor-sistema/Enunciado.md) | CPU, RAM, disk and alerts in a log | ⏳ Pending |
| 17 | [Log analyzer](03-avanzado/17-analizador-logs/Enunciado.md) | `grep`, `awk`, `sort`, `uniq` | ⏳ Pending |
| 18 | [Network report](03-avanzado/18-informe-red/Enunciado.md) | IP, prefix, gateway and DNS | ⏳ Pending |
| 19 | [Service checker](03-avanzado/19-comprobador-servicios/Enunciado.md) | `systemctl` | ⏳ Pending |
| 20 | [Old file cleanup](03-avanzado/20-limpieza-archivos/Enunciado.md) | `find`, confirmations | ⏳ Pending |

### 🔴 Final challenges

| # | Exercise | What it practices | Status |
|---|---|---|---|
| 21 | [Complete administration menu](04-retos-finales/21-menu-administracion/Enunciado.md) | Functions and menus that combine several scripts | ⏳ Pending |
| 22 | [Automated installer](04-retos-finales/22-instalador-automatizado/Enunciado.md) | Installing a web server with error control | ⏳ Pending |
| 23 | [HTML report generator](04-retos-finales/23-informe-html/Enunciado.md) | Creating a page with the system status | ⏳ Pending |
| 24 | [Scheduled backup with `cron`](04-retos-finales/24-backup-cron/Enunciado.md) | Automatic tasks | ⏳ Pending |

---

## 6. Legend of levels and statuses

| Symbol | Meaning |
|---|---|
| 🟢 | Basic level |
| 🟡 | Intermediate level |
| 🟠 | Advanced level |
| 🔴 | Final challenge |
| ✅ | Completed |
| 🚧 | In progress |
| ⏳ | Pending |

> The order and the list of exercises may change as learning progresses.
