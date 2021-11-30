library(tabulizer)

data <- extract_tables(file = "data/AbbreRptCurrent.pdf")
is(data)
length(data)
data[[1]]
head(data[[2]])

data[[1]]

head(data[[2]])
tail(data[[2]])

data <- extract_tables(file = "data/AbbreRptCurrent.pdf", output = "data.frame")
head(data[[2]])

apply(data[[1]], 2, paste, collapse = "")

library(janitor)
column_names <- apply(data[[1]], 2, paste, collapse = "")
column_names <- make_clean_names(column_names)
column_names

page1_table <- data[[2]]
page1_table <- data.frame(page1_table)
names(page1_table) <- column_names
head(page1_table)
tail(page1_table)

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
