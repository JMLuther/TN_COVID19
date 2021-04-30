tndoh_age$age.f %>% unique()
tndoh_age %>% 
  filter(date >= lubridate::ymd("2021-02-15"),
         age.f %in% c("41-50","51-60", "61-70", "71-80", "81+")) %>% 
  ggplot(aes(x = date,
             y = age.f,
             height = ar_new_deaths_100k_7davg,
             fill = age.f)) +
  ggridges::geom_ridgeline(alpha = 0.5) +
  theme(legend.position = "none") +
  labs(x = NULL, y = NULL,
       title = "New Deaths, by Age (per 100k within age group)") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b", expand = c(0, 0))

pl_deaths_age <-
  tndoh_age %>% 
  filter(date >= lubridate::ymd("2021-02-15"),
         age.f %in% c("41-50","51-60", "61-70", "71-80", "81+")) %>% 
  ggplot(aes(x = date,
             y = ar_new_deaths_100k_7davg,
             fill = age.f)) +
  geom_area(alpha = 0.5) +
  theme(legend.position = "none") +
  labs(x = NULL, y = NULL,
       title = "Average Daily Deaths, per 100k within age group") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b", expand = c(0, 0)) +
  facet_wrap(~age.f, nrow = 1) +
  # facet_wrap(~age.f, nrow = 1, scales = "free_y") +
  theme(axis.text.x.bottom = element_text(angle = 90, size = 7))

pl_cases_age <-
  tndoh_age %>% 
  filter(date >= lubridate::ymd("2021-02-15"),
         age.f %in% c("41-50","51-60", "61-70", "71-80", "81+")) %>% 
  ggplot(aes(x = date,
             y = ar_new_cases_100k_7davg,
             fill = age.f)) +
  geom_area(alpha = 0.5) +
  theme(legend.position = "none") +
  labs(x = NULL, y = NULL,
       title = "Average New Cases, per 100k within age group") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b", expand = c(0, 0)) +
  facet_wrap(~age.f, nrow = 1) +
  # facet_wrap(~age.f, nrow = 1, scales = "free_y") +
  theme(axis.text.x.bottom = element_text(angle = 90, size = 7))
cowplot::plot_grid(pl_cases_age,
                   pl_deaths_age,
                   nrow = 2)

# AGE HEATMAP ####
max_newcaserate_byage <- max(tndoh_age$ar_new_cases_100k_7davg, na.rm = T)
ar_newcase_heatmap_100k <-
  tndoh_age %>% 
  filter(date >= lubridate::ymd("2020-07-01")) %>% 
  ggplot(aes(x = date,
             y = age.f)) +
  geom_tile(aes(fill = ar_new_cases_100k_7davg,
                color = ar_new_cases_100k_7davg)) +
  viridis::scale_fill_viridis(labels = scales::comma,
                              limits = c(0, max_newcaserate_byage), oob = scales::squish,
                              option = "plasma") +
  viridis::scale_color_viridis(labels = scales::comma,
                               limits = c(0, max_newcaserate_byage), oob = scales::squish,
                               option = "plasma") +
  labs(fill = "New Cases/100k/d\n(7dAvg)",
       color  = "New Cases/100k/d\n(7dAvg)",
       x = NULL, y = NULL,
       title = "New Case Rate, by Age (population adjusted)") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b", expand = c(0, 0)) +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 12),
        panel.grid = element_blank(),
        legend.position = "bottom",
        legend.background = element_blank(), 
        panel.border = element_blank(),
        legend.title = element_text(size = 10),
        legend.text =  element_text(size = 8))

# new deaths by age
max_newdeaths_byage <- max(tndoh_age$ar_new_deaths_100k_7davg, na.rm = T)
ar_newdeaths_heatmap_100k <-
  tndoh_age %>% 
    filter(date >= lubridate::ymd("2020-07-01")) %>% 
    ggplot(aes(x = date,
               y = age.f)) +
    geom_tile(aes(fill = ar_new_deaths_100k_7davg,
                  color = ar_new_deaths_100k_7davg)) +
    viridis::scale_fill_viridis(labels = scales::comma,
                                limits = c(0, max_newdeaths_byage), oob = scales::squish,
                                option = "plasma") +
    viridis::scale_color_viridis(labels = scales::comma,
                                 limits = c(0, max_newdeaths_byage), oob = scales::squish,
                                 option = "plasma") +
    labs(fill = "New Deaths/100k/d\n(7dAvg)",
         color  = "New Deaths/100k/d\n(7dAvg)",
         x = NULL, y = NULL,
         title = "Death Rate, by Age (population adjusted)") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b", expand = c(0, 0)) +
    theme_minimal() +
    theme(axis.text.y = element_text(size = 12),
          panel.grid = element_blank(),
          legend.position = "bottom",
          legend.background = element_blank(), 
          panel.border = element_blank(),
          legend.title = element_text(size = 10),
          legend.text =  element_text(size = 8))

