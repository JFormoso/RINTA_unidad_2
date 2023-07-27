# Sólamente el paquete ggplot2
#install.packages("ggplot2")

# O junto con la familia tidyverse
#install.packages("tidyverse")

# Solo
library("ggplot2")

# O junto con la familia tidyverse
library("tidyverse")

## Primer gráfico paso a paso
data(iris)
head(iris)

# definimos los datos
ggplot(data = iris)

# objetivo mostrar la relación que existe entre las características de la flor `Sepal.Width` y `Sepal.Length`, y potencialmente ver si esta es similar entre especies

# información del mapping
ggplot(data = iris) +
  aes(x = Sepal.Width, y = Sepal.Length)

# agregamos una geometría - gráfico de dispersión
ggplot(data = iris) +
  aes(x = Sepal.Width, y = Sepal.Length) +
  geom_point()

# agregarle una función para ver la relación entre variables
ggplot(data = iris) +
  aes(x = Sepal.Width, y = Sepal.Length) +
  geom_point() +
  geom_line(stat = 'smooth', method = 'lm')


#agregar la información de `Species` con atributos estéticos `color`
ggplot(data = iris) +
  aes(x = Sepal.Width, y = Sepal.Length, color = Species) +
  geom_point() +
  geom_line(stat = 'smooth', method = 'lm')

#agregar la información de `Species` con atributos estéticos `shape`
ggplot(data = iris) +
  aes(x = Sepal.Width, y = Sepal.Length, shape = Species) +
  geom_point() +
  geom_line(stat = 'smooth', method = 'lm')

# combinamos atributos
ggplot(data = iris) +
aes(x = Sepal.Width, y = Sepal.Length,   size = Petal.Width, color = Petal.Length) +
  geom_point() 

# modificar nombres de los ejes
ggplot(data = iris) +
  aes(x = Sepal.Width, y = Sepal.Length,size = Petal.Width, color = Petal.Length) +
  geom_point() +
    labs(x = "Sepal width (cm)", y = "Sepal length (cm)",
       color = "Petal length (cm)", size = "Petal width (cm)")


######################################################################
## Geometrías: los bloques para construir gráficos

# Gráficos de puntos
ggplot(data = iris) +
  aes(x = Sepal.Width, y = Sepal.Length) +
  geom_point() +
  labs(x = "Sepal width (cm)", y = "Sepal length (cm)",
       title = "Gráfico de dispersión")

#relación variable cuantitativa vs var cualitativa 
ggplot(data = iris) +
  aes(x = Species, y = Sepal.Width) +
  geom_point() +
  labs(x = "Species", y = "Sepal width (cm)",
       title = "Gráfico de dispersión")

# agregar un ruido aleatorio

ggplot(data = iris) +
aes(x = Species, y = Sepal.Width) +
  geom_jitter(width = 0.2) +
  labs(x = "Species", y = "Sepal width (cm)",
       title = "Gráfico de puntos")

# agregar una estadística resumen

ggplot(data = iris) +
  aes(x = Species, y = Sepal.Width) +
  geom_jitter(width = 0.1) +
  geom_point(stat = "summary", fun = mean, color = "red") +
  labs(x = "Species", y = "Sepal width (cm)",
       title = "Gráfico de puntos")


# Boxplot o diagramas de cajas
ggplot(data = iris) +
  aes(x = Species, y = Petal.Length) +
  geom_boxplot() +
  labs(x = "Species", y = "Petal length (cm)",
       title = "Boxplot")

#outliers _extremos_, es necesario indicar `coef = 3`
ggplot(data = iris) +
  aes(x = Species, y = Petal.Length) +
  geom_boxplot(coef = 3) +
  labs(x = "Species", y = "Petal length (cm)",
       title = "Boxplot")

# combinar geometrias
ggplot(data = iris) +
  aes(x = Species, y = Petal.Length) +
  geom_boxplot(coef = 3) +
  geom_point(stat = "summary", fun = mean, color = "red") +
  labs(x = "Species", y = "Petal length (cm)",
       title = "Boxplot")

# agregar ruido

ggplot(data = iris) +
  aes(x = Species, y = Petal.Length) +
  geom_boxplot(coef = 3) +
  geom_point(stat = "summary", fun = mean, color = "red") +
  geom_jitter() +
  labs(x = "Species", y = "Petal length (cm)",
       title = "Boxplot recargado")

