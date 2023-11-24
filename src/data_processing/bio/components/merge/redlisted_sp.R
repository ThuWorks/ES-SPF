merge_redlist <- function(sp_df, column, redlist_df = "./resources/synonym_checked/sp/redlist/wfo_one_checklist.csv") {
  # Might want to make the selection into its own atom or in the setup

  cat(cc$aquamarine("Merging redlist with species. \n"))

  redlist_pre <- fread(redlist_df)

  # select columns add status
  redlist <- redlist_pre %>%
    select(
      scientificName,
      popularName,
      riskCategory,
      taxonomicStatus
    )

  cat(names(redlist), "\n")

  # Set encoding to UTF8
  redlist <- set_df_utf8(redlist)

  # Set wanted column to parameter column to avoid errors
  names(redlist)[names(redlist) == "scientificName"] <- column

  merged_df <- left_join(sp_df, redlist, by = column, relationship = "many-to-many")

  # Check if there are any column names that end with .y
  if (any(grepl("\\.y$", names(merged_df)))) {
    merged_df <- dplyr::select(merged_df, -dplyr::ends_with(".y"))
  }

  names(merged_df) <- sub("\\.x$", "", names(merged_df))

  cat(names(merged_df), "\n")

  return(merged_df)
}
