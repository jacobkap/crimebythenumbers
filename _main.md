--- 
title: "Crime by the Numbers: A Criminologist's Guide to R"
date: "2021-12-08"
author: "Jacob Kaplan"
bibliography: [book.bib]
biblio-style: apalike
link-citations: yes
colorlinks: yes
description: "A guide to learning R for the purpose of conducting quantitative research. This covers collecting and cleaning data, and visualizing it in graphs and maps."
url: "https://crimebythenumbers.com"
github-repo: "jacobkap/crimebythenumbers"
site: bookdown::bookdown_site
documentclass: krantz
graphics: yes
---
\mainmatter


# (PART) Introduction {-}

# Preface

This book introduces the programming language R and is meant for undergrads or graduate students studying criminology. R is a programming language that is well-suited to the type of work frequently done in criminology - taking messy data and turning it into useful information. While R is a useful tool for many fields of study, this book focuses on the skills criminologists should know and uses crime data for the example data sets. 

For this book you should have the latest version of [R](https://cloud.r-project.org/) installed and be running it through [RStudio Desktop (The free version)](https://www.rstudio.com/products/rstudio/download/). We'll get into detail on what R and  RStudio are soon but please have them both installed to be able to follow along with each chapter. While you must install both, you only ever need to open RStudio. While R is the actual programming language, RStudio is program that makes it a lot easier to interact with R than opening up the R application itself.^[This is formally known as an "integrated development environment" or an IDE.] I highly recommend following along with the code for each lesson and then try to use the lessons learned on a data set you are interested in.  

## Why learn to program?

With the exception of some more advanced techniques like scraping data from websites or from PDFs, nearly everything we do here can be done through Excel, a software you're probably more familiar with. The basic steps for research projects are generally: 

1. Open up a data set - which frequently comes as an Excel file!
2. Change some values - misspellings or too specific categories for our purposes are very common in crime data
3. Delete some values - such as states you won't be studying
4. Make some graphs
5. Calculate some values - such as number of crimes per year
6. Sometimes do a statistical analysis depending on the type of project
7. Write up what you find 

R can do all of this but why should you want (or have) to learn an entirely new skill just to do something you can already do? R is useful for two main reasons: scale and reproducibility.

### Scale 

If you do a one-off project in your career such as downloading some data and making a graph out of it, it makes sense to stick with software like Excel. The cost (in time and effort) of learning R is certainly not worth it for a single (or even several) project - even one perfectly suited for using R. R (and many programming languages more generally, such as Python) has its strength in doing something fairly simple many times. For example, it may be quicker to download one file yourself than it is to write the code in R to download that file. But when it comes to downloading hundreds of files, writing the R code becomes very quickly the better option than doing it by hand. 

For most tasks you do in criminology when dealing with data you will end up doing them many times (including doing the same task in future projects). So R offers the trade-off of spending time upfront by learning the code with the benefit of that code being able to do work at a large scale with little extra work from you. Please keep in mind this trade-off - you need to front-load the costs of learning R for the rewards of making your life easier when dealing with data - when feeling discouraged about the small returns you get early in learning R. 

### Reproducibility 

The second major benefit of using R over something like Excel is that R is reproducible. Every action you take is written down. This is useful when collaborating with others (including your future self) as they can look at your code and follow along what you did without you having to show them every click you made as you frequently would on Excel. Your collaborator can look at your code to help you figure out a bug in the code or to add their own code to yours. 

In the research context specifically, you want to have code to give to people to ensure that your research was done correctly and there aren't bugs in the code. Additionally, if you build a tool to, for example, interpret raw crime data from an agency and turn it into a map, being able to share the code so others can modify it for their own city saves these people a lot of time and effort.

## What you will learn 

For many of the lessons we will be working through real research questions and working from start to finish as you would on your own project. This involves thinking about what you want to accomplish from the data you have and what steps you need to take to reach that goal. This involves more than just knowing what code to write - it includes figuring out what your data has, whether it can answer the question you're asking, and planning out (without writing any code yet) what you need to do when you start coding. For most lessons we'll be using actual crime data that is commonly used in research so you'll become acquainted to a number of important data sets.

### Skills 

There is a large range of skills in criminology research - far too large to cover in a single book. Here we will attempt to teach fundamental skills to build a solid foundation for future work. We'll be focusing on the following skills and trying to reinforce our skills with each lesson. 

  * Subsetting - Taking only certain rows or columns from a data set
  * Graphing
  * Regular expressions - Essentially R's "Find and Replace" function for text
  * Getting data from websites (webscraping)
  * Getting data from PDFs
  * Mapping
  * Writing documents through R

## What you won't learn 

This book is not a statistics book so we will not be covering any statistical techniques. Though some data sets we handle are fairly large, this book does not discuss how to deal with Big Data. While the lessons you learn in this book can apply to larger data sets, Big Data (which I tend to define loosely as data that are too large for my computer to handle) requires special skills that are outside the realm of this book. If you do intend to deal with huge data sets I recommend you look at the R package [data.table](https://github.com/Rdatatable/data.table/wiki) which is an excellent resource for it. While we briefly cover mapping, this book will not cover working with geographic data in detail. For a comprehensive look at geographic data please see this [book](https://geocompr.robinlovelace.net/). This book also will not cover any qualitative data or analysis. While qualitative research is an important part of criminology, this book only focuses on working with quantitative data. Some parts of this book may apply to dealing with qualitative data, such as PDF scraping and regular expressions, but the examples I use in those chapters still deal with quantitative data.

## Simple vs Easy 

In the course of this book we will cover things that are very simple. For example, we'll take a data set (think of it like an Excel file) with crime for nearly every agency in the United States and keep only data from Colorado for a small number of years. We'll then find out how many murders happened in Colorado each year. This is a fairly simple task - it can be expressed in two sentences. You'll find that most of what you do is simple like this - it is quick to talk about what you are doing and the concepts are not complicated. What it isn't is easy. To actually write the R code to do this takes knowing a number of interrelated concepts in R and several lines of code to implement each step. 

While this distinction may seem minor, I think it is important for newer programmers to understand that what they are doing may be simple to talk about but hard to implement. It is easy to feel like a bad programmer because something that can be articulated in 10 seconds may take hours to do. So during times when you are working with R try to keep in mind that even though a project may be simple to articulate, it may be hard to code and that there is often very little correlation between the two.

## How to read this book

This book is written so a person who has no programming experience can start with this chapter and by the end of the book be able to do a data project from start to finish. Each chapter introduces a new skill and builds on the skills introduced in previous chapters. So if you skip ahead you may miss important skills taught in the chapters you didn't read. For someone who has no - or minimal - programming experience, I recommend reading each chapter in order. If you have more programming experience and just want to learn how to do a specific thing, feel free to skip directly to that chapter. 

## Practice problems

At the end of most chapters there will be a series of practice problems for you to do. Not all chapters in this book have R code as some are rather theoretical, such as covering ways to collaborate with other people, so only the chapters with R code will have practice problems. I **highly** recommend that you do all of the practice problems as practicing is the best way to learn how to program. 

You can check your answers in Appendix \@ref(problem-answers) which will have the answer to each question and the code that I used. There are generally multiple ways to approach a particular problem in R - though in this book I'll cover the approach I think is best - so your code may look different than the one I have in the Appendix \@ref(problem-answers). That is totally fine, the important thing is that the answer is right. 

## Citing this book

If this book was useful in your research, please cite it. To cite this book, please use the below citation: 

Kaplan J (2021). *Crime by the Numbers: A Criminologist's Guide to R*. https://crimebythenumbers.com/. 

BibTeX format:

```bibtex
@Manual{crimebythenumbers,
  title = {Crime by the Numbers: A Criminologist's Guide to R},
  author = {Jacob Kaplan},
  year = {2021},
  url = {https://crimebythenumbers.com/},
}
```

## How to contribute to this book

If you have any questions, suggestions (such as a topic to cover), or find any issues, please make a post on the [Issues page](https://github.com/jacobkap/crimebythenumbers/issues) for this book on GitHub. On this page you can create a new issue (which is basically just a post on this forum) with a title and a longer description of your issue. You'll need a GitHub account to make a post. Posting here lets me track issues and respond to your message or alert you when the issue is closed (i.e. I've finished or denied the request). Issues are also public so you can see if someone has already posted something similar.

For more minor issues like typos or grammar mistakes, you can edit the book directly through its GitHub page. That'll make an update for me to accept, which will change the book to include your edit. To do that, click the edit button at the top of the site - the button is highlighted in the below figure. You will need to make a GitHub account to make edits. When you click on that button you'll be taken to a page that looks like a Word Doc where you can make edits. Make any edits you want and then scroll to the bottom of the page. There you can write a short (please, no more than a sentence or two) description of what you've done and then submit the changes for me to review.


\begin{center}\includegraphics[width=0.9\linewidth,]{images/edit_button} \end{center}

Please only use the above two methods to contribute or make suggestions about the book. Don't email me. While it's a bit more work for you to do it this way, since you'll need to make a GitHub account if you don't already have one, it helps me. I wrote this book, in part, to help my career so having evidence that people read it and are contributing to it is important to me. It's a way to publicly measure the book's impact. 

## Where to find data included in this book

To download the data used in this book please see [here](https://github.com/jacobkap/r4crimz/tree/master/data). Each of the files that are used in this book are available to download here. At the top of every chapter that uses one of these files I'll say exactly which files you need to download. The best way to use this book is to follow along by downloading the data and running the code that I include in each chapter. 

## Where to find code included in this book

If you're reading this book through its [website](https://crimebythenumbers.com) you can easily copy the code by clicking on the "Copy to clipboard" option on the top right of every chunk of code. This button, shown in the image below, will copy all of the code in the chunk and you can then paste (through Control/Command+V) into R.


\begin{center}\includegraphics[width=0.9\linewidth,]{images/copy_code} \end{center}

I've also made each chapter available to download as an R file that has every line of code used in each chapter available to you to run. To download the files, please go to the book's GitHub page [here](https://github.com/jacobkap/crimebythenumbers/tree/master/code_repository). I've saved each chapter twice - once where it only includes the code used (in the "just_code" folder) and once where it includes the code and all of the text in the chapter (in the "code_and_text" folder). So download whichever one you want to use. The code is identical in each. 

<!--chapter:end:index.Rmd-->

# About the author {-}


**Jacob Kaplan** is the Chief Data Scientist of the Research on Policing Reform and Accountability (RoPRA), a multi-disciplinary, multi-institutional team of social scientists studying the feasibility and efficacy of policing reform, with a focus on statistically rigorous research and practical applications. His current appointment is at the Princeton School of Public and International Affairs. He holds a PhD and a master's degree in criminology from the University of Pennsylvania and a bachelor's degree in criminal justice from California State University, Sacramento. 

He is the author of several R packages that make it easier to work with data, including  [fastDummies](https://jacobkap.github.io/fastDummies/) and [asciiSetupReader](https://jacobkap.github.io/asciiSetupReader/). His [website](http://jacobdkaplan.com/) allows easy analysis of crime-related data and he has released over a [dozen crime data sets](http://jacobdkaplan.com/data.html) (primarily FBI UCR data) on openICPSR that he has compiled, cleaned, and made available to the public. He is also the author of books on the two primary criminal justice data sets: the FBI's [Uniform Crime Reporting (UCR) Program Data](https://ucrbook.com/), and the FBI's [National Incident Based Reporting System (NIBRS)](https://nibrsbook.com/) data. 


<!--chapter:end:author.Rmd-->

# (PART) Visualize {-}

# Graphing with `ggplot2` {#graphing-intro}

For this chapter you'll need the following file, which is available for download [here](https://github.com/jacobkap/r4crimz/tree/master/data): apparent_per_capita_alcohol_consumption.rda.

We've made some simple graphs earlier; in this lesson we will use the package `ggplot2` to make simple and elegant looking graphs. 

The "gg" part of `ggplot2` stands for "grammar of graphics" which is the idea that most graphs can be made using the same few "pieces." We'll get into those pieces during this lesson. For a useful cheat sheet for this package see [here](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf)


```r
install.packages("ggplot2")
```


```r
library(ggplot2)
```

When working with new data, It's often useful to quickly graph the data to try to understand what you're working with. It is also useful when understanding how much to trust the data.

The data we will work on is data about alcohol consumption in U.S. states from 1977-2017 from the National Institute of Health. It contains the per capita alcohol consumption for each state for every year. Their method to determine per capita consumption is amount of alcohol sold / number of people aged 14+ living in the state. More details on the data are available [here](https://www.openicpsr.org/openicpsr/project/105583/version/V2/view).

Now we need to load the data. 


```r
load("data/apparent_per_capita_alcohol_consumption.rda")
```

The name of the data is quite long so for convenience let's copy it to a new object with a better name, *alcohol*.


```r
alcohol <- apparent_per_capita_alcohol_consumption
```

The original data has every state, region, and the US as a whole. For this lesson we're using data subsetted to just include states. For now let's just look at Pennsylvania.


```r
penn_alcohol <- alcohol[alcohol$state == "pennsylvania", ]
```

## What does the data look like? 

Before graphing, it's helpful to see what the data includes. An important thing to check is what variables are available and the units of these variables.


```r
head(penn_alcohol)
#>             state year ethanol_beer_gallons_per_capita
#> 1559 pennsylvania 2017                            1.29
#> 1560 pennsylvania 2016                            1.31
#> 1561 pennsylvania 2015                            1.31
#> 1562 pennsylvania 2014                            1.32
#> 1563 pennsylvania 2013                            1.34
#> 1564 pennsylvania 2012                            1.36
#>      ethanol_wine_gallons_per_capita ethanol_spirit_gallons_per_capita
#> 1559                            0.33                              0.71
#> 1560                            0.33                              0.72
#> 1561                            0.32                              0.70
#> 1562                            0.32                              0.70
#> 1563                            0.31                              0.68
#> 1564                            0.31                              0.67
#>      ethanol_all_drinks_gallons_per_capita number_of_beers
#> 1559                                  2.34        305.7778
#> 1560                                  2.36        310.5185
#> 1561                                  2.33        310.5185
#> 1562                                  2.34        312.8889
#> 1563                                  2.33        317.6296
#> 1564                                  2.34        322.3704
#>      number_of_glasses_wine number_of_shots_liquor number_of_drinks_total
#> 1559               65.48837               147.4128               499.2000
#> 1560               65.48837               149.4891               503.4667
#> 1561               63.50388               145.3366               497.0667
#> 1562               63.50388               145.3366               499.2000
#> 1563               61.51938               141.1841               497.0667
#> 1564               61.51938               139.1079               499.2000
```

So each row of the data is a single year of data for Pennsylvania. It includes alcohol consumption for wine, liquor, beer, and total drinks - both as gallons of ethanol (a hard unit to interpret) and more traditional measures such as glasses of wine or number of beers. The original data only included the gallons of ethanol data which I converted to the more understandable units. If you encounter data with odd units, it is a good idea to convert it to something easier to understand - especially if you intend to show someone else the data or results!

## Graphing data 

To make a plot using `ggplot()` (please note that the function does not have a 2 at the end of it, only the package name does), all you need to do is specify the data set and the variables you want to plot. From there you add on pieces of the graph using the + symbol (which operates like a `dplyr` pipe) and then specify what you want added.

For `ggplot()` we need to specify 4 things

1. The data set
2. The x-axis variable
3. The y-axis variable
4. The type of graph - e.g. line, point, etc.

Some useful types of graphs are

  + `geom_point()` - A point graph, can be used for scatter plots
  + `geom_line()` - A line graph
  + `geom_bar()` - A barplot
  + `geom_smooth()` - Adds a regression line to the graph

 
## Time-Series Plots 

Let's start with a time-series of beer consumption in Pennsylvania. In time-series plots the x-axis is always the time variable while the y-axis is the variable whose trend over time is what we're interested in. When you see a graph showing, for example, crime rates over time, this is the type of graph you're looking at.

The code below starts by writing our data set name. Then says what our x- and y-axis variables are called. The x- and y-axis variables are within parentheses of the function called `aes()`. `aes()` stands for aesthetic and what's included inside here describes how the graph will look. It's not intuitive to remember, but you need to include it. Like in `dplyr` functions, you do not need to put the column names in quotes or repeat which data set you are using.


```r
ggplot(penn_alcohol, aes(x = year,
                         y = number_of_beers))
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-7-1} \end{center}

Note that on the x-axis it prints out every single year and makes it completely unreadable. That is because the "year" column is a character type, so R thinks each year is its own category. It prints every single year because it thinks we want every category shown. To fix this we can make the column numeric and `ggplot()` will be smarter about printing fewer years.


```r
penn_alcohol$year <- as.numeric(penn_alcohol$year)
```


```r
ggplot(penn_alcohol, aes(x = year,
                         y = number_of_beers))
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-9-1} \end{center}

When we run it, we get our graph. It includes the variable names for each axis and shows the range of data through the tick marks. What is missing is the actual data. For that we need to specify what type of graph it is. We literally add it with the + followed by the type of graph we want. Make sure that the + is at the end of a line, not the start of one. Starting a line with the + will not work.

Let's start with point and line graphs.


```r
ggplot(penn_alcohol, aes(x = year, y = number_of_beers)) +
  geom_point()
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-10-1} \end{center}


```r
ggplot(penn_alcohol, aes(x = year, y = number_of_beers)) +
  geom_line()
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-11-1} \end{center}

We can also combine different types of graphs.


```r
ggplot(penn_alcohol, aes(x = year, y = number_of_beers)) +
  geom_point() +
  geom_line()
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-12-1} \end{center}

It looks like there's a huge change in beer consumption over time. But look at where they y-axis starts. It starts around 280 so really that change is only ~60 beers. That's because when graphs don't start at 0, it can make small changes appear big. We can fix this by forcing the y-axis to begin at 0. We can add `expand_limits(y = 0)` to the graph to say that the value 0 must always appear on the y-axis, even if no data is close to that value.


```r
ggplot(penn_alcohol, aes(x = year, y = number_of_beers)) +
  geom_point() +
  geom_line() +
  expand_limits(y = 0)
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-13-1} \end{center}

Now that graph shows what looks like nearly no change even though that is also not true. Which graph is best? It's hard to say.

Inside the types of graphs we can change how it is displayed. As with using `plot()`, we can specify the color and size of our lines or points. 


```r
ggplot(penn_alcohol, aes(x = year, y = number_of_beers)) +
  geom_line(color = "forestgreen", size = 1.3)
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-14-1} \end{center}

Some other useful features are changing the axis labels and the graph title. Unlike in `plot()` we do not include it in the () of `ggplot()` but use their own functions to add them to the graph.

  + `xlab()` - x-axis label
  + `ylab()` - y-axis label
  + `ggtitle()` - graph title
  
  

```r
ggplot(penn_alcohol, aes(x = year, y = number_of_beers)) +
  geom_line(color = "forestgreen", size = 1.3) +
  xlab("Year") +
  ylab("Number of Beers") +
  ggtitle("PA Annual Beer Consumption Per Capita (1977-2017)")
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-15-1} \end{center}

Many time-series plots show multiple variables over the same time period (e.g. murder and robbery over time). There are ways to change the data itself to make creating graphs like this easier, but let's stick with the data we currently have and just change `ggplot()`.

Start with a normal line graph, this time looking at wine.


```r
ggplot(penn_alcohol, aes(x = year, y = number_of_glasses_wine)) +
  geom_line()
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-16-1} \end{center}

Then include a second geom_line() with its own aes() for the second variable. Since we are using the "penn_alcohol" data set for both lines we do not need to include it in the second `geom_line()` as it assumes that the data is the same if we don't specify otherwise. If we used a different data set for the second line, we would need to specify which data inside of `geom_line()` and before `aes()`.


```r
ggplot(penn_alcohol, aes(x = year, y = number_of_glasses_wine)) +
  geom_line() +
  geom_line(aes(x = year, y = number_of_shots_liquor))
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-17-1} \end{center}

A problem with this is that both lines are the same color. We need to set a color for each line and do so within `aes()`. Instead of providing a color name, we need to provide the name the color will have in the legend. Do so for both lines.


```r
ggplot(penn_alcohol, aes(x = year, y = number_of_glasses_wine,
                         color = "Glasses of Wine")) +
  geom_line() +
  geom_line(aes(x = year, y = number_of_shots_liquor,
                color = "Shots of Liquor"))
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-18-1} \end{center}

We can change the legend title by using the function `labs()` and changing the value `color` to what we want the legend title to be.


```r
ggplot(penn_alcohol, aes(x = year, y = number_of_glasses_wine,
                         color = "Glasses of Wine")) +
  geom_line() +
  geom_line(aes(x = year, y = number_of_shots_liquor,
                color = "Shots of Liquor")) +
  labs(color = "Alcohol Type")
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-19-1} \end{center}

Finally, a useful option to move the legend from the side to the bottom is setting the `theme()` function to move the `legend.position` to "bottom". This will allow the graph to be wider.


```r
ggplot(penn_alcohol, aes(x = year, y = number_of_glasses_wine,
                         color = "Glasses of Wine")) +
  geom_line() +
  geom_line(aes(x = year, y = number_of_shots_liquor,
                color = "Shots of Liquor")) +
  labs(color = "Alcohol Type") +
  theme(legend.position = "bottom")
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-20-1} \end{center}

## Scatter Plots

Making a scatter plot simply requires changing the x-axis from year to another numerical variable and using `geom_point()`. Since our data has one row for every year for Pennsylvania, we can make a scatterplot comparing different drinks in each year. For this example, we'll compare liquor to beer sales.


```r
ggplot(penn_alcohol, aes(x = number_of_shots_liquor,
                         y = number_of_beers)) +
  geom_point()
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-21-1} \end{center}

