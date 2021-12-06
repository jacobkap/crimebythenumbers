for (i in 1:10) {
   print(i)
}

for (a_number in 1:10) {
   print(a_number)
}

animals <- c("cat", "dog", "gorilla", "buffalo", "lion", "snake")
for (animal in animals) {
   print(animal)
}

for (a_number in 1:10) {
   print(a_number + 2)
}

numbers <- 1:10
for (i in 1:length(numbers)) {
  numbers[i] <- numbers[i] + 2
}

numbers

add_2 <- function(number) {
  number <- number + 2
  return(number)
}

for (i in 1:length(numbers)) {
  numbers[i] <- add_2(numbers[i])
}

numbers

library(rvest)
scrape_recipes <- function(URL) {
  
  brownies <- read_html(URL)
  
  ingredients <- html_nodes(brownies, ".ingredients-item-name")
  ingredients <- html_text(ingredients)
  
  directions <- html_nodes(brownies, ".instructions-section-item")
  directions <- html_text(directions)
  directions <- trimws(directions)
  
  print(ingredients)
  print(directions)
}

recipe_urls <- c("https://www.allrecipes.com/recipe/25080/mmmmm-brownies/",
                 "https://www.allrecipes.com/recipe/27188/crepes/",
                 "https://www.allrecipes.com/recipe/84270/slow-cooker-corned-beef-and-cabbage/",
                 "https://www.allrecipes.com/recipe/25130/soft-sugar-cookies-v/",
                 "https://www.allrecipes.com/recipe/53304/cream-corn-like-no-other/",
                 "https://www.allrecipes.com/recipe/10294/the-best-lemon-bars/",
                 "https://www.allrecipes.com/recipe/189058/super-simple-salmon/")

for (recipe_url in recipe_urls) {
  scrape_recipes(recipe_url)
}
