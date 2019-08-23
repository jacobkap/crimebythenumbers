--- 
knit: "bookdown::render_book"
title: "R 4 Criminology"
author: ["Jacob Kaplan"]
bibliography: [packages.bib]
biblio-style: apalike
link-citations: yes
colorlinks: yes
description: "These notes introduce the programming language R and are meant for undergrads or graduate students studying criminology. R is a programming language that is well-suited to the type of work frequently done in criminology - taking messy data and turning it into useful information such as cleaning the data, graphing it, or running statistical tests on the data. While R is a useful tool for many fields of study, this book focuses on the skills criminologists should know and uses crime data for the example data sets."
url: "https://r4crim.com"
cover-image: "Ruby-throated_HummingBird.jpg"
fontsize: 12pt
github-repo: jacobkap/r4crim
site: bookdown::bookdown_site
documentclass: book
---

# Welcome {-}

Placeholder


## What you will learn {-}
### Skills {-}
### Data {-}
## What you won't learn {-}
## Simple vs Easy {-}
## How to Contribute {-}

<!--chapter:end:index.Rmd-->


# About the author {-}

**Jacob Kaplan** (<http://crimedatatool.com/>) is a Ph.D. candidate in criminology at the University of Pennsylvania. His research focuses on Crime Prevention Through Environmental Design (CPTED), specifically on the effect of outdoor lighting on crime. He is the author of several R packages, such as [asciiSetupReader](https://jacobkap.github.io/asciiSetupReader/), [fastDummies](https://jacobkap.github.io/fastDummies/), and [boxoffice](https://jacobkap.github.io/boxoffice/). His website [Crime Data Tool](http://crimedatatool.com/) allows easy analysis of crime-related data and he has released over a [dozen crime data sets](http://crimedatatool.com/data.html) (primarily FBI UCR data) on openICPSR. He is currently on the job market.

For a list of papers he has written (including working papers), please see [here](http://crimedatatool.com/research.html).

For a list of data sets he has cleaned, aggregated, and make public, please see [here](http://crimedatatool.com/data.html).

<!--chapter:end:author.Rmd-->


# Introduction to R and RStudio

Placeholder


## Why learn to program?
### Scale
### Reproducibility
## Using RStudio
### Opening an R Script
### Setting the working directory
### Changing RStudio
#### General
#### Code
#### Appearance
#### Pane Layout
### Helpful cheatsheets
## Reading data into R
### Loading data
## First steps to exploring data
## Finding help about functions

<!--chapter:end:intro-to-r.Rmd-->


# (PART) Clean {-}
# Subsetting: Making big things small {#subsetting-intro}

Placeholder


## Select specific values
## Assignment values to objects (Making "things") {#assignment}
## Vectors (collections of "things") {#vectors}
## Logical values and operations
### Matching a single value
### Matching multiple values
### Does not match
### Greater than or less than
### Combining conditional statements - or, and
## Subsetting a data.frame 
### Select specific columns
### Select specific rows
### Battleships
### Subset Colorado data

<!--chapter:end:subsetting.Rmd-->


# Exploratory data analysis {#explore}

Placeholder


## Summary and Table
## Graphing
## Aggregating (summaries of groups) {#aggregate}

<!--chapter:end:exploratory-data-analysis.Rmd-->


# Dates and times

Placeholder


## Why do dates and times matter?
## `lubridate`
## Working with dates
## Chicago crime data
### Exercises

<!--chapter:end:dates-and-times.Rmd-->


# Regular Expressions 

Placeholder


## Finding patterns in text with `grep()`
## Finding and replacing patterns in text with `gsub()`
## Useful special characters
### Multiple characters `[]`
### n-many of previous character `{n}`
### n-many to m-many of previous character `{n,m}`
### Start of string and "not" `^`
### End of string `$`
### Anything `.`
### One or more of previous `+`
### Zero or more of previous `*`
### Multiple patterns `|`
### Parentheses `()`
###  Optional text `?`
## Changing capitalization

<!--chapter:end:regular-expressions.Rmd-->


# (PART) Collect {-}
# Webscraping with `rvest`

Placeholder


## Scraping one page
## Cleaning the webscraped data
## Fixing names
### Exercises

<!--chapter:end:webscraping.Rmd-->


# Functions

Placeholder


## A simple function
## Adding parameters 
## Making a function to scrape movie data {#movie_function}

<!--chapter:end:functions.Rmd-->


# For loops

Placeholder


## Basic for loops
## Scraping multiple days of movie data

<!--chapter:end:for-loops.Rmd-->


# Reading and Writing Data

Placeholder


## Reading Data into R
### R 
### Excel 
### Stata 
### SAS 
### SPSS
## Writing Data 
### R 
### Excel 
### Stata 
### SAS 
### SPSS

<!--chapter:end:reading-writing-data.Rmd-->


# Scraping data from PDFs

Placeholder


## Downloading officer-involved Shooting Files
## Scraping information from the page
### Combining the data sets
## Extracting data from PDFs
### Scraping a single PDF
### Making a function
### Looping through every PDF

<!--chapter:end:pdf-scraping.Rmd-->


# Scraping Tables from PDFs {#scrape-table}

Placeholder


## Scraping the first table
## Making a function

<!--chapter:end:pdf-tables.Rmd-->


# Geocoding 

Placeholder


## Geocoding a single address
## Making a function
## Geocoding officer shooting locations

<!--chapter:end:geocoding.Rmd-->


# (PART) Visualize {-}
# Graphing with `ggplot2` {#graphing-intro}

Placeholder


## What does the data look like? 
## Graphing data 
## Time-Series Plots
## Color blindness

<!--chapter:end:graphing.Rmd-->


# Hotspot maps

Placeholder


## A simple map
## What really are maps?
## Making a hotspot map
### Colors
## Looping through each year

<!--chapter:end:hotspot-maps.Rmd-->


# Choropleth maps

Placeholder


## Spatial joins
## Making choropleth maps

<!--chapter:end:choropleth-maps.Rmd-->


# Interactive maps

While maps of data are useful, their ability to show incident-level information is quite limited. They tend to show broad trends - where crime happened in a city - rather than provide information about specific crime incidents. While broad trends are important, there are significant drawbacks about being unable to get important information about an incident without having to check the data. An interactive map bridges this gap by showing trends while allowing you to zoom into individual incidents and see information about each incident.

For this lesson we will continue to use the officer shooting data so let's load that.


```r
load("data/officer_shootings_geocoded.rda")
```


## Why do interactive graphs matter?

### Understanding your data

The most important thing to learn from this course is that understanding your data is crucial to good research. Making interactive maps is a very useful way to better understand your data as you can immediately see geographic patterns and quickly look at characteristics of those incidents to understand them. 

In this lesson we will make a map of each officer-involved shooting that lets you click on the shooting and see some information about it. If we see a cluster of shootings, we can click on each shooting to see if they are similar. Though it is possible to find these patterns just looking at the data, it is easier to be able to see a geographic pattern and immediately look at information about each incident.

### Police departments use them

Interactive maps are popular in large police departments such as Philadelphia and New York City. They allow easy understanding of geographic patterns in the data and, importantly, allow such access to people who do not have the technical skills necessary to create the maps. If nothing else, learning interactive maps will help you with a future job. 

## Making the interactive map 

As usual, let's take a look at the top 6 rows of the data.


```r
head(officer_shootings_geocoded)
#>   shooting_number                                 location      dates
#> 1           19-04      4900 Hazel Avenue, Philadelphia, PA 2019-03-06
#> 2           19-06      1300 Kater Street, Philadelphia, PA 2019-03-28
#> 4           19 11     2100 Taney Terrace, Philadelphia, PA 2019-04-25
#> 5           19-13   1800 N. Broad Street, Philadelphia, PA 2019-05-11
#> 6           19 14          3400 G Street, Philadelphia, PA 2019-05-20
#> 7           18-01 2800 Kensington Avenue, Philadelphia, PA 2018-01-13
#>         lon      lat
#> 1 -75.22087 39.95046
#> 2 -75.16355 39.94289
#> 4 -75.19104 39.92646
#> 5 -75.15754 39.98030
#> 6 -75.11482 39.99991
#> 7 -75.12253 39.99151
```

This data is fairly sparse about information regarding the shooting. All it has is the date , shooting number, and address (which isn't that useful as location is already covered by the map). The level of detail about the crime may be sparse, but we can still create a map where you can click an incident dot on the map and a popup will tell you when it happened. 

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

preserve14bb8ee9313454e7

When you run the above code it shows a world map (copied several times). Zoom into it and it'll start showing relevant features of wherever you're looking.

Note the `%>%` between the `leaflet()` function and the `addTiles()` function. This is called a "pipe" in R and is used like the `+` in `ggplot()` to combine multiple functions together. This is used heavily in what is called the "tidyverse", a series of packages that are prominent in modern R and useful for data analysis. We won't be covering them in this book but for more information on them you can check the [tidyverse website](https://www.tidyverse.org/). For this lesson you need to know that each piece of the `leaflet` function must end with `%>%` for the next line to work. 

To add the points to the graph we use the function `addMarkers()` which has two parameters, `lng` and `lat`. For both parameters we put the column in which the longitude and latitude are, respectively.


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addMarkers(lng = officer_shootings_geocoded$lon, 
             lat = officer_shootings_geocoded$lat)
```

preserve0bdf9ec05b7fff99

It now adds an icon indicating where every shooting in our data is. You can zoom in and scroll around to see more about where the shootings happen. These icons are a bit large, covering nearly all of the city and making it hard to see where shootings happen. To change the icons to circles we can change the function `addMarkers()` to `addCircleMarkers()`, keeping the rest of the code the same, 



```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = officer_shootings_geocoded$lon, 
                   lat = officer_shootings_geocoded$lat)
```

preserve9166529ba5e38435

This makes the icon into circles but they are still large and cover most of the map. To adjust the size of our icons we use the `radius` parameter in `addMarkers()` or `addCircleMarkers()`. The larger the radius, the larger the icons. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = officer_shootings_geocoded$lon, 
                   lat = officer_shootings_geocoded$lat,
                   radius = 5)
```

preserve9ee177f5fa84571c

Setting the `radius` option to 5 shrinks the size of the icon a lot. In your own maps you'll have to fiddle with this option to get it to look the way you want. Let's move on to adding information about each icon when clicked upon. 

## Adding popup information

The parameter `popup` in the `addMarkers()` or `addCircleMarkers()` functions lets you input a character value (if not already a character value it will convert it to one) and that will be shown as a popup when you click on the icon. Let's start simple here by inputting the dates column in our data and then build it up to a more complicated popup. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = officer_shootings_geocoded$lon, 
                   lat = officer_shootings_geocoded$lat,
                   radius = 5,
                   popup = officer_shootings_geocoded$dates)
```

preserve4f8635ff3761400b

Try clicking around and you'll see that the data of the incident you clicked on appears over the dot. Though fairly clear in this case, we usually want to have a title indicating what the value in the popup means. We can do this by using the `paste()` function to combine text explaining the value with the value itself. Let's add the words "Date of Shooting:" before the date. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = officer_shootings_geocoded$lon, 
                   lat = officer_shootings_geocoded$lat,
                   radius = 5,
                   popup = paste("Date of Shooting:", officer_shootings_geocoded$dates))
```

preserve086c61ee74fe3f9e

We don't have many other columns but we can add the location and shooting number to the popup by adding them to the `paste()` function we're using. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = officer_shootings_geocoded$lon, 
                   lat = officer_shootings_geocoded$lat,
                   radius = 5,
                   popup = paste("Shooting Number:", officer_shootings_geocoded$shooting_number,
                                 "Date:", officer_shootings_geocoded$dates,
                                 "Location:", officer_shootings_geocoded$location))
```

preserve90b24d3d33053fd6

Just adding the location text makes it try to print out everything on one line which is hard to read. If we add the text `<br>` where we want a line break it will make one. `<br>` is the HTML tag for line-break which is why it works making a new line in this case. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = officer_shootings_geocoded$lon, 
                   lat = officer_shootings_geocoded$lat,
                   radius = 5,
                   popup = paste("Shooting Number:", officer_shootings_geocoded$shooting_number,
                                 "<br>",
                                 "Date:", officer_shootings_geocoded$dates,
                                 "<br>",
                                 "Location:", officer_shootings_geocoded$location))
```

preserved0ed4bf676122a4c

## Dealing with too many markers

Even though we shrunk the size of the circles, it is still rather hard to see any trends as there are so many incidents and relatively large circles. One solution is to keep shrinking the size of the circles, but this quickly becomes a bad solution when using more frequent data such as a crime data set (Philadelphia data alone has about 200k crimes reported per year). The other solution is to cluster the data into groups where the dots only show if you zoom down. 

If we add the code `clusterOptions = markerClusterOptions()` to our `addCircleMarkers()` it will cluster for us. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = officer_shootings_geocoded$lon, 
                   lat = officer_shootings_geocoded$lat,
                   radius = 5,
                   popup = paste("Shooting Number:", officer_shootings_geocoded$shooting_number,
                                 "<br>",
                                 "Date:", officer_shootings_geocoded$dates,
                                 "<br>",
                                 "Location:", officer_shootings_geocoded$location),
                   clusterOptions = markerClusterOptions())
