library(formatR)
knitr::opts_chunk$set(
  comment = "#>",
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

options(readr.show_col_types = FALSE) 

# To silence coordinate system message
cf <- ggplot2::coord_fixed()
cf$default <- TRUE
