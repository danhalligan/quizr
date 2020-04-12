parse_spec <- function(file) {
  structure(
    yaml.load_file(file),
    class = "quiz"
  )
}

answer_box <- function(x, i) {
  if (!is.null(x$options)) {
    selectInput(glue("a", i), label =  glue("Answer ", i), choices = x$options)
  } else {
    textInput(glue("a", i), label =  glue("Answer ", i), value = "")
  }
}


question <- function(x, i) {
  renderText(x$questions[[i]]$text)
}

is_correct <- function(question, answer) {
  answer %in% question$acceptable
}

mark <- function(input) {
  
}
  
send <- function(input) {
  
}


npbuttons <- function(id, label = "npbuttons") {
  ns <- NS(id)
  tagList(
    actionButton(ns("prevq"), "Prev"),
    actionButton(ns("nextq"), "Next")
  )
}

counter <- function(input, output, session) {
  count <- reactiveValues(val = 1)
  observeEvent(input$nextq, {count$val <- count$val + 1})
  observeEvent(input$prevq, {count$val <- count$val - 1})
  observe({
    toggleState("nextq", count$val < length(spec$questions))
    toggleState("prevq", count$val > 1)
  })
  count
}
