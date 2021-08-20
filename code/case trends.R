# library(seasonal)
# CASE DECOMPOSITION METHODS
# STANDARD DECOMPOSITION ####
tndoh_daily$new_cases_ts <- ts(tndoh_daily$new_cases, frequency = 7, start = 1)
tndoh_daily$new_cases_trend <- decompose(tndoh_daily$new_cases_ts)$trend

# STL METHOD
tndoh_daily$new_cases_ts <- ts(tndoh_daily$new_cases, frequency = 7, start = 1)
tndoh_daily$new_cases_trend.stl <-stl(tndoh_daily$new_cases_ts, s.window = 7)$time.series[, "trend"]

stl(tndoh_daily$new_cases_ts, s.window = 7) %>% plot()
# stl(tndoh_daily$new_cases_ts, s.window = 7)$time.series[, "trend"]
# test_stl <- stl(tndoh_daily$new_cases_ts, s.window = 7) 
# test_stl$time.series[, "trend"]
# test_stl %>% str()

tndoh_daily %>% 
  filter(date >= lubridate::ymd("2021-01-01")) %>% 
  ggplot(aes(date, new_cases)) +
  geom_area(fill = "grey", alpha = 0.5) +
  geom_line(aes(y = new_cases_trend), color = "red", size = 1) +
  geom_line(aes(y = new_cases_trend.stl), color = "blue", size = 1) +
  geom_line(aes(y = new_cases_7davg), color = "black", size = 1) +
  geom_line(aes(y = new_cases_trend.stl), color = "blue", size = 1) 
  
