setwd("C:/Users/anujp/OneDrive/Desktop/Coding/Data Sets Analysis")
library(readr)
library(dplyr)
library(ggplot2)
library(scales)
testing <- read_csv("covid testing.csv")
regions <- read_csv("us regions.csv")
glimpse(testing)
testing$state <- NULL
testing$state_fips <- NULL
testing$fema_region <- NULL
testing1 <- left_join(testing,regions,by=c("state_name"="State"))
testing1 <- testing1 %>% filter(overall_outcome=="Positive") %>% filter(Region != "NA")
overall <- ggplot(testing1,aes(x=date,y=new_results_reported,group=Region,color=Region)) +
  scale_color_manual(values=c('orange','navy blue','green','purple')) +
  geom_line()+
  scale_x_date(breaks=date_breaks("months")) +
  ylim(0,25000) +
  labs(x='Date',y='Positive results')+
  ggtitle('Positive COVID-19 Tests across the U.S')+
  theme(plot.title = element_text(hjust = 0.5))
overall 
facet1 <- overall + facet_grid(rows= vars(Region)) 
facet1