# Change the naming here to be more general

filter_uniq_sp <- function(df, column, folder) {
  
  # If duplicated is true then filter out duplicated species else move on
  if(any(duplicated(df[[column]]))) {
    cat("Some of the species are identical, removing duplications. \n")
    sp_uniq <- df %>%
      distinct(.data[[column]], .keep_all = TRUE)
  } else {
    cat("No species are identical, moving on... ", "\n")
    sp_uniq <- df
  }
  
  # Set encoding to UTF8
  for (name in names(sp_uniq)[sapply(sp_uniq, is.character)]) {
    sp_uniq[[name]] <- enc2utf8(sp_uniq[[name]])
  }

  if (!dir.exists(paste0("./outputs/", folder))) dir.create(paste0("./outputs/", folder))

  fwrite(sp_uniq, paste0("./outputs/", folder, "/unique_species.csv"), bom = T)

  cat(cc$aquamarine("Unique species list created"), "\n")

  return(sp_uniq)
}
