library(dotenv)
profile_id <- Sys.getenv('AMAZON_PROFILE_ID')
userInfo <- scrape_profile(profile_id)
userInfo

library(dplyr)
db_user <- Sys.getenv('DB_USER')
db_pass <- Sys.getenv('DB_PASS')
db_host <- Sys.getenv('DB_HOST')
db_port <- Sys.getenv('DB_PORT')
db_name <- Sys.getenv('DB_NAME')
src <- src_postgres(user = db_user, password = db_pass, host = db_host, port = db_port, dbname = db_name)

record_user_info(src$con, "user_info", userInfo)

rows <- tbl(src, "user_info")
rows

library(ggvis)
rows %>% collect %>% ggvis(~timestamp, ~rank)
rows %>%
	mutate(percent_helpful = 100 * reviews_helpful / reviews_voted, inverted_rank = -rank) %>%
	collect %>%
	ggvis(~timestamp, ~rank) %>%
	layer_points(stroke = ~percent_helpful, size = ~reviews)

library(ggplot2)
rows %>%
	mutate(percent_helpful = 100 * reviews_helpful / reviews_voted, inverted_rank = -rank) %>%
	collect %>%
	ggplot(aes(x = timestamp, y = inverted_rank, color = percent_helpful)) +
	geom_point(aes(size = reviews)) + geom_line() +
	scale_y_continuous("Rank", limits = c(-3500000, -1), breaks = c(-1, -1500000, -3000000), labels = c("1", "1.5 million", "3 million")) +
	xlab("Date") + labs(title = "Christian's Amazon Reviewer Rank", color = "Percent\nHelpful", size = "Reviews")

model <- rows %>%
	mutate(percent_helpful = 100 * reviews_helpful / reviews_voted, inverted_rank = -rank) %>%
	collect %>%
	lm(reviews ~ inverted_rank, data = .)
