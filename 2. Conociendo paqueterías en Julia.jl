### Módulo 2: Conociendo paqueterías en Julia.
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

####################################################################################################################################################

# En este Módulo nos vamos a aprender a usar las paqueterías que nos van a permitir simular y visualizar datos en Julia.

Random.seed!(123) # Permite repetir la simulación y tener control sobre ella.

# Si tenemos duda, usemos la guia con "?". El ";" omite la salida del input de nuestro código.
μ, σ = 2,3; # Declaremos valores para la media y des. estandar de nuestra v.a.
X = Normal() # v.a. Normal(0,1). NOTA: Usar "?" en caso de que se tengan dudas.
mean(X),var(X), params(X) # Obtenemos la media y varianza de la v.a., así como los parámetros de nuestra v.a.
x = rand(X, 100); # Obtenemos 100 valores de una normal Normal(μ,σ)
mean(x), var(x) # Estimaciones muestrales (usando una muestra) de la media y varianza del modelo X.
pdf(X, 0), pdf(X,2) # Valuación de la función de densidad de probabilidades.
cdf(X, 0), cdf(X,2) # Valuación de la función de distribución de probabilidades.
quantile(X, 0.25), quantile(X, 0.5), quantile(X, 0.75) # Valuación de la función de cuantiles en la Mediana (Percentil al 50%) y Percentil al 25% y 75%.
quantile.(X, [0.25, 0.5, 0.75]) # Lo mismo pero utilizando '.'
## Queremos usar la función en multiples valores, ¿cómo lo hacemos? Usando el operador '.'
pdf.(X, [-1, 0, 1])
cdf(X, [-1, 0, 1]) # Algunas funciones reconocen en automático la operación vectorial 
quantile.(X, [0.25, 0.5, 0.75])
#La paquetería tiene distintas v.a. disponibles: https://juliastats.org/Distributions.jl/stable/univariate/
Binomial(4, 0.5) # v.a. Binomial(4, 0.5)
Cauchy(-5.0, 6.0)  # v.a. Cauchy(-5,6)

####################################################################################################################################################

# Es hora de graficar información de v.a. con Plots. Recuerden que '!' se traduce en "actualizar"

Random.seed!(123);

X = Normal(3,2) # v.a. Normal(3,2)
x = rand(X, 10000); # Observaciones del modelo
p = histogram(x, normalize =:pdf, label = "Observaciones", color =:lightblue) # Histograma normalizado
plot!(p, X, label = "pdf", lw = 2.5, color=:orange) # Agregamos la pdf de X
plot!(p, xlims = (-3,9), ylims = (0,0.22)) # Límites de los ejes
plot!(p, xticks = -3:3:9, yticks = 0:0.05:0.25) # Separación de los ejes
plot!(p, title = "Histograma: Normal(3,2)")
μ, σ = mean(X), sqrt(var(X));
vline!(p, [μ], lw = 3.5, color = :green, linestyle = :dash,
label = L"E(X)")

"""
    T_pdf(ν::Float64)

Devuelve la pdf de una v.a. t-student con 'ν' grados de libertad.

"""
function T_pdf(ν)
    Y = TDist(ν)  
    g(x) = pdf(Y,x)
    return g
end

g1 = T_pdf(1.0);
g2 = T_pdf(5.0);
g3 = T_pdf(20.0);

X = Normal(0,1)
p1 = plot(title = "Comparativo: Normal vs. T-Student");
plot!(p1, X, -5, 5, label = L"Normal(0,1)", lw = 2.5, color=:orange);
plot!(p1, g1, label = L"X\sim t(1)", lw = 1.5);
plot!(p1, g2, label = L"X\sim t(5)", lw = 1.5);
plot!(p1, g3, label = L"X\sim t(10)", lw = 1.5)

savefig(p1, "Comparativo Normal.png")
#Cambiemos la dirección donde vamos a guardar nuestro gráfico

dir = "D:\\Escritorio\\Enrique Lecuona\\Clases\\Cursos de Programación\\Simulación y Visualización de datos en Julia\\Imagenes\\"
nombre_archivo = "Comparativo Normal.png"
dir * nombre_archivo # Revisar como funciona la multiplicación de strings
savefig(p1, dir * nombre_archivo)

####################################################################################################################################################

##### Fin del Módulo 2. Espero les haya gustado :D


