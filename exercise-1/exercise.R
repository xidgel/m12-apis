### Exercise 1 ###

# Load the httr and jsonlite libraries for accessing data
#install.packages("httr")
library(httr)
#install.packages("jsonlite")
library(jsonlite)

## For these questions, look at the API documentation to identify the appropriate endpoint and information.
## Then send GET() request to fetch the data, then extract the answer to the question

# For what years does the API have statistical data?
query.params <- list(population_type_code="AS")
response <- GET("http://data.unhcr.org/api/stats/time_series_all_years.json", query=query.params)
body <- content(response, "text")
parsed.data <- fromJSON(body)
min(parsed.data$year)
max(parsed.data$year)

# What is the "country code" for the "Syrian Arab Republic"?
response <- GET("http://data.unhcr.org/api/countries/list.json")
body <- content(response, "text")
parsed.data <- fromJSON(body)
parsed.data[parsed.data$name_en=="Syrian Arab Republic",]$country_code

# How many persons of concern from Syria applied for residence in the USA in 2013?
# Hint: you'll need to use a query parameter
# Use the `str()` function to print the data of interest
# See http://www.unhcr.org/en-us/who-we-help.html for details on these terms
query.params <- list(year=2013, country_of_asylum="USA", country_of_origin="SYR")
response <- GET("http://data.unhcr.org/api/stats/asylum_seekers.json", query=query.params)
body <- content(response, "text")
parsed.data <- fromJSON(body)
sum(as.integer(parsed.data$applied_during_year))

## And this was only 2013...


# How many *refugees* from Syria settled the USA in all years in the data set (2000 through 2013)?
# Hint: check out the "time series" end points
query.params <- list(population_type_code="AS", country_of_residence="USA", country_of_origin="SYR")
response <- GET("http://data.unhcr.org/api/stats/time_series_all_years.json", query=query.params)
body <- content(response, "text")
parsed.data <- fromJSON(body)

# Use the `plot()` function to plot the year vs. the value.
# Add `type="o"` as a parameter to draw a line
plot(x=parsed.data$year, y=parsed.data$value, type="o")


# Pick one other country in the world (e.g., Turkey).
# How many *refugees* from Syria settled in that country in all years in the data set (2000 through 2013)?
# Is it more or less than the USA? (Hint: join the tables and add a new column!)
# Hint: To compare the values, you'll need to convert the data (which is a string) to a number; try using `as.numeric()`
query.params <- list(population_type_code="AS", country_of_residence="TUR", country_of_origin="SYR")
response <- GET("http://data.unhcr.org/api/stats/time_series_all_years.json", query=query.params)
body <- content(response, "text")
parsed.data.turkey <- fromJSON(body)



## Bonus (not in solution):
# How many of the refugees in 2013 were children (between 0 and 4 years old)?


## Extra practice (but less interesting results)
# How many total people applied for asylum in the USA in 2013?
# - You'll need to filter out NA values; try using `is.na()`
# - To calculate a sum, you'll need to convert the data (which is a string) to a number; try using `as.numeric()`


## Also note that asylum seekers are not refugees
