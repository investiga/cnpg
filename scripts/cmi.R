# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)

# Importar datos de casos de minas (cmi)
CasosMI <- read_excel("rawd/CasosMI.xlsx")

# Animación de número de casos en el tiempo 
cmi <- ggplot(subset(CasosMI, ANNOH != 0)) + 
  aes(ANNOH) +
  geom_line(stat = "count", size = 2) + 
  transition_reveal(along = ANNOH)

animate(cmi, fps = 12, duration =20, 
        renderer = ffmpeg_renderer(format = "mp4"), 
        width = 720, height = 480, rewind = FALSE)

anim_save("cmi.mp4", animation = last_animation())