```

preserve5c3cb78b01f40cc0

Incidents close to each other are grouped together in fairly arbitrary groupings and we can see how large each grouping is by moving our cursor over the circle. Click on a circle or zoom in and and it will show smaller groupings at lower levels of aggregation. Keep clicking or zooming in and it will eventually show each incident as its own circle. 

This method is very useful for dealing with huge amounts of data as it avoids overflowing the map with too many icons at one time. A downside, however, is that the clusters are created arbitrarily meaning that important context, such as neighborhood, can be lost. 

## Interactive choropleth maps

In Chapter \@ref(choropleth-maps) we worked on choropleth maps which are maps with shaded regions, such as states colored by which political party won them in an election. Here we will make interactive choropleth maps where you can click on a shaded region and see information about that region. We'll make the same map as before - Census tracts with the number of officer-involved shootings. 

Let's load the tract-level officer-involved shooting data we made earlier. 


```r
load("data/philly_tracts_shootings.rda")
```

We'll begin the `leaflet` map similar to before but use the function `addPolygons()` and our input here is the geometry column of *philly_tracts_shootings*. 


```r
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry)
#> Warning: sf layer is not long-lat data
#> Warning: sf layer has inconsistent datum (+proj=lcc +lat_1=40.96666666666667 +lat_2=39.93333333333333 +lat_0=39.33333333333334 +lon_0=-77.75 +x_0=600000 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=us-ft +no_defs).
#> Need '+proj=longlat +datum=WGS84'
```

preserve086a5cba9a618ad8

It gives us a blank map because our polygons are projected to Philly's projection while the `leaflet` map expects the standard CRS, WGS84 which uses longitude and latitude. So we need to change our projection to that using the `st_transform()` function from the `sf` package. 


```r
library(sf)
#> Linking to GEOS 3.6.1, GDAL 2.2.3, PROJ 4.9.3
philly_tracts_shootings <- st_transform(philly_tracts_shootings,
                                        crs = "+proj=longlat +datum=WGS84")
