# 🐧 Bash Exercises

🇪🇸 [Leer en español](README.es.md)

A collection of **Bash scripting exercises**, ordered from easiest to hardest. Each exercise includes a **statement** (what to do) and its **solution** in a script.

> 📝 **Note:** the exercise statements and the comments inside the scripts are currently written in Spanish.

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
- **Helping others:** anyone starting with Bash can follow the exercises in order and read the explained solutions.

No previous experience is needed. Each exercise explains the new concepts it uses.

---

## 3. How it is organized

Each exercise lives in **its own folder**, with two files:

```text
.
├── README.md                    ← This file (English)
├── README.es.md                 ← Spanish version of this file
├── GUIA-entorno-bash.md         ← Guide to set up the working environment
├── ejercicio-presentacion/
│   ├── Enunciado.md             ← What the exercise asks for
│   └── presentacion.sh          ← The solution
├── ejercicio-xxxxx/
│   ├── Enunciado.md
│   └── xxxxx.sh
└── ...
```

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
- Checking files and folders.

### 🟡 Intermediate level: more complete scripts

- Validating data with regular expressions (`=~`).
- Menus with `case`.
- Functions to reuse code.
- Script arguments (`$1`, `$2`, `$#`).
- Reading and writing text files.
- Backups with `tar`.
- Managing system users.
- Recording actions in log files.

### 🟠 Advanced level: administration and networking

- Checking the connection to other machines (`ping`).
- Checking open ports.
- Analyzing logs with `grep`, `awk`, `sort` and `uniq`.
- Controlling services with `systemctl`.
- Monitoring CPU, memory and disk.
- Searching for and cleaning files with `find`.

### 🔴 Final challenges: complete projects

- Combining several scripts into one tool with a menu.
- Automating installations with error control.
- Generating reports in HTML.
- Scheduling automatic tasks with `cron`.

---

## 5. Exercise table

### 🟢 Basic level

| # | Exercise | What it practices | Status |
|---|---|---|---|
| 1 | [Personalized introduction](ejercicio-presentacion/Enunciado.md) | `read`, variables, `if / elif / else`, validation with `while` | ✅ Completed |
| 2 | [Even or odd](ejercicio-par-impar/Enunciado.md) | Number operations and conditions | ✅ Completed |
| 3 | [Multiplication table](ejercicio-tabla-multiplicar/Enunciado.md) | `for` loop | ✅ Completed |
| 4 | File counter | Going through a folder and counting | ⏳ Pending |
| 5 | Temperature converter | Menu and calculations with decimals | ⏳ Pending |
| 6 | Check if a file exists | Checks on files and folders | ⏳ Pending |

### 🟡 Intermediate level

| # | Exercise | What it practices | Status |
|---|---|---|---|
| 7 | Guess the number | Random numbers, loops and counters | ⏳ Pending |
| 8 | Password validator | Regular expressions | ⏳ Pending |
| 9 | Automatic backup | `tar`, dates in file names | ⏳ Pending |
| 10 | User manager | `useradd`, `userdel`, administrator permissions | ⏳ Pending |
| 11 | Mass renamer | Loops over files | ⏳ Pending |
| 12 | Contact book | Reading and writing text files | ⏳ Pending |
| 13 | Passing parameters | Arguments `$1`, `$2`, `$#` | ⏳ Pending |

### 🟠 Advanced level

| # | Exercise | What it practices | Status |
|---|---|---|---|
| 14 | Ping a list of machines | `ping`, reading files line by line | ⏳ Pending |
| 15 | Simple port scanner | Checking ports with `nc` or `/dev/tcp` | ⏳ Pending |
| 16 | System monitor | CPU, RAM, disk and alerts in a log | ⏳ Pending |
| 17 | Log analyzer | `grep`, `awk`, `sort`, `uniq` | ⏳ Pending |
| 18 | Network report | IP, mask, gateway and DNS | ⏳ Pending |
| 19 | Service checker | `systemctl` | ⏳ Pending |
| 20 | Old file cleanup | `find`, confirmations | ⏳ Pending |

### 🔴 Final challenges

| # | Exercise | What it practices | Status |
|---|---|---|---|
| 21 | Complete administration menu | Functions and menus that combine several scripts | ⏳ Pending |
| 22 | Automated installer | Installing a web server with error control | ⏳ Pending |
| 23 | HTML report generator | Creating a page with the system status | ⏳ Pending |
| 24 | Scheduled backup with `cron` | Automatic tasks | ⏳ Pending |

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
