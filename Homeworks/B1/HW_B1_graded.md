HW_B1
================
Yuhang Zhu
2023-09-17

# Indiscriminate Violence and Insurgency

## Question 1

According to the variable `fire`, there are 159 villages were attacked
by Russians and 159 were not attacked.

``` r
table(jcr$fire)
```

    ## 
    ##   0   1 
    ## 159 159

***Comment Q1: Incorrect because each row isn’t a unique village. It’s
an event where the Russian’s fired, and the `fire` variable indicates
whether the village actually got hit by fire. The homework did not
explain this well however. So, I did not take off points.***

## Question 2

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

***Comment: Good***

## Question 3

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

***Comment: Good. Different from the answer key, but still valid as an
answer***

## Question 4

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

***Comment: Good!***

## Question 5

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

***Comment: Good. Different from answer key but still valid***

## Question 6

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
did <-  (mean(jcr$postattack[jcr$fire == 1]) - mean(jcr$preattack[jcr$fire == 1])) - 
  (mean(jcr$postattack[jcr$fire == 0]) - mean(jcr$preattack[jcr$fire == 0]))

did
```

    ## [1] -0.5157233

***Comment: Good. Nice table***

# Inequality of Success in Online Music Markets

## Question 1

In **Experiment 1**, the proportions of users assigned for the *Social
Influence* and *Independent* condition are 33% and 67%, respectively.

In **Experiment 2**, the proportions of users assigned for the *Social
Influence* and *Independent* condition are 32% and 68%, respectively.

``` r
# exp1
p_exp1 <- prop.table(table(users1$world_id))

print(round(p_exp1, 2))
```

    ## 
    ##    1    9 
    ## 0.33 0.67

``` r
# exp1
p_exp2 <- prop.table(table(users2$world_id))

print(round(p_exp2, 2))
```

    ## 
    ##    1    9 
    ## 0.32 0.68

***Comment: Good***

## Question 2

In **Experiment 1**, the average number of downloads per user in the
treatment group (*Social Influence*) is 0.16 lower than control group
(*Independent*), while the average number of listens per user is 1.8
higher. These results suggest that users under *Social influence* have a
lower average number of downloads compared to those in the *Independent*
group. Conversely, the average number of songs listened to is higher
than that for users in the *Independent* group. In **Experiment 2**, the
results remain.

``` r
table(users1$world_id)
```

    ## 
    ##    1    9 
    ##  702 1441

``` r
table(users2$world_id)
```

    ## 
    ##    1    9 
    ##  689 1446

``` r
# exp1: average number of downloads per user

m_exp1_down_soc <- sum(songs1$down_soc) / 702

print(round(m_exp1_down_soc, 2))
```

    ## [1] 0.94

``` r
m_exp1_down_indep <- sum(songs1$down_indep) / 1441

print(round(m_exp1_down_indep, 2))
```

    ## [1] 1.1

``` r
# exp2:average number of downloads per user

m_exp2_down_soc <- sum(songs1$down_soc) / 689

print(round(m_exp2_down_soc, 2))
```

    ## [1] 0.95

``` r
m_exp2_down_indep <- sum(songs2$down_indep) / 1446

print(round(m_exp2_down_indep, 2))
```

    ## [1] 1.52

``` r
# exp1: average number of listening per user

m_exp1_lis_soc <- sum(songs1$listen_soc) / 702

print(round(m_exp1_lis_soc, 2))
```

    ## [1] 3.51

``` r
m_exp1_lis_indep <- sum(songs1$listen_soc) / 1441

print(round(m_exp1_lis_indep, 2))
```

    ## [1] 1.71

``` r
# exp2: average number of listening per user

m_exp2_lis_soc <- sum(songs2$listen_soc) / 689

print(round(m_exp2_lis_soc, 2))
```

    ## [1] 3.56

``` r
m_exp2_lis_indep <- sum(songs2$listen_soc) / 1446

print(round(m_exp2_lis_indep, 2))
```

    ## [1] 1.7

***Comment: Good! Only student to get this fully correct so far***

``` r
# I am not sure which downloads, because this method cannot repeat the `listens`.

# exp1
m_exp1_down <- users1 %>% 
  group_by(world_id) %>% 
  summarise(mean_down = mean(download)) %>% 
  round(2)

m_exp1_down
```

    ## # A tibble: 2 × 2
    ##   world_id mean_down
    ##      <dbl>     <dbl>
    ## 1        1      42.2
    ## 2        9      47.2

``` r
# exp2
m_exp2_down <- users2 %>% 
  group_by(world_id) %>% 
  summarise(mean_down = mean(download)) %>% 
  round(2)

