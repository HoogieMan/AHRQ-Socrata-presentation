setwd("~/SourceTree/RSocrata/R")
source("RSocrata.R")
library(ggplot2)

## R Connector for Socrata ##
healthDF <- read.socrata("http://ahrq.demo.socrata.com/resource/d6an-ytgq.csv")

head(healthDF,10)
nrow(healthDF)

selectDF <- healthDF[,c('Disease','MeasureTitle_Short','StateName','StateRate_Recent')]
papDF <- selectDF[ selectDF[, "MeasureTitle_Short"]=="Pap tests",]
cervDF <- selectDF[ selectDF[, "MeasureTitle_Short"]=="Cervical cancer diagnosed at advanced stage",]
dataFrame <- rbind(papDF, cervDF)

papVec <- papDF$StateRate_Recent
cerVec <- cervDF$StateRate_Recent

##ggplot2 correlation plot##
ggplot(dataFrame, aes(x=papVec, y=cerVec))+
  geom_point(shape=16, size= 4, color = "red") +
  geom_smooth(method=lm)+ 
  theme(                              
    axis.title.x = element_text(face="bold", color="black", size=14),
    axis.title.y = element_text(face="bold", color="black", size=14),
    plot.title = element_text(face="bold", color = "black", size=18))+
  labs(x="% of Women Who Received Pap Smear Within Last 3 Years", 
       y="Number of Advanced Cervical Cancers Diagnosed (Per 100,000 Women)",
       title="Correlation Between Pap Smears and Diagnoses of Advanced Cervical Cancer")

## negative correlation --- more pap smears --> less cervical cancers diagnosed at an advanced stage ##