This graph shows us that when liquor consumption increases, beer consumption also tends to increase.

While scatterplots can help show the relationship between variables, we lose the information of how consumption changes over time.

## Color blindness

Please keep in mind that some people are color blind so graphs (or maps which we will learn about soon) will be hard to read for these people if we choose bad colors. A helpful site for choosing colors for graphs is [colorbrewer2.org](http://colorbrewer2.org)



\begin{center}\includegraphics[width=0.9\linewidth,]{images/colorbrewer} \end{center}

This site lets you select which type of colors you want (sequential and diverging such as shades in a hotspot map, and qualitative such as for data like what we used in this lesson). In the "Only show:" section you can set it to "colorblind safe" to restrict it to colors that allow people with color blindness to read your graph. To the right of this section it shows the HEX codes for each color (a HEX code is just a code that a computer can read and know exactly which color it is). 

Let's use an example of a color blind friendly color from the "qualitative" section of ColorBrewer. We have three options on this page (we can change how many colors we want but it defaults to showing 3): green (HEX = #1b9e77), orange (HEX = #d95f02), and purple (HEX = #7570b3). We'll use the orange and purple colors. To manually set colors in `ggplot()` we use `scale_color_manual(values = c())` and include a vector of color names or HEX codes inside the `c()`. Doing that using the orange and purple HEX codes will change our graph colors to these two colors. 


```r
ggplot(penn_alcohol, aes(x = year, y = number_of_glasses_wine,
                         color = "Glasses of Wine")) +
  geom_line() +
  geom_line(aes(x = year, y = number_of_shots_liquor,
                color = "number_of_shots_liquor")) +
  labs(color = "Alcohol Type") +
  theme(legend.position = "bottom") +
  scale_color_manual(values = c("#7570b3", "#d95f02"))
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-23-1} \end{center}

## Practice problems

For answers, please see Section \@ref(problem-answers-chapter-15). Please keep in mind that the goal is to have your answers be the same as mine, even if the code isn't. With R you can answer a question in multiple ways, so different code can lead to the same answer.

<!--chapter:end:graphing.Rmd-->

# More graphing with `ggplot2` {#ois-graphs}

For this chapter you'll need the following file, which is available for download [here](https://github.com/jacobkap/r4crimz/tree/master/data): fatal-police-shootings-data.csv.

In this lesson we will continue to explore graphing using `ggplot()`. The data we will use is microdata on officer-involved shootings that result in a death in the United States since January 1st, 2015. This data has been compiled and released by the Washington Post so it will be a useful exercise in exploring data from non-government sources. This data is useful for our purposes as it has a number of variables related to the person who was shot, allowing us to practice making many types of graphs. Each row of data is a different person who was shot and killed by the police, and each column gives us information about the individual or the shooting, such as their age, their location, and whether they carried any weapon. 

To explore the data on their website, see [here](https://www.washingtonpost.com/graphics/2019/national/police-shootings-2019/?utm_term=.e870afc9a00c). 
To examine their methodology, see [here](https://www.washingtonpost.com/national/how-the-washington-post-is-examining-police-shootings-in-the-united-states/2016/07/07/d9c52238-43ad-11e6-8856-f26de2537a9d_story.html?utm_term=.f07e9800092b).

The data initially comes as a .csv file so we'll use the `read_csv()` function from the `readr` package.


```r
library(readr)
shootings <- read_csv("data/fatal-police-shootings-data.csv")
#> Rows: 4371 Columns: 14
#> -- Column specification --------------------------------------------------------
#> Delimiter: ","
#> chr  (9): name, manner_of_death, armed, gender, race, city, state, threat_le...
#> dbl  (2): id, age
#> lgl  (2): signs_of_mental_illness, body_camera
#> date (1): date
#> 
#> i Use `spec()` to retrieve the full column specification for this data.
#> i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

Since `read_csv()` reads files into a tibble object, we'll turn it into a data.frame so `head()` shows every single column.


```r
shootings <- as.data.frame(shootings)
```

## Exploring Data

Now that we have the data read in, let's look at it.


```r
nrow(shootings)
#> [1] 4371
ncol(shootings)
#> [1] 14
```

The data has 14 variables and covers 4,371 shootings. Let's check out some of the variables, first using `head()` then using `summary()` and `table()`.


```r
head(shootings)
#>   id               name       date  manner_of_death      armed age gender race
#> 1  3         Tim Elliot 2015-01-02             shot        gun  53      M    A
#> 2  4   Lewis Lee Lembke 2015-01-02             shot        gun  47      M    W
#> 3  5 John Paul Quintero 2015-01-03 shot and Tasered    unarmed  23      M    H
#> 4  8    Matthew Hoffman 2015-01-04             shot toy weapon  32      M    W
#> 5  9  Michael Rodriguez 2015-01-04             shot   nail gun  39      M    H
#> 6 11  Kenneth Joe Brown 2015-01-04             shot        gun  18      M    W
#>            city state signs_of_mental_illness threat_level        flee
#> 1       Shelton    WA                    TRUE       attack Not fleeing
#> 2         Aloha    OR                   FALSE       attack Not fleeing
#> 3       Wichita    KS                   FALSE        other Not fleeing
#> 4 San Francisco    CA                    TRUE       attack Not fleeing
#> 5         Evans    CO                   FALSE       attack Not fleeing
#> 6       Guthrie    OK                   FALSE       attack Not fleeing
#>   body_camera
#> 1       FALSE
#> 2       FALSE
#> 3       FALSE
#> 4       FALSE
#> 5       FALSE
#> 6       FALSE
```

Each row is a single shooting and it includes variables such as the victim's name, the date of the shooting, demographic information about that person, the city and state where the shooting occurred, and some information about the incident. It is clear from these first 6 rows that most variables are categorical so we can't use `summary()` on them. Let's use `summary()` on the date and age columns and then use `table()` for the rest. 


```r
summary(shootings$date)
#>         Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
#> "2015-01-02" "2016-02-07" "2017-03-16" "2017-03-18" "2018-04-11" "2019-06-25"
summary(shootings$age)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#>    6.00   27.00   35.00   36.84   45.00   91.00     182
```


From this we can see that the data is from early January through mid-2019. From the age column we can see that the average age is about 37 with most people around that range. Now we can use `table()` to see how often each value appears in each variable. We don't want to do this for city or name as there would be too many values, but it will work for the other columns. Let's start with the "manner_of_death" column.


```r
table(shootings$manner_of_death)
#> 
#>             shot shot and Tasered 
#>             4146              225
```

To turn these counts into percentages we can divide the results by the number of rows in our data and multiply by 100.


```r
table(shootings$manner_of_death) / nrow(shootings) * 100
#> 
#>             shot shot and Tasered 
#>        94.852437         5.147563
```

Now it is clear to see that in about 95% of shootings, officers used a gun and in 5% of shootings they also used a Taser. As this is data on officer shooting deaths, this is unsurprising. Let's take a look at whether the victim was armed.


```r
table(shootings$armed) / nrow(shootings) * 100
#> 
#>                  air conditioner                               ax 
#>                       0.02287806                       0.48043926 
#>                         barstool                     baseball bat 
#>                       0.02287806                       0.27453672 
#>          baseball bat and bottle baseball bat and fireplace poker 
#>                       0.02287806                       0.02287806 
#>                            baton                          bayonet 
#>                       0.09151224                       0.02287806 
#>                           BB gun                     bean-bag gun 
#>                       0.06863418                       0.02287806 
#>                      beer bottle                     blunt object 
#>                       0.06863418                       0.11439030 
#>                    bow and arrow                       box cutter 
#>                       0.02287806                       0.22878060 
#>                            brick                          carjack 
#>                       0.04575612                       0.02287806 
#>                            chain                        chain saw 
#>                       0.04575612                       0.04575612 
#>                         chainsaw                            chair 
#>                       0.02287806                       0.04575612 
#>              claimed to be armed               contractor's level 
#>                       0.02287806                       0.02287806 
#>                   cordless drill                         crossbow 
#>                       0.02287806                       0.20590254 
#>                          crowbar                        fireworks 
#>                       0.06863418                       0.02287806 
#>                         flagpole                       flashlight 
#>                       0.02287806                       0.02287806 
#>                      garden tool                      glass shard 
#>                       0.02287806                       0.06863418 
#>                              gun                      gun and car 
#>                      55.43353924                       0.11439030 
#>                    gun and knife                    gun and sword 
#>                       0.34317090                       0.02287806 
#>                  gun and vehicle              guns and explosives 
#>                       0.04575612                       0.06863418 
#>                           hammer                       hand torch 
#>                       0.22878060                       0.02287806 
#>                          hatchet                  hatchet and gun 
#>                       0.18302448                       0.04575612 
#>                incendiary device                            knife 
#>                       0.04575612                      14.96225120 
#>                 lawn mower blade                          machete 
#>                       0.04575612                       0.86936628 
#>                  machete and gun                     meat cleaver 
#>                       0.02287806                       0.06863418 
#>                  metal hand tool                     metal object 
#>                       0.02287806                       0.09151224 
#>                       metal pipe                       metal pole 
#>                       0.25165866                       0.04575612 
#>                       metal rake                      metal stick 
#>                       0.02287806                       0.06863418 
#>                       motorcycle                         nail gun 
#>                       0.02287806                       0.02287806 
#>                              oar                       pellet gun 
#>                       0.02287806                       0.02287806 
#>                              pen                     pepper spray 
#>                       0.02287806                       0.02287806 
#>                         pick-axe                    piece of wood 
#>                       0.06863418                       0.06863418 
#>                             pipe                        pitchfork 
#>                       0.13726836                       0.04575612 
#>                             pole                   pole and knife 
#>                       0.04575612                       0.04575612 
#>                             rock                    samurai sword 
#>                       0.09151224                       0.02287806 
#>                         scissors                      screwdriver 
#>                       0.06863418                       0.18302448 
#>                     sharp object                           shovel 
#>                       0.11439030                       0.06863418 
#>                            spear                          stapler 
#>                       0.02287806                       0.02287806 
#>              straight edge razor                            sword 
#>                       0.06863418                       0.34317090 
#>                            Taser                        tire iron 
#>                       0.41180508                       0.02287806 
#>                       toy weapon                          unarmed 
#>                       3.54609929                       6.36010066 
#>                     undetermined                   unknown weapon 
#>                       4.30107527                       1.25829330 
#>                          vehicle                  vehicle and gun 
#>                       1.57858614                       0.02287806 
#>                    walking stick                           wrench 
#>                       0.02287806                       0.02287806
```

This is fairly hard to interpret as it is sorted alphabetically when we'd prefer it to be sorted by most common weapon. It also doesn't round the numbers so there are many numbers past the decimal point shown. Let's solve these two issues using `sort()` and `round()`. We could just wrap our initial code inside each of these functions but to avoid making too complicated code, we save the results in a vector called "temp" and incrementally use `sort()` and `round()` on that. We'll set the parameter `decreasing` to TRUE in the `sort()` function so that it is in descending order of how common each value is. And we'll round to two decimal places by setting the parameter `digits` to 2.


```r
temp <- table(shootings$armed) / nrow(shootings) * 100
temp <- sort(temp, decreasing = TRUE)
temp <- round(temp, digits = 2)
temp
#> 
#>                              gun                            knife 
#>                            55.43                            14.96 
#>                          unarmed                     undetermined 
#>                             6.36                             4.30 
#>                       toy weapon                          vehicle 
#>                             3.55                             1.58 
#>                   unknown weapon                          machete 
#>                             1.26                             0.87 
#>                               ax                            Taser 
#>                             0.48                             0.41 
#>                    gun and knife                            sword 
#>                             0.34                             0.34 
#>                     baseball bat                       metal pipe 
#>                             0.27                             0.25 
#>                       box cutter                           hammer 
#>                             0.23                             0.23 
#>                         crossbow                          hatchet 
#>                             0.21                             0.18 
#>                      screwdriver                             pipe 
#>                             0.18                             0.14 
#>                     blunt object                      gun and car 
#>                             0.11                             0.11 
#>                     sharp object                            baton 
#>                             0.11                             0.09 
#>                     metal object                             rock 
#>                             0.09                             0.09 
#>                           BB gun                      beer bottle 
#>                             0.07                             0.07 
#>                          crowbar                      glass shard 
#>                             0.07                             0.07 
#>              guns and explosives                     meat cleaver 
#>                             0.07                             0.07 
#>                      metal stick                         pick-axe 
#>                             0.07                             0.07 
#>                    piece of wood                         scissors 
#>                             0.07                             0.07 
#>                           shovel              straight edge razor 
#>                             0.07                             0.07 
#>                            brick                            chain 
#>                             0.05                             0.05 
#>                        chain saw                            chair 
#>                             0.05                             0.05 
#>                  gun and vehicle                  hatchet and gun 
#>                             0.05                             0.05 
#>                incendiary device                 lawn mower blade 
#>                             0.05                             0.05 
#>                       metal pole                        pitchfork 
#>                             0.05                             0.05 
#>                             pole                   pole and knife 
#>                             0.05                             0.05 
#>                  air conditioner                         barstool 
#>                             0.02                             0.02 
#>          baseball bat and bottle baseball bat and fireplace poker 
#>                             0.02                             0.02 
#>                          bayonet                     bean-bag gun 
#>                             0.02                             0.02 
#>                    bow and arrow                          carjack 
#>                             0.02                             0.02 
#>                         chainsaw              claimed to be armed 
#>                             0.02                             0.02 
#>               contractor's level                   cordless drill 
#>                             0.02                             0.02 
#>                        fireworks                         flagpole 
#>                             0.02                             0.02 
#>                       flashlight                      garden tool 
#>                             0.02                             0.02 
#>                    gun and sword                       hand torch 
#>                             0.02                             0.02 
#>                  machete and gun                  metal hand tool 
#>                             0.02                             0.02 
#>                       metal rake                       motorcycle 
#>                             0.02                             0.02 
#>                         nail gun                              oar 
#>                             0.02                             0.02 
#>                       pellet gun                              pen 
#>                             0.02                             0.02 
#>                     pepper spray                    samurai sword 
#>                             0.02                             0.02 
#>                            spear                          stapler 
#>                             0.02                             0.02 
#>                        tire iron                  vehicle and gun 
#>                             0.02                             0.02 
#>                    walking stick                           wrench 
#>                             0.02                             0.02
```

Now it is a little easier to interpret. In over half of the cases the victim was carrying a gun. 15% of the time they had a knife. And 6% of the time they were unarmed. In 4% of cases there is no data on any weapon. That leaves about 20% of cases where one of the many rare weapons were used, including some that overlap with one of the more common categories.

Think about how you'd graph this data. There are 85 unique values in this column though fewer than ten of them are common enough to appear more than 1% of the time. Should we graph all of them? No, that would overwhelm any graph. For a useful graph we would need to combine many of these into a single category - possibly called "other weapons." And how do we deal with values where they could meet multiple larger categories? There is not always a clear answer for these types of questions. It depends on what data you're interested in, the goal of the graph, the target audience, and personal preference. 

Let's keep exploring the data by looking at gender and race. 


```r
table(shootings$gender) / nrow(shootings) * 100
#> 
#>         F         M 
#>  4.667124 95.218485
```

Nearly all of the shootings are of a man. Given that we saw most shootings involved a person with a weapon and that most violent crimes are committed by men, this shouldn't be too surprising. 


```r
temp <- table(shootings$race) / nrow(shootings) * 100
temp <- sort(temp)
temp <- round(temp, digits = 2)
temp
#> 
#>     O     N     A     H     B     W 
#>  0.87  1.46  1.62 16.45 22.90 44.89
```

White people are the largest race group that is killed by police, followed by Black people and Hispanic people. In fact, there are about twice as many White people killed than Black people killed, and about 2.5 times as many White people killed than Hispanic people killed. Does this mean that the oft-repeated claim that Black people are killed at disproportionate rates is wrong? No. This data simply shows the number of people killed; it doesn't give any indication on rates of death per group. You'd need to merge it with Census data to get population to determine a rate per race group. And even that would be insufficient since people are, for example, stopped by police at different rates. This data provides a lot of information on people killed by the police, but even so it is insufficient to answer many of the questions on that topic. It's important to understand the data not only to be able to answer questions about it, but to know what questions you can't answer - and you'll find when using criminology data that there are a *lot* of questions that you can't answer.^[It is especially important to not overreach when trying to answer a question when the data can't do it well. Often, no answer is better than a wrong one - especially in a field with serious consequences like criminology. For example, using the current data we'd determine that there's no (or not as much as people claim) racial bias in police killings. If we come to that conclusion based on the best possible evidence, that's okay - even if we're wrong. But coming to that conclusion based on inadequate data could lead to policies that actually cause harm. This isn't to say that you should never try to answer questions since no data is perfect and you may be wrong. You should try to develop a deep understanding of the data and be confident that you can actually answer those questions with confidence.]  

One annoying thing with the gender and race variables is that they don't spell out the name. Instead of "Female", for example, it has "F". For our graphs we want to spell out the words so it is clear to viewers. We'll fix this issue, and the issue of having many weapon categories, as we graph each variable.

## Graphing a Single Numeric Variable

We've spent some time looking at the data so now we're ready to make the graphs. We need to load the `ggplot2` package if we haven't done so already this session (i.e. since you last closed RStudio).


```r
library(ggplot2)
```

As a reminder, the benefit of using `ggplot()` is we can start with a simple plot and build our way up to more complicated graphs. We'll start here by building some graphs to depict a numeric variable - in this case the "age" column. We start every `ggplot()` the same, by inserting the data set first and then put our x and y variables inside of the `aes()` parameter. In this case we're only going to be plotting an x variable so we don't need to write anything for y.


```r
ggplot(shootings, aes(x = age))
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-13-1} \end{center}
Running the above code returns a blank graph since we haven't told `ggplot()` what type of graph we want yet. Below are a few different types of ways to display a single numeric variable. They're essentially all variations of each other and show the data at different levels of precision. It's hard to say which is best - you'll need to use your best judgment and consider your audience. 

### Histogram

The histogram is a very common type of graph for a single numeric variable. Histograms group a numeric variable into categories and then plot them, with the heights of each bar indicating how common the group is. We can make a histogram by adding `geom_histogram()` to the `ggplot()`.


```r
ggplot(shootings, aes(x = age)) + 
  geom_histogram()
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
#> Warning: Removed 182 rows containing non-finite values (stat_bin).
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-14-1} \end{center}

