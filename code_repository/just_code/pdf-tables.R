library(pdftools)

border_patrol <- pdf_text("data/usbp_stats_fy2017_sector_profile.pdf")

head(border_patrol)

length(border_patrol)

border_patrol[1]

strsplit("criminology", split = "n")

sector_profile <- border_patrol[1]
sector_profile <- strsplit(sector_profile, "\r\n")
sector_profile <- sector_profile[[1]]

head(sector_profile)

sector_profile <- trimws(sector_profile)

sector_profile

grep("Miami", sector_profile)

grep("Nationwide Total", sector_profile)

sector_profile <- sector_profile[grep("Miami", sector_profile):grep("Nationwide Total", sector_profile)]

head(sector_profile)

## install.packages("stringr")

library(stringr)

sector_profile <- str_split_fixed(sector_profile, " {2,}", 10)

head(sector_profile)

sector_profile <- data.frame(sector_profile, stringsAsFactors = FALSE)
names(sector_profile) <- c("sector",
                           "agent_staffing",
                           "apprehensions",
                           "other_than_mexican_apprehensions", 
                           "marijuana_pounds",
                           "cocaine_pounds",
                           "accepted_prosecutions",
                           "assaults",
                           "rescues",
                           "deaths")

head(sector_profile)

sector_profile <- border_patrol[1]
sector_profile <- trimws(sector_profile)
sector_profile <- strsplit(sector_profile, "\r\n")
sector_profile <- sector_profile[[1]]
sector_profile <- sector_profile[grep("Miami", sector_profile):grep("Nationwide Total", sector_profile)]
sector_profile <- str_split_fixed(sector_profile, " {2,}", 10)
sector_profile <- data.frame(sector_profile, stringsAsFactors = FALSE)
names(sector_profile) <- c("sector",
                           "agent_staffing",
                           "total_apprehensions",
                           "other_than_mexican_apprehensions", 
                           "marijuana_pounds",
                           "cocaine_pounds",
                           "accepted_prosecutions",
                           "assaults",
                           "rescues",
                           "deaths")

scrape_pdf <- function(list_of_tables, table_number, number_columns, column_names) {
  data <- list_of_tables[table_number]
  data <- trimws(data)
  data <- strsplit(data, "\r\n")
  data <- data[[1]]
  data <- data[grep("Miami", data):grep("Nationwide Total", data)]
  data <- str_split_fixed(data, " {2,}", number_columns)
  data <- data.frame(data, stringsAsFactors = FALSE)
  names(data) <- column_names
  
  return(data)
}

table_1 <- scrape_pdf(list_of_tables = border_patrol,
                      table_number = 1, 
                      number_columns = 10, 
                      column_names = c("sector",
                                       "agent_staffing",
                                       "total_apprehensions",
                                       "other_than_mexican_apprehensions", 
                                       "marijuana_pounds",
                                       "cocaine_pounds",
                                       "accepted_prosecutions",
                                       "assaults",
                                       "rescues",
                                       "deaths"))
table_2 <- scrape_pdf(list_of_tables = border_patrol,
                      table_number = 2, 
                      number_columns = 6, 
                      column_names = c("sector",
                                       "accompanied_juveniles",
                                       "unaccompanied_juveniles",
                                       "total_juveniles", 
                                       "total_adults",
                                       "total_apprehensions"))
table_3 <- scrape_pdf(list_of_tables = border_patrol,
                      table_number = 3, 
                      number_columns = 4, 
                      column_names = c("sector",
                                       "female",
                                       "male",
                                       "total_apprehensions"))

table_1$sector <- gsub("\\*", "", table_1$sector)
table_1$sector <- trimws(table_1$sector)

library(dplyr)
final_data <- left_join(table_1, table_2)
final_data <- left_join(final_data, table_3)

head(final_data)
