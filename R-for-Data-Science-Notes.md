R for Data Science Notes
================
Yuhang Zhu
2023-08-28

## 4 Workflow: basics

``` r
seq(1, 10)
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
x <- "hello, world"

y <- seq(1, 10, length.out = 5)
y
```

    ## [1]  1.00  3.25  5.50  7.75 10.00

``` r
(y <- seq(1, 10, length.out = 5))
```

    ## [1]  1.00  3.25  5.50  7.75 10.00

## 27 R Markdown

### 27.3 Text formatting with Markdown

## Text formatting

*italic* or *italic* **bold** **bold** `code` superscript<sup>2</sup>
and subscript<sub>2</sub>

## Headings

# 1st Level Header

## 2nd Level Header

### 3rd Level Header

## Lists

- Bulleted list item 1

- Item 2

  - Item 2a

  - Item 2b

1.  Numbered list item 1

2.  Item 2. The numbers are incremented automatically in the output.

## Links and images

<http://example.com>

[linked phrase](http://example.com)

<figure>
<img src="path/to/img.png" alt="optional caption text" />
<figcaption aria-hidden="true">optional caption text</figcaption>
</figure>

## Tables

| First Header | Second Header |
|--------------|---------------|
| Content Cell | Content Cell  |
| Content Cell | Content Cell  |

### 27.4 Code chunks

#### 27.4.1 Chunk name

``` r
number <- c(1, 3, 5, 6,87)
```

There is one chunk name that imbues special behavior: setup. When you’re
in a notebook mode, the chunk named setup will be run automatically
once, before any other code is run.

#### 27.4.2 Chunk options

- The most important set of options controls if your code block is
  executed and what results are inserted in the finished report:
- `eval = FALSE` prevents code from being evaluated. (And obviously if
  the code is not run, no results will be generated). This is useful for
  displaying example code, or for disabling a large block of code
  without commenting each line.
- `include = FALSE` runs the code, but doesn’t show the code or results
  in the final document. Use this for setup code that you don’t want
  cluttering your report.
- `echo = FALSE` prevents code, but not the results from appearing in
  the finished file. Use this when writing reports aimed at people who
  don’t want to see the underlying R code.
- `message = FALSE` or `warning = FALSE` prevents messages or warnings
  from appearing in the finished file.
- `results = 'hide'` hides printed output; `fig.show = 'hide'` hides
  plots.
- `error = TRUE` causes the render to continue even if code returns an
  error. This is rarely something you’ll want to include in the final
  version of your report, but can be very useful if you need to debug
  exactly what is going on inside your .Rmd. It’s also useful if you’re
  teaching R and want to deliberately include an error. The default,
  `error = FALSE` causes knitting to fail if there is a single error in
  the document.

#### 27.4.3 Table

``` r
knitr::kable(
  mtcars[1:5, ], 
  caption = "A knitr kable")
```

|                   |  mpg | cyl | disp |  hp | drat |    wt |  qsec |  vs |  am | gear | carb |
|:------------------|-----:|----:|-----:|----:|-----:|------:|------:|----:|----:|-----:|-----:|
| Mazda RX4         | 21.0 |   6 |  160 | 110 | 3.90 | 2.620 | 16.46 |   0 |   1 |    4 |    4 |
| Mazda RX4 Wag     | 21.0 |   6 |  160 | 110 | 3.90 | 2.875 | 17.02 |   0 |   1 |    4 |    4 |
| Datsun 710        | 22.8 |   4 |  108 |  93 | 3.85 | 2.320 | 18.61 |   1 |   1 |    4 |    1 |
| Hornet 4 Drive    | 21.4 |   6 |  258 | 110 | 3.08 | 3.215 | 19.44 |   1 |   0 |    3 |    1 |
| Hornet Sportabout | 18.7 |   8 |  360 | 175 | 3.15 | 3.440 | 17.02 |   0 |   0 |    3 |    2 |

A knitr kable

27.4.7 Exercises
