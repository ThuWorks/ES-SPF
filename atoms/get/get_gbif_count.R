get_gbif_count <- function(region, taxon_name) {
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

  return(gbif_count)
}
