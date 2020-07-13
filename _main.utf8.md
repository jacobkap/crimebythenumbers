--- 
knit: "bookdown::render_book"
title: "Crime by the Numbers"
date: "2020-07-08"
author: "Jacob Kaplan"
bibliography: [packages.bib]
biblio-style: apalike
link-citations: yes
colorlinks: yes
description: "This book introduces the programming language R and is meant for undergrads or graduate students studying criminology. R is a programming language that is well-suited to the type of work frequently done in criminology - taking messy data and turning it into useful information. While R is a useful tool for many fields of study, this book focuses on the skills criminologists should know and uses crime data for the example data sets."
url: "https://crimebythenumbers.com"
cover-image: "Ruby-throated_HummingBird.jpg"
fontsize: 12pt
github-repo: "jacobkap/crimebythenumbers"
site: bookdown::bookdown_site
documentclass: book
---

# Welcome {-}

Placeholder


## Why learn to program? {-}
### Scale {-}
### Reproducibility {-}
## What you will learn {-}
### Skills {-}
### Data {-}
## What you won't learn {-}
## Simple vs Easy {-}
## How to Contribute {-}

<!--chapter:end:index.Rmd-->

# About the author {-}

**Jacob Kaplan** is a PhD candidate in criminology at the University of Pennsylvania. He holds a master's degree in criminology from the University of Pennsylvania and a bachelor's degree in criminal justice from California State University, Sacramento. His research focuses on Crime Prevention Through Environmental Design (CPTED), specifically on the effect of outdoor lighting on crime. He is the author of several R packages that make it easier to work with data, including  [fastDummies](https://jacobkap.github.io/fastDummies/) and [asciiSetupReader](https://jacobkap.github.io/asciiSetupReader/). His [website](http://jacobdkaplan.com/) allows easy analysis of crime-related data and he has released over a [dozen crime data sets](http://jacobdkaplan.com/data.html) (primarily FBI UCR data) on openICPSR that he has compiled, cleaned, and made available to the public. He is currently on the job market.

For a list of papers he has written (including working papers), please see [here](http://jacobdkaplan.com/research.html).

For a list of data sets he has cleaned, aggregated, and made public, please see [here](http://jacobdkaplan.com/data.html).

<!--chapter:end:author.Rmd-->


# Introduction to R and RStudio

Placeholder


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
## Assigning values to objects (Making "things") {#assignment}
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
### Subset Colorado data

<!--chapter:end:subsetting.Rmd-->


# Exploratory data analysis {#explore}

Placeholder


## Summary and Table
## Graphing
## Aggregating (summaries of groups) {#aggregate}

<!--chapter:end:exploratory-data-analysis.Rmd-->


# Regular Expressions 

Placeholder


## Finding patterns in text with `grep()`
## Finding and replacing patterns in text with `gsub()`
## Useful special characters
### Multiple characters `[]`
### n-many of previous character `{n}`
### n-many to m-many of previous character `{n,m}`
### Start of string 
### End of string `$`
### Anything `.`
### One or more of previous `+`
### Zero or more of previous `*`
### Multiple patterns `|`
### Parentheses `()`
###  Optional text `?`
## Changing capitalization

<!--chapter:end:regular-expressions.Rmd-->


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


# (PART) Visualize {-}
# Graphing with `ggplot2` {#graphing-intro}

Placeholder


## What does the data look like? 
## Graphing data 
## Time-Series Plots
## Scatter Plots
## Color blindness

<!--chapter:end:graphing.Rmd-->


# Hotspot maps

Placeholder


## A simple map
## What really are maps?
## Making a hotspot map
### Colors

<!--chapter:end:hotspot-maps.Rmd-->


# Choropleth maps

Placeholder


## Spatial joins
## Making choropleth maps

<!--chapter:end:choropleth-maps.Rmd-->


# Interactive maps

Placeholder


## Why do interactive graphs matter?
### Understanding your data
### Police departments use them
## Making the interactive map 
## Adding popup information
## Dealing with too many markers
## Interactive choropleth maps

<!--chapter:end:interactive-maps.Rmd-->


# R Markdown

Placeholder


## Code
### Hiding code in the output
## Inline Code
## Tables
## Footnotes
## Citation
## Spell check 
## Making the output file

<!--chapter:end:rmarkdown.Rmd-->


# Git

Placeholder


## What is Git and why do I need it?

<!--chapter:end:git.Rmd-->


# (PART) Collect {-}
# Webscraping with `rvest`

Placeholder


## Scraping one page
## Cleaning the webscraped data

<!--chapter:end:webscraping.Rmd-->


# Functions

Placeholder


## A simple function
## Adding parameters 
## Making a function to scrape recipes {#recipes-function}

<!--chapter:end:functions.Rmd-->


# For loops

Placeholder


## Basic for loops
## Scraping multiple recipes

<!--chapter:end:for-loops.Rmd-->


# Scraping tables from PDFs {#scrape-table}

Placeholder


## Scraping the first table
## Making a function

<!--chapter:end:pdf-tables.Rmd-->

# More Scraping tables from PDFs {#scrape-table2}

In  Chapter \@ref(scrape-table) we used the package `pdftools` to scrape tables on arrests/seizures from the United States Border Patrol that were only available in a PDF. Given the importance of PDF scraping - hopefully by the time you read this chapter more data will be available in reasonable formats and not in PDFs - in this chapter we'll continue working on scraping tables from PDFs. Here we will use the package `tabulizer` which has a number of features making it especially useful for grabbing tables from PDFs. One issue which we saw in Chapter \@ref(scrape-table) is that the table may not be the only thing on the page - the page could also have a title, page number etc. When using `pdftools` we use regular expressions and subsetting to remove all the extra lines. Using `tabulizer` we can simply say (through a handy function) that we only want a part of the page, so we only scrape the table itself.  For more info about the `tabulizer` package please see their site [here](https://docs.ropensci.org/tabulizer/). 

For this chapter we'll scrape data from the Pennsylvania Commission on Sentencing's Sentencing Guidelines (available [here](https://github.com/jacobkap/crimebythenumbers/blob/master/data/7th%20Edition%20Amendment%205%20Complete%20Manual%202020.pdf). Sentencing guidelines are basically just a simple series of conditional statements that add up (each TRUE statement is literally given a numerical value) and then judges used the guidelines based on the final number value for the defendant. As an example, per the guidelines if a person is charged with a Felony 1 offenses (i.e. the second most serious kind of felony) that is worth 7 points. If this person has a prior record of a Felony 2 crime, add 2 points to the score. Assuming nothing else in the guidelines applies to this person, they now have 9 points and score, in combination with the current offense, affects the recommended sentence they receive. 

This PDF is 100 pages and only about a quarter of that is discussing the guidelines and what criteria a person has to meet to be given a certain score.^[I recommend reading/skimming this section - or your own state's sentencing guidelines - to get a better understanding of what they entail.] After this section is about 70 pages of tables which have the crime code (e.g. 3802 (f)(2)), the crime in plain English (e.g. DUI-commercial/school vehicles & incapable of safe driving (minor occupant; 1st/2nd off)), an indicator or what level of offense (e.g. Felony 1, Felony 2, Misdemeanor 3, etc.), the number of points a person receives for being charged with this crime, and the number of points a person receives for having a prior record of this offense.    

First, open this PDF in your web browser
While this technique 

If you don't have this package installed you'll need to install it using `install.packages("tabulizer")`. 


```r
library(tabulizer)
```


<!--chapter:end:pdf-tables2.Rmd-->


# Geocoding 

Placeholder


## Geocoding a single address
## Making a function
## Geocoding San Francisco marijuana dispensary locations

<!--chapter:end:geocoding.Rmd-->

# (PART) Data {-}

# Introduction

At this point you have learned how to read in data, manipulate it to get just the parts you want or to aggregate it to the level you want, and visualize it through maps or graphs. You've done so using data sets that are commonly used in criminological research.

In the next several chapters we will be introducing a number of other data sets - or looking deeper into data we've already seen - that are common in criminology. While these chapters do use R a bit to explore or read in the data, they are primarily a discussion of the trade-offs of using each data set. Some of the data sets are difficult to read into R, requiring more steps than you may be useful, so these chapters will also discuss how to get that data into R.

<!--chapter:end:intro-data.Rmd-->


# Uniform Crime Report (UCR) - Offenses Known and Clearances by Arrest {#ucr}

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


\cleardoublepage 

# (APPENDIX) Appendix {-}

# Useful resources

## Learning R and coding issues

[R for Data Science](http://r4ds.had.co.nz/) - This free online book provides a good introduction for R though it differs in several important ways from this class.


[Stack Overflow](http://stackoverflow.com/) - Stack Overflow is a website that answers programming-related questions. It's like the Yahoo Answers of programming. That said, a lot of the answer are bad. Some answers are overly confusing or provide code that you may not understand. You can use this source, but don't rely too heavily on it. Its search function isn't great so it's better to Google your question and choose the stackoverflow.com result. 

## Data

[National Archive of Criminal Justice Data (NACJD) - Crime Data](https://www.icpsr.umich.edu/icpsrweb/content/NACJD/index.html) - NACJD is a site where you can download crime data, including many of the data sets we've worked on throughout this book. Nearly all FBI and BJS data sets are available on this site. If you need data for a research question, NACJD is a good place to start looking. 

[Inter-university Consortium for Political and Social Research (ICPSR) - General Data](https://www.icpsr.umich.edu/icpsrweb/) - Like NACJD, ICPSR allows you to download data from a variety of government and non-government sources for research. ICPSR holds a wider variety of data than NACJD does (NACJD is part of ICPSR) so includes data that is not specifically crime-related. 

[Crime Data Tool - cleaned crime data](http://jacobdkaplan.com/data) - This is my personal site where you can look at graphs and tables of (primarily) agency-level data including offenses, arrests, assaults on officers, and prison information. On each page you can download a .csv file with the information displayed. On the [data page](http://jacobdkaplan.com/data.html), there are links to all of the data sets I have cleaned and made available - this data is mostly UCR data but includes some other data such as the alcohol consumption data we explored in Chapter \@ref(#graphing-intro). 

[Local crime data](https://www.policedatainitiative.org/datasets/) - The Police Foundation has put together a list of data sets made public by police agencies. This data is primarily data sets of crime incidents, calls for service, arrests, and officer-involved shootings though some other categories such as workforce demographics and assaults on officers are available. 

<!--chapter:end:useful-resources.Rmd-->

