clean_priority_long <- function(df, column, taxon_name, sel_cols) {
  cat("Cleaning long priority list. \n")
  cat(column, " length:", ncol(df), "\n")
  
  cat("selected columns:", sel_cols, "\n")
  
  df <- data.table(df)
    
  df_filtered <- df[, ..sel_cols]

  cat("Length after selecting:", ncol(df_filtered), "\n")

  cat("Writing priority lists out to:", yellow(paste0("./outputs/data_assessment/priority_lists/", taxon_name, "/*")), "\n")
  
  df_filtered <- set_df_utf8(df_filtered)

  if (!dir.exists(paste0("./outputs/data_assessment/priority_lists/", taxon_name))) dir.create(paste0("./outputs/data_assessment/priority_lists/", taxon_name), recursive = T)

  fwrite(df_filtered, paste0("./outputs/data_assessment/priority_lists/", taxon_name, "/priority_selected_columns.csv"), bom = T)

  cat(green("columns have been selected for the final priority lists. \n"))
  
  cat("Cleaning long priority list completed. \n")

  return(df_filtered)
}
