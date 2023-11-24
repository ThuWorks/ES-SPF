get_gbif_count <- function(taxon_name, region) {
  cat("Collecting GBIF species Keys \n")

  cat("Getting count of species using the wkt: \n", region, "\n")

  taxon_key <- name_backbone(taxon_name)$usageKey

  gbif_count <- occ_count(
    taxonKey = taxon_key,
    facet = "speciesKey",
    facetLimit = 100000,
    hasCoordinate = T,
    geometry = region
  )$speciesKey

  cat(cc$aquamarine(length(unique(gbif_count))), green("unique species keys collected \n"))
  
  if (!dir.exists(paste0("./outputs/data_acquisition/", taxon_name))) dir.create(paste0("./outputs/data_acquisition/", taxon_name), recursive = T)
  
  fwrite(data.frame(gbif_count), paste0("./outputs/data_acquisition/", taxon_name, "/gbif_count.csv"), bom = T)

  return(gbif_count)
}
