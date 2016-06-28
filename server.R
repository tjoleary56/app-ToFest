

library(shiny)
library(xlsx)
library(ggplot2)


shinyServer(function(input, output, session) {
  dsnames <- c()
   
  rawData <- reactive({
    filet <- input$file1
    if(is.null(filet)) return()
    rawData <- read.xlsx2(filet$datapath, sheetIndex = 1)
  })
  
  output$contents <- renderTable({
    rawData()
  })
  
  observe({
    dsnames <- names(rawData())
    cb_options <- list()
    cb_options[ dsnames] <- dsnames
    updateSelectInput(session, "select1",
                             label = "Select x-axis",
                             choices = cb_options,
                             selected = "")
    updateSelectInput(session, "select2",
                      label = "Select y-axis",
                      choices = cb_options,
                      selected = "")
  })
  
  output$choose_dataset <- renderUI({
    selectInput("dataset", "Data set", as.list(dsnames))
  })
  
  output$choose_columns <- renderUI({

    if(is.null(input$dataset))
      return()
    
    colnames <- names(contents)

    selectInput("columns", "Choose columns", 
                       choices  = colnames,
                       selected = NULL)
  })
  
  x <- reactive({
    df <- rawData()
    xval <- df[,input$select1]
    xval
  })
  
  y <- reactive({
    df <- rawData()
    yval <- df[,input$select2]
    yval
  })
  
 output$plot1 <- renderPlot({
    qplot(x(),y(), xlab="X Variable", ylab="Y Variable")
 })
  
})