# Gráfico de tipo violín
ggplot(data = iris) +
  aes(x = Species, y = Petal.Length) +
  geom_violin() +
  geom_point(stat = "summary", fun = mean, color = "red") +
  labs(x = "Species", y = "Petal length (cm)",
       title = "Violin plot")

### Histogramas, poligonos de frecuencia y densidad
ggplot(data = iris) +
  aes(x = Petal.Length) +
  geom_histogram() +
  labs(x = "Petal length (cm)",
       title = "Histograma")


#argumento `binwidth` y `bins` podemos controlar el ancho y el número de clases. 
# `fill` o `color` podemos diferenciar entre _S. versicolor_ y _S. virginica_.


ggplot(data = iris) +
  aes(x = Petal.Length, fill = Species) +
  geom_histogram() +
  labs(x = "Petal length (cm)",  fill = "Species",
       title = "Histograma")


# `geom_frepoly()` permita ver grupos superpuestos.


ggplot(data = iris) +
  aes(x = Petal.Length, color = Species) +
  geom_freqpoly() +
  labs(x = "Petal length (cm)",  fill = "Species",
       title = "Polígono de frecuencias")


#gráfica de densidad, `geom_density ()` + `geom_rug()`


ggplot(data = iris) +
  aes(x = Petal.Length, color = Species) +
  geom_density() +
   labs(x = "Petal length (cm)",  fill = "Species",
       title = "Densidades")


### Graficos de barras o columnas

#`geom_bar()` y `geom_col()`. 
# La diferencia radica en el tipo de `stat` que se calcula y representa en la altura de las barras. 
# 
# `geom_bar()` hace que la altura de la barra sea proporcional al número de casos en cada grupo (o si se proporciona la estética del peso, la suma de los pesos) y por lo tanto usa `stat_count()`. Esto es de utilidad para cuando queremos hacer un gráfico de frecuencias de una variable discreta.

ggplot(data = iris) +
  aes(x = Species) +
  geom_bar() +
  labs(title = "Frecuencia especies")
# 
# `geom_col()` sirve para representar datos únicos en la altura de las barras ya que usa `stat_identity()`

ggplot(data = iris) +
  aes(x = Species, y = Petal.Length) +
  geom_col() +
  labs(title = "Sumatoria de longitud de pétalos",
       y = "Total Petal length (cm)")


ggplot(data = iris) +
  aes(x = Species, y = Petal.Length) +
  geom_bar(stat = "summary", fun = mean) +
  labs(title = "Longitud promedio de los pétalos (cm)",
       x = "Especie")


### Graficos medias e intervalos

library(dplyr)
meds_sd <- group_by(iris, Species) %>% 
  summarise(ybar = mean(Petal.Length), s = sd(Petal.Length))
meds_sd

ggplot(data = meds_sd) +
  aes(x = Species, y = ybar, ymin = ybar - s, ymax = ybar + s) +
  geom_col() +
  geom_errorbar(width  = 0.1) +
  labs(title = "Longitud promedio de los pétalos (cm)",
       x = "Especie", y = "Longitud promedio de los pétalos (cm)")


# geometría `geom_pointrage()`:
  
  
ggplot(data = meds_sd) +
  aes(x = Species, y = ybar, ymin = ybar - s, ymax = ybar + s) +
  geom_pointrange() +
  labs(title = "Longitud promedio de los pétalos (cm)",
       x = "Especie", y = "Longitud promedio de los pétalos (cm)")


#definir `data` y `aes` en cada layer + `theme_classsic()`.


ggplot() +
  geom_jitter(
    data = iris, 
    aes(x = Species, y = Petal.Length),
    color = "gray", width = 0.1
  ) +
  geom_pointrange(
    data = meds_sd, 
    aes(x = Species, y = ybar, ymin = ybar - s, ymax = ybar + s)
  ) +
  labs(title = "Longitud promedio de los pétalos (cm)",
       x = "Especie", y = "Longitud promedio de los pétalos (cm)") +
  theme_classic()

# ver library(esquisse)

### Gráficos de torta

ggplot(data = iris) +
  aes(x = "", fill = Species) +
  geom_bar(width = 1, color = "white") +
  coord_polar("y") +
  labs(title = "Frecuencia especies") +
  theme_void()

### Gráficos de texto
ggplot(data = iris) +
  aes(x = Sepal.Width, y = Sepal.Length) +
  geom_text(aes(label = Species)) +
  labs(x = "Sepal width (cm)", y = "Sepal length (cm)")

# Instalar ggrepel si no está instalado
# install.packaes('ggrepel')

