DSS
================
Yuhang Zhu
2023-09-06

# 1. Introduction

# 2.Estimating Casual Effects with Randomized Experiments

## 2.1 Project Start

## 2.2 Treatment and Outcome Variables

*X* -\> *Y*

### 2.2.1 Treatment Variables

X<sub>i</sub> = 1 (treatment) or = 0 (control)

### 2.2.2 Outcome Varibales

reading, math, and graduated

## 2.3 Individual Causal Effects

causal effect of *X* on *Y*

a change in the outcome as $\Delta$*Y*

*Y*<sub>i</sub>(*X*<sub>i</sub>=1) -\> potential outcome under the
treatment condition for individual *i*

*Y*<sub>i</sub>(*X*<sub>i</sub>=0) -\> potential outcome under the
control condition for individual *i*

*individual_effects*<sub>i</sub> = $\Delta$*Y*<sub>i</sub> =
*Y*<sub>i</sub>(*X*<sub>i</sub>=1) - *Y*<sub>i</sub>(*X*<sub>i</sub>=0)

We can never observe the **counter-factual outcome**, which is the
potential outcome that would have occurred under whichever condition was
not received in reality.

**The fundamental problem we face when inferring causal effects is that
we never observe the same individual both receiving the treatment and
not receiving the treatment at the same time.**

## 2.4 Average Causal Effects

**Average causal effect** of the treatment *X* on the outcome *Y*, also
known as the **average treatment effect**, is the average of all the
individual causal effects ox *X* on *Y* within a group.

$\overline{\mathit{individual\_effects}}$ =
$\frac{\sum_{i = 1}^{n} \mathit{individual\_effects}}{\ n}$

We must find or create a situation in which the treated observations and
the untreated observations are similar with respect to all the variables
that might affect the outcome other than the treatment variable itself.
The best way to accomplish this is by conducting a randomized
experiment.

### 2.4.1 Randomized Experiments and the Difference-in-means Estimator

**Randomized experiment** / **randomized controlled trial (RCT)** to
make two groups are comparable to each other, *on average*, in all
respects other than whether or not they received the treatment.

**Pre-treatment characteristics** are the characteristics of the
individuals in a study before the treatment is administered.

average_effect = ${\overline{Y(X=1) - Y(=0)}}$ = ${\overline{Y(X=1)}}$ -
${\overline{Y(X=0)}}$

If the treatment and control groups were comparable before the treatment
was administered, we can estimate the average causal effect of treatment
X on outcome Y with formula as following, which is known as the
difference-in-means estimator:

$\hat{\mathit{individual\_effects}}$ =
${\overline{Y}}$<sub>treatment group</sub> -
${\overline{Y}}$<sub>control group</sub>

experimental data and observational data

## 2.5 Do Small Classes Improve Student Performance?

``` r
star <- read.csv("DSS/STAR.csv")
```

``` r
head(star)
```

    ##   classtype reading math graduated
    ## 1     small     578  610         1
    ## 2   regular     612  612         1
    ## 3   regular     583  606         1
    ## 4     small     661  648         1
    ## 5     small     614  636         1
    ## 6   regular     610  603         0

### 2.5.1 Relational Operators in R

``` r
star$classtype == "small"
```

### 2.5.3 Creating New Variables

``` r
star$small <- ifelse(star$classtype=="small", 1, 0)

head(star)
```

    ##   classtype reading math graduated small
    ## 1     small     578  610         1     1
    ## 2   regular     612  612         1     0
    ## 3   regular     583  606         1     0
    ## 4     small     661  648         1     1
    ## 5     small     614  636         1     1
    ## 6   regular     610  603         0     0

### 2.5.3 Subsetting Vriables

``` r
mean(star$reading)
```

    ## [1] 628.803

``` r
mean(star$reading[star$small==1])
```

    ## [1] 632.7026

``` r
mean(star$reading[star$small==0])
```

    ## [1] 625.492

``` r
mean(star$reading[star$small==1]) - mean(star$reading[star$small==0])
```

    ## [1] 7.210547

``` r
mean(star$math[star$small==1]) - mean(star$math[star$small==0])
```

    ## [1] 5.989905

``` r
mean(star$graduated[star$small==1]) - mean(star$graduated[star$small==0])
```

    ## [1] 0.007031124

# 3. Inferring Population Characteristics via Survey Research

``` r
bes <- read.csv("DSS/BES.csv")
```

``` r
head(bes)
```

    ##         vote leave education age
    ## 1      leave     1         3  60
    ## 2      leave     1        NA  56
    ## 3       stay     0         5  73
    ## 4      leave     1         4  64
    ## 5 don't know    NA         2  68
    ## 6       stay     0         4  85

``` r
dim(bes)
```

    ## [1] 30895     4

``` r
bes_test <- bes %>% 
  mutate(leave_test = ifelse(vote=="leave", 1,
                             ifelse(vote=="stay", 0, NA)))
head(bes_test)
```

    ##         vote leave education age leave_test
    ## 1      leave     1         3  60          1
    ## 2      leave     1        NA  56          1
    ## 3       stay     0         5  73          0
    ## 4      leave     1         4  64          1
    ## 5 don't know    NA         2  68         NA
    ## 6       stay     0         4  85          0

``` r
table(bes$vote)
```

    ## 
    ## don't know      leave       stay won't vote 
    ##       2314      13692      14352        537

``` r
freq_table <- table(bes$vote)
prop.table(freq_table)
```

    ## 
    ## don't know      leave       stay won't vote 
    ## 0.07489885 0.44317851 0.46454119 0.01738145

``` r
# or

prop.table(table(bes$vote))
```

    ## 
    ## don't know      leave       stay won't vote 
    ## 0.07489885 0.44317851 0.46454119 0.01738145

``` r
table(bes$education, exclude = NULL)
```

    ## 
    ##     1     2     3     4     5  <NA> 
    ##  2045  5781  6272 10676  2696  3425

``` r
mean(bes$leave)
```

    ## [1] NA

``` r
mean(bes$leave, na.rm=T)
```

    ## [1] 0.4882328

``` r
bes1 <- na.omit(bes)
```

``` r
reduced_data <- original_data[c("var1", "var2")]
```
