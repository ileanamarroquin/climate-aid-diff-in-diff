# 2_text_analysis_dictionary_classification: Creating the Dictionary to classify the projects
# Project Title: “Applying Difference-in-difference to the World Bank 
#                 Climate aid allocation in Latin America and the Caribbean. 
#                 What has changed after the Escazu Agreement in 2018?”
# Presented on April/2023 by Ileana Marroquin
###############################################################################
# 
### README
#
# Input: CSV file called "projects_dataframe.csv"  
# Output: Final database with classified projects in the form of a CSV file called
# "classified_projects.csv"  
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
library(SnowballC) 
library(streamR)
library(ggplot2)

# Load the CSV file to perform the clasification of projects
df5<-read_csv(
                here("1_processed_data","projects_dataframe.csv"), na = ""
)
glimpse(df5)

### 1. Create own dictionary lexicon

# Creating a df with a lexicon customed with manually identified words that belong
myscoring.df <- structure(list(word = c("carbon", 
                                        "climate", 
                                        "green", 
                                        "resilient", 
                                        "risk", 
                                        "sustainable", 
                                        "mitigation", 
                                        "natural", 
                                        "food", 
                                        "landscape", 
                                        "recovery", 
                                        "biodiversity",
                                        "conservation", 
                                        "natural", 
                                        "energy", 
                                        "transition", 
                                        "catastrophe", 
                                        "vulnerable", 
                                        "capacity", 
                                        "agriculture", 
                                        "clean", 
                                        "emissions", 
                                        "water",
                                        "electricity", 
                                        "extractive",
                                        "adaptation", 
                                        "ozone")))
str(myscoring.df)

# Identifying environmental keywords in project descriptions with dummy variable
# where 1 indicates the presence of environmental keywords in the development objective
df5$ogreen <- ifelse(grepl(paste(myscoring.df$word, collapse="|"), df5$p.do), 1, 0) 
df5$ngreen <- ifelse(grepl(paste(myscoring.df$word, collapse="|"), df5$p.n), 1, 0)

# Likewise, If the environmental value is 0, indicating the absence of environmental keywords, 
# the other value for that row is set to 1, classifying the project as non-environmental
df5$environmental <- ifelse(df5$ogreen>0 | df5$ngreen>0, 1, 0)
df5$other <- ifelse(df5$environmental<1, 1, 0)

# Observing the new varibles cretion
glimpse(df5)

### 2. Prepare dataframe for matching 
# Selecting the relevant variables
data <- select(df5,c(1,2,6:7,10:11))
head(data)


# Cleaning and Standardizing Country Names
data$country <- as.character(data$country)
data$country <- removePunctuation(data$country)

# Removing Unnecessary Words from Country Names
# data$country <- data$country %>% str_replace("republic of", "")
# data$country <- data$country %>% str_replace("the", "")
# data$country <- data$country %>% str_replace("republic", "")
# data$country <- data$country %>% str_replace("cooperative", "")
# data$country <- data$country %>% str_replace("federative", "")
# data$country <- data$country %>% str_replace("plurinational state of", "")
# data$country <- data$country %>% str_replace("federative", "")
# data$country <- data$country %>% str_replace("oriental", "")
# data$country <- data$country %>% str_replace("commonwealth of", "")
# data$country <- data$country %>% str_replace("argentine", "argentina")
# data$country <- data$country %>% str_replace("united mexican states", "mexico")


replacements <- c(
                  "republic of" = "",
                  "the" = "",
                  "republic" = "",
                  "cooperative" = "",
                  "federative" = "",
                  "plurinational state of" = "",
                  "oriental" = "",
                  "commonwealth of" = "",
                  "argentine" = "argentina",
                  "united mexican states" = "mexico"
                  )

data$country <- str_replace_all(data$country, replacements)


### 2. Export data frame for text analysis 
# Creating a Cleaned Project data frame to save it locally
p_data <- data
str(p_data)
write.csv(p_data, here("1_processed_data","classified_projects.csv"), row.names = FALSE)


