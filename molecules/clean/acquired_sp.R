clean_acquired_sp = function(sp_df, column, long, lat) {
  cat(cc$aquamarine("Cleaning species \n"))
  
  clean_sp <- sp_df %>% 
    select(
      acceptedScientificName,
      kingdom,
      phylum,
      order,
      family,
      genus,
      species,
      taxonRank,
      iucnRedListCategory,
      decimalLongitude,
      decimalLatitude,
      coordinateUncertaintyInMeters,
      year,
      datasetKey
    )
  
  cat("Changing the first column to", cc$paleTurquoise(column), "\n")
  names(clean_sp)[1] <- column
  
  # Fix UTM coordinates
  source("./atoms/clean/clean_coords_utm.R")
  utm_coords = clean_utm_coords(clean_sp, long, lat)
  
  # Fix long-lat coordinates
  source("./atoms/clean/clean_coords_wgs.R")
  wgs_coords = clean_wgs_coords(clean_sp, long, lat)
  
  return(clean_sp)
}