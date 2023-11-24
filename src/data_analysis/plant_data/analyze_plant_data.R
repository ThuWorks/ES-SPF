source_all("./src/data_analysis/plant_data/components")

analyze_plant_data <- function(
    plant_df,
    column = "validScientificName",
    taxon_name = "plantae",
    c_threshold = 0,
    chosen_ecosystems,
    chosen_eco_iv
    ) {
  # ---------------- Combine with CSR values ----------------------- #
  csr_df <- filter_csr_list(
    src = "./resources/synonym_checked/csr/pierce/wfo_one_checklist.csv",
    column = column,
    folder = "csr"
  )

  plants_csr <- left_join(plant_df, csr_df, by = column, relationship = "many-to-many")

  if (c_threshold == 0 || c_threshold == F || is.na(c_threshold)) {
    cat("Filtering out competitors value \n")
    # Filter out rows where 'CSR' starts with 'C'
    filtered_plants_csr <- plants_csr %>%
      filter(is.na(csr) | !str_detect(csr, "^C") & !str_detect(csr, "/C"))
  } else {
    cat("Filtering by threshold value \n")
    # Filter out competitors by threshold value
    filtered_plants_csr <- plants_csr %>%
      filter(is.na(c) | c <= c_threshold)
  }

  cat("Number of species after filtering out using CSR:", nrow(filtered_plants_csr), "\n")

  # ---------------- Combine with Swedish IVs ----------------------- #
  iv_tyler <- fread("./resources/synonym_checked/iv/tyler/wfo_one_checklist.csv")

  iv_tyler_sel <- iv_tyler %>%
    select(
      scientificName,
      3:66
    )

  names(iv_tyler_sel)[1] <- column

  plants_csr_iv <- left_join(filtered_plants_csr, iv_tyler_sel, by = column, relationship = "many-to-many")

  if (any(grepl("\\.y$", names(plants_csr_iv)))) {
    # If yes, remove those columns
    plants_csr_iv <- dplyr::select(plants_csr_iv, -dplyr::ends_with(".y"))
  }

  names(plants_csr_iv) <- sub("\\.x$", "", names(plants_csr_iv))

  # Filter out rows where 'ecosystem' is 5
  filtered_plants_ecosystems <- plants_csr_iv %>%
    filter_at(vars(all_of(chosen_ecosystems)), any_vars(. >= chosen_eco_iv)) %>%
    arrange(family)

  cat("Number of species after filtering out using Ecosystem:", nrow(filtered_plants_ecosystems), "\n")

  # Check for duplicates
  log_duplicates(filtered_plants_ecosystems, column, "data_analysis", taxon_name, "final_dup.csv")
  # ---------------- write out ----------------------- #
  filtered_plants_ecosystems <- set_df_utf8(filtered_plants_ecosystems)
  
  if (!dir.exists(paste0("./outputs/data_analysis/", taxon_name))) dir.create(paste0("./outputs/data_analysis/", taxon_name), recursive = T)
  

  cat("Writing out to:", yellow(paste0("./outputs/data_analysis/", taxon_name, "/analyzed_plants.csv")), "\n")
  
  fwrite(filtered_plants_ecosystems, paste0("./outputs/data_analysis/", taxon_name, "/analyzed_plants.csv"), bom = T)

  cat("Assess", cc$lightSteelBlue("final_dup.csv"), "with", cc$lightSteelBlue("filtered_plants.csv"), "\n")


  return(filtered_plants_ecosystems)
}
