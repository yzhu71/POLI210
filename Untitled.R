# 设置随机种子
set.seed(123)

# 创建模拟数据
years <- rep(2000:2009, each = 10)
support_rates <- runif(100) # 生成100个随机支持率

# 创建数据框
mydata <- data.frame(Year = years, SupportRate = support_rates)

# 初始化数组以存储每次循环的平均标准误差
mean_ses <- numeric(100)

# 循环100次
for (i in 1:100) {
  
  
  # 对每年的数据进行抽样并计算标准误差
  ses <- sapply(split(mydata, mydata$Year), function(year_data) {
    sampled_data <- year_data[sample(1:nrow(year_data), replace = TRUE), ]
    return(sd(sampled_data$SupportRate) / sqrt(nrow(sampled_data)))
  })
  
  # 计算并存储这次循环的平均标准误差
  mean_ses[i] <- mean(ses)
}

# 计算100次循环中每年标准误差平均值的抽样平均值
final_average <- mean(mean_ses)
final_average

split(mydata, mydata$Year)