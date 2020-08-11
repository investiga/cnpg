# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)

# Importar datos de casos de daño a bienes civiles (cdb)
CasosDB <- read_excel("rawd/CasosDB.xlsx")

# Animación de número de vćtimas en el tiempo 
cdb <- ggplot(subset(CasosDB, ANNOH != 0)) + 
  aes(ANNOH) +
  geom_line(stat = "count", size = 2) + 
  transition_reveal(along = ANNOH)

animate(cdb, fps = 12, duration =20, 
        renderer = ffmpeg_renderer(format = "mp4"), 
        width = 720, height = 480, rewind = FALSE)

anim_save("cdb.mp4", animation = last_animation())