# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)

# Importar datos de víctimas de violencia sexual (vvs)
VictimasVS <- read_excel("rawd/VictimasVS.xlsx")

# Animación de número de vćtimas en el tiempo 
vvs <- ggplot(subset(VictimasVS, ANNOH != 0)) + 
  aes(ANNOH) +
  geom_line(stat = "count", size = 2) + 
  transition_reveal(along = ANNOH)

animate(vvs, fps = 12, duration =20, 
        renderer = ffmpeg_renderer(format = "mp4"), 
        width = 720, height = 480, rewind = FALSE)

anim_save("vvs.mp4", animation = last_animation())