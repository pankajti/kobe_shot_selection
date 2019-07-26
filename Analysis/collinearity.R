library(tidyverse)
library(caret)
library(reshape2)

kobe_data = readxl::read_excel('Analysis/Data/project2KobeData.xlsx' , sheet = 'modelData')
kobe_pred_data = readxl::read_excel('Analysis/Data/project2KobeData.xlsx', sheet = 'predData'  )

col_data = mutate(kobe_data, time_remaning= minutes_remaining+ seconds_remaining/60 ) %>%
  select(avgnoisedb, arena_temp, attendance, game_date,  lon,loc_y,loc_x,shot_distance,lat)

cordata = round(cor(col_data))

head(cordata)

melted_cormat <- melt(cordata)
head(melted_cormat)

ggplot(data = melted_cormat, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile()+
  geom_text(aes(Var2, Var1, label = value), color = "black", size = 4) +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.ticks = element_blank(),
    legend.justification = c(1, 0),
    legend.position = c(0.6, 0.7),
    legend.direction = "horizontal")+
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1,
                               title.position = "top", title.hjust = 0.5))

vif(lm (lon ~ arena_temp*game_date*attendance, data = col_data))

kobe_data_for_log_model = mutate(kobe_data , locy = loc_y, cordx= loc_x) %>%
  select(-c(loc_y, loc_x))

log_mod_formula = shot_made_flag ~ avgnoisedb+ arena_temp+ attendance+ game_date + seconds_remaining +
  minutes_remaining + lon    + lat + game_event_id

logistic_model = glm (log_mod_formula,  data = kobe_data_for_log_model, family = "binomial")

alias(logistic_model)
vif(logistic_model)

cooksd = cooks.distance(logistic_model)
plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")  # plot cook's distance
abline(h = 4*mean(cooksd, na.rm=T), col="red")  # add cutoff line
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>4*mean(cooksd, na.rm=T),names(cooksd),""), col="red")

 