The x-axis is ages with each bar being a group of certain ages, and the y-axis is how many people are in each group. The grouping is done automatically and we can alter it by changing the `bin` parameter in `geom_histogram()`. By default this parameter is set to 30 but we can make each group smaller (have fewer ages per group) by **increasing** it from 30 or make each group larger by **decreasing** it.


```r
ggplot(shootings, aes(x = age)) + 
  geom_histogram(bins = 15)
#> Warning: Removed 182 rows containing non-finite values (stat_bin).
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-15-1} \end{center}


```r
ggplot(shootings, aes(x = age)) + 
  geom_histogram(bins = 45)
#> Warning: Removed 182 rows containing non-finite values (stat_bin).
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-16-1} \end{center}

Note that while the overall trend (of most deaths being around age 25) doesn't change when we alter `bin`, the data gets more or less precise. Having fewer bins means fewer, but larger, bars which can obscure trends that more, smaller, bars would show. But having too many bars may make you focus on minor variations that could occur randomly and take away attention from the overall trend. I prefer to err on the side of more precise graphs (more, smaller bars) but be careful over-interpreting data from small groups.

These graphs show the y-axis as the number of people in each bar. If we want to show proportions instead, we can add in a parameter for `y` in the `aes()` of the `geom_histogram()`. We add in `y = (..count..)/sum(..count..))` which automatically converts the counts to proportions. The "(..count..)/sum(..count..))" stuff is just taking each group and dividing it from the sum of all groups. You could, of course, do this yourself before making the graph, but it's an easy helper. If you do this, make sure to relabel the y-axis so you don't accidentally call the proportions a count.


