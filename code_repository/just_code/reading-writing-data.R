if (!knitr:::is_html_output()) {
  options("width" = 56)
  knitr::opts_chunk$set(tidy.opts = list(width.cutoff = 56, indent = 2), tidy = TRUE)
  }

## install.packages("readr")

library(readr)

shootings <- read_csv("data/fatal-police-shootings-data.csv")

head(shootings)

shootings <- as.data.frame(shootings)

## install.packages("haven")

library(haven)

shootings <- read_dta("data/fatal-police-shootings-data.dta")

shootings <- read_sas("data/fatal-police-shootings-data.sas")

shootings <- read_sav("data/fatal-police-shootings-data.sav")

## save(shootings, file =  "data/shootings.rda")

## write_csv(shootings, "data/shootings.csv")

## write_dta(shootings, "data/shootings.dta")

## write_sas(shootings, "data/shootings.sas")

## write_sav(shootings, "data/shootings.sav")
