Data Visualization Notes
================
Yuhang Zhu
2023-8-27

## Data Visualization Notes

This is a starter RMarkdown template to accompany *Data Visualization*
(Princeton University Press, 2019). You can use it to take notes, write
your code, and produce a good-looking, reproducible document that
records the work you have done. At the very top of the file is a section
of *metadata*, or information about what the file is and what it does.
The metadata is delimited by three dashes at the start and another three
at the end. You should change the title, author, and date to the values
that suit you. Keep the `output` line as it is for now, however. Each
line in the metadata has a structure. First the *key* (“title”,
“author”, etc), then a colon, and then the *value* associated with the
key.

## This is an RMarkdown File

Markdown is a simple formatting syntax for authoring HTML, PDF, and MS
Word documents. For more details on using R Markdown see
<http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that
includes both content as well as the output of any embedded R code
chunks within the document. A *code chunk* is a specially delimited
section of the file. You can add one by moving the cursor to a blank
line choosing Code \> Insert Chunk from the RStudio menu. When you do,
an empty chunk will appear:

Code chunks are delimited by three backticks (found to the left of the 1
key on US and UK keyboards) at the start and end. The opening backticks
also have a pair of braces and the letter `r`, to indicate what language
the chunk is written in. You write your code inside the code chunks.
Write your notes and other material around them, as here.

## Before you Begin

To install the tidyverse, make sure you have an Internet connection.
Then *manually* run the code in the chunk below. If you knit the
document if will be skipped. We do this because you only need to install
these packages once, not every time you run this file. Either knit the
chunk using the little green “play” arrow to the right of the chunk
area, or copy and paste the text into the console window.

``` r
## This code will not be evaluated automatically.
## (Notice the eval = FALSE declaration in the options section of the
## code chunk)

my_packages <- c("tidyverse", "broom", "coefplot", "cowplot",
                 "gapminder", "GGally", "ggrepel", "ggridges", "gridExtra",
                 "here", "interplot", "margins", "maps", "mapproj",
                 "mapdata", "MASS", "quantreg", "rlang", "scales",
                 "survey", "srvyr", "viridis", "viridisLite", "devtools")

install.packages(my_packages, repos = "http://cran.rstudio.com")
```

## Set Up Your Project and Load Libraries

To begin we must load some libraries we will be using. If we do not load
them, R will not be able to find the functions contained in these
libraries. The tidyverse includes ggplot and other tools. We also load
the socviz and gapminder libraries.

Notice that here, the braces at the start of the code chunk have some
additional options set in them. There is the language, `r`, as before.
This is required. Then there is the word `setup`, which is a label for
your code chunk. Labels are useful to briefly say what the chunk does.
Label names must be unique (no two chunks in the same document can have
the same label) and cannot contain spaces. Then, after the comma, an
option is set: `include=FALSE`. This tells R to run this code but not to
include the output in the final document.

When you click the **Knit** button a document will be generated that
includes both content as well as the output of any embedded R code
chunks within the document. You can embed an R code chunk like this:

``` r
gapminder
```

    ## # A tibble: 1,704 × 6
    ##    country     continent  year lifeExp      pop gdpPercap
    ##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
    ##  1 Afghanistan Asia       1952    28.8  8425333      779.
    ##  2 Afghanistan Asia       1957    30.3  9240934      821.
    ##  3 Afghanistan Asia       1962    32.0 10267083      853.
    ##  4 Afghanistan Asia       1967    34.0 11537966      836.
    ##  5 Afghanistan Asia       1972    36.1 13079460      740.
    ##  6 Afghanistan Asia       1977    38.4 14880372      786.
    ##  7 Afghanistan Asia       1982    39.9 12881816      978.
    ##  8 Afghanistan Asia       1987    40.8 13867957      852.
    ##  9 Afghanistan Asia       1992    41.7 16317921      649.
    ## 10 Afghanistan Asia       1997    41.8 22227415      635.
    ## # ℹ 1,694 more rows

The remainder of this document contains the chapter headings for the
book, and an empty code chunk in each section to get you started. Try
knitting this document now by clicking the “Knit” button in the RStudio
toolbar, or choosing File \> Knit Document from the RStudio menu.

## Look at Data

## Get Started

### 2.3 Things to Know about R

#### *Everything is an object*

``` r
my_numbers <- c(1, 2, 3, 1, 3, 5, 25)
your_numbers <-  c(5, 31, 71, 1, 3, 21, 6)
my_numbers
```

    ## [1]  1  2  3  1  3  5 25