```r
ggplot(shootings, aes(x = age)) + 
  geom_histogram(aes(y = (..count..)/sum(..count..)))
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
#> Warning: Removed 182 rows containing non-finite values (stat_bin).
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-17-1} \end{center}

### Density plot

Density plots are essentially smoothed versions of histograms. They're especially useful for numeric variables which are not integers (integers are whole numbers). They're also useful when you want to be more precise than a histogram as they are - to simplify - histograms where each bar is very narrow. Note that the y-axis of a density plot is automatically labeled "density" and has very small numbers. Interpreting the y-axis is fairly hard to explain to someone not familiar with statistics so I'd caution against using this graph unless your audience is already familiar with it. To interpret these kinds of graphs, I recommend looking for trends rather than trying to identify specific points. For example, in the below graph we can see that shootings rise rapidly starting around age 10, peak at around age 30 (if we were presenting this graph to other people we'd probably want more ages shown on the x-axis), and then steadily decline until about age 80 where it's nearly flat.   


```r
ggplot(shootings, aes(x = age)) + 
  geom_density()
#> Warning: Removed 182 rows containing non-finite values (stat_density).
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-18-1} \end{center}

### Count Graph

A count graph is essentially a histogram with a bar for every value in the numeric variable - like a less-smooth density plot. Note that this won't work well if you have too many unique values so I'd strongly recommend rounding the data to the nearest whole number first. Our age variable is already rounded so we don't need to do that. To make a count graph, we add `stat_count()` to the `ggplot()`. 


```r
ggplot(shootings, aes(x = age)) + 
  stat_count()
#> Warning: Removed 182 rows containing non-finite values (stat_count).
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-19-1} \end{center}
Now we have a single bar for every age in the data. Like the histogram, the y-axis shows the number of people that are that age. And like the histogram, we can change this from number of people to proportion of people using the exact same code.


```r
ggplot(shootings, aes(x = age)) + 
  stat_count(aes(y = (..count..)/sum(..count..)))
#> Warning: Removed 182 rows containing non-finite values (stat_count).
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-20-1} \end{center}

## Graphing a Categorical Variable 

### Bar graph

To make this barplot we'll set the x-axis variable to our "race" column and add `geom_bar()` to the end. 


```r
ggplot(shootings, aes(x = race)) + 
  geom_bar()
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-21-1} \end{center}
This gives us a barplot in alphabetical order. In most cases we want the data sorted by frequency, so we can easily see what value is the most common, second most common, etc. There are a few ways to do this but we'll do this by turning the "race" variable into a factor and ordering it by frequency. We can do that using the `factor()` function. The first input will be the "race" variable and then we will need to set the `levels` parameter to a vector of values sorted by frequency. An easy way to know how often values are in a column is to use the `table()` function on that column, such as below.


```r
table(shootings$race)
#> 
#>    A    B    H    N    O    W 
#>   71 1001  719   64   38 1962
```

It's still alphabetical so let's wrap that in a `sort()` function. 


```r
sort(table(shootings$race))
#> 
#>    O    N    A    H    B    W 
#>   38   64   71  719 1001 1962
```

It's sorted from smallest to largest. We usually want to graph from largest to smallest so let's set the parameter `decreasing` in `sort()` to TRUE.


```r
sort(table(shootings$race), decreasing = TRUE)
#> 
#>    W    B    H    A    N    O 
#> 1962 1001  719   71   64   38
```

Now, we only need the names of each value, not how often they occur. So we can against wrap this whole thing in `names()` to get just the names.


```r
names(sort(table(shootings$race), decreasing = TRUE))
#> [1] "W" "B" "H" "A" "N" "O"
```

If we tie it all together, we can make the "race" column into a factor variable.


```r
shootings$race <- factor(shootings$race,
                         levels = names(sort(table(shootings$race), decreasing = TRUE)))
```

Now let's try that barplot again.


```r
ggplot(shootings, aes(x = race)) + 
  geom_bar() 
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-27-1} \end{center}
It works! Note that all the values that are missing in our data are still reported in the barplot under a column called "NA". This is not sorted properly since there are more NA values than three of the other values but is still at the far right of the graph. We can change this if we want to make all the NA values an actual character type and call it something like "Unknown". But this way it does draw attention to how many values are missing from this column. Like most things in graphing, this is a personal choice as to what to do.

For bar graphs it is often useful to flip the graph so each value is a row in the graph rather than a column. This also makes it much easier to read the value name. If the value names are long, it'll shrink the graph to accommodate the name. This is usually a sign that you should try to shorten the name to avoid reducing the size of the graph. 


```r
ggplot(shootings, aes(x = race)) + 
  geom_bar() +
  coord_flip() 
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-28-1} \end{center}
Since it's flipped, now it's sorted from smallest to largest. So we'll need to change the `factor()` code to fix that.


```r
shootings$race <- factor(shootings$race,
                         levels = names(sort(table(shootings$race), decreasing = FALSE)))
ggplot(shootings, aes(x = race)) + 
  geom_bar() +
  coord_flip() 
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-29-1} \end{center}
The NA value is now at the top, which looks fairly bad. Let's change all NA values to the string "Unknown". And while we're at it, let's change all the abbreviated race values to actual names. We can get all the NA values by using `is.na(shootings$race)` and using a conditional statement to get all rows that meet that condition, then assign them the value "Unknown". Instead of trying to subset a factor variable to change the values, we should convert it back to a character type first using `as.character()`, and then convert it to a factor again once we're done. 


```r
shootings$race <- as.character(shootings$race)
shootings$race[is.na(shootings$race)] <- "Unknown"
```

Now we can use conditional statements to change all the race letters to names. It's not clear what race "O" and "N" are so I checked the [Washington Post's GitHub page](https://github.com/washingtonpost/data-police-shootings) which explains. Instead of `is.na()` we'll use `shootings$race == ""` where we put the letter inside of the quotes.


```r
shootings$race[shootings$race == "O"] <- "Other"
shootings$race[shootings$race == "N"] <- "Native American"
shootings$race[shootings$race == "A"] <- "Asian"
shootings$race[shootings$race == "H"] <- "Hispanic"
shootings$race[shootings$race == "B"] <- "Black"
shootings$race[shootings$race == "W"] <- "White"
```

Now let's see how our graph looks. We'll need to rerun the `factor()` code since now all of the values are changed.


```r
shootings$race <- factor(shootings$race,
                         levels = names(sort(table(shootings$race), decreasing = FALSE)))
ggplot(shootings, aes(x = race)) + 
  geom_bar() +
  coord_flip() 
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-32-1} \end{center}

As earlier, we can show proportion instead of count by adding `y = (..count..)/sum(..count..)` to the `aes()` in `geom_bar()`.


```r
ggplot(shootings, aes(x = race)) + 
  geom_bar(aes(y = (..count..)/sum(..count..))) +
  coord_flip() 
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-33-1} \end{center}

## Graphing data Over Time

We went over time-series graphs in Chapter \@ref(graphing-intro) but it's such an important topic we'll cover it again. A lot of criminology research is seeing if a policy had an effect, which means we generally want to compare an outcome over time (and compare the treated group to a similar untreated group). To graph that we look at an outcome, in this case numbers of killings, over time. In our case we aren't evaluating any policy, just seeing if the number of police killings change over time. 

We'll need to make a variable to indicate that the row is for one shooting. We can call this "dummy" and assign it a value of 1. Then we can make the `ggplot()` and set this "dummy" column to the y-axis value and set our date variable "date" to the x-axis (the time variable is **always** on the x-axis). Then we'll set the type of plot to `geom_line()` so we have a line graph showing killings over time.


```r
shootings$dummy <- 1
ggplot(shootings, aes(x = date, y = dummy)) +
  geom_line()
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-34-1} \end{center}
This graph is clearly wrong. Why? Well, our y-axis variable is always 1 so there's no variation to plot. Every single value, even if there are more than one shooting per day, is on the 1 line on the y-axis. And the fact that we have multiple killings per day is an issue because we only want a single line in our graph. We'll need to aggregate our data to some time period (e.g. day, month, year) so that we have one row per time-period and know how many people were killed in that period. We'll start with yearly data and then move to monthly data. Since we're going to be dealing with dates, let's use the `lubridate()` package that is well-suited for this task. 


```r
install.packages("lubridate")
```



```r
library(lubridate)
#> 
#> Attaching package: 'lubridate'
#> The following objects are masked from 'package:base':
#> 
#>     date, intersect, setdiff, union
```

We'll use two functions to create variables that tell us the month and the year of each date in our data. We'll use these new variables to aggregate our data to that time unit. First, the `floor_date()` function is a very useful tool that essentially rounds a date. Here we have the exact date the killing happened on, and we want to determine what month that date is from. So we'll use the parameter `unit` in `floor_date()` and tell the function we want to know the "month" (for a full set of options please see the documentation for `floor_date()` by entering `?floor_date` in the console). So we can do `floor_date(shootings$date, unit = "month")` to get the month - specifically, it returns the date that is the first of the month for that month - the killing happened on. Even simpler, to get the year, we simple use `year()` and put our "date" variable in the parentheses. We'll call the new variables "month_year" and "year", respectively.


```r
shootings$month_year <- floor_date(shootings$date, unit = "month")
shootings$year <- year(shootings$date)

