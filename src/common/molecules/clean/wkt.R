clean_wkt <- function(wkt) {
  source("./atoms/convert/wkt_to_vect.R")
  vect_wkt <- wkt_to_vect(wkt)
  
  source("./atoms/check/orientation_wkt.R")
  check_wkt_orientation(vect_wkt)
  
  # Should add WKT orientation fix here
  
  return(vect_wkt)
}