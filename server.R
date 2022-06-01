library(shiny)
library("eurostat")
library("rvest")
library("knitr")
library ("tidyverse")
library(dplyr)


#First dataset: obtained from Eurostat, population data on all EU countries
toc <- get_eurostat_toc() 
kable(head(toc))
kable(head(search_eurostat("Government revenue, expenditure and main aggregates")))
data <- get_eurostat("demo_pjan", time_format = "date") #the data we want. 
data
countries=c("BE","BG","CZ","DK","DE","EE","IE","EL","ES","FR","HR","IT","CY","LV","LT","LU","HU","MT","NL","AT","PL","PT","RO","SI","SK","FI","SE") 
eu=c()
#Filter by year and countries
datt = filter(data,geo %in% countries & time == "2020-01-01")


#Second dataset: a downloaded csv with US population info
states <- read.csv("uszips.csv")


# Define server logic required to plot our two visualisations and display both datasets

shinyServer(function(input, output, session) {
    
    #1. Plotting population data in european countries using plotly
    output$plot<-renderPlotly({
        plot_ly(data=datt,x =~geo,y=~values,color=~geo,type="bar")
        
    })
    
    #2. Inserting the european data in a table in order to display it later 
    output$table1<-DT::renderDataTable({
            datt
    })
    #3. Inserting the us data in a table in order to display it later
    output$table2<-DT::renderDataTable({
        states
    })
    #4. Plotting an interactive scatterplot with ggplot
    
    #plotting the scatter plot
    output$graph <- renderPlot({
        ggplot(data = states, aes(x = population, y = density, color = state_id)) +
        geom_point()
        })
    #making it interactive: the brushed data points will appear in a table below the plot, with the info on all variables
    output$data_brush <-  renderTable({
    n = nrow(brushedPoints(states, brush = input$plot_brush)) # row count will be 0 if no selection is made 
    if(n==0)  
    return()
    else
        brushedPoints(states, brush = input$plot_brush)
    
}) 
})
       
       