head(shootings$month_year)
#> [1] "2015-01-01" "2015-01-01" "2015-01-01" "2015-01-01" "2015-01-01"
#> [6] "2015-01-01"
head(shootings$year)
#> [1] 2015 2015 2015 2015 2015 2015
```

Since the data is already sorted by date, all the values printed from `head()` are the same. But you can look at the data using `View()` to confirm that the code worked properly. 

We can now aggregate the data by the "month_year" variable and save the result into a new data set we'll call *monthly_shootings*. We'll use the `group_by()` and `summarize()` functions from `dplyr` that were introduced in Chapter \@ref(explore) to do this. And we'll use the pipe method of writing `dplyr` code that was discussed in Section \@ref(dplyr-pipes)


```r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
monthly_shootings <- shootings %>%
  group_by(month_year) %>% 
  summarize(dummy = sum(dummy))
head(monthly_shootings)
#> # A tibble: 6 x 2
#>   month_year dummy
#>   <date>     <dbl>
#> 1 2015-01-01    76
#> 2 2015-02-01    77
#> 3 2015-03-01    92
#> 4 2015-04-01    84
#> 5 2015-05-01    71
#> 6 2015-06-01    65
```

Since we now have a variable that shows for each month the number of people killed, we can graph this new data set. We'll use the same process as earlier but our data set is now `monthly_shootings` instead of `shootings` and the x-axis variable is "month_year" instead of "date".


```r
ggplot(monthly_shootings, aes(x = month_year, y = dummy)) +
  geom_line()
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-39-1} \end{center}
The process is the same for yearly data.


```r
yearly_shootings <- shootings %>%
  group_by(year) %>% 
  summarize(dummy = sum(dummy))
ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line()
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-40-1} \end{center}

Note the steep drop-off at the end of each graph. Is that due to fewer shooting occurring more recently? No, it's simply an artifact of the graph comparing whole months (years) to parts of a month (year) since we haven't finished this month (year) yet (and the data has a small lag in reporting). 

## Pretty Graphs

What's next for these graphs? You'll likely want to add labels for the axes and the title. We went over how to do this in Section \@ref(time-series-plots) so please refer to that for more info. Also, check out `ggplot2`'s [website](https://ggplot2.tidyverse.org/reference/index.html#section-scales) to see more on this very versatile package. As I've said all chapter, a lot of this is going to be personal taste so please spend some time exploring the package and changing the appearance of the graph to learn what looks right to you. 

### Themes

In addition to making changes to the graph's appearance yourself, you can use a theme that someone else made. A theme is just a collection of changes to the graph's appearance that someone put in a function for others to use. Each theme is different and is fairly opinionated, so you should only use one that you think looks best for your graph. To use a theme, simply add the theme (exactly as spelled on the site) to your ggplot using the + as normal (and make sure to include the () since each theme is actually a function. `ggplot2` comes with a series of themes that you can look at [here](https://ggplot2.tidyverse.org/reference/ggtheme.html). Here, we'll be looking at themes from the `ggthemes` package which is a great source of different themes to modify the appearance of your graph. Check out this [website](https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/) to see a depiction of all of the possible themes. If you don't have the `ggthemes` package installed, do so using `install.packages("ggthemes")`. 


```r
install.packages("ggthemes")
```


Let's do a few examples using the graph made above. First, we'll need to load the `ggthemes` library.


```r
library(ggthemes)
ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line() +
  theme_fivethirtyeight()
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-42-1} \end{center}



```r
ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line() +
  theme_tufte()
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-43-1} \end{center}



```r
ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line() +
  theme_few()
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-44-1} \end{center}



```r
ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line() +
  theme_excel()
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-45-1} \end{center}

## Practice problems

For answers, please see Section \@ref(problem-answers-chapter-16). Please keep in mind that the goal is to have your answers be the same as mine, even if the code isn't. With R you can answer a question in multiple ways, so different code can lead to the same answer.

<!--chapter:end:graphing-2.Rmd-->

# Choropleth maps

For this chapter you'll need the following files, which are available for download [here](https://github.com/jacobkap/r4crimz/tree/master/data): san_francisco_suicide_2003_2017.csv, san_francisco_neighborhoods.dbf, san_francisco_neighborhoods.prj, san_francisco_neighborhoods.shp, san_francisco_neighborhoods.shx.

In Chapter \@ref(hotspot-maps) we made hotspot maps to show which areas in San Francisco had the most suicides. We made the maps in a number of ways and consistently found that suicides were most prevalent in northeast San Francisco. In this lesson we will make choropleth maps, which are shaded maps where each "unit" is some known area such as a state or neighborhood. Think of election maps where states are colored blue when a Democratic candidate wins that state and red when a Republican candidate wins. These are choropleth maps - each state is colored to indicate something. In this lesson we will continue to work on the suicide data and make choropleth maps shaded by the number of suicides in each neighborhood (we will define this later in the lesson) in the city. 

Since we will be working more on the suicide data from San Francisco, let's read it in now.


```r
library(readr)
suicide <- read_csv("data/san_francisco_suicide_2003_2017.csv")
#> Rows: 1292 Columns: 14
#> -- Column specification --------------------------------------------------------
#> Delimiter: ","
#> chr  (8): Category, Descript, DayOfWeek, Date, PdDistrict, Resolution, Addre...
#> dbl  (5): IncidntNum, X, Y, PdId, year
#> time (1): Time
#> 
#> i Use `spec()` to retrieve the full column specification for this data.
#> i Specify the column types or set `show_col_types = FALSE` to quiet this message.
suicide <- as.data.frame(suicide)
```

The package that we will use to handle geographic data and do most of the work in this lesson is `sf`. `sf` is a sophisticated package and does far more than what we will cover in this lesson. For more information about the package's features please see the website for it [here](http://r-spatial.github.io/sf/).


```r
install.packages("sf")
```


```r
library(sf)
#> Linking to GEOS 3.9.1, GDAL 3.2.1, PROJ 7.2.1
```

For this lesson we will need to read in a shapefile that depicts the boundaries of each neighborhood in San Francisco.  A shapefile is similar to a data.frame but has information on how to draw a geographic boundary such as a state. The way `sf` reads in the shapefiles is through the `st_read()` function. Our input inside the () is a string with the name of the ".shp" file we want to read in (since we are telling R to read a file on the computer rather than an object that exists, it needs to be in quotes). This shapefile contains neighborhoods in San Francisco so we'll call the object *sf_neighborhoods*. 

I downloaded this data from San Francisco's Open Data site [here](https://data.sfgov.org/Geographic-Locations-and-Boundaries/Analysis-Neighborhoods/p5b7-5n3h), selecting the Shapefile format in the Export tab. If you do so yourself it'll give you a zip file with multiple files in there. This is normal with shapefiles, you will have multiple files and only read in the file with the ".shp" extension to R. We still **do** need all of the files and `st_read()` is using them even if not explicitly called. So make sure every file downloaded is in the same working directory as the .shp file. The files from this site had hard to understand file names so I relabeled them all as "san_francisco_neighborhoods" though that doesn't matter once it's read into R.


```r
sf_neighborhoods <- st_read("data/san_francisco_neighborhoods.shp")
#> Reading layer `san_francisco_neighborhoods' from data source 
#>   `C:\Users\jkkap\Dropbox\crimebythenumbers\data\san_francisco_neighborhoods.shp' 
#>   using driver `ESRI Shapefile'
#> Simple feature collection with 41 features and 1 field
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -122.5149 ymin: 37.70813 xmax: -122.357 ymax: 37.8333
#> Geodetic CRS:  WGS84(DD)
```

As usual when dealing with a new data set, let's look at the first 6 rows.


```r
head(sf_neighborhoods)
#> Simple feature collection with 6 features and 1 field
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -122.4543 ymin: 37.70822 xmax: -122.357 ymax: 37.80602
#> Geodetic CRS:  WGS84(DD)
#>                            nhood                       geometry
#> 1          Bayview Hunters Point MULTIPOLYGON (((-122.3816 3...
#> 2                 Bernal Heights MULTIPOLYGON (((-122.4036 3...
#> 3            Castro/Upper Market MULTIPOLYGON (((-122.4266 3...
#> 4                      Chinatown MULTIPOLYGON (((-122.4062 3...
#> 5                      Excelsior MULTIPOLYGON (((-122.424 37...
#> 6 Financial District/South Beach MULTIPOLYGON (((-122.3875 3...
```

The last column is important. In shapefiles, the "geometry" column is the one with the instructions to make the map. This data has a single row for each neighborhood in the city. So the "geometry" column in each row has a list of coordinates which, if connected in order, make up that neighborhood. Since the "geometry" column contains the instructions to map, we can `plot()` it to show a map of the data. 


```r
plot(sf_neighborhoods$geometry)
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-6-1} \end{center}

