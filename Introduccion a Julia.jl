### Módulo 1: Introducción a Julia (Instalación de Julia, instalación de paqueterías, conociendo Julia). 
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

#=
## Instalación de Julia y Visual Studio Code (IDE):
1) Para instalar Julia, acceder a la siguiente página y seguir las instrucciones (traducir la página a español en caso de que se requiera):
- https://julialang.org/install/
2) Para instalar VS Code, acceder a la siguiente página y seguir las instrucciones (traducir la página a español en caso de que se requiera):
- https://code.visualstudio.com/download
3) En VS Code, instalar la extensión de Julia, cerrar la aplicación y volverla a abrir.
4) En VS Code, acceder a File > Preferences > Settings e introducir la leyenda "Julia: Executable Path".
5) Anexar la liga donde se instaló Julia: "C:\\Users\enriq\\.julia\\juliaup\\julia-1.12.1+0.x64.w64.mingw32\\bin\\julia.exe"
=#

####################################################################################################################################################

## Instalación e Inicialización de Paquetes:
# Para instalar paquetes en Julia se utiliza la sentencia "Pkg.add(Nombre_Paquetería)
# Nota: Para ejecutar lineas de comando, selecciónar las líneas específicas y presionar Ctrl + Enter. Una ejecución exitosa marca 
# palomita al final del comando.

import Pkg # Importar las sintaxis de "Pkg".
Pkg.add("Plots")
Pkg.add("StatsPlots")
Pkg.add("Distributions")
Pkg.add("Random")
Pkg.add("LaTeXStrings")
Pkg.add("Copulas")
Pkg.add("Statistics")

# Para utilizar una paquetería ya instalada en Julia, se utiliza el comando "using Nombre_Paquetería").

using Plots
using StatsPlots
using Distributions
using Random
using LaTeXStrings
using Statistics

####################################################################################################################################################

## Conociendo Julia:
# Julia funciona de forma similar a Python y a R.

# Asignación de valores
x = 10
y = 10; # ¿Cúal es la diferencia a la anterior linea? R. no se imprime el resultado en la consola por el ";"

# Asignación múltiple
x, y = 8, 2;
x # Imprimir el valor de x

# Aritmética Básica
x + y # Suma
x - y # Resta
x * y # Multiplación
x/y # División (Nos dió un número decimal y no entero !!)

# Declaración de funciones
function sumar_uno(x)
    return x + 1
end # Versión extensa
g(x) = x + 1 # Versión corta (mas intuitiva)
sumar_uno(10)
g(10)

# Declarar lenguaje LaTex (referirse a CodeCogs)
# Probar: \delta + [TAB]
# Probar: \Gamma + [TAB]
δ
Γ

# Operadores lógicos
x,y,z = 1,2,3;
x + y == z # true
x <= y # true
x >= y # false
!(x > y) # true
x != y # true

# Arreglos Unidimensionales
x = [4,5,6,7,8,9,10] # Vector de longitud tres.
x[1] # Mostrar el primer valor del vector
x[8] # ERROR: _____________
x = [4:10;] 
x == [4,5,6,7,8,9,10]
y = Float64[] # Arreglo vacio de elementos
push!(y, 11.3) # Añadir un elemento al arreglo. El símbolo "!" representa actualización
push!(y, 10) # Revisar el segundo dato y analizar por que sale como 10.0 y no como 10
z = Int64[]
push!(z, 10)
push!(z, 11.3) # ERROR: _____________

# Ejercicio: Crear una función que tome un vector n-dimensional, eleve al cuadrado todas las entradas
# en orden y devuelve un vector n-dimensional con los resultados.
# Solución 1:
function cuadrado(x)
    n = length(x) # Longitud de x
    w = Float64[] # Vector donde van a ir los cuadrados de los valores de x
    for i in 1:n
        push!(w, x[i]^2)
    end
    return w
end
x = [1:10;] # También es válido x = collect(1:10)
y = cuadrado(x);
y # Resultados
[x y] # Matrix 10 x 2 la cual myuestra los resultados.
# Solución 2: 
x = [1:10;]
f(w) = w^2
y = f.(x) # El punto hace que la función f se aplique a cada elemento de x.
[x y]
y == x.^2 # true

####################################################################################################################################################

## Documentación de funciones
g(x::Float64)::Float64 = x^2 # Construímos una función, tal y como se escriben en el pizarrón :D. Importante anotar el dato que recibe la función, esto hace todo mas rápido.
x = [2.1, 2.0, 1.3];
y = g(x) # No funciona, ¿por qué? R. Por que la función se definió para recibir solamente flotantes, no arreglos de números. Utilicemos el '.'
y = g.(x) # Esto si funciona
# Podemos mejorar nuestra función
# ¿Qué nos dice ?g ? R. ABSOLUTAMENTE nada D:

"""
    g(x::Float64)::Float64

Devuelve el cuadrado de cualquier número flotante x.

"""
function g(x::Float64)::Float64
    x^2
end

g(1) # No funciona otra vez D: ¿Qué es 1? R. Un entero, no un flotante
g(1.0) # Funciona tal y como esperaríamos.
# Queremos que g funcione con multiples números a la vez, no solamente con uno. ¿Cómo hacemos esto? R. Declaremos otro MÉTODO para la funciónm y listo (No olviden su documentación).
"""
    g(v::Vector{Float64})::Vector{Float64}

Devuelve el cuadrado de una serie de números flotantes.

"""
function g(v::Vector{Float64})::Vector{Float64}
    w = Float64[] # Inicializar un vector vacío donde se va almacenar el resultado
    for x in v
        push!(w, x^2)
    end
    w
end

g(2.0)
g([2.0, 3.4, 4, 9]) # ¡¡Julia reconoce que hacer dependiendo de que valor de entrada recibe la función!! Esto es denominado multiple dispatch.

####################################################################################################################################################

##### Fiin del Módulo 1. Espero les haya gustado :D
