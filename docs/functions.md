# Functions

So far, we have been writing code to handle specific situations such as subsetting a single data set, often using other people's functions. In cases where you want to reuse the code it is unwise to simply copy and paste the code and make minor changes to handle the new data. Instead we want something that is able to take multiple values and perform the same action (subset, aggregate, make a plot, webscrape, etc.) on those values. We've used lots of other people's function throughout this book and in this chapter we'll learn how to create our own.

Think of a function like a stapler - you put the paper in, push down, and it staples the paper together. It doesn't matter what papers you are using; it always staples them together. If you needed to buy a new stapler every time you needed to staple something (i.e. copy and pasting code) you'd quickly have way too many staplers (and waste a bunch of money). 

An important benefit is that you can use this function again and again to help solve other problems. Let's imagine you need to clean crime data from 10 different cities. Most cities' crime data is very similar so writing the code for one gets you most of the way there for the other 9 cities. Your code will probably work for the other cities, with only minor changes necessary (for example, column names are probably different across all agencies). However, copy and pasting code quickly becomes a terrible solution - functions work much better. If you did copy and paste 10 times and you found a bug, then you'd have to fix the bug 10 times. With a function, you would change the code once. 

## A simple function

We'll start with a simple function that takes a number and returns that number plus the number 2.


```r
add_2 <- function(number) {
  number <- number + 2
  return(number)
}
```

The syntax (how we write it) of a function is

function_name <- function(parameters)
{  
code   
return(output)  
}  

There are five essential parts of a function

+ function_name  - This is just the name we give to the function. It can be anything but, like when making other objects, call it something that is easy to remember what it does.
+ parameters  - Here is where we say what goes into the function. In most cases you will want to put some data in and expect something new out. For example, for the function `mean()` you put in a vector of numbers in the () section and it returns the mean of those numbers. Here is also where you can put any options to affect how the code is run.
+ code - This is the code you write to do the thing you want the function to do. In the above example our code is `number <- number + 2`. For any number inputted, our code adds 2 to it and assigns it back into the object *number*. 
+ return - This is something new in this book, here you use the `return()` function and inside the () you put the object you want to be outputted. In our example we have *number* inside the `return()` as that's what we want to come out of the function. It is not always necessary to end your function with `return()` but is highly recommended to do so to make sure you're outputting what it is you want to output. 
+ The final piece is the structure of your function. After the function_name (whatever it is you call it) you always need the text `<- function()` where the parameters (if any) are in the (). After the closing parentheses put a `{` and at the very end of the function, after the `return()`, close those squiggly brackets with a `}`. The `<- function()` tells R that you are making a function rather than some other type of object. And the `{` and `}` tell R that all the code in between are part of that function.

Our function here adds 2 to any number we input. 


```r
add_2(2)
#> [1] 4
```


```r
add_2(5)
#> [1] 7
```

## Adding parameters 

Let's add a single parameter which multiplies the result by 5 if selected.


```r
add_2 <- function(number, times_5 = FALSE) {
  number <- number + 2
  return(number)
}
```

Now we have added a parameter called `time_5` to the () part of the function and set it the be FALSE by default. Right now it doesn't do anything so we need to add code to say what happens if it is TRUE (remember in R true and false must always be all capital letters and not in quotes).


```r
add_2 <- function(number, times_5 = FALSE) {
  number <- number + 2
  
  if (times_5 == TRUE) {
    number <- number * 5
  }
  
  return(number)
}
```

Now our code says if the parameter `times_5` is TRUE, then do the thing in the squiggly brackets `{}` below. Note that we use the same squiggly brackets as when making the entire function. That just tells R that the code in those brackets belong together. Let's try out our function.


```r
add_2(2)
#> [1] 4
```

It returns 4, as expected. Since the parameter `times_5` is defaulted to FALSE, we don't need to specify that parameter if we want it to stay FALSE. When we don't tell the function that we want it to be TRUE, the code in our "if statement" doesn't run. When we set `times_5` to TRUE, it runs that code. 


