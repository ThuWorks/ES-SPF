source_all("./src/data_acquisition/bio/components")

acquire_bio_data <- function(column, taxon_name, wkt, shape, long, lat, exp_distance = 0) {
  
  exp_wkt <- expand_region(wkt, shape, exp_distance)
  
  # Get species keys
  gbif_keys <- get_gbif_count(exp_wkt, taxon_name)
  
  input <- readline(prompt="Press enter to continue if you are satisfied with the number of species, or escape to stop the process.")
  
  # Get species names --- Change this to be test and full run. Download for correct citing.
  if (length(unique(gbif_keys)) <= 10000) {
    sp_df <- get_gbif_data(gbif_keys, exp_wkt)
  } else {
      cat(cc$aquamarine("You have a big file, you should download the data."))
      sp_df <- get_gbif_download(gbif_keys, exp_wkt, length(unique(gbif_keys)))
  }
  
  return(sp_df)
}