df <- read.csv("superstore_data.csv")
library(dplyr)
library(ggplot2)
library(stringr)
print(head(df))
df <- df %>%
  filter(Income > 30000)

print(nrow(df))
df <- df %>%
select(Id, Year_Birth, Education, Marital_Status, Income, Response)
current_year <- 2023
df <- df %>%
  mutate(Age = current_year - Year_Birth)

df <- df %>%
  mutate(Rich_flag = Income > 80000)
print(head(df))
  summary_df <- df %>%
  group_by(Education) %>%  
  summarize(Average_Income = mean(Income)) 
print(summary_df)
df <- df %>%
  left_join(summary_df, by = "Education")
library(tidyr)
df <- df %>%
  unite(New_Column, Education, Marital_Status, sep = ", ")
df$Rich_flag <- as.numeric(df$Rich_flag)
str(df)
df <- df %>%
  mutate_all(funs(ifelse(is.na(.), 0, .)))
print(head(df))
plot <- ggplot(df, aes(x = Response, y = Age)) +
  geom_boxplot() +
  labs(title = "Диаграмма 'ящик с усами' Response vs. Age", 
       x = "Response", y = "Age")
ggsave("my_plot.png", plot) 

rows_with_9 <- str_which(df$Age, pattern = "9")
result <- df[rows_with_9, ]
print(result)
