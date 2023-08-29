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

# Create a gtsummary table of descriptive statistics about the data
tbl_summary(
  rec,
  label = list(
    `track` ~ "Track name",
    `type` ~ "Three lap record",
    `shortcut` ~ "Shortcut or non-shortcut record",
    `player` ~ "Player's name",
    `system_played` ~ "Used system",
    `date` ~ "World record date",
    `time` ~ "Time in seconds",
    `record_duration` ~ "Record duration in days"
  )
)

# Fit a regression model to predict the time from the track and player
track_model <- lm(time ~ track + player,
            data = rec)
tbl_regression(
  track_model,
  intercept = TRUE,
  label = list(
    track ~ "Track name",
    player ~ "Player's name"
  )
)

# Create a figure of the time vs. track
ggplot(rec, aes(track, time)) + geom_point()