# ar_newdeaths_heatmap_100k
ar_newcase_heatmap_100k
ar_newdeaths_heatmap_100k
cowplot::plot_grid(ar_newcase_heatmap_100k,
                   ar_newdeaths_heatmap_100k, nrow = 1)

## AGE RIDGEPLOT ####
max_newcaserate_byage <- max(tndoh_age$ar_new_cases_100k_7davg, na.rm = T)
tndoh_age %>% 
  filter(date >= lubridate::ymd("2020-04-01")) %>% 
  ggplot(aes(x = date,
             y = age.f,
             height = ar_new_cases_100k_7davg/25,
             fill = age.f)) +
    ggridges::geom_ridgeline(alpha = 0.5) +
    theme(legend.position = "none") +
    labs(x = NULL, y = NULL,
       title = "New Case Rate, by Age (cases/100k within age group)") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b", expand = c(0, 0)) 



## US HEATMAP WITH CLUSTERING ####
library(gplots)  
library(dtwclust)
max_newcaserate_alldates <- max(cdc_currentdata$new_cases_state_7davg_100k, na.rm = T)
  
state_order <- 
  cdc_currentdata %>% 
  filter(date == max(date)) %>% 
  mutate(state_bynewcases = reorder(state, new_cases_state_7davg_100k)) %>% 
  select(state, state_bynewcases)

data_for_usheatmap <- 
  cdc_currentdata %>% 
  left_join(state_order, by = "state") %>% 
  filter(date >= lubridate::ymd("2020-04-01")) 

data_for_usheatmap_wide <-
  data_for_usheatmap %>% 
  select(date, state, new_cases_state_7davg_100k) %>% 
  pivot_wider(names_from = state,
              values_from = new_cases_state_7davg_100k)
data_for_usheatmap_wide <- column_to_rownames(data_for_usheatmap_wide, var = "date")


dtw_dist <- function(x){dist(x, method="DTW")}  
gplots::heatmap.2(t(as.matrix(data_for_usheatmap_wide)),
                  distfun = dtw_dist,
                  hclustfun = hclust,
                  dendrogram = "row",
                  revC = T,
                  Rowv = T,     # group by STATE
                  Colv = FALSE, # Don't sort by date
                  srtRow = NULL,
                  key = TRUE,
                  col = gplots::colorpanel(100, low = "white", mid = "white", high = "black"),
                  main = "COVID19 State Clusters",
                  # ylab = "State",
                  # xlab = "Date",
                  trace = "none",
                  # scale = "none"
                  )

library(TSclust)
ts_matrix_uscovid <-  t(as.matrix(data_for_usheatmap_wide)) # 1 state per row
# head(data_for_usheatmap_wide) # TSclust can handle dataframes- assumes each column is a series
dist_ts_dtw <- TSclust::diss(SERIES = data_for_usheatmap_wide, METHOD = "DTWARP") # note the dataframe must be transposed

# VERTICAL
gplots::heatmap.2(as.matrix(data_for_usheatmap_wide),
                  distfun = dtw_dist,
                  hclustfun = hclust,
                  dendrogram = "column",
                  revC = T,
                  Rowv = F,     # group by STATE
                  Colv = TRUE, # Don't sort by date
                  # srtRow = NULL,
                  key = TRUE,
                  col = bluered(100),
                  main = "COVID19 State Cluster Analysis",
                  key.title = "Cases/100k",
                  key.ylab = NA,
                  trace = "none")
# HORIZONTAL
gplots::heatmap.2(as.matrix(t(data_for_usheatmap_wide)),
                  distfun = dtw_dist,
                  hclustfun = hclust,
                  dendrogram = "row",
                  revC = F,
                  Rowv = T,     # group by STATE
                  Colv = F, # Don't sort by date
                  # srtRow = NULL,
                  key = TRUE,
                  col = bluered(100),
                  main = "COVID19 State Cluster Analysis",
                  key.title = "Cases/100k",
                  key.ylab = NA,
                  trace = "none")



tndoh_vax_state
left_join(tndoh_daily,
          tndoh_vax_state,
          by = "date")
