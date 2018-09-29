#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(brainR)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Interactive Brain Map"),
    h4("Documentation: This an interactive Brain Map, thus it allows the user to
       change the orientation as well as the transparency(slider) and color 
        drop down menu) of the brain.
       Please note, that this app is just an exampler for the later use to display
       differences between brain activity patterns using fMRI data."),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            
            sliderInput("alpha",
                        "Adjust the transparency of the brain:",
                        min = 1,
                        max = 100,
                        value = 50),
            selectInput("color", "Change the color of the brain:",
                        choices = list("red", "blue", "yellow", "white"),
                        selected = "white")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            rglwidgetOutput("brain", width = "500px", height = "500px")
        )
    )
)
)