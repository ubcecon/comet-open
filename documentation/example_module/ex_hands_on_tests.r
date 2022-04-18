library(testthat)
library(digest)

test_1 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer1), "be07d96682ac055deedd3faddf6cf1f0")
  })
  print("Success!")
}

test_2 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(abs(answer2)), "f3481c09ab4181d4cd15f79869589215")
  })
  print("Success!")
}

test_2.5 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(answer2.5), "3a5505c06543876fe45598b5e5e5195d")
  })
  print("Success!")
}

test_3 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(round(regm$coefficients,2)), "39ed4f5524c9502fe419c723bae8e028")
  })
  print("Success!")
}

test_4 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(round(regf$coefficients,2)), "75de71587b69493dbccb55da24780133")
  })
  print("Success!")
}

test_5 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(round(lnreg$coefficients,2)), "0d6321ce24f7863ac3aacff0855b328f")
  })
  print("Success!")
}

test_6 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(lnregf), "aa8ca5ff5de0776fb598f5945315ed51")
  })
  print("Success!")
}

test_7 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(round(reg2A$coefficients,2)), "e2c2f7f8174ef76ed82c27f77636b62e")
  })
  print("Success!")
}

test_8 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(round(reg2B$coefficients[1],2)), "dc866355624fa98af7f3af50cec3c7ff")
  })
  print("Success!")
}


test_10 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(round(reg_race$coefficients,2)), "e4c85e58f1688fc79bc7f0f8e329318f")
  })
  print("Success!")
}

test_11 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(reg4), "b725a136eb98459cf499ef0e3f245c3c")
  })
  print("Success!")
}

test_12 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(round(reg5_20$coefficients,2)), "e5dbfaaca5da98db52ab38de583975af")
  })
  print("Success!")
}


test_16 <- function() {
  test_that("Solution is incorrect", {
    expect_equal(digest(round(reg5_50$coefficients,2)), "eca7a47a1caf78bd2fc48dd00168330c")
  })
  print("Success!")
}
