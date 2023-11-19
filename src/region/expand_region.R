source_all("./src/data_acquisition/region/components")

expand_region <- function(wkt = NULL, shape = NULL, exp_distance = 0) {
  
  if (!is.null(wkt)) {
    cat("Using WKT to expand region. \n")
    print(wkt)
    # First clean the wkt
    vect_wkt <- wkt_to_vect(wkt)
    
    check_wkt_orientation(vect_wkt)
  
    # Then expand
    exp_wkt <- expand_vect(vect_wkt, exp_distance)
  } 
  else if (!is.null(shape)) {
    cat("Using shape to expand region. \n")
    
    exp_wkt <- expand_vect(shape, exp_distance)
    
  } else {
    cat(red("Error: missing or invalid shapefile or WKT. \n"))
  }
  
  # clean wkt again
  #vect_wkt <- wkt_to_vect(wkt)
  check_wkt_orientation(vect_wkt)
  
  calc_wkt_size(exp_wkt)
  
  return(exp_wkt)
}