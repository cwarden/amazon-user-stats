library(shiny)
library(dplyr)
library(ggplot2)

source("heroku.R")

options(bitmapType = 'cairo')

shinyServer(function(input, output) {
		output$plot <- renderPlot({
			src <- src_heroku()

			rows <- tbl(src, "user_info")

			user <- rows %>% arrange(desc(timestamp)) %>% select(user_name) %>% head(1) %>% as.character()

			rows %>%
				mutate(percent_helpful = 100 * reviews_helpful / reviews_voted, inverted_rank = -rank) %>%
				collect %>%
				ggplot(aes(x = timestamp, y = inverted_rank, color = percent_helpful)) +
				geom_point(aes(size = reviews)) + geom_line() +
				scale_y_continuous("Rank", limits = c(-3500000, -1), breaks = c(-1, -1500000, -3000000), labels = c("1", "1.5 million", "3 million")) +
				xlab("Date") + labs(title = paste0("Amazon Reviewer Rank: ", user), color = "Percent\nHelpful", size = "Reviews")
		})
})
