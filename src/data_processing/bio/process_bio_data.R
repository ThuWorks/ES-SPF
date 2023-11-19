source_all("./src/data_processing/bio/components")

process_bio_data <- function(sp_df, column, taxon_name, long, lat) {
  
  cleaned_sp <- clean_acquired_sp(sp_df, column, long, lat)
  
  # Run synonym check on the species
  sp_synonyms = check_syn_wfo(cleaned_sp, column, taxon_name)
  
  # Select best match and remove duplications
  sp_checked = check_syn_wfo_one(sp_synonyms, column, taxon_name)
  
  filt_acq_sp  = filter_acquired_sp(sp_df, column, taxon_name)
  
  if (!any(duplicated(sp_df[[column]]))) {
    cat("Species already unique, moving on. \n")
    uniq_sp <- filt_acq_sp
    
  } else {
    cat(red("duplicates found, removing. \n"))
    uniq_sp = filter_uniq_sp(filt_acq_sp, column, taxon_name)
  }
  
  cat("Removing blacklisted species. \n")
  # Remove blacklisted species
  source("./atoms/filter/blacklisted_sp.R")
  rem_bl_sp = filter_blacklisted_sp(uniq_sp, column, taxon_name)
  
  cat("Adding redlist categories. \n")
  # Add redlist category
  source("./atoms/merge/redlisted_sp.R")
  sp_w_redlist <- merge_redlist(rem_bl_sp, column)
  
  # Remove duplicates
  sp_w_redlist <- sp_w_redlist[!duplicated(sp_w_redlist[[column]]), ]
  
  # Sort the columns
  processed_sp <- sp_w_redlist %>% 
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
  if (!dir.exists(paste0("./outputs/data_processing/", taxon_name))) dir.create(paste0("./outputs/data_processing/", taxon_name), recursive = T)
  
  cat("Final species list can be found in",paste0("./outputs/data_processing/", taxon_name, "/sp_final.csv"), "\n")
  
  fwrite(processed_sp, paste0("./outputs/data_processing/", taxon_name, "/sp_final.csv"), bom = T)
  
  return(processed_sp)
}