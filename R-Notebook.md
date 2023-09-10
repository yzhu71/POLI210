Yuhang’s R Notebook
================
Yuhang Zhu
2023-09-10

# R Symbols, Operators, and Functions

## working directory

`getwd()`查看当前工作目录

`setwd("your/directory/path")`改变当前工作目录

## define function

myfunction为函数名称，function(参数，参数), {函数语句}。

``` r
myfunction <- function(arg1, arg2, ...) {
  statements
  return(object)
}
```

## pipes

管道操作符 `%>%`
是R语言中用于简化数据处理和转换代码的一个非常有用的工具。这个操作符来自于
`magrittr` 包，并且在 `tidyverse` 生态系统中被广泛使用。

## mutate

`mutate()` 是R语言中 `dplyr`
包提供的一个非常有用的函数，用于在数据框（data
frame）中添加新的列或修改现有的列。

## summarise

### 基本用法

`summarize()` 函数的基本用法是对一个数据框的列进行汇总或聚合操作。

``` r
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

## filter

### 基本用法

`filter()` 函数的基本用法是根据一定的条件来筛选数据框的行。

``` r
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

## group_by

### 基本用法

`group_by()` 函数的基本用法是根据一个或多个列的值来分组数据框。

``` r
# 创建一个数据框
df <- data.frame(
  category = c("A", "A", "B", "B"),
  value = c(10, 20, 30, 40)
)

# 使用 group_by 对 category 列进行分组
grouped_df <- df %>%
  group_by(category)

grouped_df
```

    ## # A tibble: 4 × 2
    ## # Groups:   category [2]
    ##   category value
    ##   <chr>    <dbl>
    ## 1 A           10
    ## 2 A           20
    ## 3 B           30
    ## 4 B           40

### 在管道中使用

`group_by()` 函数通常与管道操作符 `%>%`
一起使用，以便进行更复杂的数据处理。

``` r
# 使用管道和 group_by
result <- df %>%
  group_by(category) %>%
  summarize(mean_value = mean(value))

result
```

    ## # A tibble: 2 × 2
    ##   category mean_value
    ##   <chr>         <dbl>
    ## 1 A                15
    ## 2 B                35

### 注意事项

- `group_by()` 会返回一个分组的数据框，该数据框可以用于后续的
  `summarize()` 或其他 `dplyr` 函数。
- 分组后的数据框在可视化时看起来与原数据框相似，但它们在进行汇总或其他操作时的行为是不同的。

``` r
# 分组后使用 summarize
result <- df %>%
  group_by(category) %>%
  summarize(
    mean_value = mean(value),
    sum_value = sum(value)
  )

result
```

    ## # A tibble: 2 × 3
    ##   category mean_value sum_value
    ##   <chr>         <dbl>     <dbl>
    ## 1 A                15        30
    ## 2 B                35        70

## dim

在R中，dim函数用于获取或设置数据对象（如矩阵或数组）的维度，通过dim(object)可以获取维度，而通过dim(object)
\<- c(rows, columns)可以设置维度。

## table

在R中，table函数用于创建因子水平的各种组合的计数的列联表，通过table(variable1,
variable2, …)可以生成单变量或多变量的频率表。

## prop.table

在R中，prop.table函数用于计算表格中各单元格的相对频率（或比例），通过prop.table(table_object,
margin = NULL)可以针对整个表或特定边缘（行或列）计算比例。

## na.omit

na.omit:
在R中，na.omit(object)函数用于删除包含缺失值（NA）的观察行，返回一个没有缺失值的新对象。

## hist

hist: 在R中，hist(x)函数用于创建数值变量x的直方图，以可视化其分布。

## plot

plot: 在R中，plot(x,
y)函数用于绘制两个变量x和y之间的散点图或其他类型的图形。

## abline

abline: 在R中，abline(a,
b)函数用于在现有图形上添加一条斜率为b和截距为a的直线。

## median

median: 在R中，median(x)函数用于计算数值向量x的中位数。

## sd

sd: 在R中，sd(x)函数用于计算数值向量x的样本标准差。

## var

var: 在R中，var(x)函数用于计算数值向量x的样本方差。

## cor

cor: 在R中，cor(x, y)函数用于计算两个数值向量x和y之间的Pearson相关系数。

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
<img src="R-Notebook_files/figure-gfm/unnamed-chunk-18-1.png"
alt="这是一个图的标题" />
<figcaption aria-hidden="true">这是一个图的标题</figcaption>
</figure>
