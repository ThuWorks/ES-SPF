wrangle_iv_lubomir = function(src = "./resources/wrangle/ivs/lubomir.csv", column = "scientificName") {
  cat(cc$aquamarine("Wrangling Lubomir et al. indicator values \n"))
  
  df_lubomir = fread(src)
  
  colnames(df_lubomir) = unlist(df_lubomir[1, ])
  
  colnames(df_lubomir)[1:2] = unlist(df_lubomir[2, 1:2])
  
  df_lubomir_formatted = df_lubomir[-c(1,2), ]
  
  df_lubomir_formatted = df_lubomir_formatted[, -1]
  
  colnames(df_lubomir_formatted) = c(column, "light", "temperature", "moisture", "reaction", "nutrients", "salinity")
  
  return(df_lubomir_formatted)
}
