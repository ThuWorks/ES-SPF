expand_vect = function(polygon, distance = 0) {
  cat("Expanding region by", cc$aquamarine(distance), "meters \n")
  # Make sure the polygon is a spatVector
  if (class(polygon) != "SpatVector") {
    stop("The input polygon must be a SpatVector.")
  }
  
  cat("Checking if it already has a projection \n")
  
  if (is.na(crs(polygon)) || crs(polygon) == "") {
    cat("No projection found, adding longlat \n")
    # Assign a CRS if it doesn't have one
    crs(polygon) <- "+proj=longlat +datum=WGS84 +no_defs"
  }
  
  # Transform polygon to meters
  cat("Transforming to meters \n")
  prj <- "+proj=utm +zone=33 +datum=WGS84 +units=m +no_defs"
  
  # Give projection if there are not any already
  
  polygon_transformed <- project(polygon, prj)
  
  # Expand polygon by the given distance
  expanded_polygon <- buffer(polygon_transformed, width = distance)
  
  # Transform the polygon back to the original system
  expanded_polygon <- project(expanded_polygon, crs(polygon))

  # Get extent of the expanded region
  ext_region <- ext(expanded_polygon)
  if (class(ext_region) == "SpatExtent") {
    ext_region <- c(ext_region$xmin, ext_region$xmax, ext_region$ymin, ext_region$ymax)
  }
  
  cat("Making GBIF friendly WKT \n")
  
  # Create anticlockwise (GBIF friendly) WKT string - should make into own atom
  expanded_WKT_anticlockwise <- sprintf(
    "POLYGON((%s %s,%s %s,%s %s,%s %s,%s %s))",
    formatC(ext_region[1], format = "f", digits = 5), formatC(ext_region[3], format = "f", digits = 5),
    formatC(ext_region[2], format = "f", digits = 5), formatC(ext_region[3], format = "f", digits = 5),
    formatC(ext_region[2], format = "f", digits = 5), formatC(ext_region[4], format = "f", digits = 5),
    formatC(ext_region[1], format = "f", digits = 5), formatC(ext_region[4], format = "f", digits = 5),
    formatC(ext_region[1], format = "f", digits = 5), formatC(ext_region[3], format = "f", digits = 5)
  )
  
  # Split the string into individual numbers
  numbers <- strsplit(expanded_WKT_anticlockwise, " ")[[1]]
  
  # Remove trailing zeros from each number
  numbers <- sapply(numbers, function(x) {
    x <- gsub("0+$", "", x)
    gsub("\\.$", "", x)
  })
  
  # Combine the numbers back into a single string
  expanded_WKT_anticlockwise <- paste(numbers, collapse = " ")
  
  cat("WKT: \n",cc$lightSteelBlue(expanded_WKT_anticlockwise), "\n")
  cat(green("Finished expanding region \n"))
  
  return(expanded_WKT_anticlockwise)
}