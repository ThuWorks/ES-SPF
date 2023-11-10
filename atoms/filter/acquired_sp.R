filter_acquired_sp <- function(sp_df, column, folder) {
  cat("Some species coordinates are NA: ", if (any(is.na(sp_df$decimalLatitude)) || any(is.na(sp_df$decimalLatitude))) red("True") else green("False"), "\n")

  # Sort into wanted categories
  sp_formatted <- sp_df %>%
    select(
      scientificName,
      scientificNameAuthorship,
      phylum,
      order,
      family,
      genus,
      taxonRank,
      iucnRedListCategory,
      decimalLongitude,
      decimalLatitude,
      coordinateUncertaintyInMeters,
      year,
      nomenclaturalStatus,
      taxonomicStatus,
      New.accepted,
      Old.name,
      One.Reason,
      datasetKey
    )
  
    # Set encoding to UTF8
  sp_df <- set_df_utf8(sp_df)
  
  cat("Changing the first column to", cc$paleTurquoise(column), "\n")
  names(sp_formatted)[1] <- column

  if (!dir.exists(paste0("./outputs/", folder))) dir.create(paste0("./outputs/", folder))

  fwrite(sp_formatted, paste0("./outputs/", folder, "/filtered_species.csv"), bom = T)
  cat(cc$aquamarine("Species data filtered"), "\n")

  return(sp_formatted)
}
