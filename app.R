# import libraries

library(shiny)
library(yaml)
library(glue)
library(shinyjs)
source("functions.R")

ui <- shinyUI(fluidPage(
    shinyjs::useShinyjs(),
    titlePanel(spec$title),

    sidebarLayout(
      do.call(sidebarPanel, list(
        textInput("name", label = "Name", value = ""),
        inputs,
        actionButton("submit", "Submit", class = "btn-primary")
      )),
      mainPanel(
        uiOutput("question"),
        actionButton("prevq", "Prev", disable = TRUE),
        actionButton("nextq", "Next"),
      )
    )
))


server <- shinyServer(function(input, output, session) {
  spec <- parse_spec("questions.yaml")
  
  inputs <- lapply(seq_along(spec$questions), answer_box)
  
  # Question counter
  counter <- reactiveValues(val = 1)
  observeEvent(input$nextq, {counter$val <- counter$val + 1})
  observeEvent(input$prevq, {counter$val <- counter$val - 1})
  
  # Update buttons and current question
  observe({
    toggleState("nextq", counter$val < length(spec$questions))
    toggleState("prevq", counter$val > 1)
    output$question <- question(spec, counter$val)
  })

  # Submit action
  observeEvent(input$submit, {
    disable("submit")
    input %>% 
      mark() %>%
      send()
  })
})

shinyApp(ui = ui, server = server)
