library(tidyverse)

kobe_data = readxl::read_excel('Analysis/Data/project2KobeData.xlsx' , sheet = 'modelData')

kobe_pred_data = readxl::read_excel('Analysis/Data/project2KobeData.xlsx', sheet = 'predData'  )


names(kobe_data)

sapply(names(kobe_data), class)

sapply(kobe_data, function (x) {sum(x!="")})

kobe_data$shot_distance

# plots 

p = ggplot(data= kobe_data) 


## Factors 

### action_type
p+
  geom_bar(mapping= aes(x=  action_type, fill = as.factor(shot_made_flag)))+
  coord_flip()

### combined_shot_type

p+
  geom_bar(mapping= aes(x=  combined_shot_type, fill = as.factor(shot_made_flag)))+
  coord_flip()

### matchup
  p+
    geom_bar(mapping= aes(x=  matchup, fill = as.factor(shot_made_flag)))+
    coord_flip()
   
### opponent
  p+
    geom_bar(mapping= aes(x=  opponent, fill = as.factor(shot_made_flag)))+
    coord_flip()
 
  
## Continuous var 
  
  
### game_event_id  
  p+
    geom_bar(mapping= aes(x=  game_event_id, fill = as.factor(shot_made_flag)))+
    coord_flip()

  
### game_id
  p+
    geom_bar(mapping= aes(x=  game_id, fill = as.factor(shot_made_flag)))+
    coord_flip()
  
  p+
    geom_histogram(mapping= aes(x=  game_id, fill = as.factor(shot_made_flag)))
  
  
### lat
  
  
  p+
    geom_bar(mapping= aes(x=  lat, fill = as.factor(shot_made_flag)))+
    coord_flip()
  
  p+
    geom_histogram(mapping= aes(x=  lat, fill = as.factor(shot_made_flag)))
  coord_flip()
  
### loc_x
  
  p+
    geom_bar(mapping= aes(x=  loc_x, fill = as.factor(shot_made_flag)))+
    coord_flip()
  
  
  p+
    geom_histogram(mapping= aes(x=  loc_x, fill = as.factor(shot_made_flag)))
  coord_flip()
  
### loc_y  
  p+
    geom_bar(mapping= aes(x=  loc_y, fill = as.factor(shot_made_flag)))+
    coord_flip()
  
  p+
    geom_histogram(mapping= aes(x=  loc_y, fill = as.factor(shot_made_flag)))
  coord_flip()
  

###  lon
  
  p+
    geom_bar(mapping= aes(x=  lon, fill = as.factor(shot_made_flag)))+
    coord_flip()
  
  
  p+
    geom_histogram(mapping= aes(x=  lon, fill = as.factor(shot_made_flag)))
  coord_flip()
  

### minutes_remaining 
  
  p+
    geom_bar(mapping= aes(x=  minutes_remaining, fill = as.factor(shot_made_flag)))+
    coord_flip()

  p+
    geom_histogram(mapping= aes(x=  minutes_remaining, fill = as.factor(shot_made_flag)))
  coord_flip()
  
### period
  
  p+
    geom_bar(mapping= aes(x=  period, fill = as.factor(shot_made_flag)))
  
  p+
    geom_histogram(mapping= aes(x=  period, fill = as.factor(shot_made_flag)))
  coord_flip()
  
### playoffs 
  
  p+
    geom_bar(mapping= aes(x=  playoffs, fill = as.factor(shot_made_flag)))+
    coord_flip()
  
  
  p+
    geom_histogram(mapping= aes(x=  playoffs, fill = as.factor(shot_made_flag)))
  coord_flip()
  
### season 
  
  
  p+
    geom_bar(mapping= aes(x=  season, fill = as.factor(shot_made_flag)))+
    coord_flip()
  
  
  
### seconds_remaining 
  
  p+
    geom_bar(mapping= aes(x=  seconds_remaining, fill = as.factor(shot_made_flag)))+
    coord_flip()
  p+
    geom_histogram(mapping= aes(x=  seconds_remaining, fill = as.factor(shot_made_flag)))
  
### shot_type
  p+
    geom_bar(mapping= aes(x=  shot_type, fill = as.factor(shot_made_flag)))+
    coord_flip()
  p+
    geom_histogram(mapping= aes(x=  shot_type, fill = as.factor(shot_made_flag)))
  
  
### shot_zone_area
  p+
    geom_bar(mapping= aes(x=  shot_zone_area, fill = as.factor(shot_made_flag)))+
    coord_flip()
  
  
### shot_zone_basic
  
  p+
    geom_bar(mapping= aes(x=  shot_zone_basic, fill = as.factor(shot_made_flag)))+
    coord_flip()
  
### shot_zone_range 
  
  p+
    geom_bar(mapping= aes(x=  shot_zone_range, fill = as.factor(shot_made_flag)))+
    coord_flip()
  
  
### game_date
  
  p+
    geom_bar(mapping= aes(x=  as.Date(game_date, origin="1900-01-01"), fill = as.factor(shot_made_flag)))+
    coord_flip()
  p+
    geom_histogram(mapping= aes(x=  as.Date(game_date, origin="1900-01-01"), fill = as.factor(shot_made_flag)))
  
  
### attendance
  
  
  p+
    geom_bar(mapping= aes(x=  attendance, fill = as.factor(shot_made_flag)))+
    coord_flip()
  p+
    geom_histogram(mapping= aes(x=  attendance, fill = as.factor(shot_made_flag)))
  
  
### arena_temp
  
  
  p+
    geom_bar(mapping= aes(x=  arena_temp, fill = as.factor(shot_made_flag)))+
    coord_flip()
  p+
    geom_histogram(mapping= aes(x=  arena_temp, fill = as.factor(shot_made_flag)))
  
### avgnoisedb
  
  p+
    geom_bar(mapping= aes(x=  avgnoisedb, fill = as.factor(shot_made_flag)))+
    coord_flip()
  p+
    geom_histogram(mapping= aes(x=  avgnoisedb, fill = as.factor(shot_made_flag)))
  
