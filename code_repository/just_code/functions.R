if (!knitr:::is_html_output()) {
  options("width" = 56)
  knitr::opts_chunk$set(tidy.opts = list(width.cutoff = 56, indent = 2), tidy = TRUE)
  }

add_2 <- function(number) {
  number <- number + 2
  return(number)
}

add_2(2)

add_2(5)

add_2 <- function(number, times_5 = FALSE) {
  number <- number + 2
  return(number)
}

add_2 <- function(number, times_5 = FALSE) {
  number <- number + 2
  
  if (times_5 == TRUE) {
    number <- number * 5
  }
  
  return(number)
}

add_2(2)

add_2(2, times_5 = TRUE)

library(rvest)

scrape_recipes <- function(URL) {
  
}

scrape_recipes <- function(URL) {
  
  brownies <- read_html("https://www.allrecipes.com/recipe/25080/mmmmm-brownies/")
  
  ingredients <- html_nodes(brownies, ".ingredients-item-name")
  ingredients <- html_text(ingredients)
  
  directions <- html_nodes(brownies, ".instructions-section")
  directions <- html_text(directions)
  
  ingredients <- ingredients[ingredients != "Add all ingredients to list"]
  directions <- directions[directions != ""]
}

scrape_recipes <- function(URL) {
  
  brownies <- read_html(URL)
  
  ingredients <- html_nodes(brownies, ".added")
  ingredients <- html_text(ingredients)
  
  directions <- html_nodes(brownies, ".recipe-directions__list--item")
  directions <- html_text(directions)
  
  ingredients <- ingredients[ingredients != "Add all ingredients to list"]
  directions <- directions[directions != ""]
}

scrape_recipes <- function(URL) {
  
  brownies <- read_html(URL)
  
  ingredients <- html_nodes(brownies, ".added")
  ingredients <- html_text(ingredients)
  
  directions <- html_nodes(brownies, ".recipe-directions__list--item")
  directions <- html_text(directions)
  
  ingredients <- ingredients[ingredients != "Add all ingredients to list"]
  directions  <- directions[directions != ""]
  directions  <- gsub("\n", "", directions)
  directions  <- gsub(" {2,}", "", directions)
  
  print(ingredients)
  print(directions)
}

scrape_recipes("https://www.allrecipes.com/recipe/10294/the-best-lemon-bars/")