```

Now let's try again. 


```r
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry)
```

preservefc9692afea5bcda6

It made a map with large blue lines indicating each tract. Let's change the appearance of the graph a bit before making a popup or shading the tracts. The parameter `color` in `addPolygons()` changes the color of the lines - let's change it to black. The lines are also very large, blurring into each other and making the tracts hard to see. We can change the `weight` parameter to alter the size of these lines - smaller values are smaller lines. Let's try setting this to 1.


```r
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry,
              color = "black",
              weight = 1)
```

preservec3934ebfc571486c

That looks better and we can clearly distinguish each tract now. 

As we did earlier, we can add the popup text directly to the function which makes the geographic shapes, in this case `addPolygons()`. Let's add the GEOID10 column value - the unique ID code for that tract - and the number of shootings that occurred in that tract. As before when we click on a tract a popup appears with the output we specified.


```r
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Tract ID: ", philly_tracts_shootings$GEOID10,
                             "<br>",
                             "Number of Shootings: ", philly_tracts_shootings$number_shootings))
```

preserveba431d1084f55a99

For these types of maps we generally want to shade each polygon to indicate how frequently the event occurs in the polygon. For this process we will make a simple function which will automatically shade the tracts by the value in the column we want it shaded by - *number_shootings*. 

We'll use the function `colorNumeric()` to make our colors, which takes a lot of the work out of this process. This function takes two inputs, first a color palette which we can get from the site [colorbrewer2](http://colorbrewer2.org/#type=sequential&scheme=OrRd&n=3). Let's  use the fourth bar in the Sequential page, which is light orange to red. If you look in the section with each HEX value it says that the palette is "3-class OrRd". The "3-class" just means we selected 3 colors, the "OrRd" is the part we want. That will tell `colorNumeric()` to make the palette using these colors. The second parameter is the column for our numeric variable, *number_shootings*. 

We will save the output of `colorNumeric("OrRd", philly_tracts_shootings$number_shootings)` as a new variable which we'll call *pal* for convenience. Then inside of `addPolygons()` we'll set the parameter `fillColor` to `pal(philly_tracts_shootings$number_shootings)`, running this function on the column. What this really does it determine which color every tract should be based on the value in the *number_shootings* column.


```r
pal <- colorNumeric("OrRd", philly_tracts_shootings$number_shootings)
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Tract ID: ", philly_tracts_shootings$GEOID10,
                             "<br>",
                             "Number of Shootings: ", philly_tracts_shootings$number_shootings),
              fillColor = pal(philly_tracts_shootings$number_shootings))
