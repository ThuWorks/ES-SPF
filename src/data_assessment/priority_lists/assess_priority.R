source_all("./src/data_assessment/priority_lists/components")

assess_priority <- function(df, column, taxon_name, sel_cols) {
  
  cleaned_pri_long <- clean_priority_long(df, column, taxon_name, sel_cols)

  filtered_pri_long <- filter_priority(cleaned_pri_long, taxon_name)

  cleaned_pri_short <- clean_priority_short(df, column, taxon_name)

  filtered_pri_short <- filter_priority(cleaned_pri_short, taxon_name)

  cat("priority Levels have been filtered and output. \n")
  
  return(
    list(
      filtered_pri_long,
      filtered_pri_short
    )
  )
}
