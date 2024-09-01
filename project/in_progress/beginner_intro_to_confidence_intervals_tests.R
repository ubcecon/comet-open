library(testthat)
library(digest)

test_1 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_1), "3a5505c06543876fe45598b5e5e5195d")
  })
  print("Success!")
}

test_2 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_2), "941ce65c7d60753f1d8b410bb759d710")
  })
  print("Success!")
}

test_3 <- function(){
  ans <- digest(answer_3)
  case_when(
    ans == '75f1160e72554f4270c809f041c7a776' ~ 
    "Incorrect, the country average of 16 is below the confidence interval for the test scores of the teacher's students.",
    ans == '3a5505c06543876fe45598b5e5e5195d' ~
    "Success! Although we cannot know for sure, we are 95% confident that the teacher's students scored on average between 17.3 and 18.7. ",
    ans == '475bf9280aab63a82af60791302736f6' ~
    "Incorrect. Although we cannot know for sure what the mean is, our confidence interval provides a good estimate of how the students fared.",
    TRUE ~ "Review formatting"
  )
}

test_4 <- function(){
  ans <- digest(answer_4)
  case_when(
    ans == '75f1160e72554f4270c809f041c7a776' ~ 
    "Incorrect, this is the bootstrapping distribution. I encourage you to review the content on this notebook.",
    ans == '3a5505c06543876fe45598b5e5e5195d' ~
    "Success!",
    ans == '475bf9280aab63a82af60791302736f6' ~
    "Incorrect. I encourage you to review the content on this notebook.",
    TRUE ~ "Review formatting"
  )
}

test_5 <- function(){
  ans <- digest(answer_5)
  case_when(
    ans == '75f1160e72554f4270c809f041c7a776' ~ 
    "Success!",
    ans == '3a5505c06543876fe45598b5e5e5195d' ~
    "Incorrect, this is not an advantage.",
    ans == '475bf9280aab63a82af60791302736f6' ~
    "Incorrect. I encourage you to review the content on this notebook.",
    TRUE ~ "Review formatting"
  )
}

test_6 <- function(){
  ans <- digest(answer_5)
  case_when(
    ans == '75f1160e72554f4270c809f041c7a776' ~ 
    "Success!",
    ans == '3a5505c06543876fe45598b5e5e5195d' ~
    "Incorrect, we only have one sample of the population.",
    TRUE ~ "Review formatting"
  )
}

test_7 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(round(answer_7,2)), "6ea813eb6bb804c94ea2d022ae9e6480")
  })
  print("Success!")
}

test_8 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_8), "db2c596053ac6bd24fd78c591c7e8f1e")
  })
  print("Success!")
}

test_9 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_9), "c0b379538a7122554fb3bce6a039e8b0")
  })
  print("Success!")
}
