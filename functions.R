parse_spec <- function(file) {
  structure(
    yaml.load_file(file),
    class = "quiz"
  )
}

answer_box <- function(i) {
  textInput(glue("a", i), label =  glue("Answer ", i), value = "")
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

