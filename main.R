source("./src/utils/utils.R")
source("./src/setup/setup.R")
source("./src/bio/composites/plant_data.R")
source("./src/common/molecules/filter/prioritize.R")

final_plant_df <- get_plant_data(
  column = "validScientificName",
  taxon_name = "plantae",
  exp_distance = 0,
  wkt = "POLYGON((10.42151 63.4446,10.42691 63.44362,10.42743 63.4439,10.42094 63.44569,10.42151 63.4446))",
  shape = NULL,
  c_threshold = 0,
  chosen_ecosystems = c("calcareousRock", "moistMeadow", "moistCalcareousMeadow"),
  chosen_eco_iv = 1
)

prioritized <- prioritize(
  fread("./resources/priority_list/filtered_plants.csv"),
  "validScientificName",
  "plantae",
  sel_cols = c(1:27, 36:38, 40:41, 57, 63:64, 93:100)
)
