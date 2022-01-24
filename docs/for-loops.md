# For loops

We will often want to perform the same task on a number of different items, such as cleaning every column in a data set. One effective way to do this is through "for loops". Earlier in this book we learned how to scrape the recipe website [All Recipes](https://www.allrecipes.com/). We did so for a single recipe. If we wanted to get a feasts worth of recipes, typing out each recipe would be slow, even with the function we made in Section \@ref(recipes-function). In this chapter we will use a for loop to scrape multiple recipes very quickly. 

## Basic for loops

We'll start with a simple example of a for loop, making R print the numbers 1-10. 


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

The basic concept of a for loop is that you have some code that you need to run many times with slight changes to a value or values in the code - somewhat like a function. Like a function, all the code you want to use goes in between the `{` and `}` squiggly brackets. And you loop through all the values you specify - meaning that the code runs once for each of those values.  

Let's look closer at the `(i in 1:10)`. The `i` is simply a placeholder object which takes the value 1 through 10 each iteration of the loop. An iteration is the formal term for each time the loop runs. In our loop it will run 10 times as we have 10 numbers (1-10). The first time it runs the `i` gets the value of 1, the second time it runs `i` gets the value of 2, and so on. 

It's not necessary to call it `i` but it is the convention in programming to do so. It takes the value of whatever follows the `in` which can range from a vector of strings or numbers to lists of data.frames (though we won't do anything that complicated in this chapter). Especially when you're an early learner of R it could help to call the `i` something informative to you about what value it has. 
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

We can also include functions we made in for loops. Here's a function we made last chapter which adds 2 to each inputted number. 


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

Below is the function copied from Section \@ref(recipes-function) which takes a single URL and scraped the site [All Recipes](https://www.allrecipes.com/) for that recipe. It printed the ingredients and directions to cook that recipe to the Console. If we wanted to get that info for multiple recipes, we would need to run the function multiple times. Here we will use a for loop to do this. Since we're using the `read_html()` function from `rvest`, we need to tell R we want to use that package.


```r
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
```

With any for loop you need to figure out what is going to be changing, in this case it is the URL. And since we want multiple recipes, we will make a vector with the URLs of all the recipes we want.

Here I am making a vector called *recipe_urls* with the URLs of a few recipes that I like on the site. The way I got the URLs was to go to each recipe's page and copy and paste the URL. Is this the right approach? Shouldn't we do everything in R? Not always. In situations like this where we know that there are a small number of links we want it is reasonable to do it by hand. Remember that R is a tool to help you. While keeping everything you do in R is good for reproducibility, it is not always reasonable and may take too much time or effort given the constraints - usually limited time - of your project. 


```r
recipe_urls <- c("https://www.allrecipes.com/recipe/25080/mmmmm-brownies/",
                 "https://www.allrecipes.com/recipe/27188/crepes/",
                 "https://www.allrecipes.com/recipe/22180/waffles-i/")
```


Now we can write the for loop to go through every single URL in *recipe_urls* and use the function `scrape_recipes` on that URL.


```r
for (recipe_url in recipe_urls) {
  scrape_recipes(recipe_url)
}
#> [1] "½ cup white sugar "                  "2 tablespoons butter "              
#> [3] "2 tablespoons water "                "1 ½ cups semisweet chocolate chips "
#> [5] "2 eggs "                             "½ teaspoon vanilla extract "        
#> [7] "<U+2154> cup all-purpose flour "     "¼ teaspoon baking soda "            
#> [9] "½ teaspoon salt "                   
#> [1] "Step 1   Preheat the oven to 325 degrees F (165 degrees C). Grease an 8x8 inch square pan.    Advertisement"                                                                                                                                                                                                               
#> [2] "Step 2   In a medium saucepan, combine the sugar, butter and water. Cook over medium heat until boiling. Remove from heat and stir in chocolate chips until melted and smooth. Mix in the eggs and vanilla. Combine the flour, baking soda and salt; stir into the chocolate mixture. Spread evenly into the prepared pan."
#> [3] "Step 3   Bake for 25 to 30 minutes in the preheated oven, until brownies set up. Do not overbake! Cool in pan and cut into squares."                                                                                                                                                                                       
#> [1] "2 eggs "                      "1 cup milk "                 
#> [3] "<U+2154> cup all-purpose flour " "1 pinch salt "               
#> [5] "1 ½ teaspoons vegetable oil "
#> [1] "Step 1   In a blender combine eggs, milk, flour, salt and oil. Process until smooth. Cover and refrigerate 1 hour.    Advertisement"                                                                                                       
#> [2] "Step 2   Heat a skillet over medium-high heat and brush with oil. Pour 1/4 cup of crepe batter into pan, tilting to completely coat the surface of the pan. Cook 2 to 5 minutes, turning once, until golden. Repeat with remaining batter."
#> [1] "2 eggs "                     "2 cups all-purpose flour "  
#> [3] "1 ¾ cups milk "              "½ cup vegetable oil "       
#> [5] "1 tablespoon white sugar "   "4 teaspoons baking powder " 
#> [7] "¼ teaspoon salt "            "½ teaspoon vanilla extract "
#> [1] "Step 1   Preheat waffle iron. Beat eggs in large bowl with hand beater until fluffy. Beat in flour, milk, vegetable oil, sugar, baking powder, salt and vanilla, just until smooth.    Advertisement"
#> [2] "Step 2   Spray preheated waffle iron with non-stick cooking spray. Pour mix onto hot waffle iron. Cook until golden brown. Serve hot."
```
