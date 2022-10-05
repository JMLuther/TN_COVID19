## DOWNLOAD DIRECTLY FROM TN DOH SITE ####
# AGE
download.file(url = #"https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-Age.xlsx",
                "https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-Age.XLSX",
              mode = 'wb',
              destfile = here::here("data_tndoh/Public-Dataset-Age.xlsx"))
# tools::md5sum(here::here("data_tndoh/Public-Dataset-Age.xlsx"))

# COUNTY
download.file(url = #"https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-County-New.xlsx",
                "https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-County-New.XLSX",
              mode = 'wb',
              destfile = here::here("data_tndoh/Public-Dataset-County-New.xlsx"))
# # COUNTY AGE GROUPS
# download.file(url = "https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-Daily-County-Age-Group.XLSX",
#               mode = 'wb',
#               destfile = here::here("data_tndoh/Public-Dataset-Daily-County-Age-Group.xlsx"))


# DAILY STATE TOTALS
download.file(url = #"https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-Daily-Case-Info.xlsx",
                "https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-Daily-Case-Info.XLSX",
              mode = 'wb',
              destfile = here::here("data_tndoh/Public-Dataset-Daily-Case-Info.xlsx"))
# RACE-ETHNICITY-SEX
download.file(url = #"https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-RaceEthSex.xlsx",
                "https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-RaceEthSex.XLSX",
              mode = 'wb',
              destfile = here::here("data_tndoh/Public-Dataset-RaceEthSex.xlsx"))

# TN VACCINATION DATA ####
## COUNTY
download.file(url = "https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/COVID_VACCINE_COUNTY_SUMMARY.XLSX",
              mode = 'wb',
              destfile = here::here("data_tndoh/COVID_VACCINE_COUNTY_SUMMARY.XLSX"))
## STATE
download.file(url = "https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/COVID_VACCINE_STATE_SUMMARY.XLSX",
              mode = 'wb',
              destfile = here::here("data_tndoh/COVID_VACCINE_STATE_SUMMARY.XLSX"))

## BY AGE (STATE LEVEL)
download.file(url = "https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/COVID_VACCINE_AGE_GROUPS.XLSX",
              mode = 'wb',
              destfile = here::here("data_tndoh/COVID_VACCINE_AGE_GROUPS.XLSX"))


# # US DATA FROM THE COVIDTRACKING PROJECT ####
# deprecated 3/2/2021; site no longer plans to update data
# download.file(url = "https://covidtracking.com/api/v1/states/daily.csv",
#               destfile = here::here("data_covidtracking/daily.csv"))


# US DATA FROM THE COVIDTRACKING PROJECT ####
download.file(url = "https://data.cdc.gov/api/views/9mfq-cb36/rows.csv?accessType=DOWNLOAD",
              destfile = here::here("data_cdc/cdc_state_info.csv"))
              
# nwss_dat <- RSocrata::read.socrata(url = "https://data.cdc.gov/resource/g653-rqe2.csv")
