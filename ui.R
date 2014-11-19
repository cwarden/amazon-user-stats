library(shiny)

shinyUI(fluidPage(

	titlePanel("Amazon User Review Stats"),

	sidebarLayout(
		sidebarPanel(),

		mainPanel(
			plotOutput("plot")
		)
	)
))
