library(tidyverse)

kobe_data = readxl::read_excel('Analysis/Data/project2KobeData.xlsx' , sheet = 'modelData')

kobe_pred_data = readxl::read_excel('Analysis/Data/project2KobeData.xlsx', sheet = 'predData'  )


kobe_data$shot_distance

# plots 

p = ggplot(data= kobe_data) 

p+
  geom_point(mapping =  aes(x= shot_distance, y =   as.factor(shot_made_flag)))

p+
  geom_histogram(mapping =  aes(x= shot_distance, fill = 
                                  as.factor( shot_made_flag)))+
  facet_wrap(.~playoffs)

col_data = mutate(kobe_data, time_remaning= minutes_remaining+ seconds_remaining/60 ) %>%
  select(avgnoisedb, arena_temp, attendance, game_date,  lon,loc_y,loc_x,shot_distance,lat, time_remaning)


log_mod_formula = shot_made_flag ~ avgnoisedb+ arena_temp+ time_remaning+  
  lon    + lat +  shot_distance +playoffs


logistic_model = 
  glm (log_mod_formula,  data = kobe_data, family = "binomial")

p_data = predict(logistic_model, kobe_data, type= 'response')

table(data = as.numeric(p_data>0.5), reference = as.numeric(kobe_data$shot_made_flag))

p+
  geom_histogram(mapping =  aes(x= shot_distance, fill = 
                                  as.factor( shot_made_flag)))+
  facet_wrap(.~shot_zone_basic)

p+
  geom_histogram(mapping =  aes(x= shot_distance, fill = 
                                  as.factor( shot_made_flag)))+
  facet_wrap(shot_zone_basic~shot_zone_range)






