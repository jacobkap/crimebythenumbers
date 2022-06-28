library(formatR)
knitr::opts_chunk$set(
  comment = "#",
  collapse = TRUE,
  fig.align = 'center',
  fig.width = 9,
  fig.asp =  0.618,  
  fig.show = "hold",
  error = TRUE,
  fig.pos = "!H", 
  out.extra = "",
  tidy = "styler",
  out.width = "100%",
  out.height= "45%"
  )

options(tidygeocoder.quiet = TRUE)
options(tidygeocoder.verbose =  FALSE)
options(readr.show_col_types = FALSE) 


detachAllPackages <- function() {
  basic.packages <- c("package:stats",
                      "package:graphics",
                      "package:grDevices",
                      "package:utils",
                      "package:datasets",
                      "package:methods",
                      "package:base")
  
  package.list <- search()[ifelse(unlist(gregexpr("package:",search()))==1,TRUE,FALSE)]
  package.list <- setdiff(package.list,basic.packages)
  if (length(package.list)>0)  for (package in package.list) detach(package, character.only=TRUE)
}
