#Learning new package from the chapter dataset
#Tiday data means a consistent way to organise data
#this chapter shows package tidyr package

library(tidyverse)

# Trying show underlying data in chapter in multiple ways 
#showing each dataset in different way with four variables -->A tibble: 6 x 4
table1
# showing each dataset in different way with four variables -->A tibble: 12 x 4 sho
table2
#showing each dataset in different way with four variables --> A tibble: 6 x 3
table3 

# Spread across two tibbles
table4a #cases-->representing data in different way 3x3
table4b #population -->representing data in population
#advantages tidy data 
#consistent way to store data
#R vectorizes to mutate and summary functions

# Compute rate per 10,000
#importing packaging dplyr and ggplot2

table1 %>% 
  mutate(rate = cases / population * 10000)

# Compute cases per year
table1 %>% 
  count(year, wt = cases)
# Visualise changes over time with year and cases

library(ggplot2)
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))
# A tibble: 3 x 3
table4a
# A tibble: 6 x 3 #Cases
table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")

#Columns are gather dplyr::select()
#we use gather in similar way to tidy table4b

# A tibble: 6 x 3 #Population
table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")
#we combining and testing versions of table 4 a and table 4b into single tibble using dplyr::left_join()
tidy4a <- table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")
tidy4b <- table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")
left_join(tidy4a, tidy4b)

#Spreading
table2
table2 %>%
  spread(key = type, value = count)
#checking gather and spread are symmetrical
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  spread(year, return) %>% 
  gather("year", "return", `2015`:`2016`)
#Spread() and gather() to convert argument 
#Checking if code fails
table4a %>% 
  gather(1999, 2000, key = "year", value = "cases")
#Adding new column
people <- tribble(
  ~name,             ~key,    ~value,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)
#Tidying sample
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)
#Separating and uniting 
#Using separate() function separate():unite()
#separate() pulls apart one column into multiple columns

table3
table3 %>% 
  separate(rate, into = c("cases", "population"))

#Adding a seprator--sep expression used or separate a column 
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")
table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)
table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)

#Unite inverse of separate to rejoin separated columns
#tidyr::table5.unite() --> takes data frame to create new variable 
#dplyr::select() style:

table5 %>% 
  unite(new, century, year)

#Removing'_' between different columns not using separator
table5 %>% 
  unite(new, century, year, sep = "")
#exercise using extra and fill arguments toy dataset

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"))

#Missing values
#explicitly-->flaggged with NA
#Implicity-->not present in data

stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

#return of Q2015-->explicity missing -->NA
#return of first Q2016 

stocks %>% 
  spread(year, return)

#Setting N/A= true in gather() explicit missing values implicit
stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`:`2016`, na.rm = TRUE)

#Using Complete() for 
stocks %>% 
  complete(year, qtr)
treatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)

#using Fill() missing values missing values will be replaced

treatment %>% 
  fill(person)

#CaseStudy
who
who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)
who1
who1 %>% 
  count(key)
who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2
#adding separate
who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")
who3
who3 %>% 
  count(new)
#> # A tibble: 1 x 2
#>   new       n
#>   <chr> <int>
#> 1 new   76046
who4 <- who3 %>% 
  select(-new, -iso2, -iso3)
#separate sexage into sex and age by splitting after the first character
who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep = 1)
who5
#who dataset tidy
who %>%
  gather(key, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel")) %>%
  separate(key, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)