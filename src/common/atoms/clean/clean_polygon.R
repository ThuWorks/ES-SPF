clean_polygon <- function(wkt_string) {
  # Extract coordinates from the polygon string
  cat("Extracting coordinates from polygon \n")
  coords <- strsplit(gsub("POLYGON\\(\\((.*)\\)\\)", "\\1", wkt_string), ",")[[1]]
  coords <- matrix(as.numeric(unlist(strsplit(coords, " "))), ncol = 2, byrow = TRUE)

  # Create a SpatVector
  spat_vector <- vect(coords, type = "polygon")
  
  cat("Checking for orientation \n")
  # Check if the SpatVector is counter-clockwise
  coords <- geom(spat_vector)
  signed_area <- sum((coords[-nrow(coords), 1] + coords[-1, 1]) * (coords[-nrow(coords), 2] - coords[-1, 2])) / 2

  # If the SpatVector is not counter-clockwise, reverse the order of the vertices
  if (signed_area <= 0) spat_vector <- vect(coords[nrow(coords):1, ], type = "polygon")
  
  cat("Setting projection \n")
  crs(spat_vector) <- crs("+proj=longlat +datum=WGS84")
  crs(spat_vector, proj = T, describe = T)
 
  cat(green("Finished cleaning polygon \n"))
  return(spat_vector)
}
