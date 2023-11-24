source_all("./src/data_acquisition/bio/components")

acquire_bio_data <- function(taxon_name, exp_wkt) {
  cat("Acquiring data. \n")

  # Get species keys
  gbif_keys <- get_gbif_count(taxon_name, exp_wkt)

  input <- readline(prompt = "Press enter to continue if you are satisfied with the number of species, or escape to stop the process.")

  # Get species names --- Change this to be test and full run. Download for correct citing.
  if (length(unique(gbif_keys)) <= 10000) {
    sp_df <- get_gbif_data(gbif_keys, taxon_name, exp_wkt)
  } else {
    cat(cc$aquamarine("You have a big file, you should download the data."))
    sp_df <- get_occ_data(
      gbif_keys, 
      download_path = paste0("./outputs/data_acquisition/", taxon_name),
      filename = paste0(download_path, "/", "gbif_occ_data"),
      region = exp_wkt, 
      download_key = NULL, 
      doi = NULL
      )
  }
  
  cat("Data Acquired. \n")
  
  return(sp_df)
}
