

library(shiny)
library(xlsx)

shinyUI(fluidPage(
  
  titlePanel("Dynamic Plotter"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose File', accept = ".xlsx"),
      
      #downloadButton('downloadData', 'Download'),
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      tags$hr(),
      selectInput("selectX", "Select X Variable", choices =c()),
      tags$hr(),
      selectInput("selectY", "Select Y Variable", choices =c()),
      selectInput("selectPlot", "Select Plot Type", choices = c("Bar","Line","Points","Histogram","Boxplot")),
      selectInput("selectColor", "Select Color", choices=c("gray","white","black","blue","darkblue", "skyblue", "red", "orange", "yellow", "green","purple","pink")),
      textInput("selectTitle", "Plot Title"),
      uiOutput("choose_columns")
      
    ),
    mainPanel(
      
      tabsetPanel(
        tabPanel("Data", tableOutput('contents')),
        tabPanel("Plot", plotOutput('plot1'))
        
      )
    )
  )
))
