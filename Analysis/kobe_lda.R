library(caret)
library(reshape2)
library(car)
library(MASS)
library(tidyverse)



kobe_data = readxl::read_excel('Analysis/Data/project2KobeData.xlsx' , sheet = 'modelData')

kobe_pred_data = readxl::read_excel('Analysis/Data/project2KobeData.xlsx', sheet = 'predData'  )

col_data = mutate(kobe_data, time_remaning= minutes_remaining*60+ seconds_remaining ) %>%
  dplyr::select(avgnoisedb, arena_temp, attendance, game_date,  lon,loc_y,loc_x,shot_distance,lat)

 