### Módulo 3: Simulación y visualización de variables aleatorias en Julia.
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
# Directorio de Imágenes
dir = "D:\\Escritorio\\Enrique Lecuona\\Clases\\Cursos de Programación\\Simulación y Visualización de datos en Julia\\Imagenes\\"

####################################################################################################################################################

## En este módulo vamos a enfocarnos en la simulación de variables aleatorias (v.a.). Trataremos tres formas de realizar esto
# 1) Simulación directa mediante la paquetería 'Distributions'
# 2) Simulación de transformaciones de variables aleatorias.
# 3) Simulación utilizando el teorema de la transformada inversa.

####################################################################################################################################################

## Simulación de v.a. mediante la paquetería 'Distributions'.
# La paquetería 'Distributions' cuenta con simuladores de variables aleatorias independientes para la mayoría de los modelos clásicos.

U = Uniform(2,3) # Uniforme(2,3)
u = rand(U, 10000); # Utilizamos la función rand para generar valores aleatorios de cualquier v.a. definida sobre la paquetería 'Distributions'
X = Normal(3,2) # Normal(3,2)
x = rand(X, 10000);

p1 = histogram(u, normalize =:pdf, label = "", 
    color =:lightblue, legend = :topright); # Histograma normalizado
plot!(p1, U, label = L"f_U", lw = 2.5, color=:orange); # Agregamos la pdf de U
plot!(p1, xlims = (1.8,3.2), ylims = (0,1.4)); # Límites de los ejes
plot!(p1, xticks = 2:0.2:3, yticks = 0:0.2:1.4); # Separación de los ejes
plot!(p1, title = "Uniforme(2,3)");
vline!(p1, [mean(U)], lw = 2.5, color = :red, linestyle = :dash,
    label = L"E(U)")

p2 = histogram(x, normalize =:pdf, label = "", color =:lightblue); # Histograma normalizado
plot!(p2, X, label = L"f_X", lw = 2.5, color=:orange); # Agregamos la pdf de X
plot!(p2, xlims = (-3,9), ylims = (0,0.22)); # Límites de los ejes
plot!(p2, xticks = -3:3:9, yticks = 0:0.05:0.25); # Separación de los ejes
plot!(p2, title = "Normal(3,2)");
vline!(p2, [mean(X)], lw = 3.5, color = :green, linestyle = :dash,
label = L"E(X)")

p = plot(p1, p2, layout = (1, 2), legend = false)

nombre_archivo = "Histogramas Uniforme y Normal.png"
savefig(p, dir * nombre_archivo)

####################################################################################################################################################

## Simulación de transformaciones de variables aleatorias.
# Sea X una variable aleatoria la cual ya sabemos simular, si deseamos simular datos de Y = G(X) solamente aplicamos la función 'G' a la simulación de X.
# Ejemplo: Sea Y = |X| donde X∽Normal(0,1), queremos simular datos de la v.a. Y

X = Normal(0,1);
x = rand(X, 10000); # Simulación de la variable aleatoria X.
y = abs.(x); # Aplicamos la función 'g' a cada valor de la simulación de 'x'.
[x y][1:10,:] # Veamos los primeros diez datos de nuestra simulacíon.
Y = Chi(1); # Variable aleatoria chi-cuadrada con un grado de libertad

# Recordemos que si X∽Normal(0,1) y Y = |X|, entonces Y∽χ(1)
p = histogram(y, normalize =:pdf, label = "", color =:lightblue); # Histograma normalizado
plot!(p, Y, label = L"f_Y", lw = 2.5, color=:orange); # Agregamos la pdf de X
plot!(p, xlims = (0,3.0), ylims = (0,1.0)); # Límites de los ejes
plot!(p, xticks = 0:0.5:3.0, yticks = 0:0.2:0.9); # Separación de los ejes
plot!(p, title = "Histograma de Y");
vline!(p, [mean(y)], lw = 3.5, color = :green, linestyle = :dash,
label = L" \bar{y}_n")
nombre_archivo = "Transformación ji-cuadrada.png"
savefig(p, dir * nombre_archivo)


####################################################################################################################################################

## Simulación utilizando el teorema de la transformada inversa.
# Podemos utilizar el teorema de la transformada inversa para simular datos de cualquier variable aleatoria.
# Ejemplo: Sea X una v.a con función de densidad f_X(x) = nx^{n-1} en el intervalo (0,1) para n en los naturales
# Teo. Transformada Inversa: Y = F_X^{-1}(U) entonces F_Y = F_X

n = 3;
u = rand(10000); # Muestra Unif(0,1)
f(x::Float64) = n*x^(n-1); # Densidad de X
q(u::Float64) = u^(1/n); # Función de cuantiles de X
x = q.(u);
[u x][1:10,:]

p = histogram(x, normalize =:pdf, label = "", color =:lightblue); # Histograma normalizado
plot!(p, f, label = L"f_X", lw = 2.5, color=:orange); # Agregamos la pdf de X
plot!(p, xlims = (0,1.0), ylims = (0,3.0)); # Límites de los ejes
plot!(p, xticks = 0:0.2:1.0, yticks = 0:0.5:3.0); # Separación de los ejes
plot!(p, title = "Histograma de X");
vline!(p, [mean(x)], lw = 3.5, color = :green, linestyle = :dash,
label = L" \bar{x}_n")
nombre_archivo = "Histograma de X con parametró n.png"
savefig(p, dir * nombre_archivo)

####################################################################################################################################################

##### Fin del Módulo 3. Espero les haya gustado :D
