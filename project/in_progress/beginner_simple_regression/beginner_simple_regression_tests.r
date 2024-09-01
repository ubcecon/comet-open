library(testthat)
library(digest)


test_1 <- function() {
  ans <- digest(round(answer_1,3))
  case_when(
    ans == "56ff40ad0efef40ff463372322ead69c" ~
    "Success!",
    TRUE ~ "Incorrect, review your answer")
}

test_2 <- function() {
  ans <- digest(answer_2)
  case_when(
    ans == "f3481c09ab4181d4cd15f79869589215" ~
    "Success!",
    ans == "4a2a6f0787c1f8efb37a6041b28f6857" ~
    "Incorrect, this is the intercept",
    TRUE ~ "Incorrect, review your answer")
}

test_3 <- function() {
  ans <- digest((answer_3$coefficients["(Intercept)"]))
  case_when(
    ans == "d04e501feee380e7aa9c8a313849e111" ~
    "Success!",
    TRUE ~ "Incorrect, review your answer")
}

test_4 <- function() {
  ans <- digest(answer_4$coefficients["(Intercept)"])
  case_when(
    ans == "1cfd101c88f9989027d558d343ad6a8a" ~
    "Success!",
    TRUE ~ "Incorrect, review your answer")
}

test_5 <- function() {
  ans <- digest(answer_5)
  case_when(
    ans == "75f1160e72554f4270c809f041c7a776" ~
    "Congratulations! This is the correct answer!",
    ans == "3a5505c06543876fe45598b5e5e5195d" ~
    "Close, try again!",
    ans == "475bf9280aab63a82af60791302736f6" ~
    "No, that's the value of the immstatimmigrants (beta_1)",
    ans == "c1f86f7430df7ddb256980ea6a3b57a4" ~
    "You should definitely worry about this!",
    TRUE ~ "That is an invalid input. Recheck the formatting")
}

test_6 <- function() {
  ans <- digest(answer_6)
  case_when(
    ans == "75f1160e72554f4270c809f041c7a776" ~
    "Incorrect",
    ans == "3a5505c06543876fe45598b5e5e5195d" ~
    "Correct!",
    ans == "475bf9280aab63a82af60791302736f6" ~
    "Incorrect",
    TRUE ~ "That is an invalid input. Recheck the formatting")
}

test_7 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(reg5_20$coefficients["(Intercept)"]), "f10153215a5910d043fb8ef0228cb12b")
  })
  print("Success!")
}

test_8 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(reg5_50$coefficients["(Intercept)"]), "e362866a0c9c9b4071157a818f6a204d")
  })
  print("Success!")
}

test_9 <- function() {
  ans <- digest(answer_9)
  case_when(
    ans == "75f1160e72554f4270c809f041c7a776" ~
    "Incorrect",
    ans == "3a5505c06543876fe45598b5e5e5195d" ~
    "Incorrect",
    ans == "475bf9280aab63a82af60791302736f6" ~
    "Success!",
    TRUE ~ "That is an invalid input. Recheck the formatting")
}


test_10 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_10$coefficients["(Intercept)"]), "99d40d5e6978824972f67271c7dc6277")
  })
  print("Success!")
}

test_11 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_11$coefficients["(Intercept)"]), "448082c864610ce442656d60b99c390c")
  })
  print("Success!")
}

test_12 <- function() {
  ans <- digest(answer_12)
  case_when(
    ans == "75f1160e72554f4270c809f041c7a776" ~
    "Success!",
    ans == "3a5505c06543876fe45598b5e5e5195d" ~
    "Incorrect",
    ans == "475bf9280aab63a82af60791302736f6" ~
    "Incorrect",
    TRUE ~ "That is an invalid input. Recheck the formatting")
}

test_13 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer_13$coefficients["(Intercept)"]), "26b0bb7b159e579fa2413eaacbfa6027")
  })
  print("Success!")
}

test_14 <- function() {
  ans <- digest(answer_14)
  case_when(
    ans == "75f1160e72554f4270c809f041c7a776" ~
    "Success!",
    ans == "3a5505c06543876fe45598b5e5e5195d" ~
    "No, this result is for the entire population and not just the immigrant wage gap!",
    ans == "475bf9280aab63a82af60791302736f6" ~
    "We haven't added controls to this regression model",
    TRUE ~ "That is an invalid input. Recheck the formatting")
}

test_15 <- function() {
  ans <- digest(answer_15)
  case_when(
    ans == "75f1160e72554f4270c809f041c7a776" ~
    "We should add controls!",
    ans == "3a5505c06543876fe45598b5e5e5195d" ~
    "Correct! We should experiment with other controls because other factors could help explain this wage gap",
    ans == "475bf9280aab63a82af60791302736f6" ~
    "We shouldn't say that education is the only missing control. Other factors could also be a contributing factor",
    ans == "c1f86f7430df7ddb256980ea6a3b57a4" ~
    "We shouldn't say that immigrant status is the only missing control. Other factors could also be a contributing factor",
    TRUE ~ "That is an invalid input. Recheck the formatting")
}
