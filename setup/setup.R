source("./setup/composites/syncheck_wrangled_lists.R")

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
    
    checked_lists_bio <- check_wrangled_lists("./src/aspects/biological/atoms/wrangle", "validScientificName")
    
    checked_lists_env <- check_wrangled_lists("./src/aspects/environmental/atoms/wrangle", "validScientificName")
    
    checked_lists_soc <- check_wrangled_lists("./src/aspects/social/atoms/wrangle", "validScientificName")
    
    lapply(names(checked_lists), function(name) {
      
      split_name <- strsplit(name, "_")[[1]]
      parent_folder <- split_name[1]
      child_folder <- split_name[2]
      
      # Create a file path for each data frame
      file_path <- paste0("resources/synonym_checked/", parent_folder, "/", child_folder, ".csv")
      
      # Write the data frame to a csv file
      data.table::fwrite(checked_lists[[name]], file_path)
    })
    
    message("Setup sequence finished.")
  } 
  else if (tolower(run_setup) == "n") {
    cat("Skipping setup.")
  } 
  
}
