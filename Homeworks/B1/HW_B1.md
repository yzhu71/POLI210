HW_B1
================
Yuhang Zhu
2023-09-17

# Indiscriminate Violence and Insurgency

## Question 1: How many villages were and were not attacked by Russians? Give the overall breakdown.

According to the variable `fire`, there are 159 villages were attacked
by Russians and 159 were not attacked.

``` r
table(jcr$fire)
```

    ## 
    ##   0   1 
    ## 159 159

## Question 2: Did Russian artillery result in a greater number of deaths in Groznyy compared to the villages outside of Groznyy? Conduct the comparison in terms of the mean and median.

Yes.

The estimated number of individuals killed during Russian artillery fire
in Groznyy villages is on average 2.14 more than in villages outside
Groznyy.

According to the median, the number in Grozny villages is 3 higher than
in villages outside Grozny.

``` r
deaths_groznyy <- jcr %>%
  group_by(groznyy) %>%
  summarise(mean_deaths = mean(deaths, na.rm = TRUE),
            median_deaths = median(deaths, na.rm = TRUE)) %>% 
  round(2)

deaths_groznyy
```

    ## # A tibble: 2 × 3
    ##   groznyy mean_deaths median_deaths
    ##     <dbl>       <dbl>         <dbl>
    ## 1       0        1.57             0
    ## 2       1        3.71             3

## Question 3: Compare the average number of insurgent attacks after Russian fire for villages hit by artillery fire and those that were not hit. Also, compare the quartiles. Would you conclude that indiscriminate violence reduces insurgent attacks? Why or why not?

For villages hit by artillery fire, the average number of insurgent
attacks was fewer than for those not hit. The difference is -0.55.
However, the `postattack` distributions for villages that were hit and
those that were not are similar.

We cannot definitively conclude that indiscriminate violence reduces
insurgent attacks, as the Russians may not attack villages randomly.
According to evidence from **Question 2**, villages in Groznyy are more
susceptible to attacks. If the dataset doesn’t come from a randomized
experiment, the treatment (`fire == 1`) and control (`fire == 0`) groups
may not be comparable based on their pre-treatment characteristics.

``` r
sum_postattack <- jcr %>%
  group_by(fire) %>%
  summarise(m_postattack = mean(postattack, na.rm = TRUE),
            qtl_0_postattack = quantile(postattack, probs = 0, na.rm = T),
            qtl_25_postattack = quantile(postattack, probs = 0.25, na.rm = T),
            qtl_50_postattack = quantile(postattack, probs = 0.5, na.rm = T),
            qtl_75_postattack = quantile(postattack, probs = 0.75, na.rm = T),
            qtl_100_postattack = quantile(postattack, probs = 1, na.rm = T))

sum_postattack
```

    ## # A tibble: 2 × 7
    ##    fire m_postattack qtl_0_postattack qtl_25_postattack qtl_50_postattack
    ##   <int>        <dbl>            <dbl>             <dbl>             <dbl>
    ## 1     0         2.05                0                 0                 0
    ## 2     1         1.50                0                 0                 0
    ## # ℹ 2 more variables: qtl_75_postattack <dbl>, qtl_100_postattack <dbl>

``` r
diff_postattack <- sum_postattack$m_postattack[sum_postattack$fire == 1] - sum_postattack$m_postattack[sum_postattack$fire == 0]

diff_postattack
```

    ## [1] -0.5534591

## Question 4: What is the difference in the average number of insurgent attacks before Russian artillery fire between the villages that were hit by artillery fire and those that were not? What does this tell you about the validity of comparison behind the identification strategy used for the previous question?

The difference in the average number is -0.04, indicating that villages
had similar numbers of insurgent attacks prior to Russian artillery
fire. Given the similarity in the key variable
`the number of insurgent attacks` prior to the treatment (`fire`), the
validity of the previously used identification strategy is partially
confirmed.

``` r
diff_preattack <- mean(jcr$preattack[jcr$fire == 1]) - mean(jcr$preattack[jcr$fire == 0])

diff_preattack
```

    ## [1] -0.03773585

## Question 5: Create a new variable called diffattack by calculating the difference in the number of insurgent attacks before and after the Russian artillery fire. Among the villages shelled by Russians, did the number of insurgent attacks increase after the artillery fire? Give a substantive interpretation of the result.

The number of insurgent attacks actually decreased, rather than
increased, following the artillery fire. Among the villages shelled by
Russians, the average number of insurgent attacks decreased by -0.62
after the fire.

``` r
jcr$diffattack <- jcr$postattack - jcr$preattack

diff_attack_fire <- mean(jcr$diffattack[jcr$fire == 1])

diff_attack_fire
```

    ## [1] -0.6163522

## Question 6: Compute the mean difference in the diffattack variable between villages shelled and villages not shelled. Does this analysis support the claim that indiscriminate violence reduces insurgency attacks? Is the validity of this analysis improved over the analyses you conducted in the previous questions? Why or why not? Specifically, explain what additional factor this analysis addresses when compared to the analyses conducted in the previous questions.

This identification strategy **supports** the claim that indiscriminate
violence reduces insurgency attacks, and its validity is improved
relative to prior strategies. By using the strategy ($T_{2}$ -
$T_{1}$) - ($C_{2}$ - $C_{1}$), this paper isolates the net treatment
effect of `indiscriminate violenc` on the `number of insurgency attacks`
(-0.516). $T_{2}$ - $T_{1}$ determines the treatment effect
(`indiscriminate violenc`) on the `number of insurgency attacks`
(-0.616), whereas $C_{2}$ - $C_{1}$ represents the original trend
without treatment effect (-0.101).

| Variables   | Pre-attack             | post-attack            |                        |
|:------------|:-----------------------|:-----------------------|:-----------------------|
| `fire == 1` | $T_{1}$                | $T_{2}$                | $T_{2}$ - $T_{1}$ (Q5) |
| `fire == 0` | $C_{1}$                | $C_{2}$                | $C_{2}$ - $C_{1}$ (Q6) |
|             | $T_{1}$ - $C_{1}$ (Q4) | $T_{2}$ - $C_{2}$ (Q3) | $\beta_{DD}$ (Q6)      |

``` r
m_diffattack <- mean(jcr$diffattack[jcr$fire == 1]) - mean(jcr$diffattack[jcr$fire == 0])

m_diffattack
```

    ## [1] -0.5157233

``` r
# double check
did_ate <-  (mean(jcr$postattack[jcr$fire == 1]) - mean(jcr$preattack[jcr$fire == 1])) - 
  (mean(jcr$postattack[jcr$fire == 0]) - mean(jcr$preattack[jcr$fire == 0]))

did_ate
```

    ## [1] -0.5157233
