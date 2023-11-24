source_all("./src/setup/components/")
source_all("./src/data_processing/bio/components/synonym_check")

setup_region <- function(wkt = NULL, shape = NULL, exp_distance = 0) {
  cat(blue("Initiating setup protocol. \n"))
  
  cat("Setting up region. \n")

  if (!is.null(wkt)) {
    cat("Using WKT to expand region. \n")
    print(wkt)
    # First clean the wkt
    vect_wkt <- wkt_to_vect(wkt)

    check_wkt_orientation(vect_wkt)

    # Then expand
    exp_wkt <- expand_vect(vect_wkt, exp_distance)
  } else if (!is.null(shape)) {
    cat("Using shape to expand region. \n")

    exp_wkt <- expand_vect(shape, exp_distance)
  } else {
    cat(red("Error: missing or invalid shapefile or WKT. \n"))
  }

  # vect_wkt <- wkt_to_vect(wkt)

  check_wkt_orientation(vect_wkt)

  calc_wkt_size(exp_wkt)

  cat("Region set up. \n")

  return(exp_wkt)
}

setup_data_raw <- function() {
  cat("Setting up raw data. \n")
  
  # Get a list of all subdirectories under './outputs/setup/data_raw/'
  subdirs <- list.dirs(path = "./outputs/setup/data_raw/", recursive = TRUE)
  
  # Remove the parent directory ('./outputs/setup/data_raw/') from the list
  subdirs <- subdirs[-1]
  
  # Filter out directories that contain other directories
  deepest_subdirs <- subdirs[unlist(sapply(subdirs, function(dir) {
    length(list.dirs(path = dir, recursive = FALSE)) == 0
  }))]
  
  # Check if 'wfo_one_checklist.csv' exists in each subdirectory
  files_exist <- sapply(deepest_subdirs, function(dir) {
    file.exists(paste0(dir, "/wfo_one_checklist.csv"))
  })
  
  # If 'wfo_one_checklist.csv' exists in all subdirectories, print a message
  if (all(files_exist)) {
    cat(green("You do not have to run the setup. \n"))
  } else {
    missing_files <- deepest_subdirs[!files_exist]
    cat(red("You need to run the setup for these files:"), paste(missing_files, collapse = ", "), "\n")
  }

  run_setup <- readline(prompt = "Do you want to setup raw data frames? (y/n): ")

  if (tolower(run_setup) == "y") {
    cat("wrangling data frames and checking for synonyms. \n")

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

    cat("Raw data setup completed. \n")
  } else if (tolower(run_setup) == "n") {
    cat("Skipping raw data setup. \n")
  }
}
