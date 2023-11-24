source("./src/utils/utils.R")
source("./src/setup/setup.R")
source("./src/data_acquisition/bio/acquire_bio_data.R")
source("./src/data_acquisition/env/acquire_env_data.R")
source("./src/data_acquisition/soc/acquire_soc_data.R")
source("./src/data_processing/bio/process_bio_data.R")
source("./src/data_analysis/plant_data/analyze_plant_data.R")
source("./src/data_analysis/insect_data/analyze_insect_data.R")
source("./src/data_assessment/priority_lists/assess_priority.R")
source("./src/data_assessment/interactions/assess_interactions.R")


main <- function() {
  setup_region(wkt = NULL, shape = NULL, exp_distance = 0)

  setup_data_raw()

  acquired_bio_data <- acquire_bio_data(
    taxon_name,
    wkt,
  )

  # acquired_env_data <- acquire_env_data()

  # acquired_soc_data <- acquire_soc_data()

  processed_bio_data <- process_bio_data(
    sp_df,
    column,
    taxon_name,
    long,
    lat
  )

  # processed_bio_data <- process_bio_data()

  # processed_bio_data <- process_bio_data()

  analyzed_plant_data <- analyze_plant_data(
    plant_df,
    column = "validScientificName",
    taxon_name = "plantae",
    c_threshold = 0,
    chosen_ecosystems,
    chosen_eco_iv
  )

  # analyze_insect_data <- function(
  #   insect_df,
  #   column = "validScientificName",
  #   taxon_name = "insecta"
  # )

  assesses_priority <- assess_priority(df, column, taxon_name, sel_cols)

  # assessed_interactions <- assess_interactions()
}