### Módulo 4: Simulación y visualización de vectores aleatorios en Julia.
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

## En este módulo vamos a enfocarnos en la simulación de vectores aleatorios (v.a.). Trataremos dos formas de hacer esto.
# 1) Simulación mediante la distribución condicional.
# 2) Simulación mediante cópulas.
# 3) Ejemplos: Transformación de una muestra aleatoria.

####################################################################################################################################################

## Simulación mediante la distribución condicional.
# Podemos utilizar la distribución condicional de probabilidades para generar información de un vector aleatorio (X,Y).
# Tomemos un vector aleatorio (X,Y) distribuido de forma uniforme en la región T con T descrito como sigue:
# T = {(x,y)∈ R^2 | 0 ≤ x \leq 1; 0 ≤ y ≤ 1 - |x|}

# Grafiquemos la región T
p = plot(title = "Región T", xlims = (-1.5,1.5), ylims = (0,1.5),
    aspect_ratio = :equal);
plot!(p, xticks = -1.5:0.5:1.5, yticks = 0:0.5:1.5);
plot!(p, [-1,0], [0, 1], label = L"f_{XY}", lw = 2.5, color =:red);
plot!(p, [0,1], [1, 0], label = "", lw = 2.5, color =:red);
plot!(p, [-1,1], [0, 0], label = "", lw = 2.5, color =:red);
vline!(p, [0.0], lw = 1.0, color = :gray, linestyle = :dash,
label = "")

nombre_archivo = "Region T.png"
savefig(p, dir * nombre_archivo)

# Creemos una función para generar valores aleatorios de (X,Y)
"""
    rand_XY(n::Int64)

Devuelve una simulación del vector aletorio (X,Y) de tamaño n.

"""
function rand_XY(n::Int64)
    u = rand(n) # 'n' valores Unif(0,1)
    y = Float64[] # Almacenar la muestra de Y
    for w in u
        push!(y, 1-sqrt(1-w)) 
    end
    x = Float64[] # Almacenar la muestra de X
    for w in y
        push!(x, rand(Uniform(w-1,1-w))) # Generamos un valor de la Unif(yj-1, 1-yj)
    end
    return x,y
end
x,y = rand_XY(300);

scatter!(p, x, y, label = "",
    title = "Modelo (X,Y)", color =:orange)

nombre_archivo = "Modelo (X,Y).png"
savefig(p2, dir * nombre_archivo)

# Analicemos la información univariada de X y y
f(x::Float64)::Float64 = (1-abs(x)) # f.d.p univariada de X
g(y::Float64)::Float64 = 2*(1-y) # f.d.p univariada de y

p2 = histogram(x, normalize =:pdf, label = "Obs. de X", color =:lightblue);  # Histograma normalizado
plot!(p2, f, label = L"f_X", lw = 2.5, color=:orange); # Agregamos la pdf de X
plot!(p2, xlims = (-1.0,1.0), ylims = (0.0,1.0)); # Límites de los ejes
plot!(p2, xticks = -1.0:0.2:1.0, yticks = 0:0.2:1.0); # Separación de los ejes
plot!(p2, title = "Histograma de X");
vline!(p2, [0], lw = 3.5, color = :green, linestyle = :dash,
label = L"E(X)")

p3 = histogram(y, normalize =:pdf, label = "Obs. de X", color =:lightblue);  # Histograma normalizado
plot!(p3, g, label = L"f_Y", lw = 2.5, color=:orange); # Agregamos la pdf de X
plot!(p3, xlims = (0.0,1.0), ylims = (0.0,2.0)); # Límites de los ejes
plot!(p3, xticks = 0.0:0.25:1.0, yticks = 0:0.5:2.0); # Separación de los ejes
plot!(p3, title = "Histograma de Y");
vline!(p3, [1/3], lw = 3.5, color = :green, linestyle = :dash,
label = L"E(Y)")

savefig(p2, dir * "Modelo univariado X.png")
savefig(p3, dir * "Modelo univariado Y.png")

####################################################################################################################################################

## Simulación mediante cópulas.
# Podemos utilizar la copula de nuestro modelo bivariado para generar información de un vector aleatorio (X,Y).
# Recordemos que F_{XY}(x,y) = C(F_{X}(x), F_{Y}(y)) de donde
# 1) C = La cópula del modelo
# 2) F_{X} = cdf de X
# 3) F_{Y} = cdf de Y

Random.seed!(123)

## Analicemos la Cópula Frank
C1 = FrankCopula(2, 13) # Cópula de Frank bivariada (2) con parámetro 13
C2 = FrankCopula(2,-5) # Cópula de Frank bivariada (2) con parámetro -5
c1 = rand(C1, 500); x1 = c1[1,:]; y1 = c1[2,:]; # Muestras de la cópula C1
c2 = rand(C2, 500); x2 = c2[1,:]; y2 = c2[2,:]; # Muestras de la cópula C2

