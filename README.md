# Amazon Reviewer Stats

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

An example [shiny](http://shiny.rstudio.com/) app, which runs on Heroku, to
fetch the reviewer stats from an [Amazon user
profile](http://www.amazon.com/gp/pdp/profile/A1SHLJYKY8W7HY/), and chart them
over time.  It uses [Chris Stefano's](https://github.com/virtualstaticvoid) [R
buildpack](https://github.com/virtualstaticvoid/heroku-buildpack-r).

## Installation

Use the [Deploy to Heroku](https://heroku.com/deploy) button above to create a copy of the app.

Creating the app will enable the free [postgresql
add-on](https://addons.heroku.com/heroku-postgresql#hobby-basic) to store
historical data and the free [scheduler
add-on](https://addons.heroku.com/scheduler#standard) to allow automatic
recording of stats.

It will also record the first data point.

### Scheduling

After installation, launch the schedueler to set up a schedule job.

```
$ heroku addons:open scheduler
```

Click on Add Job, and create a task for `R CMD BATCH record.R` that uses a 1X
dyno and runs daily.

## Viewing Stats

Navigate to your app to view the collected stats.

```
$ heroku open
```

## Demo

An example app is available at
[cwarden-amazon-stats.herokuapp.com](http://cwarden-amazon-stats.herokuapp.com/).
