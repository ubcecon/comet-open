library(dplyr)
library(evaluate)
library(haven)
library(parsermd)
library(tidyverse)

## Setup

qmd_path <- "../comet-quarto/docs/Beginner/beginner_intro_to_statistical_concepts/beginner_intro_to_statistical_concepts.qmd"
answer_nodes <- parse_rmd(qmd_path)

source("../comet-quarto/docs/Beginner/beginner_intro_to_statistical_concepts/beginner_intro_to_statistical_concepts_tests.r")
source("../comet-quarto/docs/Beginner/beginner_intro_to_statistical_concepts/beginner_intro_to_statistical_concepts_functions.r")

# Extract answer chunks from QMD file

answer_codes <- c()
i <- 1
while (i <= length(answer_nodes)) {
  if ("code" %in% names(answer_nodes[[i]])) {
    answer_codes[[i]] <- answer_nodes[[i]][["code"]]
  }
  i <- i+1
}

answer_codes <- Filter(Negate(is.null), answer_codes)
answer_codes <- answer_codes[grepl('answer', answer_codes) & !grepl('question', answer_codes)]

## Run self-tests extracted froma answer chunks, hopefully no errors

message(paste("Testing notebook", gsub("^.*/", "", qmd_path)))

i <- 1
while (i <= length(answer_codes)) {
  extracted_answer_cell <- paste(unlist(answer_codes[[i]]), collapse="\n")
  capture.output(eval(parse(text=extracted_answer_cell)))
  message(paste("Tests for answer cell", i, "out of", length(answer_codes), "passed"))
  i <- i+1
}

message("All tests passed!")
