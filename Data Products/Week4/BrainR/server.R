#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(brainR)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # load template
    template <- readNIfTI(system.file("MNI152_T1_8mm_brain.nii.gz", package="brainR")
                          , reorient= FALSE)
    dtemp <- dim(template)
    
    # downsample the image
    brain <- contour3d(template, x=1:dtemp[1], y=1:dtemp[2],
                       z=1:dtemp[3], level = 4500, alpha = 0.8, draw = FALSE)
    
    # create plot image
    output$brain <- renderRglwidget({
        open3d(useNULL = TRUE)
        drawScene.rgl(brain)
        rglwidget()
    })
    
    # alter alpha based on userinput
    output$brain <- renderRglwidget({
        brain <- contour3d(template, x=1:dtemp[1], y=1:dtemp[2],
                           z=1:dtemp[3], level = 4500, alpha = input$alpha/100,
                           draw = FALSE) 
    })
    
    # alter color based on userinput
    output$brain <- renderRglwidget({
        open3d(useNULL = TRUE)
        contour3d(template, level = c(5000),
                  alpha = input$alpha/100, add = TRUE, 
                  color = input$color)
        rglwidget()
    })
    
})