``` r
mean(x= my_numbers)
```

    ## [1] 5.714286

``` r
mean(your_numbers)
```

    ## [1] 19.71429

``` r
my_summary <- summary(my_numbers)
my_summary
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   1.000   1.500   3.000   5.714   4.000  25.000

#### *Functions come in packages*

``` r
table(my_numbers)
```

    ## my_numbers
    ##  1  2  3  5 25 
    ##  2  1  2  1  1

``` r
sd(my_numbers)
```

    ## [1] 8.616153

#### *If you’re not sure what an object is, ask for its class*

``` r
class(my_numbers)
```

    ## [1] "numeric"

``` r
class(my_summary)
```

    ## [1] "summaryDefault" "table"

``` r
class(summary)
```

    ## [1] "function"

``` r
my_new_vector <-  c(my_numbers, "Apple")
my_new_vector
```

    ## [1] "1"     "2"     "3"     "1"     "3"     "5"     "25"    "Apple"

``` r
class(my_new_vector)
```

    ## [1] "character"

``` r
titanic
```

    ##       fate    sex    n percent
    ## 1 perished   male 1364    62.0
    ## 2 perished female  126     5.7
    ## 3 survived   male  367    16.7
    ## 4 survived female  344    15.6

``` r
class(titanic)
```

    ## [1] "data.frame"

``` r
titanic$percent
```

    ## [1] 62.0  5.7 16.7 15.6

``` r
titanic_tb <-  as_tibble(titanic)
titanic_tb
```

    ## # A tibble: 4 × 4
    ##   fate     sex        n percent
    ##   <fct>    <fct>  <dbl>   <dbl>
    ## 1 perished male    1364    62  
    ## 2 perished female   126     5.7
    ## 3 survived male     367    16.7
    ## 4 survived female   344    15.6

#### *To see inside an object, ask for its structure*

``` r
str(my_numbers)
```

    ##  num [1:7] 1 2 3 1 3 5 25

``` r
str(my_summary)
```

    ##  'summaryDefault' Named num [1:6] 1 1.5 3 5.71 4 ...
    ##  - attr(*, "names")= chr [1:6] "Min." "1st Qu." "Median" "Mean" ...

### 2.4 Be Patient with R, and with Yourself

- Here are three specific things to watch out for:
  - Make sure parentheses are balanced and that every opening “(” has a
    corresponding closing “)”.  
  - Make sure you complete your expressions.
  - In ggplot specifically, as you will see, we will build up plots a
    piece at a time by adding expressions to one another. When doing
    this, make sure your + character goes at the end of the line and not
    the beginning.

``` r
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

### 2.5 Get Data into R

``` r
url  <-  "https://cdn.rawgit.com/kjhealy/viz-organdata/master/organdonation.csv" 
organs <-  read_csv(file = url)
```

    ## Rows: 238 Columns: 21
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): country, world, opt, consent.law, consent.practice, consistent, ccode
    ## dbl (14): year, donors, pop, pop.dens, gdp, gdp.lag, health, health.lag, pub...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

### 2.6 Make Your First Figure

``` r
library(gapminder)
gapminder
```

    ## # A tibble: 1,704 × 6
    ##    country     continent  year lifeExp      pop gdpPercap
    ##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
    ##  1 Afghanistan Asia       1952    28.8  8425333      779.
    ##  2 Afghanistan Asia       1957    30.3  9240934      821.
    ##  3 Afghanistan Asia       1962    32.0 10267083      853.
    ##  4 Afghanistan Asia       1967    34.0 11537966      836.
    ##  5 Afghanistan Asia       1972    36.1 13079460      740.
    ##  6 Afghanistan Asia       1977    38.4 14880372      786.
    ##  7 Afghanistan Asia       1982    39.9 12881816      978.
    ##  8 Afghanistan Asia       1987    40.8 13867957      852.
    ##  9 Afghanistan Asia       1992    41.7 16317921      649.
    ## 10 Afghanistan Asia       1997    41.8 22227415      635.
    ## # ℹ 1,694 more rows

