library(testthat)
library(digest)

test_0 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer0), "03e6f9fdf05162a425d39f81512124a2")
  })
  print("Success!")
}

test_1 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer1), "70ee60bb4371259196e9c61e3851aac3")
  })
  print("Success!")
}

test_2 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer2), "3116178fb6596b74db2d96267b5e7bb3")
  })
  print("Success!")
}

test_3 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer3), "eb123648c8976514d74104f67d1200dc")
  })
  print("Success!")
}

test_4 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer4), "53ccbf0bbf5fc8810c3131aa9c68fc30")
  })
  print("Success!")
}
