wrangle_csr_pierce <- function(src = "./resources/wrangle/csr/csr_pierce.csv", column = "scientificName") {
  cat(cc$aquamarine("Wrangling csr_values \n"))
  
  csr_df <- fread(src)

  names(csr_df)[1] <- column

  origin_names <- c(
    "Palearctic",
    "Boreal Forests/Taiga",
    "Tundra",
    "Nearctic",
    "Temperate Coniferous Forests",
    "Temperate Broadleaf and Mixed Forests",
    "Neotropic",
    "Afrotropic",
    "Indo-Malay",
    "Australasia",
    "Oceania",
    "Tropical and Subtropical Moist Broadleaf Forests",
    "Tropical and Subtropical Dry Broadleaf Forests",
    "Tropical and Subtropical Coniferous Forests",
    "Tropical and Subtropical Grasslands, Savannas, and Shrublands",
    "Temperate Grasslands, Savannas, and Shrublands",
    "Flooded Grasslands and Savannas",
    "Montane Grasslands and Shrublands",
    "Mediterranean Forests, Woodlands, and Scrub",
    "Deserts and Xeric Shrublands",
    "Mangroves"
  )

  priority_list <- c(
    "1" = "palearctic",
    "2" = "borealForestsTaiga",
    "3" = "tundra",
    "4" = "nearctic",
    "5" = "temperateConiferousForests",
    "6" = "temperateBroadLeadAndMixedForests",
    "7" = "neotropic",
    "8" = "afrotropic",
    "9" = "indoMalay",
    "10" = "australasia",
    "11" = "oceania",
    "12" = "tropicalSubtropicalMoistBroadleafForests",
    "13" = "tropicalSubtropicalDryBroadleafForests",
    "14" = "tropicalSubtropicalConiferousForests",
    "15" = "tropicalSubtropicalGrasslandsSavannasShrublands",
    "16" = "temperateGrasslandsSavannasShrublands",
    "17" = "floodedGrasslandsSavannas",
    "18" = "montaneGrasslandsShrublands",
    "19" = "mediterraneanForestsWoodlandsScrub",
    "20" = "desertsXericShrublands",
    "21" = "mangroves"
  )

  csr_df_formatted <- csr_df

  for (i in seq_along(priority_list)) {
    names(csr_df_formatted)[names(csr_df_formatted) == origin_names[i]] <- priority_list[[i]]
  }

  # Add priority column
  csr_df_formatted$priority <- csr_df_formatted[, apply(.SD, 1, function(x) {
    present_regions <- which(x == 1)
    if (length(present_regions) > 0) {
      return(names(priority_list)[min(present_regions)])
    } else {
      cat(yellow("Warning: one or more columns do not have a region and NA will be returned \n"))
      return(NA)
    }
  }), .SDcols = priority_list]

  csr_df_formatted$priority <- as.numeric(csr_df_formatted$priority)

  # Set all empty strings to NA
  csr_df_formatted <- csr_df_formatted %>%
    mutate(across(where(is.character), ~ na_if(., "")))


  csr_df_formatted <- csr_df_formatted %>%
    select(
      1:5,
      7:8,
      32:35,
      41
    )

  colnames(csr_df_formatted) <- c(
    column,
    "family",
    "order",
    "superOrder",
    "seedStructure",
    "lifeCycleHabit",
    "growthHabit",
    "c", "s", "r",
    "csr",
    "priority"
  )

  if (any(is.na(csr_df_formatted[[column]]))) {
    cat("Some of the CSR species are NA: ", red("True"), "\n")
    cat("The NA value can be found at row:", which(is.na(csr_df_formatted[[column]])), "\n")
    cat("trying to remove rows with NA species names... \n")
    csr_df_formatted <- csr_df_formatted[!is.na(csr_df_formatted[[column]]), ]
    cat("Rows left after removal: ", nrow(csr_df_formatted), "\n")

    if (!any(is.na(csr_df_formatted[[column]]))) {
      cat(green("NA species names successfully removed \n"))
    } else {
      cat(yellow("Warning: removal of NA species names failed \n"))
    }
  } else {
    cat("Some of the CSR species are NA: ", green("False"), "\n")
  }


  if (any(csr_df_formatted[[column]] == "")) {
    cat("Some of the CSR species are blank: ", red("True"), "\n")
    cat("blank value can be found at row:", which(csr_df_formatted[[column]] == ""), "\n")
    cat("Removing rows with blank species names... \n")
    csr_df_formatted <- csr_df_formatted[csr_df_formatted[[column]] != "", ]

    if (!any(csr_df_formatted[[column]] == "")) {
      cat(green("NA species names successfully removed \n"))
    } else {
      cat(yellow("Warning: removal of NA species names failed \n"))
    }
  } else {
    cat("Some of the CSR species are blank: ", green("False"), "\n")
  }

  cat(cc$aquamarine("Wrangled CSR values \n"))

  return(csr_df_formatted)
}
