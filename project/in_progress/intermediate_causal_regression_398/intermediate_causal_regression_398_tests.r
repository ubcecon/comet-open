library(digest)
library(testthat)
library(tidyverse)


test_1 <- function(){
    test_that("Solution is incorrect", {
        expect_equal(digest(reg1$coefficients["(Intercept)"]), "405e109d8bddbdad843f5fb7916c57bb")
    })
}

test_2 <- function(){
    test_that("Solution is incorrect", {
        expect_equal(digest(round(answer_2, 2)), "23659dec803b67d1fe3f3a938a034d28")
    })
}

test_3 <- function(){
    test_that("Solution is incorrect", {
        expect_equal(digest(round(answer_3, 2)), "23659dec803b67d1fe3f3a938a034d28")
    })
}

test_5 <- function(){
    test_that("Solution is incorrect", {
        expect_equal(digest(reg2$coefficients["(Intercept)"]), "25ee026037425de500566e178d3096d9")
    })
}

test_6 <- function(){
    test_that("Solution is incorrect", {
        expect_equal(digest(round(answer_6, 2)), "86506483832148f94d53092d46ef0293")
    })
}

test_7 <- function(){
    test_that("Solution is incorrect", {
        expect_equal(digest(round(answer_7, 2)), "ed85ebe8513b2a54ac9fcbfaf7c060a7")
    })
}

test_8 <- function(){
    test_that("Solution is incorrect", {
        expect_equal(digest(round(answer_8, 2)), "e8a48456c86b65da07481970b274aeb2")
    })
}

test_10 <- function(){
    test_that("Solution is incorrect", {
        expect_equal(digest(reg3$coefficients["(Intercept)"]), "d4af4c647411bc0781811b9eb7599d74")
    })
}

test_11 <- function(){
    test_that("Solution is incorrect", {
        expect_equal(digest(round(answer_11, 2)), "aacc9e84cbbdc0522f4b645364538d09")
    })
}

test_12 <- function(){
    test_that("Solution is incorrect", {
        expect_equal(digest(round(answer_12, 2)), "88aabbb2fc0d1e7d588aba7c4d52ddb2")
    })
}