source_all("./src/setup/components")
source_all("./src/data_processing/bio/components/synonym_check")

setup = function() {
  
  # Get a list of all subdirectories under './outputs/setup/'
  subdirs <- list.dirs(path = "./outputs/setup/", recursive = TRUE)
  
  # Remove the parent directory ('./outputs/setup/') from the list
  subdirs <- subdirs[-1]
  
  # Check if 'wfo_one_checklist.csv' exists in each subdirectory
  files_exist <- sapply(subdirs, function(dir) {
    file.exists(paste0(dir, "/wfo_one_checklist.csv"))
  })
  
  # If 'wfo_one_checklist.csv' exists in all subdirectories, print a message
  if (all(files_exist)) {
    cat(green("You do not have to run the setup. \n"))
  } else {
    missing_files <- subdirs[!files_exist]
    cat(red("You need to run the setup for these files:"), paste(missing_files, collapse = ", "), "\n")
  }
  
  run_setup <- readline(prompt = "Do you want to run the setup? (y/n): ")
  
  if (tolower(run_setup) == "y") {
    cat("Initiating setup protocol.")
    
    df_list <- list(
      bio = check_wrangled_dfs("./src/data_processing/bio/components/wrangle", "validScientificName"),
      env = check_wrangled_dfs("./src/data_processing/env/components/wrangle", "validScientificName"),
      soc = check_wrangled_dfs("./src/data_processing/soc/components/wrangle", "validScientificName")
    )
    
    # Apply the function to each list in the list
    lapply(names(df_list), function(list_name) {
      
      # Apply the function to each data frame in the list
      lapply(names(df_list[[list_name]]), function(df_name) {
        
        # Create a file path for each data frame
        file_path <- paste0("resources/synonym_checked/", list_name, "/", df_name, ".csv")
        
        # Write the data frame to a csv file
        fwrite(df_list[[list_name]][[df_name]], file_path)
      })
    })
    
    message("Setup sequence completed.")
  } 
  else if (tolower(run_setup) == "n") {
    cat("Skipping setup.")
  } 
  
}
