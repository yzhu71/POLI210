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













