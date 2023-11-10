check_wkt_orientation <- function(vect_polygon) {
  
  if (!inherits(vect_polygon, "SpatVector")) {
    stop("vect_polygon must be a SpatVector")
  }
  
  # Extract the coordinates of the first ring of the first feature
  coords <- geom(vect_polygon)

  # Get x and y coordinates
  x_coords <- coords[, 3]
  y_coords <- coords[, 4]
  
  # Add the first pair of coordinates to the end of x_coords and y_coords
  x_coords <- c(x_coords, x_coords[1])
  y_coords <- c(y_coords, y_coords[1])
  
  # Calculate the signed area (positive for counter-clockwise, negative for clockwise)
  signed_area <- sum((x_coords[1:(length(x_coords)-1)] * y_coords[2:length(y_coords)]) - (x_coords[2:length(x_coords)] * y_coords[1:(length(y_coords)-1)])) / 2
  
  # Check the orientation and print a message
  if (signed_area > 0) {
    cat(cc$paleTurquoise("The orientation is counter-clockwise (GBIF friendly).\n"))
  } else if (signed_area < 0) {
    cat(cc$paleTurquoise("The orientation is clockwise.\n"))
  } else {
    stop(red("STOP: The polygon does not have a clear orientation. \n"))
  }
}