```

preservedbfc6d8492542a75

Since the tracts are transparent, it is hard to distinguish which color is shown. We can make each tract a solid color by setting the parameter `fillOpacity` inside of `addPolygons()` to 1.


```r
pal <- colorNumeric("OrRd", philly_tracts_shootings$number_shootings)
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Tract ID: ", philly_tracts_shootings$GEOID10,
                             "<br>",
                             "Number of Shootings: ", philly_tracts_shootings$number_shootings),
              fillColor = pal(philly_tracts_shootings$number_shootings),
              fillOpacity = 1)
```

preservedb521f62d851a641

To add a legend to this we use the function `addLegend()` which takes three parameters. `pal` asks which color palette we are using - we want it to be the exact same as we use to color the tracts so we'll use the *pal* object we made. The `values` parameter is used for which column our numeric values are from, in our case the *number_shootings* column so we'll input that. Finally `opacity` determines how transparent the legend will be. As each tract is set to not be transparent at all, we'll also set this to 1. 


```r
pal <- colorNumeric("OrRd", philly_tracts_shootings$number_shootings)
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Tract ID: ", philly_tracts_shootings$GEOID10,
                             "<br>",
                             "Number of Shootings: ", philly_tracts_shootings$number_shootings),
              fillColor = pal(philly_tracts_shootings$number_shootings),
              fillOpacity = 1) %>%
  addLegend(pal = pal, 
            values = philly_tracts_shootings$number_shootings,
            opacity = 1)