Here we have a map of San Francisco broken up into neighborhoods. Is this a perfect representation of the neighborhoods in San Francisco? No. It is simply the city's attempt to create definitions of neighborhoods. Indeed, you're likely to find that areas at the border of neighborhoods are more similar to each other than they are to areas at the opposite side of their designated neighborhood. You can read a bit about how San Francisco determined the neighborhood boundaries [here](https://data.sfgov.org/Geographic-Locations-and-Boundaries/Analysis-Neighborhoods/p5b7-5n3h) but know that this, like all geographic areas that someone has designated, has some degree of inaccuracy and arbitrariness in it. Like many things in criminology, this is just another limitation we will have to keep in mind. 

In the `head()` results there was a section about something called "epsg" and "proj4string". Let's talk about that specifically since they are important for working with spatial data. A way to get just those two results in the `st_crs()` function which is part of `sf`.  Let's look at the "coordinate reference system" (CRS) for `sf_neighborhoods`.


```r
st_crs(sf_neighborhoods)
Coordinate Reference System:
  User input: WGS84(DD) 
  wkt:
GEOGCRS["WGS84(DD)",
    DATUM["WGS84",
        ELLIPSOID["WGS84",6378137,298.257223563,
            LENGTHUNIT["metre",1,
                ID["EPSG",9001]]]],
    PRIMEM["Greenwich",0,
        ANGLEUNIT["degree",0.0174532925199433]],
    CS[ellipsoidal,2],
        AXIS["geodetic longitude",east,
            ORDER[1],
            ANGLEUNIT["degree",0.0174532925199433]],
        AXIS["geodetic latitude",north,
            ORDER[2],
            ANGLEUNIT["degree",0.0174532925199433]]]
```

An issue with working with geographic data is that [the Earth is not flat](https://en.wikipedia.org/wiki/Spherical_Earth). Since the Earth is spherical, there will always be some distortion when trying to plot the data on a flat surface such as a map. To account for this we need to transform the longitude and latitude values we have to work properly on a map. We do so by "projecting" our data onto the areas of the Earth we want. This is a complex field with lots of work done on it (both abstractly and for R specifically) so this lesson will be an extremely brief overview of the topic and oversimplify some aspects of it. 

If we look at the output of `st_crs(sf_neighborhoods)` we can see that the EPSG is set to 4326 and the proj4string (which tells us the current map projection) is "+proj=longlat +datum=WGS84 +no_defs". This CRS, WGS84, is a standard CRS and is the one used whenever you use a GPS to find a location. To find the CRS for certain parts of the world see [here](https://spatialreference.org/). If you search that site for "California" you'll see that California is broken into 6 zones. The site isn't that helpful on which zones are which but some Googling can often find state or region maps with the zones depicted there. We want California zone 3 which has the EPSG code 2227. We'll use this code to project this data properly. 

If we want to get the proj4string for 2227 we can use


```r
st_crs(2227)
#> Coordinate Reference System:
#>   User input: EPSG:2227 
#>   wkt:
#> PROJCRS["NAD83 / California zone 3 (ftUS)",
#>     BASEGEOGCRS["NAD83",
#>         DATUM["North American Datum 1983",
#>             ELLIPSOID["GRS 1980",6378137,298.257222101,
#>                 LENGTHUNIT["metre",1]]],
#>         PRIMEM["Greenwich",0,
#>             ANGLEUNIT["degree",0.0174532925199433]],
#>         ID["EPSG",4269]],
#>     CONVERSION["SPCS83 California zone 3 (US Survey feet)",
#>         METHOD["Lambert Conic Conformal (2SP)",
#>             ID["EPSG",9802]],
#>         PARAMETER["Latitude of false origin",36.5,
#>             ANGLEUNIT["degree",0.0174532925199433],
#>             ID["EPSG",8821]],
#>         PARAMETER["Longitude of false origin",-120.5,
#>             ANGLEUNIT["degree",0.0174532925199433],
#>             ID["EPSG",8822]],
#>         PARAMETER["Latitude of 1st standard parallel",38.4333333333333,
#>             ANGLEUNIT["degree",0.0174532925199433],
#>             ID["EPSG",8823]],
#>         PARAMETER["Latitude of 2nd standard parallel",37.0666666666667,
#>             ANGLEUNIT["degree",0.0174532925199433],
#>             ID["EPSG",8824]],
#>         PARAMETER["Easting at false origin",6561666.667,
#>             LENGTHUNIT["US survey foot",0.304800609601219],
#>             ID["EPSG",8826]],
#>         PARAMETER["Northing at false origin",1640416.667,
#>             LENGTHUNIT["US survey foot",0.304800609601219],
#>             ID["EPSG",8827]]],
#>     CS[Cartesian,2],
#>         AXIS["easting (X)",east,
#>             ORDER[1],
#>             LENGTHUNIT["US survey foot",0.304800609601219]],
#>         AXIS["northing (Y)",north,
#>             ORDER[2],
#>             LENGTHUNIT["US survey foot",0.304800609601219]],
#>     USAGE[
#>         SCOPE["Engineering survey, topographic mapping."],
#>         AREA["United States (USA) - California - counties Alameda; Calaveras; Contra Costa; Madera; Marin; Mariposa; Merced; Mono; San Francisco; San Joaquin; San Mateo; Santa Clara; Santa Cruz; Stanislaus; Tuolumne."],
#>         BBOX[36.73,-123.02,38.71,-117.83]],
#>     ID["EPSG",2227]]
```

Note the text in "prj4string" that says "+units=us-ft". This means that the units are in feet. Some projections have units in meters so be mindful of this when doing some analysis such as seeing if a point is within X feet of a certain area. 

Let's convert our sf_neighborhoods data to coordinate reference system 2227 using `st_transform()`. 


```r
sf_neighborhoods <- st_transform(sf_neighborhoods, crs = 2227)
st_crs(sf_neighborhoods)
Coordinate Reference System:
  User input: EPSG:2227 
  wkt:
PROJCRS["NAD83 / California zone 3 (ftUS)",
    BASEGEOGCRS["NAD83",
        DATUM["North American Datum 1983",
            ELLIPSOID["GRS 1980",6378137,298.257222101,
                LENGTHUNIT["metre",1]]],
        PRIMEM["Greenwich",0,
            ANGLEUNIT["degree",0.0174532925199433]],
        ID["EPSG",4269]],
    CONVERSION["SPCS83 California zone 3 (US Survey feet)",
        METHOD["Lambert Conic Conformal (2SP)",
            ID["EPSG",9802]],
        PARAMETER["Latitude of false origin",36.5,
            ANGLEUNIT["degree",0.0174532925199433],
            ID["EPSG",8821]],
        PARAMETER["Longitude of false origin",-120.5,
            ANGLEUNIT["degree",0.0174532925199433],
            ID["EPSG",8822]],
        PARAMETER["Latitude of 1st standard parallel",38.4333333333333,
            ANGLEUNIT["degree",0.0174532925199433],
            ID["EPSG",8823]],
        PARAMETER["Latitude of 2nd standard parallel",37.0666666666667,
            ANGLEUNIT["degree",0.0174532925199433],
            ID["EPSG",8824]],
        PARAMETER["Easting at false origin",6561666.667,
            LENGTHUNIT["US survey foot",0.304800609601219],
            ID["EPSG",8826]],
        PARAMETER["Northing at false origin",1640416.667,
            LENGTHUNIT["US survey foot",0.304800609601219],
            ID["EPSG",8827]]],
    CS[Cartesian,2],
        AXIS["easting (X)",east,
            ORDER[1],
            LENGTHUNIT["US survey foot",0.304800609601219]],
        AXIS["northing (Y)",north,
            ORDER[2],
            LENGTHUNIT["US survey foot",0.304800609601219]],
    USAGE[
        SCOPE["Engineering survey, topographic mapping."],
        AREA["United States (USA) - California - counties Alameda; Calaveras; Contra Costa; Madera; Marin; Mariposa; Merced; Mono; San Francisco; San Joaquin; San Mateo; Santa Clara; Santa Cruz; Stanislaus; Tuolumne."],
        BBOX[36.73,-123.02,38.71,-117.83]],
    ID["EPSG",2227]]
```

## Spatial joins

What we want to do with these neighborhoods is to find out which neighborhood each suicide occurred in and sum up the number of suicides per neighborhood. Once we do that, we can make a map at the neighborhood level and be able to measure suicides per neighborhood. A spatial join is very similar to regular joins where we merge two data sets based on common variables (such as state name or unique ID code of a person). In this case it merges based on some shared geographic feature such as if two lines intersect or (as we will do so here) if a point is within some geographic area. 

Right now our *suicide* data is in a data.frame with some info on each suicide and the longitude and latitude of the suicide in separate columns. We want to turn this data.frame into a spatial object to allow us to find which neighborhood each suicide happened in. We can convert it into a spatial object using the `st_as_sf()` function from `sf`. Our input is first our data, *suicide.* Then in the `coords` parameter we put a vector of the column names so the function knows which columns the longitude and latitude columns are so it can convert those columns to a "geometry" column like we saw in *sf_neighborhoods* earlier. We'll set the CRS to be the WGS84 standard we saw earlier but we will change it to match the CRS that the neighborhood data has.


```r
suicide <- st_as_sf(suicide, 
                    coords = c("X", "Y"),
                    crs = "+proj=longlat +ellps=WGS84 +no_defs")
```

We want our suicides data in the same projection as the neighborhoods data so we need to use `st_transform()` to change the projection. Since we want the CRS to be the same as in *sf_neighborhoods*, we can set it using `st_crs(sf_neighborhoods)` to use the right CRS.


```r
suicide <- st_transform(suicide, 
                        crs = st_crs(sf_neighborhoods))
```

Now we can take a look at `head()` to see if it was projected.


```r
head(suicide)
#> Simple feature collection with 6 features and 12 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: 5986822 ymin: 2091310 xmax: 6013739 ymax: 2117180
#> Projected CRS: NAD83 / California zone 3 (ftUS)
#>   IncidntNum Category                           Descript DayOfWeek       Date
#> 1  180318931  SUICIDE ATTEMPTED SUICIDE BY STRANGULATION    Monday 04/30/2018
#> 2  180315501  SUICIDE       ATTEMPTED SUICIDE BY JUMPING  Saturday 04/28/2018
#> 3  180295674  SUICIDE              SUICIDE BY LACERATION  Saturday 04/21/2018
#> 4  180263659  SUICIDE                            SUICIDE   Tuesday 04/10/2018
#> 5  180235523  SUICIDE     ATTEMPTED SUICIDE BY INGESTION    Friday 03/30/2018
#> 6  180236515  SUICIDE            SUICIDE BY ASPHYXIATION  Thursday 03/29/2018
#>       Time PdDistrict Resolution                 Address
#> 1 06:30:00    TARAVAL       NONE     0 Block of BRUCE AV
#> 2 17:54:00   NORTHERN       NONE   700 Block of HAYES ST
#> 3 12:20:00   RICHMOND       NONE   3700 Block of CLAY ST
#> 4 05:13:00    CENTRAL       NONE     0 Block of DRUMM ST
#> 5 09:15:00    TARAVAL       NONE 0 Block of FAIRFIELD WY
#> 6 17:30:00   RICHMOND       NONE    300 Block of 29TH AV
#>                                         Location         PdId year
#> 1  POINT (-122.45168059935614 37.72218061554315) 1.803189e+13 2018
#> 2  POINT (-122.42876060987851 37.77620120112792) 1.803155e+13 2018
#> 3   POINT (-122.45462091999406 37.7881754224736) 1.802957e+13 2018
#> 4  POINT (-122.39642194376758 37.79414474237039) 1.802637e+13 2018
#> 5  POINT (-122.46324153155875 37.72679184368551) 1.802355e+13 2018
#> 6 POINT (-122.48929119750689 37.782735835121265) 1.802365e+13 2018
#>                  geometry
#> 1 POINT (5997229 2091310)
#> 2 POINT (6004262 2110838)
#> 3 POINT (5996881 2115353)
#> 4 POINT (6013739 2117180)
#> 5 POINT (5993921 2093059)
#> 6 POINT (5986822 2113584)
```

We can see it is now a "simple feature collection" with the correct projection. And we can see there is a new column called "geometry" just like in *sf_neighborhoods*. The type of data in "geometry" is POINT since our data is just a single location instead of a polygon like in the neighborhoods data. 

Since we have both the neighborhoods and the suicides data let's make a quick map to see the data.


```r
plot(sf_neighborhoods$geometry)
plot(suicide$geometry, add = TRUE, col = "red")
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-13-1} \end{center}

Our next step is to combine these two data sets to figure out how many suicides occurred in each neighborhood. This will be a multi-step process so let's plan it out before beginning. Our suicide data is one row for each suicide, our neighborhood data is one row for each neighborhood. Since our goal is to map at the neighborhood-level we need to get the neighborhood where each suicide occurred then aggregate up to the neighborhood-level to get a count of the suicides-per-neighborhood. Then we need to combine that with that the original neighborhood data (since we need the "geometry" column) and we can then map it.

1. Find which neighborhood each suicide happened in
2. Aggregate suicide data until we get one row per neighborhood and a column showing the number of suicides in that neighborhood
3. Combine with the neighborhood data
4. Make a map

We'll start by finding the neighborhood where each suicide occurred using the function `st_join()` which is a function in `sf`. This does a spatial join and finds the polygon (neighborhood in our case) where each point is located in. Since we will be aggregating the data, let's call the output of this function *suicide_agg*. The order in the () is important! For our aggregation we want the output to be at the suicide-level so we start with the *suicide* data. In the next step we'll see why this matters. 


```r
suicide_agg <- st_join(suicide, sf_neighborhoods)
```

Let's look at the first 6 rows. 


```r
head(suicide_agg)
#> Simple feature collection with 6 features and 13 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: 5986822 ymin: 2091310 xmax: 6013739 ymax: 2117180
#> Projected CRS: NAD83 / California zone 3 (ftUS)
#>   IncidntNum Category                           Descript DayOfWeek       Date
#> 1  180318931  SUICIDE ATTEMPTED SUICIDE BY STRANGULATION    Monday 04/30/2018
#> 2  180315501  SUICIDE       ATTEMPTED SUICIDE BY JUMPING  Saturday 04/28/2018
#> 3  180295674  SUICIDE              SUICIDE BY LACERATION  Saturday 04/21/2018
#> 4  180263659  SUICIDE                            SUICIDE   Tuesday 04/10/2018
#> 5  180235523  SUICIDE     ATTEMPTED SUICIDE BY INGESTION    Friday 03/30/2018
#> 6  180236515  SUICIDE            SUICIDE BY ASPHYXIATION  Thursday 03/29/2018
#>       Time PdDistrict Resolution                 Address
#> 1 06:30:00    TARAVAL       NONE     0 Block of BRUCE AV
#> 2 17:54:00   NORTHERN       NONE   700 Block of HAYES ST
#> 3 12:20:00   RICHMOND       NONE   3700 Block of CLAY ST
#> 4 05:13:00    CENTRAL       NONE     0 Block of DRUMM ST
#> 5 09:15:00    TARAVAL       NONE 0 Block of FAIRFIELD WY
#> 6 17:30:00   RICHMOND       NONE    300 Block of 29TH AV
#>                                         Location         PdId year
#> 1  POINT (-122.45168059935614 37.72218061554315) 1.803189e+13 2018
#> 2  POINT (-122.42876060987851 37.77620120112792) 1.803155e+13 2018
#> 3   POINT (-122.45462091999406 37.7881754224736) 1.802957e+13 2018
#> 4  POINT (-122.39642194376758 37.79414474237039) 1.802637e+13 2018
#> 5  POINT (-122.46324153155875 37.72679184368551) 1.802355e+13 2018
#> 6 POINT (-122.48929119750689 37.782735835121265) 1.802365e+13 2018
#>                            nhood                geometry
#> 1     Oceanview/Merced/Ingleside POINT (5997229 2091310)
#> 2                   Hayes Valley POINT (6004262 2110838)
#> 3               Presidio Heights POINT (5996881 2115353)
#> 4 Financial District/South Beach POINT (6013739 2117180)
#> 5             West of Twin Peaks POINT (5993921 2093059)
#> 6                 Outer Richmond POINT (5986822 2113584)
```

There is now the *nhood* column from the neighborhoods data which says which neighborhood the suicide happened in. Now we can aggregate up to the neighborhood-level using `group_by()` and `summarize()` functions from the `dplyr` package. 

We actually don't have a variable with the number of suicides so we need to make that. We can simply call it *number_suicides* and give it that value of 1 since each row is only one suicide.


```r
suicide_agg$number_suicides <- 1
```

Now we can aggregate the data and save the results back into *suicide_agg*. 


```r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
suicide_agg <- suicide_agg %>% 
  group_by(nhood) %>% 
  summarize(number_suicides = sum(number_suicides))
```

Let's check a summary of the *number_suicides* variable we made.


```r
summary(suicide_agg$number_suicides)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>    1.00   13.50   23.50   32.30   37.25  141.00
```

The minimum is one suicide per neighborhood, 33 on average, and 141 in the neighborhood with the most suicides. So what do we make of this data? Well, there are some data issues that cause problems in these results. Let's think about the minimum value. Did every single neighborhood in the city have at least one suicide? No. Take a look at the number of rows in this data, keeping in mind there should be one row per neighborhood.


```r
nrow(suicide_agg)
#> [1] 40
```

And let's compare it to the *sf_neighborhoods* data.


```r
nrow(sf_neighborhoods)
#> [1] 41
```

The suicides data is missing 2 neighborhoods (one of the 40 values is missing and is NA, not a real neighborhood). That is because if no suicides occurred there, there would never be a matching row in the data so that neighborhood wouldn't appear in the suicide data. That's not going to be a major issue here but is something to keep in mind in future research. 

The data is ready to merge with the *sf_neighborhoods* data. We'll introduce a new function that makes merging data simple. This function also comes from the `dplyr` package.

The function we will use is `left_join()` which takes two parameters, the two data sets to join together. 

`left_join(data1, data2)`

This function joins these data and keeps all of the rows from the left data and every column from both data sets. It combines the data based on any matching columns (matching meaning same column name) in both data sets. Since in our data sets, the column *nhood* exists in both, it will merge the data based on that column. 

There are two other functions that are similar but differ based on which rows they keep. 

+ `left_join() ` - All rows from Left data and all columns from Left and Right data
+ `right_join()` - All rows from Right data and all columns from Left and Right data
+ `full_join() ` - All rows and all columns from Left and Right data

We could alternatively use the `merge()` function which is built into R but that function is slower than the `dplyr` functions and requires us to manually set the matching columns. 

We want to keep all rows in *sf_neighborhoods* (keep all neighborhoods) so we can use `left_join(sf_neighborhoods, suicide_agg)`. Let's save the results into a new data set called *sf_neighborhoods_suicide*. 

We don't need the spatial data for "suicide_agg" anymore and it will cause problems with our join if we keep it, so let's delete the "geometry" column from that data. We can do this by assigning the column the value of NULL.


```r
suicide_agg$geometry <- NULL
```

Now we can do our join. 


```r
sf_neighborhoods_suicide <- left_join(sf_neighborhoods, suicide_agg)
#> Joining, by = "nhood"
```

If we look at `summary()` again for *number_suicides* we can see that there are now 2 rows with NAs. These are the neighborhoods where there were no suicides so they weren't present in the *suicide_agg* data. 


```r
summary(sf_neighborhoods_suicide$number_suicides)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#>    1.00   15.00   24.00   33.08   38.50  141.00       2
```

We need to convert these values to 0. We will use the `is.na()` function to conditionally find all rows with an NA value in the *number_suicides* column and use square bracket notation to change the value to 0.


```r
sf_neighborhoods_suicide$number_suicides[is.na(sf_neighborhoods_suicide$number_suicides)] <- 0
```

Checking it again we see that the minimum is now 0 and the mean number of suicides decreases a bit to about 31.5 per neighborhood.


```r
summary(sf_neighborhoods_suicide$number_suicides)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>    0.00   12.00   23.00   31.46   36.00  141.00
```

## Making choropleth maps

**Finally** we are ready to make some choropleth maps.

For these maps we are going to use `ggplot2` again so we need to load it.


```r
library(ggplot2)
```

`ggplot2`'s benefit is you can slowly build graphs or maps and improve the graph at every step. Earlier, we used functions such as `geom_line()` for line graphs and `geom_point()` for scatter plots. For mapping these polygons we will use `geom_sf()` which knows how to handle spatial data. 

As usual we will start with `ggplot()`, inputting our data first. Then inside of `aes` (the aesthetics of the graph/map) we use a new parameter `fill`. In `fill` we will put in the *number_suicides* column and it will color the polygons (neighborhoods) based on values in that column. Then we can add the `geom_sf()`. 


```r
ggplot(sf_neighborhoods_suicide, aes(fill = number_suicides)) +
  geom_sf() 
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-27-1} \end{center}

We have now created a choropleth map showing the number of suicides per neighborhood in San Francisco! Based on the legend, neighborhoods that are light blue have the most suicides while neighborhoods that are dark blue have the fewest (or none at all). Normally we'd want the opposite, with darker areas signifying a greater amount of whatever the map is showing. 

We can use `scale_fill_gradient()` to set the colors to what we want. We input a color for low value and a color for high value and it'll make the map shade by those colors. 


```r
ggplot(sf_neighborhoods_suicide, aes(fill = number_suicides)) +
  geom_sf() +
  scale_fill_gradient(low = "white", high = "red") 
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-28-1} \end{center}

This gives a much better map and clearly shows the areas where suicides are most common and where there were no suicides.

To make this map easier to read and look better, let's add a title to the map and to the legend.


```r
ggplot(sf_neighborhoods_suicide, aes(fill = number_suicides)) +
  geom_sf() +
  scale_fill_gradient(low = "white", high = "red") +
  labs(fill = "# of suicides",
       title = "Suicides in San Francisco, by neighborhood",
       subtitle = "2003 - 2017") 
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-29-1} \end{center}

Since the coordinates don't add anything to the map, let's get rid of them.


```r
ggplot(sf_neighborhoods_suicide, aes(fill = number_suicides)) +
  geom_sf() +
  scale_fill_gradient(low = "white", high = "red") +
  labs(fill = "# of suicides",
       title = "Suicides in San Francisco, by neighborhood",
       subtitle = "2003 - 2017") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank())
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-30-1} \end{center}

So what should we take away from this map? There are more suicides in the downtown area than any other place in the city. Does this mean that people are more likely to kill themselves there than elsewhere? Not necessarily. A major mistake people make when making a choropleth map (or really any type of map) is accidentally making a population map. The darker shaded parts of our map are also where a lot of people live. So if there are more people, it is reasonable that there would be more suicides (or crimes, etc.). What we'd really want to do is make a rate per some population (usually per 100k though this assumes equal risk for every person in the city which isn't really correct) to control for population differences.

We'll use this data in Chapter \@ref(interactive-maps) to make interactive choropleth maps so let's save it.


```r
save(sf_neighborhoods_suicide, file = "data/sf_neighborhoods_suicide.rda")
```

## Practice problems

For answers, please see Section \@ref(problem-answers-chapter-18). Please keep in mind that the goal is to have your answers be the same as mine, even if the code isn't. With R you can answer a question in multiple ways, so different code can lead to the same answer.

<!--chapter:end:choropleth-maps.Rmd-->

# Interactive maps

For this chapter you'll need the following files, which are available for download [here](https://github.com/jacobkap/r4crimz/tree/master/data): san_francisco_marijuana_geocoded.csv and sf_neighborhoods_suicide.rda.

While maps of data are useful, their ability to show incident-level information is quite limited. They tend to show broad trends - where crime happened in a city - rather than provide information about specific crime incidents. While broad trends are important, there are significant drawbacks about being unable to get important information about an incident without having to check the data. An interactive map bridges this gap by showing trends while allowing you to zoom into individual incidents and see information about each incident.

For this lesson we will be using data on every marijuana dispensary in San Francisco that has an active dispensary license as of late September 2019. The file is called "san_francisco_marijuana_geocoded.csv".

When downloaded from California's Bureau of Cannabis Control ([here](https://aca5.accela.com/bcc/customization/bcc/cap/licenseSearch.aspx) if you're interested) the data contains the address of each dispensary but does not have coordinates. Without coordinates we are unable to map points, meaning we need to 
geocode them. Geocoding is the process of taking an address and getting the longitude and latitude of that address for mapping. For this lesson I've already geocoded the data and we'll learn how to do so in Chapter \@ref(geocoding).


```r
library(readr)
marijuana <- read_csv("data/san_francisco_marijuana_geocoded.csv")
#> Rows: 33 Columns: 13
#> -- Column specification --------------------------------------------------------
#> Delimiter: ","
#> chr (11): License_Number, License_Type, Business_Owner, Business_Contact_Inf...
#> dbl  (2): lat, long
#> 
#> i Use `spec()` to retrieve the full column specification for this data.
#> i Specify the column types or set `show_col_types = FALSE` to quiet this message.
marijuana <- as.data.frame(marijuana)
```

## Why do interactive graphs matter?

### Understanding your data

The most important thing to learn from this book is that understanding your data is crucial to good research. Making interactive maps is a very useful way to better understand your data as you can immediately see geographic patterns and quickly look at characteristics of those incidents to understand them. 

In this lesson we will make a map of each marijuana dispensary in San Francisco that lets you click on the dispensary and see some information about it. If we see a cluster of dispensaries, we can click on each one to see if they are similar - for example if owned by the same person. Though it is possible to find these patterns just looking at the data, it is easier to be able to see a geographic pattern and immediately look at information about each incident.

### Police departments use them

Interactive maps are popular in large police departments such as Philadelphia and New York City. They allow easy understanding of geographic patterns in the data and, importantly, allow such access to people who do not have the technical skills necessary to create the maps. If nothing else, learning interactive maps may help you with a future job. 

## Making the interactive map 

As usual, let's take a look at the top 6 rows of the data.


```r
head(marijuana)
#>    License_Number                License_Type   Business_Owner
#> 1 C10-0000614-LIC Cannabis - Retailer License     Terry Muller
#> 2 C10-0000586-LIC Cannabis - Retailer License    Jeremy Goodin
#> 3 C10-0000587-LIC Cannabis - Retailer License     Justin Jarin
#> 4 C10-0000539-LIC Cannabis - Retailer License Ondyn Herschelle
#> 5 C10-0000522-LIC Cannabis - Retailer License      Ryan Hudson
#> 6 C10-0000523-LIC Cannabis - Retailer License      Ryan Hudson
#>                                                                                                           Business_Contact_Information
#> 1                             OUTER SUNSET HOLDINGS, LLC  : Barbary Coast Sunset : Email- terry@barbarycoastsf.com : Phone- 5107173246
#> 2                           URBAN FLOWERS  : Urban Pharm : Email- hilary@urbanpharmsf.com : Phone- 9168335343 : Website- www.up415.com
#> 3                      CCPC, INC.  : The Green Door : Email- alicia@greendoorsf.com : Phone- 4155419590 : Website- www.greendoorsf.com
#> 4 SEVENTY SECOND STREET  : Flower Power SF : Email- flowerpowersf@hotmail.com : Phone- 5103681262 : Website- flowerpowerdispensary.com
#> 5   HOWARD STREET PARTNERS, LLC  : The Apothecarium : Email- Ryan@apothecarium.com : Phone- 4157469001 : Website- www.apothecarium.com
#> 6              DEEP THOUGHT, LLC  : The Apothecarium : Email- ryan@pothecarium.com : Phone- 4157469001 : Website- www.Apothecarium.com
#>          Business_Structure                         Premise_Address Status
#> 1 Limited Liability Company  2165 IRVING ST san francisco, CA 94122 Active
#> 2               Corporation 122 10TH ST SAN FRANCISCO, CA 941032605 Active
#> 3               Corporation   843 Howard ST SAN FRANCISCO, CA 94103 Active
#> 4               Corporation    70 SECOND ST SAN FRANCISCO, CA 94105 Active
#> 5 Limited Liability Company   527 Howard ST San Francisco, CA 94105 Active
#> 6 Limited Liability Company 2414 Lombard ST San Francisco, CA 94123 Active
#>   Issue_Date Expiration_Date                Activities Adult-Use/Medicinal
#> 1  9/13/2019       9/12/2020 N/A for this license type                BOTH
#> 2  8/26/2019       8/25/2020 N/A for this license type                BOTH
#> 3  8/26/2019       8/25/2020 N/A for this license type                BOTH
#> 4   8/5/2019        8/4/2020 N/A for this license type                BOTH
#> 5  7/29/2019       7/28/2020 N/A for this license type                BOTH
#> 6  7/29/2019       7/28/2020 N/A for this license type                BOTH
#>        lat      long
#> 1 37.76318 -122.4811
#> 2 37.77480 -122.4157
#> 3 37.78228 -122.4035
#> 4 37.78823 -122.4004
#> 5 37.78783 -122.3965
#> 6 37.79945 -122.4414
```

This data has information about the type of license, who the owner is, where the dispensary is (as an address and as coordinates), and contact information. We'll be making a map showing every dispensary in the city and make it so when you click a dot it'll make a popup showing information about that dispensary. 

We will use the package `leaflet` for our interactive map. `leaflet` produces maps similar to Google Maps with circles (or any icon we choose) for each value we add to the map. It allows you to zoom in, scroll around, and provides context to each incident that isn't available on a static map. 


```r
install.packages("leaflet")
```


```r
library(leaflet)
```

To make a `leaflet` map we need to run the function `leaflet()` and add a tile to the map. A tile is simply the background of the map. This [website](https://leaflet-extras.github.io/leaflet-providers/preview/) provides a large number of potential tiles to use, though many are not relevant to our purposes of crime mapping. 

We will use a standard tile from Open Street Maps. This tile gives street names and highlights important features such has parks and large stores which provides useful contexts for looking at the data. The `attribution` parameter isn't strictly necessary but it is good form to say where your tile is from.  


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors')
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-5-1} 

When you run the above code it shows a world map (copied several times). Zoom into it and it'll start showing relevant features of wherever you're looking.

Note the `%>%` between the `leaflet()` function and the `addTiles()` function. `leaflet` is one of the packages in R where we can use pipes.

To add the points to the graph we use the function `addMarkers()` which has two parameters, `lng` and `lat`. For both parameters we put the column in which the longitude and latitude are, respectively.


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addMarkers(lng = marijuana$long, 
             lat = marijuana$lat)
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-6-1} 

It now adds an icon indicating where every dispensary in our data is. You can zoom in and scroll around to see more about where the dispensaries are. There are only a few dozen locations in the data so the popups overlapping a bit doesn't affect our map too much. If we had more - such as crime data with millions of offenses - it would make it very hard to read. To change the icons to circles we can change the function `addMarkers()` to `addCircleMarkers()`, keeping the rest of the code the same.


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$long, 
                   lat = marijuana$lat)
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-7-1} 

This makes the icon into circles which take up less space than icons. To adjust the size of our icons we use the `radius` parameter in `addMarkers()` or `addCircleMarkers()`. The larger the radius, the larger the icons. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$long, 
                   lat = marijuana$lat,
                   radius = 5)
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-8-1} 

Setting the `radius` option to 5 shrinks the size of the icon a lot. In your own maps you'll have to fiddle with this option to get it to look the way you want. Let's move on to adding information about each icon when clicked upon. 

## Adding popup information

The parameter `popup` in the `addMarkers()` or `addCircleMarkers()` functions lets you input a character value (if not already a character value it will convert it to one) and that will be shown as a popup when you click on the icon. Let's start simple here by inputting the business owner column in our data and then build it up to a more complicated popup. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$long, 
                   lat = marijuana$lat,
                   radius = 5,
                   popup = marijuana$Business_Owner)
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-9-1} 

Try clicking around and you'll see that the owner of the dispensary you clicked on appears over the dot. We usually want to have a title indicating what the value in the popup means. We can do this by using the `paste()` function to combine text explaining the value with the value itself. Let's add the words "Business Owner:" before the business owner column.


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$long, 
                   lat = marijuana$lat,
                   radius = 5,
                   popup = paste("Business Owner:", marijuana$Business_Owner))
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-10-1} 

We don't have too much information in the data but we let's add the address and license number to the popup by adding them to the `paste()` function we're using. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$long, 
                   lat = marijuana$lat,
                   radius = 5,
                   popup = paste("Business Owner:", marijuana$Business_Owner,
                                 "Address:", marijuana$Premise_Address,
                                 "License:", marijuana$License_Number))
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-11-1} 

Just adding the location text makes it try to print out everything on one line which is hard to read. If we add the text `<br>` where we want a line break it will make one. `<br>` is the HTML tag for line-break which is why it works making a new line in this case. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$long, 
                   lat = marijuana$lat,
                   radius = 5,
                   popup = paste("Business Owner:", marijuana$Business_Owner,
                                 "<br>",
                                 "Address:", marijuana$Premise_Address,
                                 "<br>",
                                 "License:", marijuana$License_Number))
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-12-1} 

## Dealing with too many markers

In our case with only 33 rows of data, turning the markers to circles solves our visibility issue. In cases with many more rows of data, this doesn't always work. A solution for this is to cluster the data into groups where the dots only show if you zoom down. 

If we add the code `clusterOptions = markerClusterOptions()` to our `addCircleMarkers()` it will cluster for us. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$long, 
                   lat = marijuana$lat,
                   radius = 5,
                   popup = paste("Business Owner:", marijuana$Business_Owner,
                                 "<br>",
                                 "Address:", marijuana$Premise_Address,
                                 "<br>",
                                 "License:", marijuana$License_Number),
                   clusterOptions = markerClusterOptions())
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-13-1} 

Locations close to each other are grouped together in fairly arbitrary groupings and we can see how large each grouping is by moving our cursor over the circle. Click on a circle or zoom in and it will show smaller groupings at lower levels of aggregation. Keep clicking or zooming in and it will eventually show each location as its own circle. 

This method is very useful for dealing with huge amounts of data as it avoids overflowing the map with too many icons at one time. A downside, however, is that the clusters are created arbitrarily meaning that important context, such as neighborhood, can be lost. 

## Interactive choropleth maps

In Chapter \@ref(choropleth-maps) we worked on choropleth maps which are maps with shaded regions, such as states colored by which political party won them in an election. Here we will make interactive choropleth maps where you can click on a shaded region and see information about that region. We'll make the same map as before - neighborhoods shaded by the number of suicides. 

Let's load the San Francisco suicides-by-neighborhood data that we made earlier. 


```r
load("data/sf_neighborhoods_suicide.rda")
```

We'll begin the `leaflet` map similar to before but use the function `addPolygons()` and our input here is the geometry column of *sf_neighborhoods_suicide*. 


```r
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry)
#> Warning: sf layer is not long-lat data
#> Warning: sf layer has inconsistent datum (+proj=lcc +lat_0=36.5 +lon_0=-120.5 +lat_1=38.4333333333333 +lat_2=37.0666666666667 +x_0=2000000.0001016 +y_0=500000.0001016 +datum=NAD83 +units=us-ft +no_defs).
#> Need '+proj=longlat +datum=WGS84'
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-15-1} 

