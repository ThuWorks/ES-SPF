clean_priority_long = function(df, taxon_name, sel_cols) {
  
  cat("column length:", ncol(df), "\n")
  
  df_filtered <- df[, ..sel_cols]
  
  cat("Length after selecting:", ncol(df_filtered), "\n")
  
  cat("Writing priority lists out to:", yellow(paste0("./outputs/priority_lists/",taxon_name,"/*")),"\n")
  
  if (!dir.exists(paste0("./outputs/priority_lists/", taxon_name))) dir.create(paste0("./outputs/priority_lists/", taxon_name), recursive = T)
  
  fwrite(df_filtered, paste0("./outputs/priority_lists/",taxon_name,"/priority_selected_columns.csv"), bom = T)
  
  cat(green("columns have been selected for the final priority lists. \n"))
  
  return(df_filtered)
  
}