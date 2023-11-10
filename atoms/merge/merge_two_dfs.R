merge_two_dfs = function(df1, column1, df2, column2) {
  # Create a new data frame with unique values from the column specified by column1
  new_df <- data.frame(scientificName = unique(df1[[column1]]))
  
  # Check if there are identical rows in df1
  if(any(duplicated(df1[[column1]]))) {
    cat("There are identical rows in df1\n")
  } else {
    cat("There are no identical rows in df1\n")
  }
  
  # Check if there are identical rows in df2
  if(any(duplicated(df2[[column2]]))) {
    cat("There are identical rows in df2\n")
  } else {
    cat("There are no identical rows in df2\n")
  }
  
  # Extract column information from df1 and df2 based on species names
  new_df <- merge(new_df, df1, by = column1, all.x = TRUE)
  new_df <- merge(new_df, df2, by = column2, all.x = TRUE)
  
  str(new_df)
  
  return(new_df)
}
