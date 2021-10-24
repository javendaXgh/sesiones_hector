library(rvest)
library(stringr)
titulo <- read_html('https://www.eluniversal.com/politica/110396/')%>%
  html_nodes('#titulo')%>%
  html_text()%>%
  str_remove_all('\n|r')%>%
  str_squish()

fecha <- read_html('https://www.eluniversal.com/politica/110396/')%>%
  html_nodes('#fch_public')%>%
  html_text()%>%
  str_remove_all('\n|r')%>%
  str_squish()



texto <- read_html('https://www.eluniversal.com/politica/110396/')%>%
  html_nodes('#cuerpo p , #cuerpo div')%>%
  html_text()%>%
  str_remove_all('\n|r')%>%
  str_squish()%>%
  paste(.,collapse = ' ')

df_ed <- data.frame(fecha=character(),
                    titulo=character(),
                    texto=character(),
                    stringsAsFactors = FALSE)

for(i in 110390:110396){#110396
  download.file(paste0('https://www.eluniversal.com/politica/',i,'/'),'archivo.html')
  lectura <- read_html('archivo.html')
  
  titulo <-lectura %>%
    html_nodes('#titulo')%>%
    html_text()%>%
    str_remove_all('\n|r')%>%
    str_squish()
  
  fecha <- lectura%>%
    html_nodes('#fch_public')%>%
    html_text()%>%
    str_remove_all('\n|r')%>%
    str_squish()
  
  
  
  texto <- lectura%>%
    html_nodes('#cuerpo p , #cuerpo div')%>%
    html_text()%>%
    str_remove_all('\n|r')%>%
    str_squish()%>%
    paste(.,collapse = ' ')
  
  df_ed <- rbind(df_ed,c(fecha=fecha,titulo=titulo,texto=texto))
  saveRDS(df_ed,'df_ed.rds')
  
}

View(df_ed)
names(df_ed) <- c('fecha', 'titulo', 'texto')
#extensión "selector gadget"

sw <- read_html('https://es.wikipedia.org/wiki/Star_Wars')%>%
  html_table('th')

sw
