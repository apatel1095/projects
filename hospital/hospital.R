setwd("C:/Users/anujp/OneDrive/Desktop/Coding/Data Sets Analysis")
library(readr)
library(dplyr)
library(ggplot2)
hospital <- read_csv("hospital utilization.csv")
glimpse(hospital)
hospital
hospital <- hospital %>% group_by(state) %>%
  arrange(state)
hospital <- hospital[-c(8,40,48),]
regions <- read_csv("us regions.csv")
  hospital1 <- left_join(hospital,regions,by=c("state"="State"))
  hospital1