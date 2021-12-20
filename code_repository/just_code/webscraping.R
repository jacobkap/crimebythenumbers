## install.packages("rvest")

library(rvest)

knitr::include_graphics('images/brownies_1.PNG')

knitr::include_graphics('images/brownies_2.PNG')

read_html("https://www.allrecipes.com/recipe/25080/mmmmm-brownies/")

brownies <- read_html("https://www.allrecipes.com/recipe/25080/mmmmm-brownies/")

knitr::include_graphics('images/brownies_3.PNG')

knitr::include_graphics('images/brownies_4.PNG')

ingredients <- html_nodes(brownies, ".ingredients-item-name")

ingredients <- html_text(ingredients)

ingredients

knitr::include_graphics('images/brownies_5.PNG')

directions <- html_nodes(brownies, ".instructions-section-item")
directions <- html_text(directions)

directions

directions  <- trimws(directions)
ingredients <- trimws(ingredients)

ingredients
directions

directions <- gsub(" {2,}", " ", directions)

directions
