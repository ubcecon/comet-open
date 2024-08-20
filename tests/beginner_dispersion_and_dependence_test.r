library(dplyr)
library(evaluate)
library(haven)
library(parsermd)
library(tidyverse)

## Setup

qmd_path <- "../comet-quarto/docs/Beginner/beginner_dispersion_and_dependence/beginner_dispersion_and_dependence.qmd"
qmd <- parse_rmd(qmd_path)

census_data <- read_dta("../comet-quarto/docs/Beginner/datasets_beginner/01_census2016.dta")
package_data <- c(95, 130, 148, 183, 100, 98, 137, 110, 188, 166)

source("../comet-quarto/docs/Beginner/beginner_dispersion_and_dependence/beginner_dispersion_and_dependence_tests.r")

# Extract answer chunks from QMD file

answer_nodes <- rmd_select(qmd, by_section(c("Test your knowledge")))

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
