## install.packages("rvest")

library(rvest)

read_html("https://www.allrecipes.com/recipe/25080/mmmmm-brownies/")

brownies <- read_html("https://www.allrecipes.com/recipe/25080/mmmmm-brownies/")

ingredients <- html_nodes(brownies, ".ingredients-item-name")

ingredients <- html_text(ingredients)

ingredients

directions <- html_nodes(brownies, ".instructions-section-item")
directions <- html_text(directions)

directions

directions  <- trimws(directions)
ingredients <- trimws(ingredients)

ingredients
directions

directions <- gsub(" {2,}", ": ", directions)

directions