# Cargar ggrepel
library(ggrepel)

# Gráfico con ggrepel::geom_text_repel()
ggplot(data = iris) +
  aes(x = Sepal.Width, y = Sepal.Length) +
  geom_text_repel(aes(label = Species)) +
  labs(x = "Sepal width (cm)", y = "Sepal length (cm)",
       title = "Gráfico de dispersión")

#geometrías extra comúnmente usadas
ggplot() +
  geom_jitter(
    data = iris, 
    aes(x = Species, y = Petal.Length),
    color = "gray", width = 0.1
  ) +
  geom_pointrange(
    data = meds_sd, 
    aes(x = Species, y = ybar, ymin = ybar - s, ymax = ybar + s)
  ) +
  geom_hline(data = iris, aes(yintercept = mean(Petal.Length))) +
  labs(title = "Longitud promedio de los pétalos (cm)",
       x = "Especie", y = "Longitud promedio de los pétalos (cm)") +
  theme_classic()

# lineas verticales, horizontales o con una determinada orientación
ggplot(iris) +
  aes(x = Petal.Length, y = Petal.Width) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0) +
  labs(title = "Relacion entre longitud y ancho de los pétalos", x = "Longitud de los pétalos (cm)",
       y = "Ancho de los pétalos (cm)") +
  lims(x = c(0, 8), y = c(0,8)) +
  theme_classic()


## Sistemas de coordendas

ggplot(data = iris) +
  aes(x = Species, y = Petal.Width) +
  geom_bar(stat = "summary", fun  = mean) +
  coord_flip() 


ggplot(data = iris) +
  aes(x = Petal.Length, y = Petal.Width) +
  geom_point(stat = "summary", fun  = mean) +
  coord_fixed(ratio = 2)


#aplicar transformaciones `coord_trans()`. 

ggplot(data = iris) +
  aes(x = Petal.Length, y = Petal.Width) +
  geom_point(stat = "summary", fun  = mean) +
  coord_trans(y = "log10", x = "sqrt") 

###########################################################

## Gráficos condicionales o por paneles: `facets`

ggplot(data = iris) +
  aes(x = Sepal.Width, y = Sepal.Length) +
  geom_point() +
  geom_line(stat = 'smooth', method = 'lm') +
  facet_wrap(~ Species)


ggplot(iris) +
 aes(x = Sepal.Length) +
 geom_histogram(bins = 30L, fill = "#112446") +
 coord_flip() +
 theme_minimal() +
 facet_wrap(vars(Species))
# Creación de una segunda variable para ilustrar el ejemplo
iris$Petalo4 <- iris$Petal.Length > 4

# Gráfico usando facet_grid

# Creacion de una segunda vairable para ilustrar el ejemplo
iris$Petalo4 <- iris$Petal.Length > 4

# Gráfico usando facet_grid
ggplot(data = iris) +
  aes(x = Sepal.Width, y = Sepal.Length) +
  geom_point() +
  geom_line(stat = 'smooth', method = 'lm') +
  facet_grid(Petalo4 ~ Species)

#Aquí vemos como las especies quedaron en columnas y se generaron dos filas de acuerdo a si las observaciones tenian una longitud de pétalo mayor a 4 cm.
#Por defecto los subplots o `facets` tienen escalas iguales en ambos ejes. A veces conviene dejar una o las dos escalas variar libremente, esto se hace con el argumento `scales` y las palabras clave `'free_y'`, `'free_x'` o `'free'` (ambas a la vez).


ggplot(data = iris) +
  aes(x = Sepal.Width, y = Sepal.Length) +
  geom_point() +
  geom_line(stat = 'smooth', method = 'lm') +
  facet_wrap(~ Species, scales = "free")


# nombres ad-hoc:
  
 # Vector con los nombres que queremos mostrar
lbls <- c(
  setosa = "I. setosa",
  virginica = "I. virginica",
  versicolor = "I. versicolor"
)

# Grafico con custom labels
ggplot(data = iris) +
  aes(x = Sepal.Width, y = Sepal.Length) +
  geom_point() +
  geom_line(stat = 'smooth', method = 'lm') +
  facet_wrap(~ Species, labeller = labeller(Species = lbls))


library(plotly)
plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length,
        type = "scatter", name = ~ Species)


# gráfico ggplot
plt <- ggplot(data = iris) + 
  aes(x = Sepal.Length, y = Petal.Length, color = Species) +
  geom_point()
plt

# Conversión a plotly


ggplotly(plt)




