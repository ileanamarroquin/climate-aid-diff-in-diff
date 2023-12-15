# 1_data_cleaning: Cleaning the data downloaded from the Projects List Operations
#                  World Bank website
# Project Title: “Applying Difference-in-difference to the World Bank 
#                 Climate aid allocation in Latin America and the Caribbean. 
#                 What has changed after the Escazu Agreement in 2018?”
# Presented on April/2023 by Ileana Marroquin
###############################################################################
# 
### README
#  
#
# Input: 8 Downloaded CSV files folder called "WBG1.csv"
# Output: Data frame for the text analysis in the form of a CSV file called
#         "projects_dataframe.csv"  
# 
###############################################################################

### 0. Settup

rm(list=ls())

#Loading data cleaning libraries
library(tidyverse)
library(dplyr)
library(plm)
library(tidyr)
library(stringr)
library(readxl)
library(here)
library(lubridate)


# Load all CSV files in the "raw_data/WBG1" directory into a list
data_files <- list.files("raw_data/WBG1", full.names = TRUE)

# Reading each CSV file into a data frame
data_frames <- lapply(data_files, read.csv)

# Combining the data frames into a single data frame
df <- bind_rows(data_frames)
glimpse(df)


### 1. Clean the data frame 

# Selecting the relevant variables
df1 <- select(df,c(1,3,5,6,11,14))
dim(df1)

# Ensuring the names are easy to process
df2 <- df1
colnames(df2) <- gsub(" ","_",colnames(df2))
names(df2) <- tolower(names(df2))
names(df2)

# Renaming variables
df2 <- df2 %>%
            rename(p.do = project.development.objective) %>% 
            rename(p.cdate = project.closing.date) %>% 
            rename(p.n = project.name) %>% 
            rename(p.invest = current.project.cost)
glimpse(df2)

# Converting project investment values to numeric format
class('p.invest')
df2$p.invest <- as.numeric(df2$p.invest)
class('p.invest')

# Converting p.cdate to date format and creating a new p.year variable 
class('p.cdate')
df2$p.cdate <- as.Date(df2$p.cdate, format = "%m/%d/%Y")
p.year <- year(df2$p.cdate)
df3 <- df2 %>% 
            add_column(p.year)
class(year)

# Filtering out rows with missing values in p.year and creating a new data frame 
# excluding rows with missing values in p.year
df3 %>%
      filter(!is.na(p.year)) %>%
      dim()

df4 <- df3 %>%
            na.omit(!is.na(p.year))

# Converting character variables to lowercase and removing special characters
df5 <- df4 %>%
            mutate(across(where(is.character), ~ tolower(iconv(.x, from = "UTF-8", to = "latin1")))) %>%
            mutate(across(where(is.character), ~ gsub("[^[:alnum:][:space:]]", "", .x)))

# Examining the transformed data frame
glimpse(df5)


### 2. Export data frame for text analysis 

#Save it locally
write.csv(df5, file = here("1_processed_data","projects_dataframe.csv"), row.names = FALSE)
