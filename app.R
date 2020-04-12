library(shiny)
library(yaml)
library(glue)
library(shinyjs)
library(slackr)
library(shinythemes)
library(magrittr)
library(purrr)

source("functions.R")

ui <- shinyUI(fluidPage(
  theme = shinytheme("darkly"),
  useShinyjs(),
  uiOutput("title"),

  sidebarLayout(
    do.call(sidebarPanel, list(
      textInput("name", label = "Name", value = ""),
      uiOutput("inputs"),
      actionButton("submit", "Submit", class = "btn-primary")
    )),
    mainPanel(
      uiOutput("question"),
      npbuttons("counter1")
    )
  )
))

server <- shinyServer(function(input, output, session) {
  spec <- parse_spec("questions.yaml")

  output$title <- renderUI(titlePanel(spec$title))
  output$inputs <- renderUI(imap(spec$questions, answer_box))

  # Question counter
  counter <- callModule(counter, "counter1")

  # Update buttons and current question
  observe({
    output$question <- renderUI(div(
      class = "jumbotron",
      h4(glue("Question ", counter$val, ":")),
      h2(question(spec, counter$val))
    ))
  })

  # Submit action
  observeEvent(input$submit, {
    disable("submit")
    saveRDS(input, "input.RDS")
    # input %>%
    #   mark() %>%
    #   send()
  })
})

shinyApp(ui = ui, server = server)
