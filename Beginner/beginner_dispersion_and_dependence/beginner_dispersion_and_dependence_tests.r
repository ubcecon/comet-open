library(testthat)
library(digest)
library(tidyverse)

test_1 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_1), "b4f5e8891b19a71cd98e3e688e75ea02")
  })
  print("Success!")
}
digest(0.0015)

test_2 <- function() {
  ans <- digest(answer_2)
  case_when(
    ans == "70b2bf5c874b6f236d6b393ba9fe82d3" ~
    "Almost there! Remember that only students on the right tail of the distribution scored more than me.",
    ans == "513d699d10a735af8dd1fb947f409f06" ~
    "Success!",
    ans == "261abe241cbe07f423dba931c46e9879" ~
    "No! We're trying to calculate the percentage of students who scored higher than me.",
    TRUE ~ "Solution is incorrect")
}

test_3 <- function() {
  ans <- digest(answer_3)
  case_when(
    ans == "96c24a598c808db5ff9c1aa505c6aa15" ~
    "Incorrect, the covariance also measures linear relationships. The correlation coefficient adjusts the covariance so that the measure is interpretable.",
    ans == "81949aed6f8e18b150efa97ff46a6fc3" ~
    "Success!",
    TRUE ~ "Solution is incorrect")
}

test_4 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_4), "5f27e1ddc5abf47b89ca737ec8ca002c")
  })
  print("Success!")
}

test_5 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_5), "d055f4e0f0ce06123d0210bced79d88a")
  })
  print("Success!")
}

test_6 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_6), "a8509fa7ee5b900a9958cf0927e4b2e0")
  })
  print("Success!")
}

test_7 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_7), "3a5505c06543876fe45598b5e5e5195d")
  })
  print("Success!")
}