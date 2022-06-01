#importamos librerías
library(shiny)
library(shiny)
library(ggplot2)
library(clipr)
#install.packages("DT")
#install.packages("plotly")
library(plotly)
library(DT)




# Define UI for application that draws an interactive scatterplot
shinyUI(fluidPage(
    titlePanel(div(column(width=5,h2('Population Analysis')),)), #title
    mainPanel(
        tabsetPanel(type ="tabs", #creating the tabs
                    tabPanel("Plot EU Population by Country",plotlyOutput("plot")), #tab to plot EU population plot
                    tabPanel("Plot US Population vs Density by State",plotOutput(outputId = "graph", brush = "plot_brush",height="300px"),#tab to plot the interactive scatter plot
                             fluidRow(column(width=12,height="100px", tags$b(tags$i("Select data points to display their info")),tableOutput("data_brush"), offset = 2))),#formatting and displaying the brushed data points
                    tabPanel("EU Data", DT::dataTableOutput("table1")), #tab to show EU data table
                    tabPanel("US Data", DT::dataTableOutput("table2")) #tab to show US data table
                    ) 
                
    )
))
     
    