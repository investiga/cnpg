# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)

# Importar datos de casos de atentados terroristas (at)
CasosAT <- read_excel("rawd/CasosAT.xlsx")

# Animación de los casos ocurridos en el tiempo 
cat <- ggplot(subset(CasosAT, ANNOH != 0)) + 
  aes(ANNOH) +
  geom_line(stat = "count", size = 2) + 
  transition_reveal(along = ANNOH)

animate(cat, fps = 12, duration =20, 
        renderer = ffmpeg_renderer(format = "mp4"), 
        width = 720, height = 480, rewind = FALSE)

anim_save("cat.mp4", animation = last_animation())
