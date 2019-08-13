
--- 
knit: "bookdown::render_book"
title: "R 4 Criminology"
author: ["Jacob Kaplan"]
bibliography: [packages.bib]
biblio-style: apalike
link-citations: yes
colorlinks: yes
description: "Notes for learning R for Criminology."
url: "https://r4crim.com"
fontsize: 12pt
github-repo: jacobkap/r4crim
site: bookdown::bookdown_site
documentclass: book
---



# Welcome {-}

These notes introduce the programming language R and are meant for undergrads or graduate students studying criminology. While R is a useful tool for any field of study, this book focuses on the skills criminologists should know and uses crime data as the example data sets. For most of the lessons we will be working through real research questions such as "what do victims of murder look like?" and "are Pennsylvanians drinking more beer than they used to?" and "where do police shootings occur in Philadelphia?" This book will also cover the following skills in R: regular expressions, webscraping, mapping and handling geographic data, and basic data coding skills. It will also cover some important official crime data sources such as UCR, NIBRS, and the Census.

This book is based off of the lessons I took as a Master's student in criminology at Penn from [Dr. Greg Ridgeway](https://crim.sas.upenn.edu/people/greg-ridgeway). While the code and some of the packages are different, the basic philosophy of teaching by example and a focus on the fundamentals of R (and programming in general) are the same. For Dr. Ridgeway's R lessons, please see [here](https://github.com/gregridgeway/R4crim) .

For this book you should have the latest version of [R](https://cloud.r-project.org/) installed and be running it through [RStudio Desktop (The free version)](https://www.rstudio.com/products/rstudio/download/) . We'll get into what R and RStudio are soon but please have them installed to be able to follow along with each chapter. I highly recommend following along with the code for each lesson and trying to use the lessons learned on a data set you are interested in. 

## Simple vs Easy {-}

In the course of this book we will cover things that are very simple. For example, we'll take a data set (think of an Excel file) with crime for nearly every agency in the United States and keep only data from Colorado for a small number of years. We'll then find out how many murders happened in Colorado each year. This is a fairly simple task - it can be expressed in two sentences. You'll find that most of what you do is simple like this - it is quick to talk about what you are doing and the concepts are not complicated. What it isn't is easy. To actually write the R code to do this takes knowing a number of interrelated concepts in R and several lines of code to implement each step. 

While this distinction may seem minor, I think it is important for newer programmers to understand that what they are doing may be simple to talk about but hard to implement. It is easy to feel like a bad programmer because something that can be articulated in 10 seconds may take 10 hours to do. So during times when you are working with R try to keep in mind that even though a project may be easy to articulate, it may be hard to code and that there is often very little correlation between the two.

## How to Contribute {-}

If you have any questions, suggestions, or find any issues please email me at jacob@crimedatatool.com. If this book has helped you, also email me so I can try to measure the book's impact and who is using it. 

## Acknowledgements {-}

Finally I am thankful for the authors of all of the R packages used in this book which make my own work easier and hopefully make it easier for you to learn R through this book.
