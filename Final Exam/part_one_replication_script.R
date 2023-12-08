library(dplyr) # install this package if you don't have it yet
library(ggplot2) # install this package if you don't have it yet
library(grDevices) # install this package if you don't have it yet
library(grid)
library(tidyr) # I don't think you absolutely need this library
library(broom) # I don't think you absolutely need this library

rm(list=ls()) # removes junk from your R environment


# Read in cq_data.csv file savide it as a variable cq_data
cq_data <- read.csv("cq_data.csv")

# This is based on a paper that was published at Research and Politics.
# The point of this part of the final is to see if you can replicate a published paper
# with the skills you've learned this semester.
# Some parts of the code are done for you. Try to still see if you can figure out what they do.
# It might help to read up on the dplyr package

# The data has dv which is the Democratic party's vote share for districts i in year t
# there is also a variable called dvp, which is the Democratic party's vote share for districts i in year t-1 (the previous year)

# 1 write a function called nationalization that takes two vectors called "dv" and "dvp, and returns a single number that corresponds to the measure "nationalization" in the paper by LeVeck and Nail. Make sure to handle NA's. You don't have to worry about the fact that the measure is computed for a specific year, that's handled later. You can just assume all dv and dvp observations come from one year.
nationalization <- function(dv, dvp){
  
}

# 2
# Calculate nationalization measure by year
# requires dplyr
# This should work if you've properly programmed the functions above
swing_variance <- cq_data %>%
  filter(inc3 !=0) %>%
  group_by(year) %>%
  summarise(nationalization = nationalization(dv, dvp)
  ) %>%
  ungroup()


# Calculate correlation between Gary J' measure and our measure of nationalization

# load gary j's data 
gary_j_data <- read.csv("gary_j_data.csv")

# Make a dataset with both our measure and 
# gary J's measure of nationalization for every year.
measure_comparison <- gary_j_data %>%
  filter(year>=1954) %>%
  group_by(year) %>%
  summarise(nationalization1 = nationalization(dv, dvp), # our measure
            nationalization2 = cor(dv,dpres,use = "pairwise.complete.obs") # garyj's measure
            )


# 3 compare the pearson correlation between our measure and gary j's nationalization measure




####################################################
# Calculate Incumbency advantage  coeffients by year
# Join these estimates with our nationalization measure
#####################################################

b_incumbency_adv <- cq_data %>%
  group_by(year) %>% 
  do(., tidy(lm(dv ~ dvp + ptynow + inc3, data = . ))) %>% 
  filter(term == "inc3") %>%
  ungroup() %>% 
  left_join(., swing_variance, by="year") %>% # join to nationalization measure
  mutate(post_1952 = as.numeric(year>1952)) # dummy for whether the year is after
# 1952


# Add in markers for 1950 and 1954
# This will be used in figure 1c
b_incumbency_adv$marker_break <- NA
b_incumbency_adv$marker_break[b_incumbency_adv$year==1950] <- 1950
b_incumbency_adv$marker_break[b_incumbency_adv$year==1954] <- 1954

# plot nationalization over time 
# this is all done for you, but you can try to learn about
# making graphics from this code
# might be useful in the future?
nationalization_year_plot <- ggplot(data=swing_variance, 
                                    aes(x= year, 
                                        y= nationalization)) +
  geom_line() +
  geom_point() +
  theme_bw() + ylab("Nationalization") + xlab("Year")


# 4 run the line below to make sure that you get a similar graph to 1a
# it won't have standard error bars like the main paper. 5pts extra credit if you can get those
# by bootstrapping your nationalization measure in every year
nationalization_year_plot


# plot incumbency advantage over time
incumbency_adv_year_plot <- ggplot(data=b_incumbency_adv, 
                                   aes(x=year, y=estimate)) +
  geom_line() +
  geom_point() +
  theme_bw() + ylab("Incumbency Advantage") + xlab("Year")

# 5 run the line below to make sure that you get a similar graph to 1b
incumbency_adv_year_plot


# 6a Find the pearson correlation between nationalization and the incumbency advantage by era (pre 1952 and post 1952) using the b_incumbency_adv data


# 6b Find the spearman correlation between nationalization and the incumbency advantage by era (pre 1952 and post 1952) using the b_incumbency_adv data


# Plot relationship between nationalization and the incumbency advantage
nationalization_incumbency_path_plot <- ggplot(data=b_incumbency_adv, 
                                               aes(x=nationalization, 
                                                   y=estimate))+ 
  geom_point(aes(colour= year)) +
  geom_path(aes(color=year))+
  geom_text(size=4.5, aes(color=year, label=marker_break, hjust=-.3, vjust=.2)) +
  geom_text(label= "Post 1952:",
            x=-11, y=10.7, size=4.5, fontface="bold") +
  geom_text(label= "Pre 1952:",
            x=-11.5, y=4.8, size=4.5,fontface="bold") +
  theme_classic() + 
  xlab("Nationalization") + 
  ylab("Incumbency Advantage") +
  scale_color_continuous(name="Year") +
  xlim(c(-13.5,-2.5)) +
  theme(legend.key.height = unit(1.5, "cm"),
        legend.title.align=0)

# 7 run the line below to make sure you get a similar plot to panel 1c
# This will look slightly different than plot 1c, which is a scatter plot
# This is a path diagram, which connects points in temporal order
nationalization_incumbency_path_plot