p1 = scatter(x1,y1, title = L"Mapa\;de\;dispersión\;Frank(13)", color =:blue, label = "");
plot!(p1, xlims = (0.0,1.0), ylims = (0.0,1.0), aspect_ratio=:equal);

p2 = scatter(x2,y2, title = L"Mapa\;de\;dispersión\;Frank(-5)", color =:blue, label = "");
plot!(p2, xlims = (0.0,1.0), ylims = (0.0,1.0), aspect_ratio=:equal);

savefig(p2, dir * "Cópula Frank 1.png")
savefig(p3, dir * "Cópula Frank 2.png")


# Ahora bien, combinemos nuestra cópula Frank con v.a. univariadas distintas.

Random.seed!(123) # Generador de nùmeros aleatorios fijo

X = Gamma(2,3) # Distribución Gamma: info en ?Gamma
Y = Beta(0.5,2) # Distribución Beta: info en ?Beta
C1 = FrankCopula(2, 13) # Cópula de Frank bivariada con parámetro 13
C2 = FrankCopula(2,-20) # Cópula de Frank bivariada con parámetro -5
D1 = SklarDist(C1,(X,Y)) # Nuestro modelo bivariado usando Frank(13)
D2 = SklarDist(C2,(X,Y)) # Nuestro modelo bivariado usando Frank(-5)

d1 = rand(D1, 10000); x1 = d1[1,:]; y1 = d1[2,:]; # Muestras del modelo D1
d2 = rand(D2, 10000); x2 = d2[1,:]; y2 = d2[2,:]; # Muestras del modelo D2

p1 = scatter(x1[1:500],y1[1:500], title = L"Mapa\;de\;dispersión\;D_1", color =:blue, label = "");
plot!(p1, xlims = (0.0,20), ylims = (0.0,1.0));
p2 = scatter(x2[1:500],y2[1:500], title = L"Mapa\;de\;dispersión\;D_2", color =:blue, label = "");
plot!(p2, xlims = (0.0,20), ylims = (0.0,1.0));

px = histogram(x1, normalize =:pdf, color =:lightblue, label = "");
histogram!(px, x2, normalize =:pdf, color =:orange, label = "",
        seriesalpha = 0.20, xlims = (0.0, 20.0), ylims = (0.0, 0.15));
plot!(px, title = L"Histograma\;Gamma(2,3)");
plot!(px, X, lw = 2.5, color=:red, label = L"f_{X}(x)") # Agregamos la pdf de X

py = histogram(y1, normalize =:pdf, color =:lightblue, label = "");
histogram!(py, y2, normalize =:pdf, color =:orange, label = "",
        seriesalpha = 0.20);
plot!(py, xlims = (0.0, 1.0), ylims = (0.0,8.0), title = L"Histograma\;Beta(0.5,2)");
f(x::Float64) = pdf(Y, x)
plot!(py, f, lw = 2.5, color=:red, label = L"f_{Y}(y)") # Agregamos la pdf de Y

####################################################################################################################################################

## Ejemplos: Transformación de una muestra aleatoria.
# Es de interés transformar la información de una muestra aleatoria X = (X_1,...,X_n) de la forma T = t(X_1,...,X_n)
# Ejemplo: Sea una m.a. X = (X_1,...,X_n) de Unif(0,1) y sea T = max{X_1,...,X_n}, realicemos simulación de T.

"""
    rand_T(m::Int64, n::Int64)

Devuelve una simulación de tamaño m para T = max{X_1,...,X_n} donde X = (X_1,...,X_n) es una m.a. de Unif(0,1).

"""
function rand_T(m::Int64, n::Int64)
    u = rand(m, n) # 'mxn' valores de Unif(0,1)
    t = maximum(u, dims = 2) # Aplica la función máximo por filas 
    return t
end
n = 5;
t = rand_T(1000, n); # Simulación de tamaño 1000 de T = max{X_1,...,X_n}
f(x::Float64) = n*x^(n-1); 

p = histogram(t, normalize =:pdf, label = "", color =:lightblue); # Histograma normalizado
plot!(p, f, label = L"f_T", lw = 2.5, color=:orange); # Agregamos la pdf de X
plot!(p, xlims = (0,1.0), ylims = (0,3.0)); # Límites de los ejes
plot!(p, xticks = 0:0.2:1.0, yticks = 0:0.5:3.0); # Separación de los ejes
plot!(p, title = "Histograma de X");
vline!(p, [mean(t)], lw = 3.5, color = :green, linestyle = :dash,
label = L" \bar{t}_n")

savefig(p, dir * "Histograma de T.png")

####################################################################################################################################################

##### Fiin del Módulo 4. Espero les haya gustado :D