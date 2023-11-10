match_sp_iv = function(iv_dfs, sp_list) {
  # list
  print(head(iv_dfs, 1))
  
  # our list
  print(head(sp_list, 1))
  
  # Merge the data frames in the list with sp_list
  merged_df = merge(sp_list, iv_dfs, by.x = names(sp_list)[1], by.y = names(iv_dfs)[1], all.x = T)
  
  # Check if the merged data frame is empty
  if(nrow(merged_df) == 0) {
    cat(cc$aquamarine("No matching species and indicator values found"))
    return(NULL)
  } else {
    cat(cc$aquamarine("Species and indicator values matched successfully"))
    
    # Define the desired order of columns
    cols_order = c("family", "genus", "scientificName", setdiff(names(merged_df), c("family", "genus", "scientificName")))
    
    # Reorder the columns
    merged_df = merged_df[, ..cols_order]
    
    return(merged_df)
  }
}