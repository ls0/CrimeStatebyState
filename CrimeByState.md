CrimeByState
========================================================
## Screenshot of Rstudio for The Data Scientist’s Toolbox assignment.  Created on 4/14/2014, by user: ls0
## Data was from: (hci.stanford.edu/jheer/workshop/data/crime/CrimeStatebyState.csv). 
## Data was tidied using Hadley Wickham's dplyr.
## A function called 'crime' was created so data for any USA state can be observed and plotted.
## Hadley Wickham's ggplot2 was used to produce the graph.
## Download and try it for any state.   
**Below are the libraries used and function created to obtain data for individual states of 
the USA.
```{r}
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
```
The example uses Maryland, but any state can be added. 
A ggplot is generated that shows violent and property crimes per year.
```{r fig.width=7, fig.height=6}
stateData <- crime("Maryland")
ggplot(stateData, aes(x=Year, y=Count, colour=Crime)) + 
  geom_smooth(method="loess", aes(group=Crime), lwd=1.2) +
  geom_point(size=3) +
  ggtitle("Crimes Committed from 1960-2005") +
  theme(plot.title = element_text(size = 20,colour="blue"))
```

