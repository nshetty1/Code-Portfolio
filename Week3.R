#Exploratory Data Analysis using US EDA OZONE 2017 file provided 
# using data set Ozone data we check ozone levels in US
library(readr)
#formulate the question to guide exploratory data analysis proces and to limit exponential paths for EDA
#question should be specfic out of all possibilities 

setwd(dir = "/Users/nrupali.shetty/Documents/Code Portfolio")
ozone <- read_csv("US EPA data 2017.csv")

#checking number of rowns and columns
nrow(ozone)
ncol(ozone)

#checking number of rows in case of large datasets--use this function 
str(ozone)

#str() duplicates may be populated number of rows and columns 

#reading a file it is useful to check beginning and end of dataset right 

#checking data head
head(ozone[, c(6:7, 10)])
tail(ozone[,c(6:7,10)])
#tail() useful reading end of dataset to chck structure file is as expect to begin EDA

#checking year the ozone data recorded
table(ozone$Year)

library(dplyr)

#checking function Filter
filter(ozone, Year =2017) %>%
select("Pollutant Standard","Units of Measure","Required Day Count"
,"Date of Last Change")

#tried using the chapter code for our dataset getting error with functions 
#Error Call `rlang::last_error()` to see a backtrace
filter(ozone,Year=='2017' & Metric Used=="Daily Mean") %>%
  select (Year,Metric Used)%>%

)