# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)

# Importar datos de víctimas de reclutamiento y utilización de menores (vru)
VictimasRU <- read_excel("rawd/VictimasRU.xlsx")

# Animación de número de vćtimas en el tiempo 
vru <- ggplot(subset(VictimasRU, ANNOH != 0)) + 
  aes(ANNOH) +
  geom_line(stat = "count", size = 2) + 
  transition_reveal(along = ANNOH)

animate(vru, fps = 12, duration =20, 
        renderer = ffmpeg_renderer(format = "mp4"), 
        width = 720, height = 480, rewind = FALSE)

anim_save("vru.mp4", animation = last_animation())