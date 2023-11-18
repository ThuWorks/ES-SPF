filter_sp = function(sp_df, column, taxon_name) {
  
  # Filter species by the wanted parameters
  source("./atoms/filter/acquired_sp.R")
  filt_acq_sp  = filter_acquired_sp(sp_df, column, taxon_name)
 
  # Get a list of unique species
  if (!any(duplicated(sp_df[[column]]))) {
    cat("Species already unique, moving on. \n")
    uniq_sp <- filt_acq_sp
    
  } else {
    cat(red("duplicates found, removing. \n"))
    # ----- Needs to be fixed ------
    source("./atoms/filter/filter_uniq_sp.R")
    uniq_sp = filter_uniq_sp(filt_acq_sp, column, taxon_name)
  }
  
  cat("Removing blacklisted species. \n")
  # Remove blacklisted species
  source("./atoms/filter/blacklisted_sp.R")
  rem_bl_sp = filter_blacklisted_sp(uniq_sp, column, taxon_name)
  
  cat("Adding redlist categories. \n")
  # Add redlist category
  source("./atoms/merge/redlisted_sp.R")
  sp_w_redlist <- merge_redlist(rem_bl_sp, column)
  
  # Remove duplicates
  sp_w_redlist <- sp_w_redlist[!duplicated(sp_w_redlist[[column]]), ]
  
  return(sp_w_redlist)
}