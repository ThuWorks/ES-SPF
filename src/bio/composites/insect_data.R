source("./organisms/list/sp_list.R")
source("./atoms/filter/csr_pierce.R")

get_insect_data <- function(
    column = "validScientificName",
    taxon_name = "insecta",
    exp_distance = 0,
    wkt = NULL,
    shape = NULL,
    c_threshold = 0,
    chosen_ecosystems,
    chosen_eco_iv
) {
  
insect_df <- acquire_species_data(
  # Using "scientificName" led to some issues with the WFO synonym check for some reason.
  column = column,
  taxon_name = taxon_name,
  wkt = wkt,
  shape = shape,
  long = "decimalLongitude",
  lat = "decimalLatitude",
  exp_distance = exp_distance
)

}