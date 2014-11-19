library(dotenv)
src_heroku <- function() {
	db_url <- Sys.getenv('DATABASE_URL')
	db <- httr::parse_url(db_url)
	dplyr::src_postgres(user = db$username, password = db$password, host = db$hostname, port = db$port, dbname = db$path)
}