``` r
p <- ggplot(gapminder, 
            mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_point()
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

## Make a Plot

``` r
library(gapminder)
```

``` r
gapminder
```

    ## # A tibble: 1,704 × 6
    ##    country     continent  year lifeExp      pop gdpPercap
    ##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
    ##  1 Afghanistan Asia       1952    28.8  8425333      779.
    ##  2 Afghanistan Asia       1957    30.3  9240934      821.
    ##  3 Afghanistan Asia       1962    32.0 10267083      853.
    ##  4 Afghanistan Asia       1967    34.0 11537966      836.
    ##  5 Afghanistan Asia       1972    36.1 13079460      740.
    ##  6 Afghanistan Asia       1977    38.4 14880372      786.
    ##  7 Afghanistan Asia       1982    39.9 12881816      978.
    ##  8 Afghanistan Asia       1987    40.8 13867957      852.
    ##  9 Afghanistan Asia       1992    41.7 16317921      649.
    ## 10 Afghanistan Asia       1997    41.8 22227415      635.
    ## # ℹ 1,694 more rows

``` r
p <- ggplot(gapminder, aes(gdpPercap, lifeExp))

p
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

``` r
p + geom_point()
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-12-2.png)<!-- -->

``` r
p + geom_smooth()
```

    ## `geom_smooth()` using method = 'gam' and formula = 'y ~ s(x, bs = "cs")'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

``` r
p + geom_point() + geom_smooth()
```

    ## `geom_smooth()` using method = 'gam' and formula = 'y ~ s(x, bs = "cs")'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-13-2.png)<!-- -->

``` r
p + geom_point() + geom_smooth(method = "lm")
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-13-3.png)<!-- -->

``` r
p + geom_point() + geom_smooth(method = "gam") + scale_x_log10()
```

    ## `geom_smooth()` using formula = 'y ~ s(x, bs = "cs")'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-13-4.png)<!-- -->

``` r
p + geom_point() +
  geom_smooth(method = "gam") +
  scale_x_log10(labels = scales::dollar)
```

    ## `geom_smooth()` using formula = 'y ~ s(x, bs = "cs")'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-13-5.png)<!-- -->

``` r
ggplot(gapminder, aes(gdpPercap, lifeExp, color = continent)) + 
  geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10()
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

``` r
p + 
  geom_point(color = "purple") +
  geom_smooth(method= "loess") +
  scale_x_log10()
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-14-2.png)<!-- -->

``` r
p +
  geom_point(position = "jitter", alpha = 0.3) +
  geom_smooth(color = "orange", se= F, linewidth = 2, method = "lm") +
  scale_x_log10()
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-14-3.png)<!-- -->

``` r
p + geom_point(alpha = 0.3) +
  geom_smooth(method = "gam") +
  scale_x_log10(labels = scales::dollar) +
  labs(x = "GDP Per Capita", y = "Life Expectancy in Years",
       title = "Economic Growth and Life Expectancy",
       subtitle = "Data points are country-years",
       caption = "Source: Gapminder.")
```

    ## `geom_smooth()` using formula = 'y ~ s(x, bs = "cs")'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-14-4.png)<!-- -->

``` r
ggplot(gapminder, aes(gdpPercap, lifeExp, color = continent, fill = continent)) + 
  geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10()
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-14-5.png)<!-- -->

``` r
ggplot(gapminder, aes(gdpPercap, lifeExp)) + 
  geom_point(aes(color = continent)) +
  geom_smooth(method = "loess") +
  scale_x_log10()
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

``` r
p +
  geom_point(aes(color = log(pop))) +
  scale_x_log10()
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-15-2.png)<!-- -->

``` r
knitr::opts_chunk$set(fig.width = 8, fig.highlight = 5)
```

``` r
p +
  geom_point(aes(color = log(pop))) +
  scale_x_log10()
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

``` r
# ggsave(filename = "save_example.png")

# ggsave(filename = "save_example.pdf")

p_out <- p +
  geom_point(aes(color = log(pop))) +
  scale_x_log10()

# ggsave("my_figure.pdf", plot = p_out)

ggsave(here("figure", "lifexp_vs_gdp_gradient.pdf"), plot = p_out)
```

    ## Saving 12 x 9 in image

``` r
ggplot(gapminder, aes(gdpPercap, lifeExp)) + 
  geom_smooth(method = "loess") +
  geom_point(aes(color = continent)) +
  scale_x_log10()
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

``` r
ggplot(gapminder, aes(lifeExp, pop, color = continent, fill = continent)) + 
  geom_point(alpha = 0.5) +
  geom_smooth(se=F) +
  scale_y_log10()
```

    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-17-2.png)<!-- -->

