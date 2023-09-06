DSS
================
Yuhang Zhu
2023-09-06

# Introduction

``` r
library(tidyverse)
library(socviz)
```

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