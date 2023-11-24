clean_species_dup <- function(df, column = "scientificName") {
  # Check for duplicates
  if (any(duplicated(df[column]))) {
    cat("There are duplicates in the data frame based on the column", column, "\n")
  } else {
    cat("There are no duplicates in the data frame based on the column", column, "\n")
  }

  # Remove duplicates
  df <- df[!duplicated(df[column]), ]

  return(df)
}
