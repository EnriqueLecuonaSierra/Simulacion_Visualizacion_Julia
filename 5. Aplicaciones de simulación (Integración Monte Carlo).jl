### Módulo 5: Aplicaciones de simulación (Introducción a la integración por método Monte Carlo).
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

## En este módulo vamos a enfocarnos en una aplicación particular de la simulación, la integración por Método Montecarlo
# 1) Recordatorio de la Ley de los Grandes Números y sus implicaciónes.
# 2) Ejemplo de simulación Monte Carlo.

####################################################################################################################################################

## Ley de los Grandes Números.
# Podemos utilizar cualquier modelo estadístico con varianza finita. Tomemos X ∽ N(0,1) y analicemos como se comporta
Random.seed!(123);

μ = 5; X = Normal(μ); n = 150; x = 1:n;
y = rand(X, n); y = cumsum(y) ./ (1:length(y)); # Promedio acumulativo

p1 = plot(x, y, color = :blue, lw = 2.0, ylabel = L"\bar{x}_n", xlabel = L"n",
            title = "Comportamiento Media Muestral para Normal(0,1).",
            label = "");
hline!(p1, [μ], lw = 1.5, color = :orange, linestyle = :dash, label = L"E(X)")
plot!(p1, ylims = (μ - 1, μ + 1))
savefig(p1, dir * "LGN para Normal(0,1).png")

# Veamos que sucede con un modelo estadístico con varianza infinita. Tomemos X ∽ tν con ν ∈ (0,1].

ν = 0.8; X = TDist(ν); n = 300; x = 1:n;
y = rand(X, n); y = cumsum(y) ./ (1:length(y)); # Promedio acumulativo
mean(X) # No esta definida la esperanza para X ∽ tν con ν ∈ (0,1].
p2 = plot(x, y, color = :blue, lw = 2.0, ylabel = L"\bar{x}_n", xlabel = L"n",
            title = "Comportamiento Media Muestral para Normal(0,1).",
            label = "");
savefig(p2, dir * "LGN para distribución T con varianza infinita.png")
# Analicemos la anterior gráfica cuando ν ∈ (1, ∞),
# el comportamiento deja de ser errático y se centraliza en la esperanza de X la cual es cero para cualquier ν ∈ (1, ∞).

####################################################################################################################################################

## Integración numérica mediante método Monte Carlo.
# Podemos utilizar La Ley de los Grandes Números para integral sobre intervalos del tipo (a,b).
# Para realizar esto hacemos lo siguiente
# 1) Simulamos una muestra {u_1, ..., u_n} perteneciente a una variable aleatoria U ∽ Unif(a,b)
# 2) Aproximamos la esperanza de E(g(U)) mediante un promedio de las observaciones {g(u_1), ..., g(u_n)}, 
#    esto justificado por la Ley de los Grandes Números.
# 3) La integral que deseamos es igual a (b-a)E(g(U)). 

g(x) = log(x); # Función que deseamos integrar
I = 1; # El valor exacto de la integral de g sobre el intervalo (1,e)
n = 50; x = 1:n; # Tamaño de la muestra, mientras mas grande la muestra mejor.
U = Uniform(1, exp(1)); u = rand(U, n); # Una muestra de U ∽ Unif(a,b) 
y = g.(u); y = cumsum(y) ./ (1:length(y)); # Promedio acumulativo
y = y .* (exp(1)-1);

p3 = plot(x, y, color = :blue, lw = 2.0, xlabel = L"n", label = "",
            title = "Aprox: Integral de g sobre (1,e).");
hline!(p3, [I], lw = 1.5, color = :orange, linestyle = :dash, label = L"\int g")
plot!(p3, ylims = (I - 3, I + 3))
savefig(p3, dir * "Integración Monte Carlo.png")


####################################################################################################################################################

##### Fiin del Módulo 5. Espero les haya gustado :D
