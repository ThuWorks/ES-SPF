source("./src/utils/utils.R")
source("./src/setup/setup.R")
source("./src/data_acquisition/bio/acquire_bio_data.R")
source("./src/data_processing/bio/process_bio_data.R")
source("./src/data_analysis/plant_data/analyze_plant_data.R")
source("./src/data_assessment/priority_lists/assess_priority.R")


main <- function() {
  
  column <- "validScientificName"
  
  expanded_region <- setup_region(
    wkt = "POLYGON((10.42151 63.4446,10.42691 63.44362,10.42743 63.4439,10.42094 63.44569,10.42151 63.4446))",
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
  
  assesses_priority <- assess_priority(
    fread("./examples/nyhavna_project/resources/manually_modified/priority_list/filtered_plants.csv"),
    "validScientificName",
    "plantae",
    sel_cols = c(1:27, 36:38, 40:41, 57, 63:64, 93:100)
  )
  
  # write out timers
  print_all_timers()
}