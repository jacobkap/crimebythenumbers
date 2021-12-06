load("data/sf_neighborhoods_suicide.rda")

rds_example <- readRDS("data/shr_1976_2020.rds") 

## install.packages("readr")

library(readr)

shootings <- read_csv("data/fatal-police-shootings-data.csv")

head(shootings)

shootings <- as.data.frame(shootings)

## install.packages("readxl")

library(readxl)

sqf <- read_excel("data/sqf-2019.xlsx")

## install.packages("haven")

library(haven)

shootings <- read_dta("data/fatal-police-shootings-data.dta")

shootings <- read_sas("data/fatal-police-shootings-data.sas")

shootings <- read_sav("data/fatal-police-shootings-data.sav")

## install.packages("asciiSetupReader")

library(asciiSetupReader)
shr <- read_ascii_setup("data/2020_SHR_NATIONAL_MASTER_FILE.txt", "data/ucr_shr.sps")

## save(shootings, file =  "data/shootings.rda")

## saveRDS(shootings, "data/shootings.rds")

## write_csv(shootings, "data/shootings.csv")

## write_dta(shootings, "data/shootings.dta")

## write_sas(shootings, "data/shootings.sas")

## write_sav(shootings, "data/shootings.sav")
