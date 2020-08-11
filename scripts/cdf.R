# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)

# Importar datos de casos de desaparición forzada (cdf)
CasosDF <- read_excel("rawd/CasosDF.xlsx")

# Animación de número de vćtimas en el tiempo 
cdf <- ggplot(subset(CasosDF, ANNOH != 0)) + 
  aes(ANNOH) +
  geom_line(stat = "count", size = 2) + 
  transition_reveal(along = ANNOH)

animate(cdf, fps = 12, duration =20, 
        renderer = ffmpeg_renderer(format = "mp4"), 
        width = 720, height = 480, rewind = FALSE)

anim_save("cdf.mp4", animation = last_animation())