filter_checklist <- function(df, column, taxon_name) {
  
  # Depreacted -- convert to a check for NA and blank values 
  
  sp_checklist <- df %>%
    select(all_of(column))
  
  if (!any(is.na(sp_checklist$column))) {
    cat("No names are NA: ", green("True"), "\n")
  } else {
    cat("No names are NA: ", red("False"), "\n")
    cat("NA values can be found at row(s): ", which(is.na(sp_checklist$column)), "\n")
    cat("Attempting to remove NA species names... \n")
    sp_checklist <- sp_checklist[complete.cases(sp_checklist$column)]
    
    if (!any(is.na(sp_checklist$column))) cat(green("Successfully removed NA values. \n")) else cat(red("Error, unable to remove NA value \n"))
  }
  
  if (!any(sp_checklist$column == "")) {
    cat("None of the names are blank: ", green("True"), "\n")
  } else {
    cat("None of the names are blank: ", red("False"), "\n")
    cat("Blank values can be found at row(s): ", which(sp_checklist$column == ""), "\n")
    cat("Attempting to remove blank species names... \n")
    sp_checklist = sp_checklist[sp_checklist$column != ""]
    
    if (!any(sp_checklist$column == "")) cat(green("Successfully removed blank values. \n")) else cat(red("Error, unable to remove blank value \n"))
  }

  # Set encoding to UTF8
  for (name in names(sp_checklist)[sapply(sp_checklist, is.character)]) {
    sp_checklist[[name]] <- enc2utf8(sp_checklist[[name]])
  }

  if (!dir.exists(paste0("./outputs/", taxon_name))) dir.create(paste0("./outputs/", taxon_name))

  fwrite(sp_checklist, paste0("./outputs/", taxon_name, "/species_checklist.csv"), bom = T)

  cat(cc$aquamarine("Checklist recieved \n"))

  return(sp_checklist)
}
