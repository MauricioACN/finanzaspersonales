#### library ----------------------------

library(tidyverse)
library(zoo)
library(DT)
library(ggplot2)
library(ggthemes)
library(plotly)
library(shiny)
library(shinythemes)
library(rdrop2)

# categorias
categorias = read.csv("categorias.csv", header = T, sep = ",")


#### library ----------------------------

fields <- c("nombre","fecha","modelo","rubro","categoria","subcategoria","valor")

