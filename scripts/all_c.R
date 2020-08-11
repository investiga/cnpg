# Gráficos globales de casos

all_c %>%
  filter(ANNOH >= 1958L & ANNOH <= 2018L, MESH >= 1L & MESH <= 12L,
         DIAH >= 1L & DIAH <= 31L) -> distri
distri <-  fdt(distri$ANNOH, breaks = "Sturges")

ca10 %>%
  filter(ANNOH >= 1958L & ANNOH <= 2018L, MESH >= 1L & MESH <= 12L,
         DIAH >= 1L & DIAH <= 31L) %>%
  #count(ANNOH) %>%
  #arrange(desc(n))
  ggplot() +
  aes(x = ANNOH) +
  #geom_bar() +
  geom_histogram(bins = 16L, fill = "#0c4c8a") +
  labs(x = "Año", y = "Década", title = "Acciones bélicas", 
       subtitle = "Casos", caption = "Fuente: elaborado con datos del CNMH") +
  theme_economist()

# Eliminar datos de mes y año con valor 0
ca11 <- filter(ca10, (ANNOH != 0 & MESH != 0 & DIAH != 0))
# Unir datos de año, mes y día de ocurrencia
ca11_date <- unite(ca11, fecha, ANNOH:MESH, sep = "-", remove = FALSE)
ca11_date <- unite(ca11_date, Fecha, fecha:DIAH, na.rm = TRUE, sep = "-", remove = FALSE)
# Convertir columna a tipo "Date"
ca11_date$Fecha <- as.Date(ca11_date$Fecha)

ca11_date %>%
  filter(Fecha >= "1958-08-07" & Fecha <= "2018-05-14" & !is.na(Fecha)) %>%
  ggplot() +
  aes(x = Fecha) +
  geom_histogram(bins = 15L, fill = "#0c4c8a") +
  geom_density() +
  scale_x_date(breaks = seq(as.Date("1958-08-07"), as.Date("2018-05-14"), "4 years")) +
  theme_minimal()

ca11_date %>%
  count(fecha) %>%
  filter(n >= 2500) %>%
  arrange(desc(n)) -> ca11_date1

ggplot(ca11_date1) + 
  aes(fecha, weight = n) +
  geom_bar()
  
summarise(fecha, total = n()) %>%
  arrange(desc(total)) 

ggplot(ca11_date, aes(Fecha)) +
  scale_x_date(breaks = seq(as.Date("1958-08-07"), as.Date("2018-08-07"), "4 years")) +
  geom_bar()

ggplot(ca11_date) +
  aes(x = fecha) +
  geom_bar(fill = "#0c4c8a") +
#  scale_x_date(breaks = "4 years") +
  theme_hc()


ca15_date1 <- filter(ca15_date, !is.na(Fecha1))

ggplot(ca15_date1, aes(Fecha1)) +
  geom_bar() +
  #geom_vline(xintercept=vic11_date$Fecha[4],linetype=4) +
  scale_x_date(breaks = seq(as.Date("1958-08-07"), as.Date("2018-08-07"), "4 years")) +
  ylim(0, 160) +
  theme_fivethirtyeight()

ggplot(ca15_date1) +
  aes(x = Fecha1) +
  geom_histogram(bins = 61L, fill = "#00a8e6") +
  scale_x_date(breaks = seq(as.Date("1958-08-07"), as.Date("2018-08-07"), "4 years")) +
  theme_minimal()

ggplot(ca15_date1) +
  aes(x = Fecha1) +
  geom_density(adjust = 1L, fill = "#0c4c8a") +
  scale_x_date(breaks = seq(as.Date("1958-08-07"), as.Date("2018-08-07"), "4 years")) +
  theme_minimal()


ca15_date1 %>%
  filter(Fecha1 >= "2000-01-01" & Fecha1 <= "2009-12-31") %>%
  ggplot() +
  aes(x = Fecha1) +
  geom_bar(fill = "#0c4c8a") +
  theme_minimal()