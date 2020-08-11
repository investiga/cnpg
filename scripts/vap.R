# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)

# Víctimas de ataques a poblados (ap)
VictimasAP <- read_excel("rawd/VictimasAP.xlsx")

# Animación víctimas sumadas en el tiempo 
vap <- ggplot(subset(VictimasAP, ANNOH != 0), 
  aes(ANNOH)) +
  geom_line(stat = "count", size = 2) + 
  transition_reveal(along = ANNOH)

animate(vap, fps = 12, duration = 20, 
        renderer = ffmpeg_renderer(format = "mp4"), 
        width = 720, height = 480)

anim_save("vap.mp4")

# Gráficos de víctimas ap
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
