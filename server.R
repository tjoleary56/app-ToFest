


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
    updateSelectInput(session, "selectX",
                             label = "Select x-axis",
                             choices = cb_options,
                             selected = "")
    updateSelectInput(session, "selectY",
                      label = "Select y-axis",
                      choices = cb_options,
                      selected = "")
  })
  
  #output$choose_dataset <- renderUI({
  #  selectInput("dataset", "Data set", as.list(dsnames))
  #})
  
  #output$choose_columns <- renderUI({

  #  if(is.null(input$dataset))
  #    return()
    
  #  colnames <- names(contents)

  #  selectInput("columns", "Choose columns", 
  #                     choices  = colnames,
  #                     selected = NULL)
  #})
  
  x <- reactive({
    df <- rawData()
   #xval <- df[,input$selectX]
    xval <- as.numeric(as.character(df[,input$selectX]))
    xval
  })
  
  y <- reactive({
    df <- rawData()
    #yval <- df[,input$selectY]
    yval <- as.numeric(as.character(df[,input$selectY]))
    yval
  })
  
 output$plot1 <- renderPlot({
   if(input$selectPlot == "Points"){
     plot(x(), y(), col = input$selectColor, main = input$selectTitle, xlab = input$selectX, ylab = input$selectY,
          las=1)
    #qplot(x(),y(), xlab="X Variable", ylab="Y Variable") +
    #   ggtitle(input$selectPlot) +
    #   xlab(input$selectX) +
    #   ylab(input$selectY) 
   }else
   if(input$selectPlot == "Line"){
     #plot(x(),y(),type="l")
     ggplot(data = rawData(), aes(x = x(), y = y(), group = 1)) +
        geom_line() +
       ggtitle(input$selectPlot) +
       xlab(input$selectX) +
       ylab(input$selectY)
   }else
     if(input$selectPlot == "Bar"){
       barplot(x(), xlab = input$selectX, ylab = "Quantity", col = input$selectColor, main = input$selectTitle,
               las=1)
       #ggplot(data=rawData(), aes(x=x(), y=y())) +
       # geom_bar(stat="identity") + 
       # ggtitle(input$selectPlot) +
       #   xlab(input$selectX) +
       #   ylab(input$selectY)
     }else
       if(input$selectPlot == "Histogram"){
         hist(x(), col = input$selectColor, xlab = input$selectX, main = input$selectTitle,
              las=1)
       }else
       if(input$selectPlot == "Boxplot"){
         boxplot(x(), col = input$selectColor, xlab = input$selectX, ylab = "Quantity", main = input$selectTitle,
                 las=1)
       }
     
 })
  
})
