# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)

# Importar datos de casos de asesinatos selectivos (as)
CasosAS <- read_excel("rawd/CasosAS.xlsx")

# Animación de los casos ocurridos en el tiempo 
cas <- ggplot(subset(CasosAS, ANNOH != 0)) + 
  aes(ANNOH) +
  geom_line(stat = "count", size = 2) + 
  transition_reveal(along = ANNOH)

animate(cas, fps = 12, duration =20, 
        renderer = ffmpeg_renderer(format = "mp4"), 
        width = 720, height = 480, rewind = FALSE)

anim_save("cas.mp4", animation = last_animation())
