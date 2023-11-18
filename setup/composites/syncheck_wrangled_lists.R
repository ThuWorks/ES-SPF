source("./molecules/wrangle/list.R")
source("./molecules/synonym/synonym_check.R")

check_wrangled_lists = function(src, column) {
  # Wrangle all lists
  wrangled_lists <- wrangle_lists(src, column)
  
  # Synonym Check all the lists separately.
  synonym_lists <- lapply(names(wrangled_lists), function(name) {
    
    split_name <- strsplit(name, "_")[[1]]
    directory <- "setup"
    parent_folder <- split_name[1]
    child_folder <- split_name[2]
    
    check_synonyms(wrangled_lists[[name]], column, paste(directory, parent_folder, child_folder, sep = "/"))
  })
  
  return(synonym_lists)
}