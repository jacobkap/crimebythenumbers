a <- "2"
b <- "2"

a + b

a <- 2
b <- 2
a + b

2 == 3

is(2)

is("2")

is(TRUE)

is("TRUE")

is(true)

class(2)
class("2")
class(TRUE)

is.numeric(2)
is.character("2")
is.character(2)
is.logical(TRUE)

load("data/ucr2017.rda")

names(ucr2017)

is(ucr2017$year)

is.numeric(ucr2017$year)

a <- c(1, 2, 3)

a <- (1, 2, 3)

a <- c(1 2 3)

c("cat", "dog", 2)

example <- data.frame(column_1 = c(1, 3, 5, 7, 9),
                      column2  = c("hello", "darkness", "my", "old", "friend"))
example

example <- data.frame(c(1, 3, 5, 7, 9),
                      c("hello", "darkness", "my", "old", "friend"))
example

column_1 = c(1, 3, 5, 7, 9)
column2  = c("hello", "darkness", "my", "old", "friend")
example <- data.frame(column_1, 
           overridden_name = column2)
example

is(example)

nrow(example)

ncol(example)

list_example <- list("hello", 1:5, 6:10, list(c(33, 66, 99)), head(mtcars))
head(list_example)

matrix(1:50, nrow = 5, ncol = 5)

matrix(c("1", 2:50), nrow = 5, ncol = 5)
