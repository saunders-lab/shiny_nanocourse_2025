#----------------- Install packages---------------------------#
#install.packages("reactable")
#install.packages("shinyFeedback")
#install.packages("reactlog")
#install.packages("shinythemes")


library(shinyFeedback)
library(reactlog)
library(shiny)
library(bslib)
library(readr)




setwd(dir = "C:......") # Change it to the path of your Shiny app directory
getwd()
list.files(getwd())



   
#runApp("shiny_app", display.mode = "showcase")


# options(shiny.autoreload=TRUE)
# reactlog_enable()


shiny::runApp("L3_Exercise")



