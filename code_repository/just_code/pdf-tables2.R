## install.packages("tabulizer")

library(tabulizer)

data <- extract_tables(file = "data/AbbreRptCurrent.pdf")

length(data)
is(data)

data[[1]]

head(data[[2]])
tail(data[[2]])

data <- extract_tables(file = "data/AbbreRptCurrent.pdf", output = "data.frame")
head(data[[2]])

data <- extract_tables(file = "data/AbbreRptCurrent.pdf")

column_names <- c("county",
                  "pretrial_felons",
                  "conv_felons",
                  "conv_felons_sentence_to_county_jail_time",
                  "parole_violators",
                  "parole_violators_with_a_new_charge",
                  "pretrial_misd",
                  "conv_misd",
                  "bench_warrants",
                  "federal",
                  "pretrial_sjf",
                  "conv_sjf_sentenced_to_co_jail_time",
                  "conv_sjf_sentence_to_state_jail",
                  "total_others",
                  "total_local",
                  "total_contract",
                  "total_population",
                  "total_capacity",
                  "percent_of_capacity",
                  "available_beds")

page1_table <- data[[2]]
page1_table <- data.frame(page1_table)
names(page1_table) <- column_names
page1_table

for (i in c(2, 4, 6, 8, 10, 12, 14, 16, 18)) {
  temp        <- data[[i]]
  temp        <- data.frame(temp)
  names(temp) <- column_names
}

library(dplyr)
example1 <- head(mtcars)
example2 <- head(mtcars)
bind_rows(example1, example2)

final <- data.frame()
for (i in c(2, 4, 6, 8, 10, 12, 14, 16, 18)) {
  temp        <- data[[i]]
  temp        <- data.frame(temp)
  names(temp) <- column_names
  final       <- bind_rows(final, temp)
}
head(final)
tail(final)

data <- extract_tables(file = "data/PregnantFemaleReportingCurrent.pdf")
data <- data[[1]]
data

head(data[, c(1, 3, 5, 7, 9)])

head(data[, c(2, 4, 6, 8, 10)])

data <- data.frame(county = c(data[, c(1, 3, 5, 7, 9)]),
              pregnant_females_booked = c(data[, c(2, 4, 6, 8, 10)]))
head(data)
tail(data)

data <- data[data$county != "", ]
head(data)
tail(data)

data <- extract_tables(file = "data/PregnantFemaleReportingCurrent.pdf")
data <- data[[1]]

x <- 1:10
x

x[c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)]

x[TRUE]

x[c(TRUE, FALSE)]

data <- data.frame(county = c(data[, c(TRUE, FALSE)]),
                   pregnant_females_booked = c(data[, c(FALSE, TRUE)]))
data <- data[data$county != "", ]
head(data)
tail(data)
