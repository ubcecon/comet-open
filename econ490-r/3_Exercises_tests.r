library(testthat)
library(digest)

test_1 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_1), "48c265e4d3c821bd60faf71f7c2cd201")
  })
  print("Success!")
}

test_2 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_2), "d02e5f211f5e19b5c73114a9185a645d")
  })
  print("Success!")
}

test_3 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_3), "c196a096e5733795b11f6ecbaeaa4828")
  })
  print("Success!")
}

test_4 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_4), "a69bc5e1f19ba909c48b471bc5c4bb61")
  })
  print("Success!")
}
