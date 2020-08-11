# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)

# Importar datos de casos de ataques a poblados (ap)
CasosAP <- read_excel("rawd/CasosAP.xlsx")

# Animación de los casos ocurridos en el tiempo 
cap <- ggplot(subset(CasosAP, ANNOH != 0)) + 
  aes(ANNOH) +
  geom_line(stat = "count", size = 2) + 
  transition_reveal(along = ANNOH)

animate(cap, fps = 12, duration =20, 
        renderer = ffmpeg_renderer(format = "mp4"), 
        width = 720, height = 480, rewind = FALSE)

anim_save("cap.mp4", animation = last_animation())

# Gráficos de casos de ap
# Region
ggplot(subset(CasosAP, ANNOH != 0), 
       aes(ANNOH)) +
  facet_wrap(~REGION) +
  stat_bin(binwidth = 1)

# Departamentos
ggplot(subset(CasosAP, ANNOH != 0), 
       aes(ANNOH)) +
  facet_wrap(~DEPTO_CASO) +
  stat_bin(binwidth = 1)

# Presunto responsable
ggplot(subset(CasosAP, ANNOH != 0), 
       aes(ANNOH)) +
  facet_wrap(~PRESUNTO_REPONSABLE) +
  stat_bin(binwidth = 1)

# Descripcion presunto responsable
ggplot(subset(CasosAP, ANNOH != 0), 
       aes(ANNOH)) +
  facet_wrap(~DESCRIPCION_PRESUNTO_RESPONSABLE) +
  stat_bin(binwidth = 1)