```r
add_2(2, times_5 = TRUE)
#> [1] 20
```

## Making a function to scrape recipes {#recipes-function}

In Section \@ref(scraping-one-page) we wrote some code to scrape data from the website [All Recipes](https://www.allrecipes.com/) for a recipe. We are going to turn that code into a function here. The benefit is that our input to the function will be an URL and then it will print out the ingredients and directions for that recipe. If we want multiple recipes (and for webscraping you usually will want to scrape multiple pages), we just change the URL we input without changing the code at all.

We used the `rvest` package so we need to tell R want to use it again.


```r
library(rvest)
```

Let's start by writing a shell of the function - everything but the code. We can call it *scrape_recipes* (though any name would work), add in the `<- function()` and put URL in the () as our input for the function is the URL of the page with the recipe we want. For this function we won't return any object, we will just print things to the console, so we don't need the `return()` value. Don't forget the `{` after the end of the `function()` and `}` at the very end of the function. 


```r
scrape_recipes <- function(URL) {
  
}
```

Now we need to add the code that takes the URL, scrapes the website, and assigns the ingredients part of the page to an object called *ingredients* and the directions part to an object called *directions*. Since we have the code from an earlier lesson, we can copy and paste that code into the function and make a small change to get a working function.


```r
scrape_recipes <- function(URL) {
  
  brownies <- read_html("https://www.allrecipes.com/recipe/25080/mmmmm-brownies/")
  
  ingredients <- html_nodes(brownies, ".ingredients-item-name")
  ingredients <- html_text(ingredients)
  
  directions <- html_nodes(brownies, ".instructions-section-item")
  directions <- html_text(directions)
  directions <- trimws(directions)
}
```

The part inside the () of `read_html()` is the URL of the page we want to scrape. This is the part of the function that will change based on our input. We want whatever input is in the URL parameter to be the URL we scrape. So let's change the URL of the brownies recipe we scraped previously to simply say URL (without quotes). 


```r
scrape_recipes <- function(URL) {
  
  brownies <- read_html(URL)
  
  ingredients <- html_nodes(brownies, ".ingredients-item-name")
  ingredients <- html_text(ingredients)
  
  directions <- html_nodes(brownies, ".instructions-section-item")
  directions <- html_text(directions)
  directions <- trimws(directions)
}
```

To make this function print something to the console, we need to specifically tell it to do so in the code. We do this using the `print()` function. Let's first print the ingredients and then the directions. We'll add that to the final lines of the function.


```r
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

Now we can try it for a new recipe, this one for "The Best Lemon Bars" at this [link](https://www.allrecipes.com/recipe/10294/the-best-lemon-bars/). 


```r
scrape_recipes("https://www.allrecipes.com/recipe/10294/the-best-lemon-bars/")
#> [1] "1 cup butter, softened "   "½ cup white sugar "       
#> [3] "2 cups all-purpose flour " "4 eggs "                  
#> [5] "1 ½ cups white sugar "     "¼ cup all-purpose flour " 
#> [7] "2 lemons, juiced "        
#> [1] "Step 1   Preheat oven to 350 degrees F (175 degrees C).    Advertisement"                                                                                                                                                                                                                                                                         
#> [2] "Step 2   In a medium bowl, blend together softened butter, 2 cups flour and 1/2 cup sugar. Press into the bottom of an ungreased 9x13 inch pan."                                                                                                                                                                                                  
#> [3] "Step 3   Bake for 15 to 20 minutes in the preheated oven, or until firm and golden. In another bowl, whisk together the remaining 1 1/2 cups sugar and 1/4 cup flour. Whisk in the eggs and lemon juice. Pour over the baked crust."                                                                                                              
#> [4] "Step 4   Bake for an additional 20 minutes in the preheated oven. The bars will firm up as they cool. For a festive tray, make another pan using limes instead of lemons and adding a drop of green food coloring to give a very pale green. After both pans have cooled, cut into uniform 2 inch squares and arrange in a checker board fashion."
```

In the next lesson we'll use "for loops" to scrape multiple recipes very quickly. 
