

library(tidyverse)
library(rvest) 
library(janitor) 
library(tidyr) 
library(lubridate)
library(stringr)
library(glue)
library(readr)


url <- "https://www.senado.cl/appsenado/index.php?mo=lobby&ac=GetReuniones"


audiencias_url <- read_html(url)



audiencias <- audiencias_url %>% 
  html_nodes("table") %>% 
  html_table()

audiencias



audiencias <- tibble(audiencias[[2]])

audiencias
audiencias <- janitor::clean_names(audiencias)


audiencias <- audiencias %>% 
  separate(fecha_duracion_lugar, c("fecha", "duracion", "lugar"), "  ", extra = "merge")

audiencias$fecha <- lubridate::as_date(audiencias$fecha)


audiencias <- audiencias %>% 
  mutate(duracion = str_remove(duracion, " Min."), 
         duracion = as.numeric(duracion))

