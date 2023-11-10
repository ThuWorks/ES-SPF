wkt_to_vect <- function(wkt_string) {
  
  cat("Converting the wkt into vector \n")
  
  # Extract coordinates from the polygon string
  coords <- strsplit(gsub("POLYGON\\(\\((.*)\\)\\)", "\\1", wkt_string), ", ?")[[1]]
  coords <- matrix(as.numeric(unlist(strsplit(coords, " "))), ncol = 2, byrow = TRUE)
  
  # Create a SpatVector
  spat_vector <- vect(coords, type = "polygon")
  
  return(spat_vector)
}