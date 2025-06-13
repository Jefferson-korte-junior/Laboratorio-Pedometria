#Instala e carrega o pacote necessario pra trabalhar com o google sheets
install.packages("googlesheets4")
library(googlesheets4)

gs4_auth() #Autentica o acesso ao Google Sheets

#Cria uma nova planilha no Google Sheets e salva o objeto retornado em 'sheet'
sheet <- gs4_create("Minha Nova Planilha") 

#Exibe detalhes da planilha
print(sheet)

#Define o ID da planilha
sheet_id <- "1fdDbNQcuh2bQPJ5qC0U7-xqVcNURVNFZi0wUxwvwhtY"

Sys.sleep(3)  # Aguarda 3 segundos

#Modifincando o nome das colunas
dados_modificados <- mtcars %>%
  rename(
    Consumo = mpg,       # Milhas por galão → Consumo
    Cilindros = cyl,     # Número de cilindros
    Cilindrada = disp,   # Volume do motor
    Potencia = hp,       # Cavalos de potência
    Diferencial = drat,  # Relação do eixo traseiro
    Peso = wt,           # Peso do carro
    Aceleracao = qsec,   # Tempo de 1/4 de milha
    Motor = vs,          # Tipo do motor (V ou Linha)
    Cambio = am,         # Tipo de transmissão (Automático ou Manual)
    Marchas = gear,      # Número de marchas
    Carburadores = carb  # Número de carburadores
  )


Sys.sleep(5)

## Escreve o conjunto de dados original 'mtcars' na aba 'Pagina1' dentro da planilha
write_sheet(mtcars, sheet_id, sheet = "Pagina1")  

#Le os dados escritos na aba "Pagina1" e printa eles no console
dados_pagina1 <- read_sheet(sheet_id, sheet = "Pagina1")
print(dados_pagina1)

# Escreve os dados modificados (com colunas renomeadas) na aba 'Pagina2'
write_sheet(dados_modificados, sheet_id, sheet = "Pagina2")

#Le os dados escritos na aba "Pagina2" e printa eles no console
dados_pagina2 = read_sheet(sheet_id, sheet = "Pagina2")
print(dados_pagina2)


# Construindo a URL da planilha para acesso no Google Sheets
url <- paste0("https://docs.google.com/spreadsheets/d/", sheet_id, "/edit#gid=0")

# Exibir o link no console
print(url)

browseURL(url) #o R abre automaticamente a URL especificada no navegador padrão








