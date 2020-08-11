# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)

# Importar datos de casos de violencia sexual (cvs)
CasosVS <- read_excel("rawd/CasoVSI.xlsx")

# Animación de número de casos en el tiempo 
cvs <- ggplot(subset(CasosVS, ANNOH != 0)) + 
  aes(ANNOH) +
  geom_line(stat = "count", size = 2) + 
  transition_reveal(along = ANNOH)

animate(cvs, fps = 12, duration =20, 
        renderer = ffmpeg_renderer(format = "mp4"), 
        width = 720, height = 480, rewind = FALSE)

anim_save("cvs.mp4", animation = last_animation())