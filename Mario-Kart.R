# Get the Data

# Read in with tidytuesdayR package
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load(2021, week = 22)
here::here("tuesdata")

records <- tuesdata$records

# Load the packages
library(gtsummary)
library(broom)
library(here)
library(renv)
library(tidyverse)


#limiting the number of observations
rec <- records %>%
  select(track, type, shortcut, player, system_played, date, time, record_duration) %>%
  filter(type == "Three Lap", system_played == "NTSC")
