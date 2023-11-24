get_gbif_data <- function(gbif_keys, taxon_name, region) {
  cat(cc$aquamarine("Using Keys to collect names. this may take a while \n"))
  # Set up a progress handler
  handlers("txtprogressbar")

  # Use with_progress instead of directly calling mclapply
  with_progress({
    # Set up a progress bar
    p <- progressor(steps = length(gbif_keys))

    gbif_sp_data <- lapply(gbif_keys, FUN = function(x) {
      # Update progress bar
      p()

      tryCatch(
        {
          occ_data(
            speciesKey = x,
            hasCoordinate = T,
            geometry = region
          )$data
        },
        error = function(e) {
          cat("Error with speciesKey:", x, "\n")
          cat("Error message:", e$message, "\n")
          return(NULL)
        }
      )
    })
  })

  cat("Removing duplicates and merging dfs \n")
  gbif_sp_data <- lapply(gbif_sp_data, function(x) x %>% distinct(speciesKey, .keep_all = TRUE))
  gbif_sp_data <- bind_rows(gbif_sp_data)
  gbif_sp_data <- data.frame(gbif_sp_data)

  cat("All species unique:", if (!any(duplicated(gbif_sp_data$scientificName)) == T) green("True") else red("False"), "\n")
  
  if (!dir.exists(paste0("./outputs/data_acquisition/", taxon_name))) dir.create(paste0("./outputs/data_acquisition/", taxon_name))
  
  gbif_sp_data[sapply(gbif_sp_data, is.list)] <- lapply(gbif_sp_data[sapply(gbif_sp_data, is.list)], function(col) {
    ifelse(sapply(col, is.null), NA, col)
  })
  
  fwrite(gbif_sp_data, paste0("./outputs/data_acquisition/", taxon_name, "/gbif_data.csv"), bom = T)

  cat(green("GBIF species collected. \n"))

  return(gbif_sp_data)
}
