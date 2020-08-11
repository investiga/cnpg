# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)

# Importar datos de casos de secuestro (cse)
CasosSE <- read_excel("rawd/CasosSE.xlsx")

# Animación de casos en el tiempo 
cse <- ggplot(subset(CasosSE, ANNOH != 0)) + 
  aes(ANNOH) +
  geom_line(stat = "count", size = 2) + 
  transition_reveal(along = ANNOH)

animate(cse, fps = 12, duration =20, 
        renderer = ffmpeg_renderer(format = "mp4"), 
        width = 720, height = 480, rewind = FALSE)

anim_save("cse.mp4", animation = last_animation())

# Casos de secuestros ocurridos en tiempo y espacio
# Region
ggplot(subset(CasosSE, ANNOH != 0), aes(ANNOH)) +
  facet_wrap(~REGION) +
  geom_bar()

# Departamento
ggplot(subset(CasosSE, ANNOH != 0), aes(ANNOH)) +
  facet_wrap(~DEPTO_CASO) +
  geom_bar()

# Region
ggplot(subset(CasosSE, ANNOH != 0 & MUNINICIO_CASO == "GRANADA"), 
       aes(ANNOH, fill = Modalidad)) +
  geom_bar(stat = "bin", position = position_dodge2()) +
  # geom_text(stat = 'count', aes(label=..count..), vjust=-1) +
  scale_color_viridis_d()
  # ylim(0, 38)

ggplot(group_by(subset(CasosSE, ANNOH != 0 & MUNINICIO_CASO == "GRANADA")),
       aes(ANNOH)) +
  geom_point()
