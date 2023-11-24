get_species <- function(names) {
  library(httr)

  api <- "https://artskart.artsdatabanken.no/publicapi/api/"
  endpoint <- "Taxon/ScientificName/"

  # Define a function to send a GET request for a single taxonID
  get_taxon_data <- function(name) {
    # Construct the full URL
    url <- paste0(api, endpoint, URLencode(name))

    # Send the GET request
    response <- GET(url)

    # Check if the request was successful
    if (response$status_code == 200) {
      # If successful, parse the response to JSON and return as a list
      return(content(response, "parsed"))
    } else {
      # If not successful, return NULL
      return(NULL)
    }
  }

  # Apply the function to each taxonID in your dataframe
  taxon_data <- lapply(names, get_taxon_data)

  print(head(taxon_data, 5))

  # Convert the list of taxon data to a dataframe
  taxon_df <- do.call(rbind, lapply(taxon_data, data.frame))

  return(taxon_df)
}
