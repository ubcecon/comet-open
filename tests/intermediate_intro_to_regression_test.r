library(dplyr)
library(evaluate)
library(haven)
library(parsermd)
library(tidyverse)

## Setup

qmd_path <- "../comet-quarto/docs/Intermediate/intermediate_intro_to_regression/intermediate_intro_to_regression.qmd"
answer_nodes <- parse_rmd(qmd_path)

source("../comet-quarto/docs/Intermediate/intermediate_intro_to_regression/intermediate_intro_to_regression_tests.r")

SFS_data <- read_dta("../comet-quarto/docs/Intermediate/datasets_intermediate/SFS_2019_Eng.dta")  #this code is discussed in module 1

SFS_data <- filter(SFS_data, !is.na(SFS_data$pefmtinc))
SFS_data <- rename(SFS_data, income_before_tax = pefmtinc)
SFS_data <- rename(SFS_data, income_after_tax = pefatinc)
SFS_data <- rename(SFS_data, wealth = pwnetwpg)
SFS_data <- rename(SFS_data, gender = pgdrmie)
SFS_data <- rename(SFS_data, education = peducmie)

SFS_data <- SFS_data[!(SFS_data$education=="9"),]
SFS_data$education <- as.numeric(SFS_data$education)
SFS_data <- SFS_data[order(SFS_data$education),]
SFS_data$education <- as.character(SFS_data$education)
SFS_data$education[SFS_data$education == "1"] <- "Less than high school"
SFS_data$education[SFS_data$education == "2"] <- "High school"
SFS_data$education[SFS_data$education == "3"] <- "Non-university post-secondary"
SFS_data$education[SFS_data$education == "4"] <- "University"

SFS_data$gender <- as_factor(SFS_data$gender)
SFS_data$education <- as_factor(SFS_data$education)

SFS_data <- SFS_data %>%
  mutate(lnincome = log(SFS_data$income_before_tax)) %>% # what goes here?
  mutate(lnwealth = log(SFS_data$wealth)) # what goes here?

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