It gives us a blank map because our polygons are projected to San Francisco's projection while the `leaflet` map expects the standard CRS, WGS84 which uses longitude and latitude. So we need to change our projection to that using the `st_transform()` function from the `sf` package. 


```r
library(sf)
#> Linking to GEOS 3.9.1, GDAL 3.2.1, PROJ 7.2.1
sf_neighborhoods_suicide <- st_transform(sf_neighborhoods_suicide,
                                         crs = "+proj=longlat +datum=WGS84")
```

Now let's try again. 


```r
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry)
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-17-1} 

It made a map with large blue lines indicating each neighborhood. Let's change the appearance of the graph a bit before making a popup or shading the neighborhoods The parameter `color` in `addPolygons()` changes the color of the lines - let's change it to black. The lines are also very large, blurring into each other and making the neighborhoods hard to see. We can change the `weight` parameter to alter the size of these lines - smaller values are smaller lines. Let's try setting this to 1.


```r
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry,
              color = "black",
              weight = 1)
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-18-1} 

That looks better and we can clearly distinguish each neighborhood now. 

As we did earlier, we can add the popup text directly to the function which makes the geographic shapes, in this case `addPolygons()`. Let's add the *nhood* column value - the name of that neighborhood - and the number of suicides that occurred in that neighborhood. As before, when we click on a neighborhood a popup appears with the output we specified.


