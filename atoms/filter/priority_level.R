filter_priority = function(df, taxon_name) {
  cat(cc$aquamarine("Filtering priority levels \n"))
  
  cat("column length:", ncol(df), "\n")
  
  set_df_utf8(df)
  
  pri_lvl_1 <- df %>% 
    filter(priorityLevel == "1")
  
  pri_lvl_2 <- df %>% 
    filter(priorityLevel == "2")
 
  pri_lvl_3 <- df %>% 
    filter(priorityLevel == "3")
  
  cat("Priority level 1 species:",nrow(pri_lvl_1), "\n")
  cat("Priority level 2 species:",nrow(pri_lvl_2), "\n")
  cat("Priority level 3 species:",nrow(pri_lvl_3), "\n")
  
  cat("Writing priority lists out to:", yellow(paste0("./outputs/priority_lists/",taxon_name,"/*")),"\n")
  
  if (!dir.exists(paste0("./outputs/priority_lists/", taxon_name))) dir.create(paste0("./outputs/priority_lists/", taxon_name), recursive = T)
  
  if(ncol(df) > 3) {
    cat("Creating long lists \n")
    fwrite(pri_lvl_1, paste0("./outputs/priority_lists/",taxon_name,"/pri_list_long_1.csv"), bom = T)
    fwrite(pri_lvl_2, paste0("./outputs/priority_lists/",taxon_name,"/pri_list_long_2.csv"), bom = T)
    fwrite(pri_lvl_3, paste0("./outputs/priority_lists/",taxon_name,"/pri_list_long_3.csv"), bom = T)
  } else {
    cat("Creating short lists \n")
    fwrite(pri_lvl_1, paste0("./outputs/priority_lists/",taxon_name,"/pri_list_short_1.csv"), bom = T)
    fwrite(pri_lvl_2, paste0("./outputs/priority_lists/",taxon_name,"/pri_list_short_2.csv"), bom = T)
    fwrite(pri_lvl_3, paste0("./outputs/priority_lists/",taxon_name,"/pri_list_short_3.csv"), bom = T)
  }
  
  cat(green("priority_lists have been made. \n"))
  
  return(list(pri_lvl_1, pri_lvl_2, pri_lvl_1))
}