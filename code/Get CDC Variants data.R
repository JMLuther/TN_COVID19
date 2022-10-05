# CDC VARIANT DATASET ----
# see https://data.cdc.gov/Laboratory-Surveillance/SARS-CoV-2-Variant-Proportions/jr58-6ysp for database information
library(httr)

## ├ Get Data ----
# cdc_variants <- content(httr::GET("https://data.cdc.gov/resource/jr58-6ysp.csv")) # Full US data
cdc_variants_data <- content(httr::GET("https://data.cdc.gov/resource/jr58-6ysp.csv?usa_or_hhsregion=4")) # Just Southeast

# cdc_variants$usa_or_hhsregion <- factor(cdc_variants$usa_or_hhsregion, 
#                                         levels = c("USA", 1:10),
#                                         labels = c("USA", paste("Region", 1:10)))
cdc_variants_data$variant <- factor(cdc_variants_data$variant)
cdc_variants_data$week_ending <- lubridate::date(cdc_variants_data$week_ending)
cdc_variants_data$creation_date <- lubridate::date(cdc_variants_data$creation_date)
cdc_variants_data$usa_or_hhsregion %>% unique
cdc_variants_data$modeltype %>% unique
cdc_variants <- 
  cdc_variants_data %>% 
  filter(modeltype == "weighted") %>% 
  arrange(creation_date) %>% 
  filter(!duplicated(interaction(week_ending, variant))) 

# figure out why sum > 1
# cdc_variants %>% 
#   filter(week_ending < lubridate::ymd("2021/08/14")) %>%
#   filter(modeltype == "weighted") %>%
#   # filter(!duplicated(interaction(week_ending, variant))) %>% View
#   group_by(week_ending) %>%
#   arrange(creation_date) %>% 
#     filter(!duplicated(interaction(week_ending, variant))) %>% 
#   summarise(sum(share))
# 
# cdc_variants %>% 
#   filter(week_ending < lubridate::ymd("2021/08/14")) %>%
#   filter(modeltype == "weighted") %>%
#   filter(creation_date lubridate::ymd("2022/08/14")) 
#   View

## ├ Plot ----
cdc_variants %>%
  ggplot(aes(week_ending, share,
             group = variant,
             fill = variant)) +
  geom_area(color = "grey50", alpha = 0.6) +
  scale_y_continuous(expand = c(0,0), limits = c(0,NA)) +
  # scale_x_date(expand = c(0,0), date_breaks = "3 month", date_labels = "%b-%Y" ) +
  theme(legend.position = "none") +
  labs(x = NULL,
       y = "Proportion of cases by Variant",
       fill = "Variant:") 

## ├ Get current Variant table from CDC ----
variant_table_response <- httr::GET(url = "https://www.cdc.gov/coronavirus/2019-ncov/variants/variant-classifications.html")
variant_table <- rvest::html_table(rvest::read_html(variant_table_response))[[1]]
names(variant_table) <- tolower(make.names(names(variant_table)))
other_variants <- 
  tribble(~who.label, ~pango.lineage,
          "Delta", "AY.1",
          "Delta","AY.2",
          "Omicron", "B.1.1.529",
          "Omicron","BA.1", 
          "Omicron","BA.1.1",
          "Omicron","BA.2",
          "Omicron","BA.3",  
          "Omicron","BA.4",
          "Omicron","BA.4.6",
          "Omicron","BA.5",
          "Omicron", "BA.2.12.1",
          "", "Other")


cdc_variant_table <-
  variant_table %>% 
  select(who.label, pango.lineage) %>% 
  mutate(who.label = gsub("N/A", NA, who.label)) %>%   # remove , if at end
  mutate(pango.lineage = gsub("and|lineages|descendent", "", pango.lineage)) %>% 
  mutate(pango.lineage = gsub("[^[:alnum:]\\.]+", ",", pango.lineage))  %>% 
  mutate(pango.lineage = gsub(",$", "", pango.lineage)) %>%   # remove , if at end
  
  separate_rows(pango.lineage, sep = "[,\\\n]") %>% 
  bind_rows(other_variants) %>% 
  mutate(tt = case_when(is.na(who.label) ~ pango.lineage,
                        pango.lineage == "Other" ~ pango.lineage,
                        TRUE ~ paste0(pango.lineage, " (", who.label, ")")))


saveRDS(cdc_variant_table, here::here("data_rds/cdc_variant_table.rds"))  


## ├ Join new data with variants ----
cdc_variant_table <- readRDS(here::here("data_rds/cdc_variant_table.rds"))  
cdc_variants_tt <- 
  left_join(cdc_variants, cdc_variant_table, by = c("variant" = "pango.lineage"))  

# cdc_variants_tt %>% 
#   filter(is.na(tt)) %>%
#   pull(variant) %>% unique()


## ├ Interactive Plot ----
pl_variants <-
  cdc_variants_tt %>%
  ggplot(aes(week_ending, share,
             group = variant,
             fill = variant)) +
  ggiraph::geom_area_interactive(color = "grey50", alpha = 0.6, aes(tooltip = tt), hover_css = "stroke:red;stroke-width:inherit;") +
  scale_y_continuous(expand = c(0,0), limits = c(0,NA)) +
  # scale_x_date(expand = c(0,0), date_breaks = "3 month", date_labels = "%b-%Y" ) +
  theme(legend.position = "none") +
  labs(x = NULL,
       y = "Proportion of cases by Variant",
       fill = "Variant:") 

x <- girafe(ggobj = pl_variants)
x <- girafe_options(x = x,
                    opts_hover(css = girafe_css(
                      css = "stroke:orange;stroke-width:3px;",
                      area = "fill:blue;"
                    )))
x
