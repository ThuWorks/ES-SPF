acquire_species_data <- function(column, taxon_name, wkt, shape, long, lat, exp_distance = 0) {
  cat(cc$aquamarine("Initiating acquisition sequence. \n"))
  
  source("./organisms/region/expand.R")
  exp_wkt <- expand_region(wkt, shape, exp_distance)
  
  # Get species keys
  source("./atoms/get/get_gbif_count.R")
  gbif_keys <- get_gbif_count(exp_wkt, taxon_name)
  
  input <- readline(prompt="Press enter to continue if you are satisfied with the number of species, or escape to stop the process.")

  # Get species names
  if (length(unique(gbif_keys)) <= 10000) {
    source("./atoms/get/get_gbif_data.R")
    sp_df <- get_gbif_data(gbif_keys, exp_wkt)
  } else {
    cat(cc$aquamarine("You have a big file, you should download the data."))
    source("./atoms/get/get_gbif_download.R")
    sp_df <- get_gbif_download(gbif_keys, exp_wkt, length(unique(gbif_keys)))
  }

  source("./molecules/clean/acquired_sp.R")
  cleaned_sp <- clean_acquired_sp(sp_df, column, long, lat)
  
  source("./molecules/synonym/synonym_check.R")
  sp_checked <- check_synonyms(cleaned_sp, column, taxon_name)
  
  source("./molecules/filter/filter_sp.R")
  sp_filtered <- filter_sp(sp_checked, column, taxon_name)
  
  # Sort the columns
  sp_filtered <- sp_filtered %>% 
    select(
      all_of(column),
      scientificNameAuthorship,
      popularName,
      phylum,
      order,
      family,
      genus,
      taxonRank,
      iucnRedListCategory,
      riskCategory,
      decimalLongitude,
      decimalLatitude,
      coordinateUncertaintyInMeters,
      year,
      taxonomicStatus,
      nomenclaturalStatus,
      New.accepted,
      Old.name,
      One.Reason,
      datasetKey
    )

  # Create a directory for the given taxon_name
  if (!dir.exists(paste0("./outputs/", taxon_name))) dir.create(paste0("./outputs/", taxon_name), recursive = T)
  
  cat("Final species list can be found in",paste0("./outputs/", taxon_name, "/sp_final.csv"), "\n")
  fwrite(sp_filtered, paste0("./outputs/", taxon_name, "/sp_final.csv"), bom = T)
  
  cat(green("Acquisition sequence successfully completed. \n"))

  return(sp_filtered)
}