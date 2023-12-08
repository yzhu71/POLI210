Final Exam
================
Yuhang Zhu
2023-12-08

# POLI 210

## Quantitative Analysis I

## Final Examination

### Part I:

Open the R script part_one_replication_script.R. Fill in the code as
needed. The code is broken up into 7 tasks (noted in the code’s
comments). I should be able to run your R file and get the correct
answers.

Do not look up the answer by googling the paper on which this
replication file is based. I have included a copy of th e paper without
the replication file in this repo.

``` r
cq <- read.csv("/Users/zhuyuhang/Desktop/Git/POLI210/Final Exam/cq_data.csv")

head(cq)
```

    ##   X year stcd ptynow inc3    dv   dvp state south
    ## 1 1 1876  101      1    0 49.25 46.45     1     1
    ## 2 2 1878  101      1    0 69.10 49.25     1     1
    ## 3 3 1880  101      1    0 55.94 69.10     1     1
    ## 4 4 1884  101      1    0 58.08 57.40     1     1
    ## 5 5 1890  101      1    0 69.89 62.00     1     1
    ## 6 6 1894  101      1    1 76.89 63.62     1     1

``` r
dim(cq)
```

    ## [1] 17932     9

#### 1 write a function called nationalization that takes two vectors called “dv” and “dvp, and returns a single number that corresponds to the measure”nationalization” in the paper by LeVeck and Nail. Make sure to handle NA’s. You don’t have to worry about the fact that the measure is computed for a specific year, that’s handled later. You can just assume all dv and dvp observations come from one year.

``` r
nationalization <- function(dv, dvp){
  
}
```
