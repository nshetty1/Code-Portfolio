#Learning basic of R object management in this chapter
#Learnign about working directory file path for defaul locationfrom where R reads into or save out of R
#r will always assume the file is inside the workign directory

#checking for current working directory for R read the file from
getwd()

#trying to change directory to different location from present directory--> /Users/nrupali.shetty/Documents/R/MyRProject

setwd(dir = "/Users/nrupali.shetty/Documents/Code Portfolio")

#R studio creates a new R project with .RProj file.
#workspace represents objects and functions defined in session

#tried suign function ls() resulting in no objects in my current workspace
ls()

#trying to search a object if it exist in workspace
study3.df

#--> Error: object 'study3.df' not found
# as the object is not present in our current workspace 

#Best way to store ojects from R with .RData files. Files specific to R can store many objects in a single file.
# Save() saves selected objects into .RData file


#creating new objects in current workspace, trying input none input to try results 
study1.df <- data.frame(id = 1:5, 
                        sex = c("m", "m", "none", "f", "m"), 
                        score = c(51, 20, 67, 52, 42))

score.by.sex <- aggregate(score ~ sex, 
                          FUN = mean, 
                          data = study1.df)

study1.htest <- t.test(score ~ sex, 
                       data = study1.df)

#now checked if new objects created available in workspace
ls()

#saving all the created objects in .Rdata file
save(study1.df, score.by.sex, study1.htest,
     file = "/Users/nrupali.shetty/Documents/Code Portfolio")

save(study1.df, score.by.sex, study1.htest,
     file = "/Users/nrupali.shetty/Documents/Code Portfolio/study1.RData")

# Save my workspace image in data folder of my working directory
save.image(file = "/Users/nrupali.shetty/Documents/Code Portfolio/projectimage.RData")

#loaded object study1 in current workspace
load(file = "/Users/nrupali.shetty/Documents/Code Portfolio/study1.RData")

# Loading objects projectimage.RData in current workspace
load(file = "/Users/nrupali.shetty/Documents/Code Portfolio/projectimage.RData")

#Remove object study1 workspace 
rm(study1.df)

#remove all objects from current  workspace
rm(list=ls())

#REmoved object cannot be undo to get it back. We need to recreate the object again from scratch
study1.df
#Error: object 'study1.df' not found

# writing table[write.table()] in files pirates as tab-delimited text file


pirates.df <- data.frame(id = 1:5, 
                        sex = c("m", "m", "f", "f", "m"), 
                        Age= c(51, 20, 67, 52, 42))
ls()

#set directory again for Pirates
setwd(dir = "/Users/nrupali.shetty/Documents/Code Portfolio")
getwd()
#save Pirates file in directory
save(pirates.df,
     file = "/Users/nrupali.shetty/Documents/Code Portfolio/study1.RData")

write.table(x = pirates.df,
           file = "pirates.txt",  
           sep = "\t")    

# saving file in different location with different name
write.table(x = pirates.df,
            file = "/Users/nrupali.shetty/Documents/Code Portfolio/pirates1.txt",  
            sep = "\t")    
#read file three critical arguments file,sep, header and stringAsFactors. Header argument is logical-->TRUE OR FALSE
#sep argument comma-separated file sep="\t", stringAsFactors logical value whether to convert strings to factor

#read file from computer using function read.table() with tab delimiter

mydata <- read.table(file = '/Users/nrupali.shetty/Documents/Code Portfolio/mydata.txt',    # file is in a data folder in my working directory
                     sep = '\t',                  # file tab--delimited
                     header = TRUE,               # the first row is a header row
                     stringsAsFactors = FALSE)    

#read file from website that can be used to load text files directly from web
#Chapter author has stored file
fromweb <- read.table(file = 'http://goo.gl/jTNf6PD',
                      sep = '\t',
                      header = TRUE)

#whenever we load text file that was exported from excel it is good idea to clean the data in excel
#columns have simple names without spaces and special characters

#We can use many funstion other than read.table() like read.csv and read.delim-->comma separated and tab separated text files



