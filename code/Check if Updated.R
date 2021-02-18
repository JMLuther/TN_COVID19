# check if file is updated:
check_if_updated <- function(file_url_fordownload, filename_on_disk){
  oldchecksum <- tools::md5sum(filename_on_disk)
  download.file(url = file_url_fordownload,
                mode = 'wb',
                destfile = filename_on_disk)
  newchecksum <- tools::md5sum(filename_on_disk)
  ifelse(oldchecksum == newchecksum, 
         "This file is Unchanged",
         "YAY, THIS FILE HAS BEEN UPDATED!")}

check_if_updated(file_url_fordownload = "https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-Age.XLSX",
                 filename_on_disk = here::here("data_tndoh/Public-Dataset-Age.xlsx")
)


# STATE DATA
{
  filename <- here::here("data_tndoh/Public-Dataset-Daily-Case-Info.xlsx")
  oldchecksum <- tools::md5sum(filename)
  download.file(url = "https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-Daily-Case-Info.XLSX",
                mode = 'wb',
                destfile = here::here("data_tndoh/Public-Dataset-Daily-Case-Info.xlsx"))
  newchecksum <- tools::md5sum(filename)
  ifelse(oldchecksum == newchecksum, 
         "This file is Unchanged",
         "YAY, THIS FILE HAS BEEN UPDATED!")
}


# AGE
{
  filename <- here::here("data_tndoh/Public-Dataset-Age.xlsx")
  oldchecksum <- tools::md5sum(filename)
  download.file(url = #"https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-Age.xlsx",
                  "https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-Age.XLSX",
                mode = 'wb',
                destfile = here::here("data_tndoh/Public-Dataset-Age.xlsx"))
  newchecksum <- tools::md5sum(filename)
  ifelse(oldchecksum == newchecksum, 
         "This file is Unchanged",
         "YAY, THIS FILE HAS BEEN UPDATED!")
}



# VACCINE DATA
{
  filename <- here::here("data_tndoh/Public-Dataset-Age.xlsx")
  oldchecksum <- tools::md5sum(filename)
  download.file(url = #"https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-Age.xlsx",
                  "https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-Age.XLSX",
                mode = 'wb',
                destfile = here::here("data_tndoh/Public-Dataset-Age.xlsx"))
  newchecksum <- tools::md5sum(filename)
  ifelse(oldchecksum == newchecksum, 
         "This file is Unchanged",
         "YAY, THIS FILE HAS BEEN UPDATED!")
}


# COUNTY DATA
{
  filename <- here::here("data_tndoh/COVID_VACCINE_STATE_SUMMARY.XLSX")
  oldchecksum <- tools::md5sum(filename)
  download.file(url = #"https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/Public-Dataset-County-New.xlsx",
                  "https://www.tn.gov/content/dam/tn/health/documents/cedep/novel-coronavirus/datasets/COVID_VACCINE_STATE_SUMMARY.XLSX",
                mode = 'wb',
                destfile = here::here("data_tndoh/COVID_VACCINE_STATE_SUMMARY.XLSX"))
  newchecksum <- tools::md5sum(filename)
  ifelse(oldchecksum == newchecksum, 
         "This file is Unchanged",
         "YAY, THIS FILE HAS BEEN UPDATED!")
}

# US DATA FROM THE COVIDTRACKING PROJECT ####
download.file(url = "https://covidtracking.com/api/v1/states/daily.csv",
              destfile = here::here("data_covidtracking/daily.csv"))


