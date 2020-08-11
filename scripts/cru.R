# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)

# Importar datos de casos de reclutamiento y utilización de menores (cru)
CasosRU <- read_excel("rawd/CasosRU.xlsx")

# Animación de número de casos en el tiempo 
cru <- ggplot(subset(CasosRU, ANNOH != 0)) + 
  aes(ANNOH) +
  geom_line(stat = "count", size = 2) + 
  transition_reveal(along = ANNOH)

animate(cru, fps = 12, duration =20, 
        renderer = ffmpeg_renderer(format = "mp4"), 
        width = 720, height = 480, rewind = FALSE)

anim_save("cru.mp4", animation = last_animation())