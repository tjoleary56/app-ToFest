

library(shiny)
library(xlsx)

shinyUI(fluidPage(
  
  titlePanel("To-Fest"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose File', accept = ".xlsx"),
      
      #downloadButton('downloadData', 'Download'),
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      tags$hr(),
      selectInput("select1", "Select X Variable", choices =c()),
      tags$hr(),
      selectInput("select2", "Select Y Variable", choices =c()),
      
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
