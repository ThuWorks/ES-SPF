filter_blacklisted_sp <- function(df, column, taxon_name) {
  cat("filtering out blacklisted species \n")

  blacklist_pre <- fread("./resources/synonym_checked/sp/blacklist/wfo_one_checklist.csv")

  # select columns add status
  blacklist <- blacklist_pre %>%
    select(
      scientificName,
      scientificNameAuthorship,
      popularNameNO,
      family,
      genus,
      establishmentClass,
      alienStatus,
      riskCategory,
      taxonomicStatus,
      New.accepted,
      One.Reason
    )

  # Set encoding to UTF8
  blacklist <- set_df_utf8(blacklist)

  # Set wanted column to column to avoid errors
  names(blacklist)[names(blacklist) == "scientificName"] <- column

  sp_blacklist <- merge(df, blacklist, by = column)

  # Check if there are any column names that end with .y
  if (any(grepl("\\.y$", names(sp_blacklist)))) {
    sp_blacklist <- dplyr::select(sp_blacklist, -dplyr::ends_with(".y"))
  }

  names(sp_blacklist) <- sub("\\.x$", "", names(sp_blacklist))

  # Write out blacklisted species
  if (!dir.exists(paste0("./outputs/", taxon_name))) dir.create(paste0("./outputs/", taxon_name), recursive = T)

  cat("Writing blacklist to: ", paste0("./outputs/", taxon_name, "/blacklisted_species.csv"), "\n")

  fwrite(sp_blacklist, paste0("./outputs/", taxon_name, "/blacklisted_species.csv"), bom = T)

  # Write out without the blacklisted species
  sp_rem_blacklist <- anti_join(df, blacklist, by = column)

  if (any(grepl("\\.y$", names(sp_blacklist)))) {
    # If yes, remove those columns
    sp_blacklist <- dplyr::select(sp_blacklist, -dplyr::ends_with(".y"))
  }

  names(sp_rem_blacklist) <- sub("\\.x$", "", names(sp_rem_blacklist))

  cat("Writing without blacklisted species to: ", paste0("./outputs/", taxon_name, "/wo_blacklisted_sp.csv"), "\n")

  fwrite(sp_rem_blacklist, paste0("./outputs/", taxon_name, "/wo_blacklisted_sp.csv"), bom = T)


  cat(cc$aquamarine("Removed blacklisted species \n"))
  return(sp_rem_blacklist)
}
