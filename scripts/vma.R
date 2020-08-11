# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)

# Importar datos de víctimas de masacres (vma)
VictimasMA <- read_excel("rawd/VictimasMA.xlsx")

# Animación de número de vćtimas en el tiempo 
vma <- ggplot(subset(VictimasMA, ANNOH != 0)) + 
  aes(ANNOH) +
  geom_line(stat = "count", size = 2) + 
  transition_reveal(along = ANNOH)

animate(vma, fps = 12, duration =20, 
        renderer = ffmpeg_renderer(format = "mp4"), 
        width = 720, height = 480, rewind = FALSE)

anim_save("vma.mp4", animation = last_animation())