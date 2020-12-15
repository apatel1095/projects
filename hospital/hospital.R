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
  hospital1 <- left_join(hospital,regions,by=c("state"="State Code"))
  hospital1
  
inpatient_beds <- ggplot(hospital1,aes(x=inpatient_beds_used_covid,y=inpatient_beds,group=Region,color=Region))+
  geom_line()+
  labs(x='Inpatient beds used for COVID',y='Total Inpatient Beds')+
  ggtitle('Inpatient bed usage for COVID per Region')+
  theme(plot.title = element_text(hjust=0.5))
inpatient_beds
facet1 <- inpatient_beds + facet_grid(rows=vars(Region))
facet1

icu <- ggplot(hospital1, aes(x=staffed_icu_adult_patients_confirmed_and_suspected_covid,y=staffed_adult_icu_bed_occupancy,group=Region,color=Region))+
  geom_line()+
  labs(x='ICU beds used for COVID',y='Staffed ICU beds available')+
  ggtitle('ICU bed usage for COVID per Region')+
  theme(plot.title = element_text(hjust=0.5))
icu
facet2 <- icu + facet_grid(rows=vars(Region))
facet2