m_exp2_down
```

    ## # A tibble: 2 × 2
    ##   world_id mean_down
    ##      <dbl>     <dbl>
    ## 1        1      301.
    ## 2        9      124.

***Comment: Yes, the extra downloads variable in there is confusing. You
got it right the first time. See answer key for more details***

## Question 3

In both **Experiment 1** and **Experiment 2**, the Gini coefficient for
*Social Influence* (0.33 and 0.46, respectively) is higher than that for
*Independent* (0.24 and 0.19 respectively). This suggests that in the
treatment group, some songs are downloaded more frequently than others,
whereas downloads are more evenly distributed among songs in the control
group. Thus, the hypothesis that social influence increases the
inequality of success in the music market is supported. The same
conclusion holds when analyzing the number of times each song was
listened to.

``` r
# exp1 download
ineq_exp1_soc_down <- Gini(songs1$down_soc)

print(round(ineq_exp1_soc_down, 2))
```

    ## [1] 0.33

``` r
ineq_exp1_indep_down <- Gini(songs1$down_indep)

print(round(ineq_exp1_indep_down, 2))
```

    ## [1] 0.24

``` r
# exp2 download
ineq_exp2_soc_down <- Gini(songs2$down_soc)

print(round(ineq_exp2_soc_down, 2))
```

    ## [1] 0.46

``` r
ineq_exp2_indep_down <- Gini(songs2$down_indep)

print(round(ineq_exp2_indep_down, 2))
```

    ## [1] 0.19

``` r
# exp1 listen
ineq_exp1_soc_lis <- Gini(songs1$listen_soc)

print(round(ineq_exp1_soc_lis, 2))
```

    ## [1] 0.17

``` r
ineq_exp1_indep_lis <- Gini(songs1$listen_indep)

print(round(ineq_exp1_indep_lis, 2))
```

    ## [1] 0.12

``` r
# exp2 listen
ineq_exp2_soc_lis <- Gini(songs2$listen_soc)

print(round(ineq_exp2_soc_lis, 2))
```

    ## [1] 0.42

``` r
ineq_exp2_indep_lis <- Gini(songs2$listen_indep)

print(round(ineq_exp2_indep_lis, 2))
```

    ## [1] 0.09

***Comment: Good***

## Question 4

According to the table, the pre-treatment characteristics are balanced
between treatment group and control group, validating the randomized
**Experiment 1** and **Experiment 2**. Based on the randomized
experiments, the conclusions draw from the previous question are
credible.

``` r
# exp1
user1_charct <- users1 %>% 
  group_by(world_id) %>% 
  summarise(mean_web = mean(web, na.rm = TRUE),
            mean_visit = mean(visit, na.rm = TRUE),
            mean_purchase = mean(web, na.rm = TRUE),) %>% 
  round(2)

user1_charct
```

    ## # A tibble: 2 × 4
    ##   world_id mean_web mean_visit mean_purchase
    ##      <dbl>    <dbl>      <dbl>         <dbl>
    ## 1        1     4.5        1.87          4.5 
    ## 2        9     4.51       1.9           4.51

``` r
# exp2
user2_charct <- users2 %>% 
  group_by(world_id) %>% 
  summarise(mean_web = mean(web, na.rm = TRUE),
            mean_visit = mean(visit, na.rm = TRUE),
            mean_purchase = mean(web, na.rm = TRUE),) %>% 
  round(2)

user2_charct
```

    ## # A tibble: 2 × 4
    ##   world_id mean_web mean_visit mean_purchase
    ##      <dbl>    <dbl>      <dbl>         <dbl>
    ## 1        1     4.51       1.96          4.51
    ## 2        9     4.47       1.91          4.47

***Comment: Good!***

## Question 5

The difference implies that if the songs were ordered according to the
number of downloads, the inequality of success will expand. However, due
to the experimental design, this between-study comparison doesn’t have
as much internal validity as the within-study comparison. The two
experiments were conducted sequentially, meaning that no randomization
was employed in assigning users to either of the two experiments.
Lacking of the randomization, users in the *Experiment 1* and in the \*
Experiment 2\* could be systematically different, thereby reducing the
internal validity when comparing the estimated average effect between
them. For example, the average number of `visit` among users in the
treatment group is higher in *Experiment 2* (1.96) than in *Experiment
1* (1.87). Thus, `visit` is a potential confounder.

``` r
# downloads
diff_exp_down <- (ineq_exp1_soc_down - ineq_exp1_indep_down) - (ineq_exp2_soc_down - ineq_exp2_indep_down)

diff_exp_down
```

    ## [1] -0.1790704

``` r
# listens
diff_exp_lis <- (ineq_exp1_soc_lis - ineq_exp1_indep_lis) - (ineq_exp2_soc_lis - ineq_exp2_indep_lis)

diff_exp_lis
```

    ## [1] -0.2826119

***Comment:Good!***
