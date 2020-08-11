# Gráficos globales de víctimas

all_v %>%
  filter(ANNOH >= 1958L & ANNOH <= 2018L) %>%
  ggplot() +
  aes(x = ANNOH) +
  geom_histogram(bins = 30L, fill = "#0c4c8a") +
  theme_minimal()


all_v %>%
  ggplot(aes(ANNOH)) +
  geom_bar()

all_vic_rep %>%
  filter(Id == 482938) -> repet

all_v %>% 
  filter(IdCaso == 157761) -> casox9


casox10 <- rbind(casox6, casox7, casox8, casox9)

All_v_dup %>%
  count(Id) %>%
  group_by(n) %>%
  count()

  group_by(n) %>%
  count()
  
group_by(total) %>%
  count()

All_v_dup %>%
  group_by(Id) %>%
  count(total = n()) %>%
  group_by(total) %>%
  count()
  arrange(desc(total))

all_vic_rep %>%
  filter(Id == 482938) -> repetidos


all_vic_rep %>%
  select(Id, DIAH, MESH, ANNOH) %>%
  count(Id) %>%
  arrange(desc(n)) %>% 
  ggplot(aes(ANOH)) +
  geom_bar()

# Filtrar registros repetidos en total para análisis:
# all_vic_rep <- all_v[duplicated(all_v$Id) | duplicated(all_v$Id, fromLast=TRUE), ]

# Preparar los datos de tiempo
library(lubridate)

vic11 %>%
  filter(ANNOH > 0, MESH > 0, DIAH > 0) %>%
  mutate(Fecha = make_date(ANNOH, MESH, DIAH)) %>%
  count(Fecha) %>%
  arrange(n) -> vicxdia
ggplot(aes(Fecha)) +
  scale_x_date(breaks = seq(as.Date("1958-01-03"), as.Date("2018-05-14"), "4 years")) +
  geom_freqpoly(binwidth = 10)

vicxdia %>%
  ggplot(aes(Fecha)) +
  geom_freqpoly()


vicxdia


# Eliminar datos de mes y año con valor 0
vic13 <- filter(vic11, (ANNOH != 0 & MESH != 0 & DIAH != 0))
# Unir datos de año, mes y día de ocurrencia
vic13_date <- unite(vic13, fecha, ANNOH:MESH, na.rm = TRUE, sep = "-", remove = FALSE)
vic13_date <- unite(vic13_date, Fecha, fecha:DIAH, na.rm = TRUE, sep = "-", remove = FALSE)
# Convertir columna a tipo "Date"
vic13_date$Fecha <- as.Date(vic13_date$Fecha)

(vic13_date$Fecha)

vic13_date %>%
  filter(Fecha > "1958-08-06" & Fecha < "2018-05-15" & !is.na(Fecha)) %>%
  ggplot() +
  aes(x = Fecha) +
  geom_histogram(bins = 21830L, fill = "#0c4c8a") +
  scale_x_date(breaks = seq(as.Date("1958-08-07"), as.Date("2018-05-14"), "4 years")) +
  theme_bw()


as.Date("1962-01-01") - as.Date("2018-05-14")

vic13_date %>%
  as.Date(as.character(vic13_date$Fecha), format="%Y/%m/%d")-
  as.Date(as.character(survey$tx_start), format="%Y/%m/%d")


vic13_date %>%
  filter(Fecha > "1959-01-01" & Fecha < "1963-01-01" & !is.na(Fecha)) %>%
  ggplot() +
  aes(x = Fecha) +
  geom_bar() +
  #geom_histogram(bins = 725L, fill = "#0c4c8a") +
  #scale_x_date(breaks = seq(as.Date("1966-08-07"), as.Date("1970-08-07"), "4 years")) +
  theme_bw()

vic13_date %>%
  group_by(ANNOH, Grupo) %>%
  filter(Grupo == "Guerrilla") %>%
  count()


ggplot(vic13_date) +
  aes(x = Fecha) +
  geom_bar(fill = "#0c4c8a") +
  scale_x_date(breaks = seq(as.Date("1958-08-07"), as.Date("2018-08-07"), "4 years")) +
  ylim(0, 300) +
  theme_minimal()

group_data(vic13_date)

vic13_date %>%
  group_data(Fecha) %>%
  summarise(Fecha) %>%
  arrange(desc(total))


ggplot(vic11_date1, aes(Fecha2)) +
  geom_bar() +
  #geom_vline(xintercept=vic11_date$Fecha[4],linetype=4) +
  scale_x_date(breaks = seq(as.Date("1958-08-07"), as.Date("2018-08-07"), "4 years")) +
  ylim(0, 180)
#theme_bw()




vic11_date <- myd(vic11_date$Fecha)


vic11_y <- filter(vic11, ANNOH != "0")

vic11t$Fecha2 <- paste(vic11t$MESH, vic11t$ANNOH)

vic12 <- as.Date(vic11t$Fecha2)

vic1$Fecha2 <- dmy(vic14$Fecha)



vic15 <- as.Date(vic14, vic14$Fecha, format = "%Y.%m")


vic14$ANNOH <- as_factor(vic14$ANNOH)

vic14$Fecha <- ymd(vic14$Fecha)

vic14$newdate2 <- as.Date.POSIXlt(vic14$ANNOH)

vic14$Fecha <- format(vic14$Fecha, "%Y-%b")


vic14$Fecha1 <- as.character(vic14$Fecha)

vic14$Fecha2 <- as.Date(vic14$Fecha1, "%Y-%m-%d")



ggplot(group_by(vic11, fecha)) +
  aes(fecha) + 
  geom_bar(fill = "blue") +
  scale_x_date(breaks = seq(as.Date("ago-1958"), as.Date("ago-2018"), "4 years")) +
  ylim(0, 150) +
  theme_wsj()


# Gráficos por casos

ggplot(subset(ca10, ANNOH != 0), aes(ANNOH)) + 
  geom_bar() +
  # Gráfico por décadas
  #scale_x_binned() +
  # Gráfico por periodo presidencial
  #scale_x_binned(breaks = seq(1958, 2018, 4)) +
  theme_wsj()

# Gráficos sobre total de víctimas

vic17 <- filter(vic14, !is.na(Fecha))

library(scales)

ggplot(group_by(vic17, Fecha)) +
  aes(Fecha) + 
  geom_bar(fill = "blue") +
  scale_x_date() +
  ylim(0, 150) +
  theme_wsj()

ggplot(group_by(vic14, ANNOH), aes(ANNOH)) + 
  geom_bar(fill = "blue") +
  scale_x_continuous() +
  theme_wsj()


filter(vic11, ANNOH != 0) %>%
  group_by(ANNOH) %>%
  summarise(total=n()) %>%
  arrange(desc(total))


ggplot(subset(vic14, ANNOH != 0), aes(ANNOH)) + 
  geom_bar(fill = "blue") +
  # Gráfico por décadas
  # scale_x_binned() +
  
  # Gráfico por periodo presidencial
  # scale_x_binned(breaks = seq(1958, 2018, 4)) +
  # scale_x_date(limits = as.Date(c("1958-01-01","2018-12-31"))) +
  # scale_x_date(breaks = ANNOH) +
  # Gráfico por año
  # scale_x_binned(breaks = c(1958, 1962, 1966, 1970, 1974, 1978, 1982, 1986, 1990, 1994, 1998, 2002, 2010, 2018)) +
  theme_wsj()

# Sumario de años con más víctimas

summarise(group_by(vic11, ANNOH), total=n()) %>%
  subset(ANNOH != 0) %>%
  arrange(desc(total))
