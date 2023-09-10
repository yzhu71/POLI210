R语言中的filter函数
================
Yuhang Zhu
2023-09-10

# R Symbols, Operators, and Functions

## Working Directory

`getwd()`查看当前工作目录

`setwd("your/directory/path")`改变当前工作目录

## Define Function

myfunction为函数名称，function(参数，参数), {函数语句}。

``` r
myfunction <- function(arg1, arg2, ...) {
  statements
  return(object)
}
```

## Pipes

管道操作符 `%>%`
是R语言中用于简化数据处理和转换代码的一个非常有用的工具。这个操作符来自于
`magrittr` 包，并且在 `tidyverse` 生态系统中被广泛使用。

### Exercise 1

你的任务是：  
筛选出数学成绩大于80的学生。  
计算这些学生的英语成绩的平均分。  
将结果存储在一个变量中。

请使用%\>%管道操作符完成这个任务。

### Exercise 2

你的任务是：

筛选出订单金额大于50的订单。  
对这些订单按customer_id进行分组。  
计算每个客户的平均订单金额。  
筛选出平均订单金额大于100的客户。  
将结果存储在一个变量中。

## Mutate

`mutate()` 是R语言中 `dplyr`
包提供的一个非常有用的函数，用于在数据框（data
frame）中添加新的列或修改现有的列。

### Exercise 1

你的任务是：
添加一个新列average，该列是每个学生数学和英语成绩的平均分。  
添加一个新列status，如果average大于或等于60，则status为”Pass”，否则为”Fail”。  
将结果存储在一个新的数据框中。

## Summarise

### `summarize()` 函数的介绍

`summarize()` 是R语言中 `dplyr`
包提供的一个非常有用的函数，用于对数据框（data frame）进行汇总或聚合。

### 基本用法

`summarize()` 函数的基本用法是对一个数据框的列进行汇总或聚合操作。

``` r
library(dplyr)

# 创建一个数据框
df <- data.frame(
  x = c(1, 2, 3, 4),
  y = c(4, 3, 2, 1)
)

# 使用 summarize 计算 x 和 y 的平均值
result <- df %>%
  summarize(
    mean_x = mean(x),
    mean_y = mean(y)
  )

result
```

    ##   mean_x mean_y
    ## 1    2.5    2.5

### 在管道中使用

`summarize()` 函数通常与管道操作符 `%>%`
一起使用，以便进行更复杂的数据处理。

``` r
# 使用管道和 summarize
result <- df %>%
  filter(x > 2) %>%
  summarize(mean_y = mean(y))

result
```

    ##   mean_y
    ## 1    1.5

### 注意事项

- `summarize()` 会返回一个新的数据框，该数据框包含汇总或聚合的结果。
- 在使用 `group_by()` 后，`summarize()` 可以对每个组进行汇总。

``` r
# 分组后使用 summarize
grouped_result <- df %>%
  group_by(x > 2) %>%
  summarize(mean_y = mean(y))

grouped_result
```

    ## # A tibble: 2 × 2
    ##   `x > 2` mean_y
    ##   <lgl>    <dbl>
    ## 1 FALSE      3.5
    ## 2 TRUE       1.5

## Filter

## `filter()` 函数的介绍

`filter()` 是R语言中 `dplyr`
包提供的一个非常有用的函数，用于对数据框（data frame）进行筛选或过滤。

### 基本用法

`filter()` 函数的基本用法是根据一定的条件来筛选数据框的行。

``` r
library(dplyr)

# 创建一个数据框
df <- data.frame(
  x = c(1, 2, 3, 4),
  y = c(4, 3, 2, 1)
)

# 使用 filter 筛选 x 大于 2 的行
result <- df %>%
  filter(x > 2)

result
```

    ##   x y
    ## 1 3 2
    ## 2 4 1

### 在管道中使用

`filter()` 函数通常与管道操作符 `%>%`
一起使用，以便进行更复杂的数据处理。

``` r
# 使用管道和 filter
result <- df %>%
  filter(x > 2) %>%
  select(y)

result
```

    ##   y
    ## 1 2
    ## 2 1

### 注意事项

- `filter()` 会返回一个新的数据框，该数据框仅包含满足条件的行。
- 你可以使用逻辑操作符（如 `&` 和 `|`）来组合多个条件。

``` r
# 使用多个条件进行筛选
result <- df %>%
  filter(x > 2 & y < 4)

result
```

    ##   x y
    ## 1 3 2
    ## 2 4 1

# RMarkdown

## eval

`eval=FALSE` 的功能是不执行代码块中的代码。

``` r
print("这段代码不会被执行")
```

## echo

`echo=FALSE` 的功能是不显示代码块中的代码，但会执行并显示结果。

    ## [1] "这段代码会被执行，但不会显示在输出文档中"

## include

`include=FALSE` 的功能是既不执行代码也不显示代码。

## warning

`warning=FALSE` 的功能是不显示代码块中产生的警告。

``` r
# 这会产生一个警告
log(-1)
```

    ## [1] NaN

## message

`message=FALSE` 的功能是不显示代码块中产生的消息。

``` r
# 这会产生一个消息
message("这是一个消息")
```

## results

`results='hide'` 的功能是执行代码但不显示结果。

``` r
print("这段代码会被执行，但结果不会显示在输出文档中")
```

## fig.cap

`fig.cap="这是一个图的标题"` 的功能是为图形添加标题。

``` r
plot(cars)
```

<figure>
<img src="R-Notebook_files/figure-gfm/unnamed-chunk-21-1.png"
alt="这是一个图的标题" />
<figcaption aria-hidden="true">这是一个图的标题</figcaption>
</figure>
