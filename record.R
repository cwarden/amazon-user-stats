source("heroku.R")

profile_id <- Sys.getenv('AMAZON_PROFILE_ID')
userInfo <- amazonuserstatr::scrape_profile(profile_id)

src <- src_heroku()

amazonuserstatr::record_user_info(src$con, "user_info", userInfo)
