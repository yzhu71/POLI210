HW_B4
================
Yuhang Zhu
2023-11-03

1.  Below is code for simulating a coin flip. Try to understand what it
    does by running it, and then running the command `coin_flip()` in
    the console 10 times.

``` r
set.seed(36850) # set random seed so that you get the same output everytime even though it's "random"

sample_space_coin <- c("H", "T")
event_probs_coin <- c(0.5, 0.5)

coin_flip <- function(){
  sample(
    size = 1,
    x = sample_space_coin,
    prob = event_probs_coin,
    replace = TRUE
  )
}

# running `coin_flip()` 10 times
coin_flip_10 <- replicate(10, coin_flip())
coin_flip_10
```

    ##  [1] "H" "T" "T" "H" "T" "H" "T" "T" "T" "T"

Copy and past the output from running `coin_flip()` 10 times in the
console here:

“H” “T” “T” “H” “T” “H” “T” “T” “T” “T”

2.  Write a function `X_coin()` that takes the result of `coin_flip()`
    as an argument (a string, “H” or “T”), and returns it into a 1 for
    “H” and 0 for “T”. I’ve already started the code for you.

``` r
set.seed(36850)
flip1 <- coin_flip()
flip2 <- coin_flip()
flip3 <- coin_flip()
flip4 <- coin_flip()

# Example flips, they will always be the same because I set a random seed.
flip1 # H
```

    ## [1] "H"

``` r
flip2 # T
```

    ## [1] "T"

``` r
flip3 # T
```

    ## [1] "T"

``` r
flip4 # H
```

    ## [1] "H"

``` r
# Function that acts like a random variable.
# returns 1 if flip == "H" and 0 otherwise.
X_coin <- function(flip){
  # fill in the code here
  # ifelse() is probably helpful
}

# The code below should return a 1 for flip1 and flip4 and 0 for flip2 and flip3
X_coin(flip1)
```

    ## NULL

``` r
X_coin(flip2)
```

    ## NULL

``` r
X_coin(flip3)
```

    ## NULL

``` r
X_coin(flip4)
```

    ## NULL

Treating `X_coin()` like a random variable describe it: a. What is the
probability of 1? b. What is the probability of 0? c. What is the
expectation of `X_coin()`? d. What is the variance of `X_coin()`?
