source("./src/utils/utils.R")
source("./src/setup/setup.R")
source("./src/data_acquisition/bio/acquire_bio_data.R")
source("./src/data_processing/bio/process_bio_data.R")
source("./src/data_analysis/plant_data/analyze_plant_data.R")
source("./src/data_assessment/priority_lists/assess_priority.R")


main <- function() {
  
  column <- "validScientificName"
  
  expanded_region <- setup_region(
    wkt = "POLYGON((8.74872 58.47132,8.75093 58.47132,8.75093 58.47223,8.74872 58.47223,8.74872 58.47132))",
    shape = NULL,
    exp_distance = 0
    )
  
  setup_data_raw()
  
  acquired_plant_data <- acquire_bio_data(
    taxon_name = "plantae",
    expanded_region
  )
  
  processed_plant_data <- process_bio_data(
    sp_df = acquired_plant_data,
    column,
    taxon_name = "plantae",
    long = "decimalLongitude",
    lat = "decimalLatitude"
  )
  
  analyzed_plant_data <- analyze_plant_data(
    plant_df = processed_plant_data,
    column,
    taxon_name = "plantae",
    c_threshold = 0,
    chosen_ecosystems = c("calcareousRock", "moistMeadow", "moistCalcareousMeadow"),
    chosen_eco_iv = 1
  )
  
  # Not possible to do with test species yet.
  assesses_priority <- assess_priority(
    analyzed_plant_data,
    "validScientificName",
    "plantae",
    sel_cols = c(1:27, 36:38, 40:41, 57, 63:64)
  )
  
}