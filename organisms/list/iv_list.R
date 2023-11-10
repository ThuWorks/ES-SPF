combine_iv_species = function(iv_data) {
  
  # Add standard filter for all IV lists.

  # combine the lists
  source("./atoms/merge/combine_iv_dfs.R")
  iv_data = combine_iv_dfs(iv_list)
  
  source("./molecules/match_IVs_species.R")
  matched_sp_iv = match_sp_iv(ivs_df, sp_data)
  
  fwrite(matched_sp_iv, "./outputs/matched_sp_iv.csv", bom = T)
  
  return(matched_sp_iv)
}