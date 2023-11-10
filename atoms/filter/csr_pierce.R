filter_csr_list = function(src = "./resources/synonym_checked/csr/pierce/wfo_one_checklist.csv", 
                           column = "scientificName", 
                           folder = "csr"
) {
  csr_prefiltered <- fread(src)
  
  # Select specific columns
  csr_filtered <- csr_prefiltered %>% 
    select(
      scientificName,
      scientificNameAuthorship,
      seedStructure,
      lifeCycleHabit,
      growthHabit,
      c, s, r, csr,
      priority
    )
  
  names(csr_filtered)[1] <- column
  
  if(any(duplicated(csr_filtered[[column]]))) {
    cat("Some of the species are identical, removing duplications. \n")
    
    # filter away the unwanted duplications by using the priority list
    csr_filtered <- csr_filtered %>%
      group_by(across(all_of(column))) %>%
      filter(priority == min(priority)) %>%
      ungroup()
    
    
    if ( any(duplicated(csr_filtered[[column]])) ) {
      # Find indices of duplicated rows based on 'column'
      log_duplicates(csr_filtered, column, folder, "filter_csr_priority_dups.csv")
    } else cat(green("Successfully removed duplications."))

  } else {
    cat("No species are identical, moving on. \n")
  }
  
  csr_filtered <- set_df_utf8(csr_filtered)
  
  # Create a directory for the given taxon_name if it does not already exist
  if (!dir.exists(paste0("./outputs/", folder))) dir.create(paste0("./outputs/", folder))
  
  fwrite(csr_filtered, paste0("./outputs/", folder, "/sp_final.csv"), bom = T)
  
  return(csr_filtered)
}