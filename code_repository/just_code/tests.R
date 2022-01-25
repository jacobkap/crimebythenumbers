example_data <- data.frame(year = c(2000, 2000, 2001, 2001),
                           crime_type = c("murder", "theft", "murder", "theft"),
                           crime_count = c(100, 100, 200, 50))
example_data

example_data[example_data$crime_type = "murder", c("year", "crime_count")]

example_data[example_data$crime_type != "murder", c("year", "crime_count")]

## install.packages("testthat")

library(testthat)

add_2 <- function(number) { return(number + 2) }
expect_equal(add_2(2), 4)

expect_equal(add_2(2), 5)

knitr::include_graphics('images/test_summary.PNG')

knitr::include_graphics('images/test_file_setup.PNG')

knitr::include_graphics('images/usethis_test.PNG')

knitr::include_graphics('images/test_setup.PNG')

knitr::include_graphics('images/usethis_test_default_example.PNG')

knitr::include_graphics('images/usethis_test_default_example2.PNG')

knitr::include_graphics('images/test_example.PNG')
