library(dplyr)
library(evaluate)
library(haven)
library(parsermd)
library(tidyverse)

## Setup

qmd_path <- "../comet-quarto/docs/Beginner/beginner_central_tendency/beginner_central_tendency.qmd"
qmd <- parse_rmd(qmd_path)

source("../comet-quarto/docs/Beginner/beginner_central_tendency/beginner_central_tendency_tests.r")

census_data <- read_dta("../comet-quarto/docs/Beginner/datasets_beginner/01_census2016.dta")

# Extract answer chunks from QMD file

answer_nodes <- rmd_select(qmd, by_section(c("Exercise *")))

answer_codes <- c()
i <- 1
while (i <= length(answer_nodes)) {
  if ("code" %in% names(answer_nodes[[i]])) {
    answer_codes[[i]] <- answer_nodes[[i]][["code"]]
  }
  i <- i+1
}
answer_codes <- answer_codes[which(sapply(answer_codes, `[[`, 2) == "#| classes: \"answer\"")]

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