``` r
ggplot(gapminder, aes(lifeExp, pop, color = year)) + 
  geom_point(alpha = 0.5) +
  geom_smooth(se=F) +
  scale_y_log10()
```

    ## `geom_smooth()` using method = 'gam' and formula = 'y ~ s(x, bs = "cs")'

    ## Warning: The following aesthetics were dropped during statistical transformation: colour
    ## ℹ This can happen when ggplot fails to infer the correct grouping structure in
    ##   the data.
    ## ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
    ##   variable into a factor?

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-17-3.png)<!-- -->

``` r
ggplot(gapminder, aes(lifeExp, pop, color = factor(year))) + 
  geom_point(alpha = 0.5) +
  geom_smooth(se=F) +
  scale_y_log10()
```

    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-17-4.png)<!-- -->

## Show the Right Numbers

``` r
p <- ggplot(gapminder, aes(year, gdpPercap))

p + geom_line()
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

``` r
p + geom_line(aes(group = country))
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-18-2.png)<!-- -->

``` r
p + 
  geom_line(aes(group = country)) +
  facet_wrap(~ continent)
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-18-3.png)<!-- -->

``` r
p + 
  geom_line(linetype = "dashed", color = "gray75", aes(group = country)) +
  geom_smooth(color = "#8696a7",size = 1.2, method = "loess", se = F) +
  scale_y_log10(labels = scales::dollar) +
  facet_wrap(~ continent, nrow = 1) +
  labs(x = "Year",
       y = "GDP per capita",
       title = "GDP per capita on Five Continents")
```

    ## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
    ## ℹ Please use `linewidth` instead.
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
    ## generated.

    ## `geom_smooth()` using formula = 'y ~ x'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-18-4.png)<!-- -->

``` r
glimpse(gss_sm)
```

    ## Rows: 2,867
    ## Columns: 32
    ## $ year        <dbl> 2016, 2016, 2016, 2016, 2016, 2016, 2016, 2016, 2016, 2016…
    ## $ id          <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,…
    ## $ ballot      <labelled> 1, 2, 3, 1, 3, 2, 1, 3, 1, 3, 2, 1, 2, 3, 2, 3, 3, 2,…
    ## $ age         <dbl> 47, 61, 72, 43, 55, 53, 50, 23, 45, 71, 33, 86, 32, 60, 76…
    ## $ childs      <dbl> 3, 0, 2, 4, 2, 2, 2, 3, 3, 4, 5, 4, 3, 5, 7, 2, 6, 5, 0, 2…
    ## $ sibs        <labelled> 2, 3, 3, 3, 2, 2, 2, 6, 5, 1, 4, 4, 3, 6, 0, 1, 3, 8,…
    ## $ degree      <fct> Bachelor, High School, Bachelor, High School, Graduate, Ju…
    ## $ race        <fct> White, White, White, White, White, White, White, Other, Bl…
    ## $ sex         <fct> Male, Male, Male, Female, Female, Female, Male, Female, Ma…
    ## $ region      <fct> New England, New England, New England, New England, New En…
    ## $ income16    <fct> $170000 or over, $50000 to 59999, $75000 to $89999, $17000…
    ## $ relig       <fct> None, None, Catholic, Catholic, None, None, None, Catholic…
    ## $ marital     <fct> Married, Never Married, Married, Married, Married, Married…
    ## $ padeg       <fct> Graduate, Lt High School, High School, NA, Bachelor, NA, H…
    ## $ madeg       <fct> High School, High School, Lt High School, High School, Hig…
    ## $ partyid     <fct> "Independent", "Ind,near Dem", "Not Str Republican", "Not …
    ## $ polviews    <fct> Moderate, Liberal, Conservative, Moderate, Slightly Libera…
    ## $ happy       <fct> Pretty Happy, Pretty Happy, Very Happy, Pretty Happy, Very…
    ## $ partners    <fct> NA, "1 Partner", "1 Partner", NA, "1 Partner", "1 Partner"…
    ## $ grass       <fct> NA, Legal, Not Legal, NA, Legal, Legal, NA, Not Legal, NA,…
    ## $ zodiac      <fct> Aquarius, Scorpio, Pisces, Cancer, Scorpio, Scorpio, Capri…
    ## $ pres12      <labelled> 3, 1, 2, 2, 1, 1, NA, NA, NA, 2, NA, NA, 1, 1, 2, 1, …
    ## $ wtssall     <dbl> 0.9569935, 0.4784968, 0.9569935, 1.9139870, 1.4354903, 0.9…
    ## $ income_rc   <fct> Gt $170000, Gt $50000, Gt $75000, Gt $170000, Gt $170000, …
    ## $ agegrp      <fct> Age 45-55, Age 55-65, Age 65+, Age 35-45, Age 45-55, Age 4…
    ## $ ageq        <fct> Age 34-49, Age 49-62, Age 62+, Age 34-49, Age 49-62, Age 4…
    ## $ siblings    <fct> 2, 3, 3, 3, 2, 2, 2, 6+, 5, 1, 4, 4, 3, 6+, 0, 1, 3, 6+, 2…
    ## $ kids        <fct> 3, 0, 2, 4+, 2, 2, 2, 3, 3, 4+, 4+, 4+, 3, 4+, 4+, 2, 4+, …
    ## $ religion    <fct> None, None, Catholic, Catholic, None, None, None, Catholic…
    ## $ bigregion   <fct> Northeast, Northeast, Northeast, Northeast, Northeast, Nor…
    ## $ partners_rc <fct> NA, 1, 1, NA, 1, 1, NA, 1, NA, 3, 1, NA, 1, NA, 0, 1, 0, N…
    ## $ obama       <dbl> 0, 1, 0, 0, 1, 1, NA, NA, NA, 0, NA, NA, 1, 1, 0, 1, 0, 1,…

``` r
p <- ggplot(gss_sm, aes(age, childs))

