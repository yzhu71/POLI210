HW_B3
================
Yuhang Zhu
2023-10-13

## Chapter 1 problems (1.9 exercises)

### Problem 22

#### Solution

$$
\frac{3! \times 3!}{6!} = \frac{1}{20}  \ or \  0.05
$$

#### Simulation

``` r
sims <- 100000

sex <- c("boy", "boy", "boy", "girl", "girl", "girl")

count <- 0

for(i in 1:sims) {
  ## random order
  order <- sample(sex)
  ## from 1st to 3rd are girls
  if(order[1] == "girl" & order[2] == "girl" & order[3] == "girl") {
    count <- count + 1}
}

prob <- count / sims

print(round(prob, 2))
```

    ## [1] 0.05

### Problem 34

#### Solution

$$ 
\frac{C(30, 5) \times C(25, 5) \times C(20, 5) \times C(15, 5) \times C(10, 5) \times C(5, 5)}{6^{30}} \approx 0.0004
$$

#### Simulation

``` r
sims <- 1000000

count <- 0

for(i in 1:sims) {
  outcome <- sample(1:6, 30, replace = T)
  if(sum(outcome == 1) == 5 & 
     sum(outcome == 2) == 5 & 
     sum(outcome == 3) == 5 & 
     sum(outcome == 4) == 5 & 
     sum(outcome == 5) == 5 & 
     sum(outcome == 6) == 5) {
    count <- count + 1
  }
}

prob <- count / sims

prob
```

    ## [1] 0.000413

## Chapter 2 problems (2.11 exercises)

### Problem 2

#### Solution

$$
P(identical | boys) = 
  \frac{P(identical \cap boys)}{P(boys)} = 
  \frac{P(boys | identical)P(identical)}{P(boys | identical)P(identical) + P(boys | fraternal)P(fraternal)} =
  \frac{1}{2}
$$

#### Simulation

``` r
sims <- 100000

says_boys <- says_identical_boys <- rep(NA, sims)

for(i in 1:sims) {
   is_identical <- sample(c("identical", "fraternal"), size = 1, prob = c(1/3, 2/3))
   
   if(is_identical == "identical") {
     says <- sample(c("boys", "not_boys"), size = 1, prob = c(1/2, 1/2))
   }
   else{
     says <- sample(c("boys", "not_boys"), size = 1, prob = c(1/4, 3/4))
   }
   
   ifelse(says == "boys", says_boys[i] <- 1, says_boys[i] <- 0)
   ifelse(says == "boys" && is_identical == "identical", says_identical_boys[i] <- 1, says_identical_boys[i] <- 0)
}

invisible(mean(says_boys))
invisible(mean(says_identical_boys))

print(round(mean(says_identical_boys) / mean(says_boys), 2))
```

    ## [1] 0.5

### Problem 32

#### (a)

##### Solution

$P(A > B)$ = $\frac{4}{6}$ = $\frac{2}{3}$

$P(B > C)$ = $\frac{4}{6}$ = $\frac{2}{3}$

$P(C > D)$ = $P(C = 6) + P(C=2 \cap D=1)$ = $\frac{2}{3}$ = 0.67

$P(D > A)$ = $P(D = 5) + P(D=1 \cap A=0)$ = $\frac{2}{3}$ = 0.67

##### Simulation

``` r
sims <- 100000

dice_a <- c(4, 4, 4, 4, 0, 0)
dice_b <- c(3, 3, 3, 3, 3, 3)
dice_c <- c(6, 6, 2, 2, 2, 2)
dice_d <- c(5, 5, 5, 1, 1, 1)

count_ab <- 0
count_bc <- 0
count_cd <- 0
count_da <- 0

for (i in 1:sims) {
  outcome_a <- sample(dice_a, size = 1, replace = T)
  outcome_b <- sample(dice_b, size = 1, replace = T)
  outcome_c <- sample(dice_c, size = 1, replace = T)
  outcome_d <- sample(dice_d, size = 1, replace = T)
  
  if(outcome_a > outcome_b) {
    count_ab <- count_ab + 1
  }
  
  if(outcome_b > outcome_c) {
    count_bc <- count_bc + 1
  }
  
  if(outcome_c > outcome_d) {
    count_cd <- count_cd + 1
  }
  
  if(outcome_d > outcome_a) {
    count_da <- count_da + 1
  }
}

prbs_ab <- count_ab / sims
print(round(prbs_ab, 2))
```

    ## [1] 0.67

``` r
prbs_bc <- count_bc / sims
print(round(prbs_bc, 2))
```

    ## [1] 0.66

``` r
prbs_cd <- count_cd / sims
print(round(prbs_cd, 2))
```

    ## [1] 0.67

``` r
prbs_da <- count_da / sims
print(round(prbs_da, 2))
```

    ## [1] 0.67

#### (b)

##### Solution

$\because P(A>B>C) = \frac{4}{6} \times \frac{4}{6} = P(A > B) \times P(B > C) = \frac{4}{6} \times \frac{4}{6}$

$\therefore A > B \text{ is independent of the event } B > C$

$\because P(B>C>D) = \frac{4}{6} \times \frac{3}{6} \ne P(B > C) \times P(C > D) = \frac{4}{6} \times \frac{4}{6}$

$\therefore B > C \text{ is not independent of the event } C > D$

##### Simulation

### Problem 38 part (a)

#### Solution

#### Simulation
