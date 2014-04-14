## CrimeByState
library(dplyr)
library(ggplot2)
crime.by.state <- read.csv("CrimeStatebyState.csv")
crime <- function(state){
  crime.by.state %.%
    filter(State==state) %.%
    arrange(Year, desc(Count)) %.%
    mutate(Crime = Type.of.Crime) %.%
    select(Year, Crime, Count) %.%
    group_by(Year, Crime) %.%
    summarise(Count = sum(Count))
}
stateData <- crime("Maryland")
ggplot(stateData, aes(x=Year, y=Count, colour=Crime)) + 
  geom_smooth(method="loess", aes(group=Crime), lwd=1.2) +
  geom_point(size=3) +
  ggtitle("Crimes Committed from 1960-2005") +
  theme(plot.title = element_text(size = 20,colour="blue"))