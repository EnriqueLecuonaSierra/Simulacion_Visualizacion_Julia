### Módulo 5: Simulación y visualización de procesos estocásticos en Julia (caso discreto).
## Autor: Act. Enrique Lecuona Sierra
## Curso: Simulación y Visualización de datos en Julia.

####################################################################################################################################################

#=
Hola a todos, bienvenidos al curso de Simulación y Visualización de datos en Julia. Los siguientes enlaces son de especial importancia que revisen.
1) Julia: https://julialang.org/
2) IDE (Integrated Development Environment/Entorno Integral de Desarrollo) (recomendado): https://code.visualstudio.com/docs/languages/julia
3) Julia Cheat-Sheet: https://cheatsheet.juliadocs.org/es/
4) Paqueterías de Julia que instalaremos en este Módulo:
- Plots.jl (Gráficas en Julia): https://docs.juliaplots.org/stable/
- Distributions.jl (Variables aleatorias en Julia): https://juliastats.org/Distributions.jl/stable/starting/
- Random.jl (Simulaciín de valores Aleatorios)
- StatsPlots.jl (Extiende Plots.jl para visualizar gráficas con fines estadísticos)
- LaTeXStrings.jl (Código de Latex para gráficas)
- Copulas.jl (Simulación de vectores aleatorios mediante cópulas)
5) CodeCogs(Ayuda para escribir en LaTeX): https://editor.codecogs.com/ 
=#

####################################################################################################################################################

# Siempre que volvamos a abrir una sesión en Julia, es necesario inicilizar las paqueterías que vamos a utilizar.

using Plots
using StatsPlots
using Distributions
using Random
using LaTeXStrings
using Statistics
using Copulas
# Directorio de Imágenes
dir = "D:\\Escritorio\\Enrique Lecuona\\Clases\\Cursos de Programación\\Simulación y Visualización de datos en Julia\\Imagenes\\"

####################################################################################################################################################

## En este módulo vamos a enfocarnos en aprender a graficar procesos estocásticos en Julia para el caso discreto.
# 1) ¿Qué es un proceso estocástico?
# 2) ¿Qué necesitamos para graficar un proceso estocastico?
# 3) Caso Practico: Camina Aleatoria.

####################################################################################################################################################
