library(dotenv)
library(dplyr)
library(amazonuserstatr)

profile_id <- Sys.getenv('AMAZON_PROFILE_ID')
userInfo <- scrape_profile(profile_id)
userInfo

db_user <- Sys.getenv('DB_USER')
db_pass <- Sys.getenv('DB_PASS')
db_host <- Sys.getenv('DB_HOST')
db_port <- Sys.getenv('DB_PORT')
db_name <- Sys.getenv('DB_NAME')
src <- src_postgres(user = db_user, password = db_pass, host = db_host, port = db_port, dbname = db_name)

record_user_info(src$con, "user_info", userInfo)

rows <- tbl(src, "user_info")
rows
