combine_iv_dfs = function(ivs, column) {
  # Initialize combined_df with the first data frame in the list
  combined_df = ivs[[1]]
  
  # Check if there are more than one data frames in the list
  if(length(ivs) > 1) {
    # Loop through the rest of the list and merge each data frame with combined_df
    for(i in 2:length(ivs)) {
      combined_df = merge(combined_df, ivs[[i]], by = column, all = TRUE)
    }
  }
  
  return(combined_df)
}