### Exercise 5 ###
library(jsonlite)
library(dplyr)
library(httr)
api_key <- "45685b625e1b4cc1951ad0e80282d2b2"
# Write a function that allows you to specify a movie, that does the following:
GetReview <- function(movie) {
  
  # Construct a search query using YOUR api key
  # The base URL is https://api.nytimes.com/svc/movies/v2/reviews/search.json?
  # Your parameters should include a "query" and an "api_key"
  # Note: the HTTR library will take care of spaces in the arguments
  # See the interactive console for more detail:https://developer.nytimes.com/movie_reviews_v2.json#/Console/GET/reviews/search.json
  base.url <- "https://api.nytimes.com/svc/movies/v2/reviews/search.json?"
  query.params <- list(api_key=api_key, query=movie)
  # Request data using your search query
  response <- GET(base.url, query=query.params)
  body <- content(response, "text")
  parsed.data <- fromJSON(body)
  
  # What type of variable does this return?
  
  # Flatten the data stored in the `$results` key of the data returned to you
  results <- flatten(parsed.data$results)
  
  # From the most recent review, store the headline, short summary, and link to full article each in their own variables
  headline <- results$headline
  summary.short <- results$summary_short
  review.link <- results$link.url

  # Return an list of the three pieces of information from above
  review <- list(headline=headline, summary.short=summary.short, review.link = review.link)
  return(review)
}

# Test that your function works with a movie of your choice
GetReview("Time Bandits")
