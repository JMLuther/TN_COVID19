# Get Nwss data  ----
## Install the required package with:
## install.packages("RSocrata")
library(tidyverse)
library("RSocrata")
nwss_api_url <- "https://data.cdc.gov/resource/g653-rqe2.csv"
nwss_dat <- RSocrata::read.socrata(url = nwss_api_url)

# httr::GET only collects first 1000 rows of the data
nwss_dat <- content(httr::GET("https://data.cdc.gov/resource/g653-rqe2.csv")) # get data


## ├ benchmark download times ----
# microbenchmark::microbenchmark(times = 1,
#                                nwss_dat <- content(httr::GET("https://data.cdc.gov/resource/g653-rqe2.csv")) # get data
# )
# 
# microbenchmark::microbenchmark(times = 1,
#                                {nwss_dat_csv <- RSocrata::read.socrata(url = nwss_api_url)}
# )

# nwss_api_url_json <- "https://data.cdc.gov/resource/g653-rqe2.json"
# {nwss_dat_json <- RSocrata::read.socrata(url = nwss_api_url_json)}
# microbenchmark::microbenchmark(times = 1,
#                                {nwss_dat_json <- RSocrata::read.socrata(url = nwss_api_url_json)}
# )


# DATA ----

## ├ Facility Data ----
nwss_info <- readr::read_csv(here::here("data_cdc/NWSS_Public_SARS-CoV-2_Wastewater_Metric_Data.csv"))
# Hmisc::describe(nwss_info)
unique(nwss_info$wwtp_jurisdiction)
unique(nwss_info$wwtp_id)
unique(nwss_info$reporting_jurisdiction)
unique(nwss_info$sample_location) # "Treatment plant" "Before treatment plant"
unique(nwss_info$sample_location_specify)
unique(nwss_info$key_plot_id)

nwss_info$county_names <- gsub(",", ", ", nwss_info$county_names)

nwss_TN <-
  nwss_info %>% 
  filter(wwtp_jurisdiction == "Tennessee")

wwtp_id_details_tn <-
  nwss_TN %>% 
  select(wwtp_id, wwtp_jurisdiction, county_fips, county_names) %>% 
  filter(!duplicated(wwtp_id))
saveRDS(wwtp_id_details_tn, here::here("data_rds/wwtp_id_details_tn.rds"))

## ├ PCR Data ----
nwss_dat <- RSocrata::read.socrata(url = "https://data.cdc.gov/resource/g653-rqe2.csv")
wwtp_id_details_tn <- readRDS(here::here("data_rds/wwtp_id_details_tn.rds"))

nwss_dat <-
  nwss_dat %>% 
  mutate(original_kpid = key_plot_id) %>% 
  extract(key_plot_id, 
          into = c("nwss_source", "state", "wwtp_id", "sample_location", "sample_location_specify", "sample_type"),
          regex = "(CDC_BIOBOT|CDC_LUMINULTRA|NWSS)_([a-z]+)_([0-9]+)_(Before treatment plant|Treatment plant)_([0-9]+)*_*(.*)") %>% 
  rename(key_plot_id = original_kpid)  %>% 
  mutate(wwtp_id = as.numeric(wwtp_id), # required for merging
         date = lubridate::ymd(date))  

nwss_dat_tn <-
  nwss_dat %>% 
  filter(state == "tn") %>%
  left_join(wwtp_id_details_tn,  by = "wwtp_id")

nwss_dat_tn %>%
  filter(!is.na(pcr_conc_smoothed)) %>% 
  ggplot(aes(date, pcr_conc_smoothed/1000, group = wwtp_id, color = factor(wwtp_id))) +
  geom_line() +
  facet_wrap(~county_names, nrow = 1, labeller = labeller(county_names = label_wrap_gen(7))) +
  labs(title = "TN Wastewater Surveillance",
       x= NULL, y = "SARS-COV2 Conc by PCR\n(Flow-Population normalized)",
       caption = "Source: CDC, National Wastewater Surveillance System (NWSS)") +
  scale_y_continuous(label=comma) +
  scale_x_date(date_breaks = "3 month", date_labels = "%b-%Y" ) +
  theme(strip.text = element_text(size = 14),
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position = "none")

