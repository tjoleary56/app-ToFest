

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
      selectInput("selectX", "Select X Variable", choices = c()),
      selectInput("selectY", "Select Y Variable", choices = c()),
      selectInput("selectPlot", "Select Plot Type", choices = c("Line","Points","Bar","Histogram","Boxplot")),
      selectInput("selectColor", "Select Color", choices=c("gray","white","black","blue","darkblue","skyblue","red","orange","yellow","green","purple","pink")),
      textInput("selectTitle", "Plot Title")
      #numericInput("selectLas", "Display Axes Numbers Options",value=0),
      #numericInput("selectXmin", "Select X axis Min", value = NULL),
      #numericInput("selectXmax", "Select X axis Max", value = NULL),
      #numericInput("selectYmin", "Select Y axis Min", value = NULL),
      #numericInput("selectYmax", "Select Y axis Max", value = NULL),
      #uiOutput("choose_columns")
      
    ),
    mainPanel(
      
      tabsetPanel(
        tabPanel("Data", tableOutput('contents')),
        tabPanel("Plot", plotOutput('plot1'))
        
      )
    )
  )
))
