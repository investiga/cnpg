# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)
library(ggthemes)
library(lubridate)

# Importar archivos de casos y víctimas y cambiar tipos de datos en columnas con errores

# Acciones bélicas
CasosAB <- read_excel("rawd/CasosAB.xlsx", 
                      col_types = c("numeric", "text", "numeric", 
                                    "numeric", "numeric", "text", "text", 
                                    "text", "text", "text", "text", "text", 
                                    "text", "text", "text", "text", "text", 
                                    "text", "numeric", "text", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "text", "text"))

# Casos de acciones bélicas ocurridas en tiempo y espacio

CasosAB %>%
  filter(ANNOH >= 1958L & ANNOH <= 2018L, MESH >= 1L & MESH <= 12L,
         DIAH >= 1L & DIAH <= 31L) %>%
  #count(ANNOH) %>%
  #arrange(desc(n))
  ggplot() +
  aes(x = ANNOH) +
  geom_bar() +
  #geom_histogram(bins = 16L, fill = "#0c4c8a") +
  labs(x = "Año", y = "Década", title = "Acciones bélicas", 
       subtitle = "Casos", caption = "Fuente: elaborado con datos del CNMH") +
  theme_economist()

CasosAB %>%
  filter(ANNOH == 2018) %>%
  count(ANNOH)

casosab %>% 
  count(ANNOH) %>%
  summarise(ANNOH, total = n())


#Nacional
ggplot(subset(CasosAB, ANNOH != 0), 
       aes(ANNOH)) +
  geom_bar() +
  scale_x_binned(breaks = seq(1954, 2020, 4)) +
  scale_y_continuous(breaks = seq(0, 7000, 1000)) +
  theme_hc(base_size = 16)

# Region
ggplot(subset(CasosAB, ANNOH != 0), aes(ANNOH)) +
  facet_wrap(~REGION) +
  geom_bar()

# Departamentos
ggplot(subset(CasosAB, ANNOH != 0), 
       aes(ANNOH)) +
  facet_wrap(~DEPTO_CASO) +
  geom_bar() +
  scale_x_binned(breaks = seq(1954, 2018, 4))

# Modalidad
ggplot(cab1, aes(ANNOH)) +
  facet_wrap(~Modalidad) +
  geom_bar()

# Iniciativa
ggplot(cab1, aes(ANNOH)) +
  facet_wrap(~Iniciativa) +
  geom_bar()

# Tipo unidad atacada
ggplot(cab1, aes(ANNOH)) +
  facet_wrap(~TipoUnidadAtacada) +
  geom_bar()

# Presunto responsable
ggplot(cab1, aes(ANNOH)) +
  facet_wrap(~PRESUNTO_REPONSABLE) +
  geom_bar()

# Descripcion presunto responsable
ggplot(cab1, aes(ANNOH)) +
  facet_wrap(~DESCRIPCION_PRESUNTO_RESPONSABLE) +
  geom_bar()

# Presunto responsable 2
ggplot(cab1, aes(ANNOH)) +
  facet_wrap(~PRESUNTO_REPONSABLE2) +
  geom_bar()

# Descripcion presunto responsable 2
ggplot(cab1, aes(ANNOH)) +
  facet_wrap(~DESCRIPCION_PRESUNTO_RESPONSABLE2) +
  geom_bar()

# Presunto responsable 3
ggplot(cab1, aes(ANNOH)) +
  facet_wrap(~PRESUNTO_REPONSABLE3) +
  geom_bar()

# Descripcion presunto responsable 3
ggplot(cab1, aes(ANNOH)) +
  facet_wrap(~DESCRIPCION_PRESUNTO_RESPONSABLE3) +
  geom_bar()

# Capturas
ggplot(cab1, aes(ANNOH, Capturas)) +
  geom_jitter(alpha = 0.5)

# Capturas (hay que limpiar estos registros)
ggplot(cab1, aes(ANNOH, GrupoPertenecenLosCapturados)) +
  geom_point()

group_by(cab1, GrupoPertenecenLosCapturados) %>%
  summarise(total=n()) %>%
  arrange(desc(total)) -> g

ggplot(subset(g, !is.na(GrupoPertenecenLosCapturados)), 
       aes(total, GrupoPertenecenLosCapturados)) +
  geom_point()
  
# Lesionados civiles
ggplot(subset(cab1, LesionadosCiviles != 0), 
       aes(ANNOH, LesionadosCiviles, size=LesionadosCiviles)) +
  geom_point() +
  scale_x_log10()

# total civiles muertos
ggplot(subset(cab1, TotalCivilesMuertos != 0), 
       aes(ANNOH, TotalCivilesMuertos, size = TotalCivilesMuertos)) +
  geom_jitter()

# Ventaja militar
ggplot(cab1, aes(VentajaMilitar, ANNOH, fill = VentajaMilitar)) +
  geom_bar(stat="identity", position=position_dodge()) +
  coord_flip()

# Agrupar casos por variable de interés
cabgv <- group_by(cab1, Capturas)
cabgv1 <- summarise(cabgv, total=n())

ggplot (data=subset(cabgv, !is.na(Capturas)), aes(x=Capturas)) +
  geom_bar(stat = "bin") +
  scale_x_log10()


ggplot(cabgv1, aes(Capturas)) +
  geom_bar(stat = "bin")

ggplot(cabg, aes(fct_rev(fct_infreq(Capturas)))) +
  geom_bar() +
  coord_flip()

ggplot(cab1, aes(ANNOH)) +
  geom_bar()