p + geom_point(alpha = 0.2) +
  geom_smooth() +
  facet_grid(sex ~ race)
```

    ## `geom_smooth()` using method = 'gam' and formula = 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 18 rows containing non-finite values (`stat_smooth()`).

    ## Warning: Removed 18 rows containing missing values (`geom_point()`).

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

``` r
ggplot(gss_sm, aes(bigregion)) +
  geom_bar()
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

``` r
ggplot(gss_sm, aes(bigregion)) +
  geom_bar(aes(y = ..prop.., group = 1))
```

    ## Warning: The dot-dot notation (`..prop..`) was deprecated in ggplot2 3.4.0.
    ## ℹ Please use `after_stat(prop)` instead.
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
    ## generated.

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-20-2.png)<!-- -->

``` r
table(gss_sm$religion)
```

    ## 
    ## Protestant   Catholic     Jewish       None      Other 
    ##       1371        649         51        619        159

``` r
ggplot(gss_sm, aes(religion, color = religion)) +
  geom_bar()
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->

``` r
ggplot(gss_sm, aes(religion, fill = religion)) +
  geom_bar() +
  guides(fill = FALSE)
```

    ## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
    ## of ggplot2 3.3.4.
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
    ## generated.

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-21-2.png)<!-- -->

``` r
ggplot(gss_sm, aes(bigregion, fill = religion)) +
  geom_bar()
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-22-1.png)<!-- -->

``` r
ggplot(gss_sm, aes(bigregion, fill = religion)) +
  geom_bar(position = "fill")
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-22-2.png)<!-- -->

``` r
ggplot(gss_sm, aes(bigregion, fill = religion)) +
  geom_bar(position = "dodge", aes(y = ..prop..))
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-22-3.png)<!-- -->

``` r
ggplot(gss_sm, aes(bigregion, fill = religion)) +
  geom_bar(position = "dodge", aes(y = ..prop.., group = religion))
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-22-4.png)<!-- -->

``` r
ggplot(gss_sm, aes(religion)) +
  geom_bar(position = "dodge", aes(y = ..prop.., group = bigregion)) +
  facet_wrap(~ bigregion, ncol = 2)
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-22-5.png)<!-- -->

``` r
ggplot(midwest, aes(area)) +
  geom_histogram()
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-23-1.png)<!-- -->

``` r
ggplot(midwest, aes(area)) +
  geom_histogram(bins =10)
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-23-2.png)<!-- -->

``` r
oh_wi <- c("OH", "WI")
ggplot(subset(midwest, subset = state %in% oh_wi),
       aes(percollege, fill = state)) +
  geom_histogram(alpha = 0.4, bins = 20)
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-23-3.png)<!-- -->

``` r
ggplot(midwest, aes(area)) +
  geom_density()
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-23-4.png)<!-- -->

``` r
ggplot(midwest, aes(area, fill = state, color = state)) +
  geom_density(alpha = 0.3)
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-23-5.png)<!-- -->

``` r
ggplot(subset(midwest, subset = state %in% oh_wi),
       aes(area, fill = state, color = state)) +
  geom_density(alpha = 0.3, aes(y = ..scaled..))
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-23-6.png)<!-- -->

