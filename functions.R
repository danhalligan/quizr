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
  x$questions[[i]]$text
}

is_correct <- function(question, answer) {
  answer %in% question$acceptable
}

mark <- function(input) {
  
}
  
send <- function(input) {
  
}

