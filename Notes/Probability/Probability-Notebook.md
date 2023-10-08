---
title: "Probability Notebook"
author: "Yuhang Zhu"
date: "2023-10-08"
output: 
  html_document: 
    keep_md: yes
---

### Chapter 1 Probability and Counting

1. De Morgan's laws:
* $(A \cup B)^c = A^c \cap B^c$
* $(A \cap B)^c = A^c \cup B^c$

2. Multiplication rule: $a*b$
* With replacement: $n^k$
* Without replacement: $n(n - 1)...(n-k+1)$
* A set with n elements has $2^n$ subsets, including the empty set; and the set itself.

3. Adjusting for overcounting
* Combination (Binomial coefficient): For any nonnegative integers *k* and *n*, the *binomial coefficient* ${n \choose k}$, is the number of subsets of size *k* for a set of size *n*.
$$ C^{n}_{k} = {n \choose k} = \frac{n(n - 1) \ldots (n-k+1)}{k!} = \frac{n!}{(n - k)!k!} $$
* Binomial theorem: 
$$ (x + y)^n = \sum_{k=0}^{n}{n \choose k}x^ky^{n-k} $$

4. Equations
* choosing the complement
$$ {n \choose k} = {n \choose n-k} $$

* team captain
$$ n{n-1 \choose k-1} = k{n \choose k} $$

* Vandermonde's identity
$$ {m+n \choose k} = \sum_{j=0}^{k}{m \choose j}{n \choose k-j} $$

* partnerships
$$ \frac{(2n)!}{2^n \cdot n!} = (2n-1)(2n-3) \ldots 3 \cdot 1 $$

5. Properties of probability
* $P(A^c) = 1 - P(A)$
* if $A \subseteq B$, then $P(A) \leq P(B)$
* $P(A \cup B) = P(A) + P(B) - P(A \cap B)$

6. de Montmort's matching problem


```r
set.seed(123)  # 设置随机数生成种子以获得可重复的结果
sims <- 100000  # 设置模拟次数
num_cards <- 52  # 设置牌的数量

# 初始化一个变量来存储每次模拟的结果
matches <- numeric(sims)

# 进行模拟
for (i in 1:sims) {
  original_order <- 1:num_cards  # 创建一个表示原始顺序的向量
  shuffled_order <- sample(original_order)  # 随机洗牌
  # 检查是否有任何一张牌在其原始位置上，并存储结果
  matches[i] <- any(original_order == shuffled_order)
}

# 计算至少有一张牌在其原始位置上的概率
mean(matches)
```

```
## [1] 0.63436
```

### Chapter 2 Conditional Probability

1. Definition of Conditional probability  
If A and B are events with P(B) > 0, then the conditional probability of A given B, denoted by P(A|B), is deﬁned as:
$$ P(A|B) = \frac{P(A \cap B)}{P(B)} $$

2. For any events A and B with positive probabilities,
$$ P(A \cap B) = P(B)P(A|B) = P(A)P(B|A) $$

3. Bayes’ rule
$$ P(A|B) = \frac{P(B|A)P(A)}{P(B)} $$
$$ P(A|B) = \frac{P(B|A)P(A)}{P(B|A)P(A) + P(B|\bar{A})P(\bar{A})} $$

$$ P(A|B, E) = \frac{P(B|A, E)P(A|E)}{P(B|E)} $$

4. Odds form of Beyes' rule (likelihood ratio)
$$ \frac{P(A|B)}{P(A^c|B)} = \frac{P(B|A)}{P(B|A^c)}\frac{P(A)}{P(A^c)} $$

5. Law of total probability (LOTP)
$$ P(B) = \sum_{i=1}^{n}P(B|A_i)P(A_i) $$

$$ P(B|E) = \sum_{i=1}^{n}P(B|A_i, E)P(A_i|E) $$

6. Independence of two events
Events A and B are independent if
$$ P(A \cap B) = P(A)P(B) $$
If P(A) > 0 and P(B) > 0, then this is equivalent to
$$ P(A|B) = P(A) $$

7. Independence of many events)
* For $n$ events $A_1, A_2, \dots, A_n$ to be *independent*, we require any pair to satisfy $P(A_i \cap A_j) = P(A_i)P(A_j)$ (for $i \neq j$), any triplet to satisfy $P(A_i \cap A_j \cap A_k) = P(A_i)P(A_j)P(A_k)$ (for $i, j, k$ distinct), and similarly for all quadruplets, quintuplets, and so on.

8. Conditional independence
* Events *A* and *B* are said to be conditionally independent given *E* if $P(A \cap B|E) = P(A|E)P(B|E)$.


```r
# Simulating the Monty Hall Problem in R

# Define the number of simulations
sims <- 100000

# Initialize a vector to store results
win_without_switch <- numeric(sims)
win_with_switch <- numeric(sims)

# Simulate the Monty Hall problem
for (i in 1:sims) {
  # Step 1: Contestant chooses a door
  contestant_choice <- sample(1:3, 1)
  
  # Step 2: Monty chooses a door
  # Monty knows where the car is and always chooses a goat
  # If contestant's initial choice has a car, Monty chooses from the remaining two doors randomly
  # If contestant's initial choice has a goat, Monty chooses the other goat
  car_location <- sample(1:3, 1)
  if (contestant_choice == car_location) {
    monty_choice <- sample(setdiff(1:3, contestant_choice), 1)
  } else {
    monty_choice <- setdiff(1:3, c(contestant_choice, car_location))
  }
  
  # Step 3: Contestant switches door
  # If the contestant switches, they change to the remaining door that Monty didn't open
  final_choice_switch <- setdiff(1:3, c(contestant_choice, monty_choice))
  
  # Step 4: Determine if the contestant wins
  # Without switching
  win_without_switch[i] <- contestant_choice == car_location
  
  # With switching
  win_with_switch[i] <- final_choice_switch == car_location
}

# Calculate win rates
win_rate_no_switch <- mean(win_without_switch)
win_rate_switch <- mean(win_with_switch)

win_rate_no_switch
```

```
## [1] 0.33209
```

```r
win_rate_switch
```

```
## [1] 0.66791
```