``` r
ggplot(titanic, aes(fate, percent, fill = sex)) +
  geom_bar(position = "dodge", stat = "identity") +
  theme(legend.position = "top")
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-24-1.png)<!-- -->

``` r
oecd_sum
```

    ## # A tibble: 57 × 5
    ## # Groups:   year [57]
    ##     year other   usa  diff hi_lo
    ##    <int> <dbl> <dbl> <dbl> <chr>
    ##  1  1960  68.6  69.9 1.30  Below
    ##  2  1961  69.2  70.4 1.20  Below
    ##  3  1962  68.9  70.2 1.30  Below
    ##  4  1963  69.1  70   0.900 Below
    ##  5  1964  69.5  70.3 0.800 Below
    ##  6  1965  69.6  70.3 0.700 Below
    ##  7  1966  69.9  70.3 0.400 Below
    ##  8  1967  70.1  70.7 0.600 Below
    ##  9  1968  70.1  70.4 0.300 Below
    ## 10  1969  70.1  70.6 0.5   Below
    ## # ℹ 47 more rows

``` r
ggplot(oecd_sum, aes(year, diff, fill = hi_lo)) +
  geom_col() +
  guides(fill = FALSE) +
  labs(x = NULL, y = "Difference in Years",
       title = "The US Life Expectancy Gap",
       subtitle = "Difference between US and OECD average life expectancies, 1960-2015",
       caption = "Data: OECD. After a chart by Christopher Ingraham, Washington Post, December 27th 2017.")
```

    ## Warning: Removed 1 rows containing missing values (`position_stack()`).

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-25-1.png)<!-- -->

``` r
ggplot(gapminder, aes(pop, gdpPercap)) +
  geom_line(color = "gray75") +
  geom_smooth(color = "#01847F", se = F) +
  scale_x_log10(labels = scales::unit_format(unit = "M", scale = 1e-6)) +
  scale_y_log10(labels = scales::unit_format(unit = "K", scale = 1e-3)) +
  facet_wrap(~ year) +
  labs(x = "Population",
       y = "GDP per Capita")
```

    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

``` r
ggsave(here("figure", "pop_gdppercap.png"), width = 12)
```

    ## Saving 12 x 6 in image
    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

``` r
ggplot(gss_sm, aes(age, childs)) +
  geom_point(alpha = 0.2) +
  geom_smooth() +
  facet_grid(sex ~ race)
```

    ## `geom_smooth()` using method = 'gam' and formula = 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 18 rows containing non-finite values (`stat_smooth()`).

    ## Warning: Removed 18 rows containing missing values (`geom_point()`).

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-26-2.png)<!-- -->

``` r
ggplot(gss_sm, aes(age, childs)) +
  geom_point(alpha = 0.2) +
  geom_smooth() +
  facet_grid(~ sex + race)
```

    ## `geom_smooth()` using method = 'gam' and formula = 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 18 rows containing non-finite values (`stat_smooth()`).
    ## Removed 18 rows containing missing values (`geom_point()`).

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-26-3.png)<!-- -->

``` r
ggplot(gss_sm, aes(age, childs)) +
  geom_point(alpha = 0.2) +
  geom_smooth() +
  facet_wrap(~ sex + race)
```

    ## `geom_smooth()` using method = 'gam' and formula = 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 18 rows containing non-finite values (`stat_smooth()`).
    ## Removed 18 rows containing missing values (`geom_point()`).

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-26-4.png)<!-- -->

``` r
ggplot(gapminder, aes(gdpPercap, lifeExp)) +
  geom_smooth(method = "gam", se =F) +
  geom_bin2d(alpha = 0.7, bins = c(100, 50)) +
  labs(title = "2D Histogram using geom_bin2d()",
       x = "GDP per Capita",
       y = "Life Expectancy")
```

    ## `geom_smooth()` using formula = 'y ~ s(x, bs = "cs")'

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-26-5.png)<!-- -->

``` r
ggplot(midwest, aes(percbelowpoverty, percollege)) +
  geom_point(aes(color = state), alpha = 0.5) +
  geom_density_2d() +
  labs(title = "Density Estimates with Points",
       x = "Percent Below Poverty Line",
       y = "Percent College Educated")
```

![](Data-Visualization-Notes_files/figure-gfm/unnamed-chunk-26-6.png)<!-- -->

## Graph Tables, Make Labels, Add Notes

## Work with Models

## Draw Maps

## Refine your Plots
