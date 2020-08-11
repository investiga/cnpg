# Cargar librerias necesarias para el proyecto
library(readr)
library(tidyverse)
library(rio)
library(readxl)
library(gganimate)
library(ggthemes)
library(dplyr)
library(lubridate)
library(tibble)
library(data.table)
library(ggrepel)

# Importar archivos de casos y víctimas; cambio de datos en columnas con errores

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
VictimasAB <- read_excel("rawd/VictimasAB.xlsx", 
                         col_types = c("numeric", "numeric", "numeric", 
                                       "numeric", "numeric", "text", "text", 
                                       "text", "text", "text", "text", "text", 
                                       "text", "text", "text", "text", "text"))

# Ataques a poblados
CasosAP <- read_excel("rawd/CasosAP.xlsx")
VictimasAP <- read_excel("rawd/VictimasAP.xlsx")

# Asesinatos selectivos
CasosAS <- read_excel("rawd/CasosAS.xlsx", 
                      col_types = c("numeric", "text", "numeric", 
                                    "numeric", "numeric", "text", "text", 
                                    "text", "text", "text", "text", "text", 
                                    "text", "text", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "text", "text", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "text"))

VictimasAS <- read_excel("rawd/VictimasAS.xlsx", 
                         col_types = c("numeric", "numeric", "numeric", 
                                       "numeric", "numeric", "text", "text", 
                                       "text", "text", "text", "text", "text", 
                                       "text", "text", "skip", "text", "text", 
                                       "text"))

# Atentados terroristas
CasosAT <- read_excel("rawd/CasosAT.xlsx")
VictimasAT <- read_excel("rawd/VictimasAT.xlsx")

# Daños a bienes civiles
CasosDB <- read_excel("rawd/CasosDB.xlsx", 
                      col_types = c("numeric", "text", "numeric", 
                                    "numeric", "numeric", "text", "text", 
                                    "text", "text", "text", "text", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "text", "text", "text", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "text", "text", 
                                    "numeric", "text"))
VictimasDB <- read_excel("rawd/VictimasDB.xlsx")

# Desapariciones forzadas
CasosDF <- read_excel("rawd/CasosDF.xlsx")
VictimasDF <- read_excel("rawd/VictimasDF.xlsx")

# Masacres
CasosMA <- read_excel("rawd/CasosMA.xlsx")
VictimasMA <- read_excel("rawd/VictimasMA.xlsx", 
                         col_types = c("numeric", "numeric", "numeric", 
                                       "numeric", "numeric", "text", "text", 
                                       "text", "text", "text", "text", "text", 
                                       "text", "text", "text", "text", "text", 
                                       "text"))

# Reclutamientos y utilización de menores
CasosRU <- read_excel("rawd/CasosRU.xlsx", 
                      col_types = c("numeric", "text", "numeric", 
                                    "numeric", "numeric", "text", "text", 
                                    "text", "text", "text", "text", "text", 
                                    "text", "text", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "text", "text", "numeric", 
                                    "text"))
VictimasRU <- read_excel("rawd/VictimasRU.xlsx")

# Secuestros
CasosSE <- read_excel("rawd/CasosSE.xlsx")
VictimasSE <- read_excel("rawd/VictimasSE.xlsx")

# Violencias sexuales
CasosVS <- read_excel("rawd/CasoVSI.xlsx", 
                      col_types = c("numeric", "text", "numeric", 
                                    "numeric", "numeric", "text", "text", 
                                    "text", "text", "text", "text", "text", 
                                    "text", "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "text", "text", "numeric", "text"))
VictimasVS <- read_excel("rawd/VictimasVS.xlsx", 
                         col_types = c("numeric", "numeric", "numeric", 
                                       "numeric", "numeric", "text", "text", 
                                       "text", "text", "text", "text", "text", 
                                       "text", "text", "text", "text", "text", 
                                       "text", "text"))

# Eventos por minas
CasosMI <- read_excel("rawd/CasosMI.xlsx", 
                      col_types = c("numeric", "text", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "text", "text", "text", "text", "text", 
                                    "text", "text", "text", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "numeric", 
                                    "text", "numeric", "numeric", "numeric", 
                                    "numeric", "numeric", "text"))
VictimasMI <- read_excel("rawd/VictimasMI.xlsx")

# Unir registros por casos y víctimas totales para conteo y graficación global

l_c <- list(CasosAB, CasosAP, CasosAS, CasosAT, CasosDB, CasosDF, CasosMA,
               CasosMI, CasosRU, CasosSE, CasosVS)
all_c <- rbindlist(l_c, fill = TRUE)

l_v <- list(VictimasAB, VictimasAP, VictimasAS, VictimasAT, VictimasDB, 
               VictimasDF, VictimasMA, VictimasMI, VictimasRU, VictimasSE, VictimasVS)
all_v <- rbindlist(l_v, fill = TRUE)

t_days <- read_csv("outd/t_days.csv", col_types = 
                     cols(Fecha = col_date(format = "%Y-%m-%d")))
t_days$year <- year(t_days$Fecha)
