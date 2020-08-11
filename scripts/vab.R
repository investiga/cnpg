# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)

# Ataques a poblados

VictimasAB <- read_excel("rawd/VictimasAB.xlsx", 
                         col_types = c("numeric", "numeric", "numeric", 
                                       "numeric", "numeric", "text", "text", 
                                       "text", "text", "text", "text", "text", 
                                       "text", "text", "text", "text", "text"))

vab0 <- filter(VictimasAB, ANNOH == 0)
vab1 <- filter(VictimasAB, ANNOH != 0)

# Víctimas de acciones bélicas ocurridas en tiempo y espacio
# Departamento
ggplot(vab1, aes(ANNOH)) +
  facet_wrap(~DEPTO_CASO) +
  geom_bar()

# Víctimas ab por departamento
ggplot(vab1, aes(fct_infreq(DEPTO_CASO))) +
  geom_bar() +
  coord_flip()

# Víctimas ab por sexo
ggplot(vab1, aes(Sexo)) +
  geom_bar()

# Víctimas ab por edad
ggplot(subset(vab1, !is.na(Edad)), aes(Edad)) +
  geom_bar()

# Conteo ab por edad
group_by(vab1, Edad) %>%
  summarise(total=n()) %>%
  arrange(desc(total))

# Víctimas ab por edad
ggplot(subset(vab1, !is.na(Etnia)), aes(Etnia)) +
  geom_bar()

# Conteo víctimas por etnia
group_by(vab1, Etnia) %>%
  summarise(total=n()) %>%
  arrange(desc(total))

# Víctimas ab por ocupación
ggplot(vab1, aes(OcupacionVictima)) +
  geom_bar() +
  coord_flip()

# Conteo víctimas por ocupación
group_by(vab1, OcupacionVictima) %>%
  summarise(total=n()) %>%
  arrange(desc(total))

# Víctimas ab por calidad vćtima
ggplot(vab1, aes(CalidadVictima)) +
  geom_bar() +
  coord_flip()

# Conteo víctimas por calidad
group_by(vab1, CalidadVictima) %>%
  summarise(total=n()) %>%
  arrange(desc(total))

# Víctimas ab por población vulnerable
ggplot(subset(vab1, !is.na(TipoPoblacionVulnerable)), aes(TipoPoblacionVulnerable)) +
  geom_bar() +
  coord_flip()

# Conteo víctimas por población vulnerable
group_by(vab1, TipoPoblacionVulnerable) %>%
  summarise(total=n()) %>%
  arrange(desc(total))

# Víctimas ab por Grupo
ggplot(subset(vab1, !is.na(Grupo)), aes(Grupo)) +
  geom_bar() +
  coord_flip()

# Conteo víctimas por grupo
group_by(vab1, Grupo) %>%
  summarise(total=n()) %>%
  arrange(desc(total))

# Víctimas ab descripción grupo
ggplot(subset(vab1, !is.na(DESCRIPCION_GRUPO)), aes(DESCRIPCION_GRUPO)) +
  geom_bar() +
  coord_flip()

# Conteo víctimas descripción grupo
group_by(vab1, DESCRIPCION_GRUPO) %>%
  summarise(total=n()) %>%
  arrange(desc(total))




ggplot(data = subset (vab1, !is.na(DEPTO_CASO)), 
       aes(x = ANNOH, y = DEPTO_CASO)) +
  facet_wrap(~DEPTO_CASO) +
  geom_line()

ggplot(data = subset (vab1, !is.na(TipoPoblacionVulnerable)), 
       aes(x=ANNOH, y=TipoPoblacionVulnerable)) +
  geom_jitter()

ggplot(data = subset (vab1, !is.na(Sexo)), 
       aes(x=ANNOH, y=Sexo)) +
  geom_jitter(alpha=0.1)

