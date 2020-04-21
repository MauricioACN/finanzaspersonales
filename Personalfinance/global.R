#### library ----------------------------

library(tm)
library(wordcloud2)
library(tidyverse)
library(zoo)
library(factoextra)
library(lubridate)
library(DT)
library(ggplot2)
library(ggthemes)
library(syuzhet)
library(scales)
library(reshape2)
library(plotly)
library(shiny)
library(shinythemes)

#### user list to save personal finances ----------------------------

# categorias
categorias = read.csv("categorias.csv", header = T, sep = ",")


#### library ----------------------------

fields <- c("Fecha",colnames(categorias),"Valor")

