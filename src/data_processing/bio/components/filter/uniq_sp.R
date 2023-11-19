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
  sp_uniq <- set_df_utf8(sp_uniq)

  if (!dir.exists(paste0("./outputs/data_processing/", folder))) dir.create(paste0("./outputs/data_processing/", folder))

  fwrite(sp_uniq, paste0("./outputs/data_processing/", folder, "/unique_species.csv"), bom = T)

  cat(cc$aquamarine("Unique species list created"), "\n")

  return(sp_uniq)
}
