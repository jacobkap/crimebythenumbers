# For loops

We will often want to perform the same task on a number of different items, such as cleaning every column in a data set. One effective way to do this is through "for loops". Earlier in this course we learned how to scrape the recipe website [All Recipes](https://www.allrecipes.com/). We did so for a single recipe, if we wanted to get a feasts worth of recipes, typing out each recipe would be excessively slow, even with the function we made in Section \@ref(recipes-function). In this lesson we will use a for loop to scrape multiple recipes very quickly. 

## Basic for loops

We'll start with a simple example, making R print the numbers 1-10. 


```r
for (i in 1:10) {
   print(i)
}
#> [1] 1
#> [1] 2
#> [1] 3
#> [1] 4
#> [1] 5
#> [1] 6
#> [1] 7
#> [1] 8
#> [1] 9
#> [1] 10
```

The basic concept of a for loop is you have some code that you need to run many times with slight changes to a value or values in the code - somewhat like a function. Like a function, all the code you want to use goes in between the `{` and `}` squiggly brackets. And you loop through all the values you specify - meaning the code runs once for each of those values.  

Let's look closer at the `(i in 1:10)`. The `i` is simply a placeholder object which takes the value 1:10 each iteration of the loop. It's not necessary to call it `i` but that is convention in programming to do so. It takes the value of whatever follows the `in` which can range from a vector of strings to numbers to lists of data.frames. Especially when you're an early learner of R it could help to call the `i` something informative to you about what value it has. 

Let's go through a few examples with different names for `i` and different values it is looping through. 


```r
for (a_number in 1:10) {
   print(a_number)
}
#> [1] 1
#> [1] 2
#> [1] 3
#> [1] 4
#> [1] 5
#> [1] 6
#> [1] 7
#> [1] 8
#> [1] 9
#> [1] 10
```



```r
animals <- c("cat", "dog", "gorilla", "buffalo", "lion", "snake")
for (animal in animals) {
   print(animal)
}
#> [1] "cat"
#> [1] "dog"
#> [1] "gorilla"
#> [1] "buffalo"
#> [1] "lion"
#> [1] "snake"
```

Now let's make our code a bit more complicated, adding the number 2 every loop. 


```r
for (a_number in 1:10) {
   print(a_number + 2)
}
#> [1] 3
#> [1] 4
#> [1] 5
#> [1] 6
#> [1] 7
#> [1] 8
#> [1] 9
#> [1] 10
#> [1] 11
#> [1] 12
```

We're keeping the results inside of `print()` since for loops do not print the results by default. Let's try combining this with some subsetting using square bracket notation `[]`. We will look through every value in *numbers*, a vector we will make with the values 1:10 and replace each value with its value plus 2.

The object we're looping through is *numbers*. But we're actually looping through every index it has, hence the `1:length(numbers)`. That is saying, `i` takes the value of each index in *numbers* which is useful when we want to change that element. `length(numbers)` finds how long the vector *numbers* is (if this was a data.frame we could use `nrow()`) to find how many elements it has. In the code we take the value at each index `numbers[i]` and add 2 to it. 


```r
numbers <- 1:10
for (i in 1:length(numbers)) {
  numbers[i] <- numbers[i] + 2
}
```


```r
numbers
#>  [1]  3  4  5  6  7  8  9 10 11 12
```

We can also include functions we made in for loops. Here's a function we made last lesson which adds 2 to each inputted number. 


```r
add_2 <- function(number) {
  number <- number + 2
  return(number)
}
```

Let's put that in the loop. 


```r
for (i in 1:length(numbers)) {
  numbers[i] <- add_2(numbers[i])
}
```


```r
numbers
#>  [1]  5  6  7  8  9 10 11 12 13 14
```

## Scraping multiple recipes

Below is the function copied from Section \@ref(recipes-function) which takes a single URL and scraped the site [All Recipes](https://www.allrecipes.com/) for that recipe. It printed the ingredients and directions to cook that recipe to the console. If we wanted to get data for multiple recipes, we would need to run the function multiple times. Here we will use a for loop to do this. Since we're using the `read_html()` function from `rvest`, we need to tell R we want to use that package.


```r
library(rvest)
#> Loading required package: xml2
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
```

With any for loop you need to figure out what is going to be changing, in this case it is the URL. And since we want multiple, we need to make an object with the URLs of all the recipes we want.

Here I am making a vector called *recipe_urls* with the URLs of several recipes that I like on the site. The way I got the URLs was to go to each recipe's page and copy and paste the URL. Is this the right approach? Shouldn't we do everything in R? Not always. In situations like this where we know that there are a small number of links we want - and there is no easy way to get them through R - it is reasonable to do it by hand. Remember that R is a tool to help you. While keeping everything you do in R is good for reproducibility, it is not always reasonable and may take too much time or effort given the constraints - usually limited time - of your project. 


```r
recipe_urls <- c("https://www.allrecipes.com/recipe/25080/mmmmm-brownies/",
                 "https://www.allrecipes.com/recipe/27188/crepes/",
                 "https://www.allrecipes.com/recipe/84270/slow-cooker-corned-beef-and-cabbage/",
                 "https://www.allrecipes.com/recipe/25130/soft-sugar-cookies-v/",
                 "https://www.allrecipes.com/recipe/53304/cream-corn-like-no-other/",
                 "https://www.allrecipes.com/recipe/10294/the-best-lemon-bars/",
                 "https://www.allrecipes.com/recipe/189058/super-simple-salmon/")
```


Now we can write the for loop to go through every single URL in *recipe_urls* and use the function `scrape_recipes` on that URL.


```r
for (recipe_url in recipe_urls) {
  scrape_recipes(recipe_url)
}
#> character(0)
#> character(0)
#> character(0)
#> character(0)
#> [1] "4 large carrots, peeled and cut into matchstick pieces"
#> [2] "10 baby red potatoes, quartered"                       
#> [3] "1 onion, peeled and cut into bite-sized pieces"        
#> [4] "4 cups water"                                          
#> [5] "1 (4 pound) corned beef brisket with spice packet"     
#> [6] "6 ounces beer"                                         
#> [7] "1/2 head cabbage, coarsely chopped"                    
#> [1] "Place the carrots, potatoes, and onion into the bottom of a slow cooker, pour in the water, and place the brisket on top of the vegetables. Pour the beer over the brisket. Sprinkle on the spices from the packet, cover, and set the cooker on High."
#> [2] "Cook the brisket for about 8 hours. An hour before serving, stir in the cabbage and cook for 1 more hour."                                                                                                                                             
#> character(0)
#> character(0)
#> [1] "2 (10 ounce) packages frozen corn kernels, thawed"
#> [2] "1 cup heavy cream"                                
#> [3] "1 teaspoon salt"                                  
#> [4] "2 tablespoons granulated sugar"                   
#> [5] "1/4 teaspoon freshly ground black pepper"         
#> [6] "2 tablespoons butter"                             
#> [7] "1 cup whole milk"                                 
#> [8] "2 tablespoons all-purpose flour"                  
#> [9] "1/4 cup freshly grated Parmesan cheese"           
#> [1] "In a skillet over medium heat, combine the corn, cream, salt, sugar, pepper and butter. Whisk together the milk and flour, and stir into the corn mixture. Cook stirring over medium heat until the mixture is thickened, and corn is cooked through. Remove from heat, and stir in the Parmesan cheese until melted. Serve hot."
#> character(0)
#> character(0)
#> character(0)
#> character(0)
```