```r
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Neighborhood: ", sf_neighborhoods_suicide$nhood,
                             "<br>",
                             "Number of Suicides: ", sf_neighborhoods_suicide$number_suicides))
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-19-1} 

For these types of maps we generally want to shade each polygon to indicate how frequently the event occurred in the polygon. We'll use the function `colorNumeric()` which takes a lot of the work out of the process of coloring in the map. This function takes two inputs, first a color palette which we can get from the site [Color Brewer](http://colorbrewer2.org/#type=sequential&scheme=OrRd&n=3). Let's  use the fourth bar in the Sequential page, which is light orange to red. If you look in the section with each HEX value it says that the palette is "3-class OrRd". The "3-class" just means we selected 3 colors, the "OrRd" is the part we want. That will tell `colorNumeric()` to make the palette using these colors. The second parameter is the column for our numeric variable, *number_suicides*. 

We will save the output of `colorNumeric("OrRd", sf_neighborhoods_suicide$number_suicides)` as a new variable which we'll call *pal* for convenience. Then inside of `addPolygons()` we'll set the parameter `fillColor` to `pal(sf_neighborhoods_suicide$number_suicides)`, running this function on the column. What this really does is determine which color every neighborhood should be based on the value in the *number_suicides* column.


```r
pal <- colorNumeric("OrRd", sf_neighborhoods_suicide$number_suicides)
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Neighborhood: ", sf_neighborhoods_suicide$nhood,
                             "<br>",
                             "Number of Suicides: ", sf_neighborhoods_suicide$number_suicides),
              fillColor = pal(sf_neighborhoods_suicide$number_suicides))
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-20-1} 

Since the neighborhoods are transparent, it is hard to distinguish which color is shown. We can make each neighborhood a solid color by setting the parameter `fillOpacity` inside of `addPolygons()` to 1.


```r
pal <- colorNumeric("OrRd", sf_neighborhoods_suicide$number_suicides)
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Neighborhood: ", sf_neighborhoods_suicide$nhood,
                             "<br>",
                             "Number of Suicides: ", sf_neighborhoods_suicide$number_suicides),
              fillColor = pal(sf_neighborhoods_suicide$number_suicides),
              fillOpacity = 1)
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-21-1} 

To add a legend to this we use the function `addLegend()` which takes three parameters. `pal` asks which color palette we are using - we want it to be the exact same as we use to color the neighborhoods so we'll use the *pal* object we made. The `values` parameter is used for which column our numeric values are from, in our case the *number_suicides* column so we'll input that. Finally `opacity` determines how transparent the legend will be. As each neighborhood is set to not be transparent at all, we'll also set this to 1 to be consistent. 


```r
pal <- colorNumeric("OrRd", sf_neighborhoods_suicide$number_suicides)
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Neighborhood: ", sf_neighborhoods_suicide$nhood,
                             "<br>",
                             "Number of Suicides: ", sf_neighborhoods_suicide$number_suicides),
              fillColor = pal(sf_neighborhoods_suicide$number_suicides),
              fillOpacity = 1) %>%
  addLegend(pal = pal, 
            values = sf_neighborhoods_suicide$number_suicides,
            opacity = 1)
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-22-1} 

Finally, we can add a title to the legend using the `title` parameter inside of `addLegend()`.


```r
pal <- colorNumeric("OrRd", sf_neighborhoods_suicide$number_suicides)
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Neighborhood: ", sf_neighborhoods_suicide$nhood,
                             "<br>",
                             "Number of Suicides: ", sf_neighborhoods_suicide$number_suicides),
              fillColor = pal(sf_neighborhoods_suicide$number_suicides),
              fillOpacity = 1) %>%
  addLegend(pal = pal, 
            values = sf_neighborhoods_suicide$number_suicides,
            opacity = 1,
            title = "Suicides")
```



\begin{center}\includegraphics[width=0.9\linewidth,]{crimebythenumbers_files/figure-latex/unnamed-chunk-23-1} 


## Practice problems

For answers, please see Section \@ref(problem-answers-chapter-19). Please keep in mind that the goal is to have your answers be the same as mine, even if the code isn't. With R you can answer a question in multiple ways, so different code can lead to the same answer.

<!--chapter:end:interactive-maps.Rmd-->

