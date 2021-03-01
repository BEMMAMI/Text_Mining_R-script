library(rvest)
library(tidyverse)


setwd("C:/Users/opouy/DEV/textminigR/corpus/html/")
htmlALL <- read_html("tousCanaux.html")

getDATA <- function(html){
  html %>%
    html_nodes(".chatlog__author-name") %>%
    html_text()
}

df_html <- getDATA(htmlALL)




setwd("C:/Users/opouy/DEV/textminigR/corpus/html/")
discordHtml <- read_html("*.html") 
discordHtml %>%
  html_nodes(".chatlog__author-name") %>%
  html_text()




dist_lev <- read_html("https://fr.wikipedia.org/wiki/Distance_de_Levenshtein")
dist_lev %>%
  html_nodes("h2") %>%
  html_text() 