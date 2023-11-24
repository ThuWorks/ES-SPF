clean_priority_short <- function(df, column, taxon_name) {
  cat("Cleaning short priority list. \n")
  cat(column, " length:", ncol(df), "\n")

  df_filtered <- df %>%
    select(all_of(column), popularName, priorityLevel)

  cat("Length after selecting:", ncol(df_filtered), "\n")

  cat("Writing priority lists out to:", yellow(paste0("./outputs/data_assessment/priority_lists/", taxon_name, "/*_short.csv")), "\n")
  
  df_filtered <- set_df_utf8(df_filtered)

  if (!dir.exists(paste0("./outputs/data_assessment/priority_lists/", taxon_name))) dir.create(paste0("./outputs/data_assessment/priority_lists/", taxon_name), recursive = T)

  fwrite(df_filtered, paste0("./outputs/data_assessment/priority_lists/", taxon_name, "/priority_selected_short.csv"), bom = T)

  cat(green("columns have been selected for the final priority lists. \n"))

  cat("Cleaning short priority list completed. \n")
  return(df_filtered)
}