```

preserve9aa4ac07eb3c3a8c

Finally, we can add a title to the legend using the `title` parameter inside of `addLegend()`.


```r
pal <- colorNumeric("OrRd", philly_tracts_shootings$number_shootings)
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Tract ID: ", philly_tracts_shootings$GEOID10,
                             "<br>",
                             "Number of Shootings: ", philly_tracts_shootings$number_shootings),
              fillColor = pal(philly_tracts_shootings$number_shootings),
              fillOpacity = 1) %>%
  addLegend(pal = pal, 
            values = philly_tracts_shootings$number_shootings,
            opacity = 1,
            title = "Police Shootings")
```

preserved35265090e02b954

<!--chapter:end:interactive-maps.Rmd-->


# More graphing with `ggplot` {#ois_graphs}

Placeholder


## Graphing a single variable
### Numeric variable
### Categorical variable
## Time Series

<!--chapter:end:graphing-officer-shootings.Rmd-->


# R Markdown

Placeholder


## Code
### Hiding code in the output
## Tables
## Making the output file

<!--chapter:end:rmarkdown.Rmd-->


# (PART) Data {-}

# Introduction

At this point you have learned how to read in data, manipulate it to get just the parts you want or to aggregate it to the level you want, and visualize it through maps or graphs. You've done so using data sets that are commonly used in criminological research.

In the next several chapters we will be introducing a number of other data sets - or looking deeper into data we've already seen - that are common in criminology. While these chapters do use R a bit to explore or read in the data, they are primarily a discussion of the trade-offs of using each data set. Some of the data sets are difficult to read into R, requiring more steps than you may be useful, so these chapters will also discuss how to get that data into R.

<!--chapter:end:intro-data.Rmd-->


# Uniform Crime Report (UCR) Data - Offenses Known and Clearances by Arrest {#ucr}

Placeholder


## Exploring the UCR data
## ORIs - Unique agency identifiers
## Hierarchy Rule
## Which crimes are included
### Index Crimes
### The problem with using index crimes 
### Rape definition change
## Actual offenses, clearances, and unfounded offenses
### Actual
### Total Cleared
### Cleared Where All Offenders Are Under 18
### Unfounded
## Number of months reported

<!--chapter:end:working-with-ucr-data.Rmd-->


# Census data from Social Explorer

Placeholder


## Getting Census data from Social Explorer

<!--chapter:end:census-data-social-explorer.Rmd-->


# Census data from IPUMS

Placeholder


## Getting IPUMS data
## Cleaning the data
## Aggregating the data
## Graphing the data
## Mapping the data

<!--chapter:end:census-data-ipums.Rmd-->


# National Incident-Based Reporting System (NIBRS) Data {#nibrs}

Placeholder


## Downloading the data
## Reading the data

<!--chapter:end:working-with-nibrs-data.Rmd-->


\cleardoublepage 

# (APPENDIX) Appendix {-}

# Useful resources

### Learning R and coding issues

[R for Data Science](http://r4ds.had.co.nz/) - This free online book provides a good introduction for R though it differs in several important ways from this class.


[Stack Overflow](http://stackoverflow.com/) - Stack Overflow is a website that answers programming-related questions. It's like the Yahoo Answers of programming. That said, a lot of the answer are bad. Some answers are overly confusing or provide code that you may not understand. You can use this source, but don't rely too heavily on it. Its search function isn't great so it's better to Google your question and choose the stackoverflow.com result. 


### Data

[Crime Data](https://www.icpsr.umich.edu/icpsrweb/content/NACJD/index.html) - 

[Crime Data (cleaned)](http://crimedatatool.com/data) - 

[General Data](https://www.icpsr.umich.edu/icpsrweb/) - 

[Census Data](https://usa.ipums.org/usa/) - 

[Local crime data](https://www.policedatainitiative.org/datasets/) - 

<!--chapter:end:useful-resources.Rmd-->

