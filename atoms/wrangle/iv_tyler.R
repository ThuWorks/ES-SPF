wrangle_iv_tyler = function(src = "./resources/wrangle/ivs/tyler.csv", column = "scientificName") {
  cat(cc$aquamarine("Wrangling Tyler et al. indicator values \n"))
  df_tyler = fread(src)
  
  df_tyler_formatted = df_tyler %>% 
    select(
      1:2,
      9:34,
      36:73
    )
  # Remove spaces, parenthesis, dots, numbers and make the first letter capital
  names <- colnames(df_tyler_formatted)
  names <- sapply(names, function(name) {
    name <- gsub("[0-9]", "", name)
    name <- gsub("\\(.*\\)", "", name)
    name <- gsub("\\.", "", name)
    name <- gsub(" ", "", tools::toTitleCase(name))
    name <- paste0(tolower(substring(name, 1, 1)), substring(name, 2))
    return(name)
  })
  setnames(df_tyler_formatted, colnames(df_tyler_formatted), names)
  
  # Set the fist column to column name
  names(df_tyler_formatted)[1] = column
  
  # Set encoding to UTF8
  for (name in names(df_tyler_formatted)[sapply(df_tyler_formatted, is.character)]) {
    df_tyler_formatted[[name]] = enc2utf8(df_tyler_formatted[[name]])
  }
  
  return(df_tyler_formatted)
}